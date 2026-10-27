% İP-2 / D-07: 12.10.2026 dört senaryo paketinin güç devresi topolojisi, cihaz
% eşlemesi ve modülasyon yapısı denetimi (salt okuma; model kaydedilmez).
%
% Çağrı (proje kökünden):
%   matlab -batch "run('scripts/audit_topology_20261027.m')"
% Girdi : runs/2026-10-27_topoloji_denetimi/model/ (ham paketin bayt bayt kopyası)
% Çıktı : runs/2026-10-27_topoloji_denetimi/<model>_netlist.txt
%         runs/2026-10-27_topoloji_denetimi/<model>_simscape_params.csv
%         runs/2026-10-27_topoloji_denetimi/<model>_signal_graph.txt
%         runs/2026-10-27_topoloji_denetimi/<model>_cihaz_eslemesi.csv
%         runs/2026-10-27_topoloji_denetimi/<model>_bacak_eslemesi.txt
%         runs/2026-10-27_topoloji_denetimi/<model>_mdosyasi_kullanim.txt
% Review: review/2026-10-27_TOPOLOJI_DENETIMI.md
%
% Simscape port sırası (LConn/RConn) .ssc düğüm bildirimlerinin konum
% açıklamasından alınır (foundation kaynakları okunabilir; ee bileşenleri
% korumalı olduğundan IGBT/diyot sırası bağlantı tutarlılığıyla doğrulanır:
% kapı sürücüsünün referans ucu = IGBT E, sıcaklık kaynağı = H).

root_dir = fileparts(fileparts(mfilename('fullpath')));
audit_run_dir = fullfile(root_dir, 'runs', '2026-10-27_topoloji_denetimi');
audit_model_dir = fullfile(audit_run_dir, 'model');
cd(audit_model_dir);   % slprj ve önbellek yalnız bu klasöre düşsün
evalin('base', sprintf('run(''%s'');', fullfile(audit_model_dir, 'inverter_common_parameters.m')));
warning('off', 'all');

audit_models = {'inverter_scenario1_parametric5_etiquetli', 'inverter_senaryo3', 'inverter_senaryo4'};
for audit_m = 1:numel(audit_models)
    audit_one_model(audit_models{audit_m}, audit_run_dir);
end
fprintf('denetim tamam: %s\n', audit_run_dir);

%% ------------------------------------------------------------------------
function audit_one_model(mdl, out_dir)
load_system(mdl);
fprintf('model: %s\n', mdl);
blocks = find_system(mdl, 'LookUnderMasks', 'all', 'FollowLinks', 'on', 'Type', 'Block');
ssc = blocks(strcmp(get_param(blocks, 'BlockType'), 'SimscapeBlock'));

% ---------- 1. Fiziksel düğüm listesi (union-find) ----------
uf = containers.Map('KeyType', 'double', 'ValueType', 'double');
parent = [];
    function i = idx(h)
        if ~isKey(uf, h)
            parent(end+1) = numel(parent) + 1;
            uf(h) = numel(parent);
        end
        i = uf(h);
    end
    function r = root(i)
        while parent(i) ~= i
            parent(i) = parent(parent(i));
            i = parent(i);
        end
        r = i;
    end
    function unite(a, b)
        ra = root(idx(a)); rb = root(idx(b));
        if ra ~= rb, parent(ra) = rb; end
    end

% Simscape blok portları
port_owner = containers.Map('KeyType', 'double', 'ValueType', 'any');
for k = 1:numel(ssc)
    ph = get_param(ssc{k}, 'PortHandles');
    sf = get_param(ssc{k}, 'SourceFile');
    for s = {'LConn', 'RConn'}
        hs = ph.(s{1});
        for p = 1:numel(hs)
            idx(hs(p));
            raw = sprintf('%s%d', s{1}(1), p);
            port_owner(hs(p)) = {ssc{k}, raw, port_role(sf, raw)};
        end
    end
end
% Fiziksel çizgiler: Simscape çizgilerinde Src/DstPortHandle çoğu kez -1 döner;
% bu yüzden bağlantı port→'Line' ve çizgi ağacı (LineParent/LineChildren)
% üzerinden kurulur. Sonuç PortConnectivity DstBlock kümeleriyle çapraz denetlenir.
subs = blocks(strcmp(get_param(blocks, 'BlockType'), 'SubSystem'));
pmio = blocks(strcmp(get_param(blocks, 'BlockType'), 'PMIOPort'));
phys_blocks = [ssc; subs; pmio];
for k = 1:numel(phys_blocks)
    ph = get_param(phys_blocks{k}, 'PortHandles');
    for h = [ph.LConn ph.RConn]
        idx(h);
        L = get_param(h, 'Line');
        if L > 0
            unite(h, L);
            ch = get_param(L, 'LineChildren');
            for p = 1:numel(ch), unite(L, ch(p)); end
            pa = get_param(L, 'LineParent');
            if pa > 0, unite(L, pa); end
        end
    end
end
lines_all = find_system(mdl, 'FindAll', 'on', 'LookUnderMasks', 'all', 'FollowLinks', 'on', 'Type', 'line');
for k = 1:numel(lines_all)
    L = lines_all(k);
    ch = get_param(L, 'LineChildren');
    for p = 1:numel(ch), unite(L, ch(p)); end
    pa = get_param(L, 'LineParent');
    if pa > 0, unite(L, pa); end
end
% Alt sistem sınırları: Connection Port (PMIOPort) ↔ üst blok LConn/RConn
for k = 1:numel(subs)
    ph = get_param(subs{k}, 'PortHandles');
    if isempty(ph.LConn) && isempty(ph.RConn), continue, end
    pm = find_system(subs{k}, 'SearchDepth', 1, 'LookUnderMasks', 'all', 'FollowLinks', 'on', 'BlockType', 'PMIOPort');
    pm = pm(~strcmp(pm, subs{k}));
    side = cellstr(get_param(pm, 'Side')); num = str2double(cellstr(get_param(pm, 'Port')));
    for s = {'Left', 'Right'}
        sel = find(strcmpi(side, s{1}));
        [~, o] = sort(num(sel)); sel = sel(o);
        if strcmp(s{1}, 'Left'), hs = ph.LConn; else, hs = ph.RConn; end
        for p = 1:min(numel(sel), numel(hs))
            pph = get_param(pm{sel(p)}, 'PortHandles');
            inner = [pph.LConn pph.RConn];
            unite(hs(p), inner(1));
        end
    end
end
% Düğümleri topla
keys_ = cell2mat(keys(port_owner));
groups = containers.Map('KeyType', 'double', 'ValueType', 'any');
for k = 1:numel(keys_)
    r = root(uf(keys_(k)));
    if isKey(groups, r), groups(r) = [groups(r) keys_(k)]; else, groups(r) = keys_(k); end
end
gk = cell2mat(keys(groups));
node_of = containers.Map('KeyType', 'double', 'ValueType', 'double');
node_members = cell(numel(gk), 1);
for n = 1:numel(gk)
    hs = groups(gk(n));
    mem = cell(numel(hs), 1);
    for p = 1:numel(hs)
        o = port_owner(hs(p));
        node_of(hs(p)) = n;
        mem{p} = sprintf('%s:%s(%s)', short(o{1}, mdl), o{3}, o{2});
    end
    node_members{n} = sort(mem);
end
% Çapraz denetim: her Simscape portunun PortConnectivity.DstBlock kümesindeki
% Simscape blokları aynı düğümde bir porta sahip olmalı.
xmiss = {};
for k = 1:numel(ssc)
    ph = get_param(ssc{k}, 'PortHandles');
    pc = get_param(ssc{k}, 'PortConnectivity');
    for q = 1:numel(pc)
        t = regexp(pc(q).Type, '^(LConn|RConn)(\d+)$', 'tokens', 'once');
        if isempty(t), continue, end
        h = ph.(t{1})(str2double(t{2}));
        my = node_of(h);
        for d = pc(q).DstBlock(:)'
            if ~strcmp(get_param(d, 'BlockType'), 'SimscapeBlock'), continue, end
            dph = get_param(d, 'PortHandles');
            dn = arrayfun(@(x) node_of(x), [dph.LConn dph.RConn]);
            if ~any(dn == my)
                xmiss{end+1} = sprintf('%s.%s -> %s', short(ssc{k}, mdl), pc(q).Type, short(getfullname(d), mdl)); %#ok<AGROW>
            end
        end
    end
end
% sıralı ve okunur düğüm adları: önce en çok üyeli
fid = fopen(fullfile(out_dir, [mdl '_netlist.txt']), 'w', 'n', 'UTF-8');
fprintf(fid, 'MODEL %s — fiziksel düğüm listesi (Simscape portları, alt sistem sınırları çözülmüş)\n', mdl);
fprintf(fid, 'Port etiketi: rol(ham), ham = L<n>/R<n> = LConn/RConn sırası\n');
fprintf(fid, 'PortConnectivity çapraz denetimi: %d uyumsuzluk\n', numel(xmiss));
if ~isempty(xmiss), fprintf(fid, '    %s\n', xmiss{:}); end
fprintf(fid, '\n');
for n = 1:numel(gk)
    fprintf(fid, 'N%03d [%d uç]\n', n, numel(node_members{n}));
    fprintf(fid, '    %s\n', node_members{n}{:});
end
% blok başına düğüm
fprintf(fid, '\n== Blok → düğüm\n');
for k = 1:numel(ssc)
    ph = get_param(ssc{k}, 'PortHandles');
    hs = [ph.LConn ph.RConn];
    parts = cell(1, numel(hs));
    for p = 1:numel(hs)
        o = port_owner(hs(p));
        parts{p} = sprintf('%s=N%03d', o{3}, node_of(hs(p)));
    end
    fprintf(fid, '%-60s %-50s %s\n', short(ssc{k}, mdl), get_param(ssc{k}, 'SourceFile'), strjoin(parts, ' '));
end
fclose(fid);

% ---------- 1b. Rol çıkarımı: T-tipi bacak, filtre, CMC yönü, ölçüm noktaları ----------
comps = struct('name', {}, 'sf', {}, 'role', {}, 'node', {}, 'tbl', {});
for k = 1:numel(ssc)
    ph = get_param(ssc{k}, 'PortHandles'); hs = [ph.LConn ph.RConn];
    c.name = short(ssc{k}, mdl); c.sf = get_param(ssc{k}, 'SourceFile');
    c.role = cellfun(@(h) subsref(port_owner(h), substruct('{}', {3})), num2cell(hs), 'uni', 0);
    c.node = arrayfun(@(h) node_of(h), hs);
    c.tbl = '';
    if contains(c.sf, 'igbt'), c.tbl = table_prefix(get_param(ssc{k}, 'Vce_mat1')); end
    if contains(c.sf, 'diode'), c.tbl = table_prefix(get_param(ssc{k}, 'Vf')); end
    comps(end+1) = c; %#ok<AGROW>
end
write_leg_map(comps, mdl, fullfile(out_dir, [mdl '_bacak_eslemesi.txt']));

% ---------- 2. Simscape parametreleri ----------
fid = fopen(fullfile(out_dir, [mdl '_simscape_params.csv']), 'w', 'n', 'UTF-8');
fprintf(fid, 'blok;kaynak;parametre;deger;birim\n');
skip = '(_unit|_conf|_specify|_priority|_nominal_value|_nominal_unit|_nominal_specify)$';
for k = 1:numel(ssc)
    b = ssc{k};
    sf = get_param(b, 'SourceFile');
    if startsWith(sf, {'foundation.thermal', 'foundation.electrical.elements.reference'}), continue, end
    dp = fieldnames(get_param(b, 'DialogParameters'));
    for q = 1:numel(dp)
        if ~isempty(regexp(dp{q}, skip, 'once')), continue, end
        v = get_param(b, dp{q});
        if ~ischar(v), continue, end
        u = '';
        try, u = get_param(b, [dp{q} '_unit']); catch, end
        fprintf(fid, '%s;%s;%s;%s;%s\n', short(b, mdl), sf, dp{q}, strrep(v, newline, ' '), u);
    end
end
fclose(fid);

% ---------- 3. Sinyal (PWM / kapı) grafiği ----------
fid = fopen(fullfile(out_dir, [mdl '_signal_graph.txt']), 'w', 'n', 'UTF-8');
fprintf(fid, 'MODEL %s — Simulink sinyal blokları (kütüphane bağlantılarının içine inilmez)\n', mdl);
fprintf(fid, 'Biçim: blok [tür] {parametreler}  <= giriş kaynakları\n\n');
for k = 2:numel(blocks)
    b = blocks{k};
    bt = get_param(b, 'BlockType');
    if strcmp(bt, 'SimscapeBlock') || strcmp(bt, 'PMIOPort'), continue, end
    if inside_link(b, mdl), continue, end
    ref = get_param(b, 'ReferenceBlock');
    prm = key_params(b, bt, ref);
    srcs = input_sources(b, mdl);
    fprintf(fid, '%s [%s%s] {%s}  <= %s\n', short(b, mdl), bt, ...
        iff(isempty(ref), '', [' ~ ' strrep(ref, newline, ' ')]), prm, srcs);
end
% Goto/From tablosu
fprintf(fid, '\n== Goto / From etiketleri\n');
gotos = blocks(strcmp(get_param(blocks, 'BlockType'), 'Goto'));
froms = blocks(strcmp(get_param(blocks, 'BlockType'), 'From'));
tags = unique([get_param(gotos, 'GotoTag'); get_param(froms, 'GotoTag')]);
for t = 1:numel(tags)
    g = gotos(strcmp(get_param(gotos, 'GotoTag'), tags{t}));
    f = froms(strcmp(get_param(froms, 'GotoTag'), tags{t}));
    gs = cellfun(@(x) sprintf('%s(%s)<=%s', short(x, mdl), get_param(x, 'TagVisibility'), input_sources(x, mdl)), g, 'uni', 0);
    fs = cellfun(@(x) short(x, mdl), f, 'uni', 0);
    fprintf(fid, '%-12s GOTO: %s\n             FROM: %s\n', tags{t}, strjoin(gs, ' | '), strjoin(fs, ' | '));
end
fclose(fid);

% ---------- 4. Cihaz eşlemesi (IGBT / diyot) ----------
fid = fopen(fullfile(out_dir, [mdl '_cihaz_eslemesi.csv']), 'w', 'n', 'UTF-8');
fprintf(fid, 'blok;kaynak;dugumler;tablo_onekleri;sabit_sayi_parametreleri;parametre_ozeti\n');
for k = 1:numel(ssc)
    b = ssc{k}; sf = get_param(b, 'SourceFile');
    if ~contains(sf, {'igbt', 'diode'}), continue, end
    [act, ~] = active_params(sf);
    pref = {}; hard = {}; summ = {};
    for q = 1:numel(act)
        try, v = get_param(b, act{q}); catch, continue, end
        summ{end+1} = sprintf('%s=%s', act{q}, v); %#ok<AGROW>
        tok = regexp(v, '\<([A-Z][A-Za-z0-9]*?)_', 'tokens');
        if isempty(regexp(v, '[A-Za-z_]', 'once')) || startsWith(strtrim(v), '[')
            if isempty(regexp(v, '[A-Za-z]', 'once')), hard{end+1} = sprintf('%s=%s', act{q}, v); end %#ok<AGROW>
        end
        for t = 1:numel(tok), pref{end+1} = tok{t}{1}; end %#ok<AGROW>
    end
    ph = get_param(b, 'PortHandles'); hs = [ph.LConn ph.RConn];
    nd = arrayfun(@(h) sprintf('%s=N%03d', subsref(port_owner(h), substruct('{}', {3})), node_of(h)), hs, 'uni', 0);
    fprintf(fid, '%s;%s;%s;%s;%s;%s\n', short(b, mdl), sf, strjoin(nd, ' '), strjoin(unique(pref), ','), ...
        strjoin(hard, ' | '), strjoin(summ, ' | '));
end
fclose(fid);

% ---------- 5. m-dosyası değişkenlerinin doğrudan kullanımı ----------
mtxt = fileread(fullfile(fileparts(get_param(mdl, 'FileName')), 'inverter_common_parameters.m'));
mlines = regexp(mtxt, '\r?\n', 'split');
vars = {}; rhs = {};
for q = 1:numel(mlines)
    t = regexp(mlines{q}, '^\s*([A-Za-z]\w*)\s*=\s*([^;%]*)', 'tokens', 'once');
    if ~isempty(t), vars{end+1} = t{1}; rhs{end+1} = t{2}; end %#ok<AGROW>
end
[vars, iu] = unique(vars, 'stable'); rhs = rhs(iu);
alltxt = {};
for k = 1:numel(blocks)
    try, dp = fieldnames(get_param(blocks{k}, 'DialogParameters')); catch, continue, end
    for q = 1:numel(dp)
        try, v = get_param(blocks{k}, dp{q}); catch, continue, end
        if ischar(v), alltxt{end+1} = v; end %#ok<AGROW>
    end
end
alltxt = strjoin(alltxt, ' ');
used = cellfun(@(v) ~isempty(regexp(alltxt, ['\<' v '\>'], 'once')), vars);
fid = fopen(fullfile(out_dir, [mdl '_mdosyasi_kullanim.txt']), 'w', 'n', 'UTF-8');
fprintf(fid, 'MODEL %s — inverter_common_parameters.m değişkenlerinin blok diyaloglarında doğrudan kullanımı\n', mdl);
fprintf(fid, 'Kullanılan: %d / %d\n\n== Doğrudan kullanılmayanlar (dolaylı: başka bir m-dosyası değişkeninin tanımına giriyor)\n', nnz(used), numel(vars));
for q = find(~used)
    ind = vars(used & cellfun(@(r) ~isempty(regexp(r, ['\<' vars{q} '\>'], 'once')), rhs));
    fprintf(fid, '%-28s %s\n', vars{q}, iff(isempty(ind), '', ['dolaylı → ' strjoin(ind, ',')]));
end
fclose(fid);
close_system(mdl, 0);
end

function p = table_prefix(v)
t = regexp(v, '^([A-Z][A-Za-z0-9]*?)_', 'tokens', 'once');
if isempty(t), p = ['SABIT:' v]; else, p = t{1}; end
end

function n = nd(c, role)
i = find(strcmp(c.role, role), 1);
if isempty(i), n = NaN; else, n = c.node(i); end
end

function write_leg_map(comps, mdl, fname)
fid = fopen(fname, 'w', 'n', 'UTF-8');
fprintf(fid, 'MODEL %s — T-tipi bacak eşlemesi (bağlantı grafiğinden otomatik çıkarım)\n', mdl);
fprintf(fid, 'Beklenen cihaz tablosu (12.10 m-dosyası + tez): dış IGBT=S12 (SKM100GB12T4), nötr IGBT=S34 (IXYN100N65C3H1),\n');
fprintf(fid, 'dış IGBT ters paralel diyot=DS12, nötr IGBT ters paralel diyot=DS34, faz–DA ray harici diyot D1/D2=D12 (DSEI2x61-12B)\n');
sf = {comps.sf};
isA = @(s) find(contains(sf, s));
vs = isA('ee.sources.voltage_source');
ig = isA('igbt'); di = isA('diode_thermal');
twot = isA({'inductor', 'capacitor', 'resistor', 'ac_voltage', 'voltage_source', 'sensors.current', 'semiconductors.diode'});
% elektriksel komşuluk (iki uçlu elemanlar + CMC sargıları + IGBT C–E)
edges = zeros(0, 2);
for k = 1:numel(comps)
    c = comps(k);
    if contains(c.sf, 'mutual_inductor')
        edges = [edges; nd(c, '1+') nd(c, '1-'); nd(c, '2+') nd(c, '2-')]; %#ok<AGROW>
    elseif contains(c.sf, 'igbt')
        edges = [edges; nd(c, 'C') nd(c, 'E')]; %#ok<AGROW>
    elseif contains(c.sf, 'sensors.current')
        edges = [edges; nd(c, 'L1') nd(c, 'R2')]; %#ok<AGROW>
    elseif ismember(k, twot)
        edges = [edges; nd(c, '+') nd(c, '-')]; %#ok<AGROW>
    elseif contains(c.sf, 'diode')
        edges = [edges; nd(c, 'A+') nd(c, 'K-')]; %#ok<AGROW>
    end
end
edges = edges(all(~isnan(edges), 2), :);
for v = vs
    dcn = nd(comps(v), '-');
    NN = max([comps.node]);
    comp_nodes = bfs_dist(edges, dcn, NN); comp_nodes = find(isfinite(comp_nodes));
    inC = @(k) any(ismember(comps(k).node, comp_nodes));
    igc = ig(arrayfun(inC, ig));
    lower = igc(arrayfun(@(k) nd(comps(k), 'E') == dcn, igc));
    upper = igc(arrayfun(@(k) ~isempty(lower) && nd(comps(k), 'E') == nd(comps(lower(1)), 'C'), igc));
    if isempty(lower) || isempty(upper)
        fprintf(fid, '\n[%s] dış anahtar çifti çözülemedi\n', comps(v).name); continue
    end
    lower = lower(1); upper = upper(1);
    dcp = nd(comps(upper), 'C'); jx = nd(comps(upper), 'E');
    caps = isA('ee.passive.capacitor');
    mid = NaN;
    for a = caps
        if nd(comps(a), '+') == dcp
            b = caps(arrayfun(@(q) nd(comps(q), '+') == nd(comps(a), '-') && nd(comps(q), '-') == dcn, caps));
            if ~isempty(b), mid = nd(comps(a), '-'); capP = a; capN = b(1); end
        end
    end
    neu = setdiff(igc, [upper lower]);
    nmid = neu(arrayfun(@(k) nd(comps(k), 'C') == mid, neu));
    nph = setdiff(neu, nmid);
    phase = nd(comps(nph(1)), 'C'); ce = nd(comps(nph(1)), 'E');
    fprintf(fid, '\n==== Devre: DA kaynak "%s" (DA+ = N%03d, orta nokta = N%03d, DA− = N%03d, faz düğümü = N%03d, dış kol orta düğümü = N%03d)\n', ...
        comps(v).name, dcp, mid, dcn, phase, jx);
    fprintf(fid, '%-18s %-26s %-30s %-8s %-8s %s\n', 'Tez rolü', 'Blok', 'Bağlantı', 'Tablo', 'Beklenen', 'Durum');
    row = @(r, k, conn, exp) fprintf(fid, '%-18s %-26s %-30s %-8s %-8s %s\n', r, comps(k).name, conn, comps(k).tbl, exp, ...
        iff(strcmp(comps(k).tbl, exp), 'UYGUN', 'UYUMSUZ'));
    row('S1 dış üst', upper, sprintf('C=DA+ E=N%03d', jx), 'S12');
    row('S2 dış alt', lower, sprintf('C=N%03d E=DA-', jx), 'S12');
    row('S3 nötr (orta n.)', nmid(1), sprintf('C=orta E=N%03d (ortak E)', ce), 'S34');
    row('S4 nötr (faz)', nph(1), sprintf('C=faz E=N%03d (ortak E)', ce), 'S34');
    dic = di(arrayfun(inC, di));
    for k = dic
        A = nd(comps(k), 'A+'); K = nd(comps(k), 'K-');
        r = '?'; e = '?';
        if A == jx && K == dcp, r = 'DS1 (S1 ters p.)'; e = 'DS12';
        elseif A == dcn && K == jx, r = 'DS2 (S2 ters p.)'; e = 'DS12';
        elseif A == ce && K == mid, r = 'DS3 (S3 ters p.)'; e = 'DS34';
        elseif A == ce && K == phase, r = 'DS4 (S4 ters p.)'; e = 'DS34';
        elseif A == phase && K == dcp, r = 'D1 harici faz→DA+'; e = 'D12';
        elseif A == dcn && K == phase, r = 'D2 harici DA−→faz'; e = 'D12';
        end
        row(r, k, sprintf('A=N%03d K=N%03d', A, K), e);
    end
    % dış kol orta düğümü ile faz düğümü arasındaki seri eleman
    for k = 1:numel(comps)
        if numel(comps(k).node) >= 2 && all(ismember([jx phase], comps(k).node)) && ~contains(comps(k).sf, {'igbt', 'diode'})
            fprintf(fid, 'Dış kol orta düğümü–faz arası seri eleman: %s (%s)\n', comps(k).name, comps(k).sf);
        end
    end
    fprintf(fid, 'DA bara kapasitörleri: %s (DA+–orta), %s (orta–DA−)\n', comps(capP).name, comps(capN).name);
    % AA tarafı
    cs = isA('sensors.current'); cs = cs(arrayfun(inC, cs));
    for k = cs
        p = nd(comps(k), 'L1'); n = nd(comps(k), 'R2');
        nb = @(x) strjoin(setdiff({comps(arrayfun(@(q) any(comps(q).node == x), 1:numel(comps))).name}, comps(k).name), ', ');
        fprintf(fid, 'Akım sensörü %-40s + N%03d [%s]  →  − N%03d [%s]\n', comps(k).name, p, nb(p), n, nb(n));
    end
    grid = isA('ac_voltage'); grid = grid(arrayfun(inC, grid));
    if ~isempty(grid)
        g = grid(1);
        d = min(bfs_dist(edges, nd(comps(g), '+'), NN), bfs_dist(edges, nd(comps(g), '-'), NN));
        mi = isA('mutual_inductor'); mi = mi(arrayfun(inC, mi));
        for k = mi
            c = comps(k);
            s1 = d(nd(c, '1+')) < d(nd(c, '1-')); s2 = d(nd(c, '2+')) < d(nd(c, '2-'));
            fprintf(fid, 'CMC %-28s 1+ şebekeye %s, 2+ şebekeye %s → %s\n', c.name, iff(s1, 'yakın', 'uzak'), ...
                iff(s2, 'yakın', 'uzak'), iff(s1 == s2, 'nokta yönü doğru (DK akımında akılar birbirini götürür)', ...
                'NOKTA YÖNÜ TERS (DK akımında akılar toplanır)'));
        end
        ind = isA('ee.passive.inductor'); ind = ind(arrayfun(inC, ind));
        for k = ind
            fprintf(fid, 'L1 adayı %s: + N%03d, − N%03d; şebekeye uzaklık %g/%g düğüm\n', comps(k).name, nd(comps(k), '+'), ...
                nd(comps(k), '-'), d(nd(comps(k), '+')), d(nd(comps(k), '-')));
        end
        for k = caps(arrayfun(inC, caps))
            if any(comps(k).node == mid) && ~ismember(k, [capP capN])
                fprintf(fid, 'Orta noktaya bağlı filtre kapasitörü %s: N%03d–orta\n', comps(k).name, setdiff(comps(k).node, mid));
            end
        end
    end
end
fclose(fid);
end

function d = bfs_dist(edges, s, NN)
d = inf(1, NN); d(s) = 0; q = s;
while ~isempty(q)
    u = q(1); q(1) = [];
    nb = [edges(edges(:, 1) == u, 2); edges(edges(:, 2) == u, 1)]';
    for w = nb
        if isinf(d(w)), d(w) = d(u) + 1; q(end+1) = w; end %#ok<AGROW>
    end
end
end

%% ------------------------------------------------------------------------
function r = port_role(sf, raw)
tbl = struct( ...
    'igbt', {{'L1', 'G'; 'L2', 'H'; 'R1', 'C'; 'R2', 'E'}}, ...
    'diode_thermal', {{'L1', 'A+'; 'R1', 'K-'; 'L2', 'H?'; 'R2', 'H?'}}, ...
    'diode', {{'L1', 'A+'; 'R1', 'K-'}}, ...
    'mutual', {{'L1', '1+'; 'L2', '1-'; 'R1', '2+'; 'R2', '2-'}}, ...
    'twoterm', {{'L1', '+'; 'R1', '-'}});
if contains(sf, 'igbt'), t = tbl.igbt;
elseif contains(sf, 'diode_thermal'), t = tbl.diode_thermal;
elseif contains(sf, 'semiconductors.diode'), t = tbl.diode;
elseif contains(sf, 'mutual_inductor'), t = tbl.mutual;
elseif contains(sf, {'inductor', 'capacitor', 'resistor', 'voltage_source', 'ac_voltage', 'dc_voltage'}), t = tbl.twoterm;
else, r = raw; return
end
i = find(strcmp(t(:, 1), raw), 1);
if isempty(i), r = raw; else, r = t{i, 2}; end
end

function [act, kind] = active_params(sf)
% "Simplified I-V characteristics and event-based timing | Show thermal port"
% varyantında etkin olan parametreler (thermal: Tj'ye bağlı tablolar).
if contains(sf, 'igbt')
    kind = 'igbt';
    act = {'Tj_vec1', 'Ic_vec1', 'Vce_mat1', 'Vce_vec1', 'Rmiller', 'Goff', 'Vth', 't_on', 't_rise', 't_off', 't_fall', ...
        'v_meas', 'Tj_vec_loss', 'Ic_vec_loss', 'E_turn_on_mat1', 'E_turn_off_mat1', 'Rth', 'thermal_mass', ...
        'thermal_time_constant', 'thermal_mass_initial_temperatures', 'thermal_network_parameterization', 'Tdevice'};
else
    kind = 'diode';
    act = {'diode_parameterization', 'Vf', 'Ron', 'Goff', 'CJ', 'CJ0', 'c_param', 'iRM', 'iF', 'Iif', 'didt', 'trr', 'Qrr', ...
        'Vr', 'Ls', 'reverse_recovery', 'prm_rr', 'Tdevice', 'thermal_mass', 'fidelity', 'model_type', 'temperature_dependence'};
end
end

function s = short(b, mdl)
s = strrep(strrep(b, [mdl '/'], ''), newline, ' ');
end

function y = iff(c, a, b)
if c, y = a; else, y = b; end
end

function tf = inside_link(b, mdl)
% kütüphane bağlantılı ya da maskeli bir bloğun içindeyse true
tf = false;
p = get_param(b, 'Parent');
while ~strcmp(p, mdl)
    ref = get_param(p, 'ReferenceBlock');
    if ~isempty(ref) || strcmp(get_param(p, 'Mask'), 'on'), tf = true; return, end
    p = get_param(p, 'Parent');
end
end

function s = input_sources(b, mdl)
pc = get_param(b, 'PortConnectivity');
out = {};
for k = 1:numel(pc)
    if isempty(pc(k).SrcBlock) || ~isempty(regexp(pc(k).Type, 'Conn', 'once')), continue, end
    if pc(k).SrcBlock < 0, out{end+1} = sprintf('in%s:<bağsız>', pc(k).Type); continue, end %#ok<AGROW>
    out{end+1} = sprintf('in%s:%s/o%d', pc(k).Type, short(getfullname(pc(k).SrcBlock), mdl), pc(k).SrcPort + 1); %#ok<AGROW>
end
s = strjoin(out, ', ');
end

function s = key_params(b, bt, ref)
names = {};
switch bt
    case 'Gain', names = {'Gain'};
    case 'Constant', names = {'Value'};
    case 'Sin', names = {'SineType', 'Amplitude', 'Bias', 'Frequency', 'Phase', 'SampleTime'};
    case 'Sum', names = {'Inputs'};
    case 'Product', names = {'Inputs', 'Multiplication'};
    case 'Math', names = {'Operator', 'Exponent'};
    case 'Trigonometry', names = {'Operator'};
    case 'Fcn', names = {'Expr'};
    case 'RelationalOperator', names = {'Operator'};
    case 'Logic', names = {'Operator', 'Inputs'};
    case 'Switch', names = {'Criteria', 'Threshold'};
    case {'Goto', 'From'}, names = {'GotoTag', 'TagVisibility'};
    case 'TransportDelay', names = {'DelayTime', 'InitialOutput'};
    case 'Saturate', names = {'UpperLimit', 'LowerLimit'};
    case 'DataTypeConversion', names = {'OutDataTypeStr'};
    case 'Abs', names = {};
    case 'Sign', names = {};
    case 'Clock', names = {};
    case 'DigitalClock', names = {'SampleTime'};
    case 'Memory', names = {'InitialCondition'};
    case 'Lookup_n-D', names = {'BreakpointsForDimension1', 'Table'};
    case 'Display', names = {};
    case 'SubSystem'
        if strcmp(get_param(b, 'Mask'), 'on') || ~isempty(ref)
            try
                mn = get_param(b, 'MaskNames'); mv = get_param(b, 'MaskValues');
                s = strjoin(cellfun(@(a, c) sprintf('%s=%s', a, c), mn(:)', mv(:)', 'uni', 0), ', ');
                return
            catch
            end
        end
    otherwise
        try
            if strcmp(get_param(b, 'Mask'), 'on')
                mn = get_param(b, 'MaskNames'); mv = get_param(b, 'MaskValues');
                s = strjoin(cellfun(@(a, c) sprintf('%s=%s', a, c), mn(:)', mv(:)', 'uni', 0), ', ');
                return
            end
        catch
        end
end
parts = {};
for k = 1:numel(names)
    try
        v = get_param(b, names{k});
        if ischar(v), parts{end+1} = sprintf('%s=%s', names{k}, v); end %#ok<AGROW>
    catch
    end
end
s = strjoin(parts, ', ');
end
