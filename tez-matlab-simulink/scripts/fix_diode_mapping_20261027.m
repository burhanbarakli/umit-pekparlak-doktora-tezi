function report = fix_diode_mapping_20261027(src_slx, new_name)
% D-08 / K-18 düzeltmesi (İP-2b): harici D1–D2 diyotları ile nötr IGBT ters
% paralel diyotları (DS3–DS4) arasındaki parametre kümesi takasını giderir.
%
% Sorun (review/2026-10-27_TOPOLOJI_DENETIMI.md): faz–DA rayı konumundaki harici
% diyotlar (D1: A = faz, K = DA+; D2: A = DA−, K = faz) DS34_* (IXYN100N65C3H1 iç
% FRD) parametreleriyle; nötr IGBT'lerin ters paralel diyotları (A = ortak
% emetör, K = orta nokta / faz) D12_* (DSEI2x61-12B) parametreleriyle
% modellenmiş. Doğrusu (K-18): D1–D2 = D12_*, DS3–DS4 = DS34_*.
%
% Yapılan (en küçük değişiklik): bağlantıya dokunulmaz, blok eklenmez/silinmez.
% Her diode_thermal bloğunun rolü bağlantı grafiğinden (A/K düğümleri, IGBT
% C/E düğümleri ve DA bara kapasitörleri) çıkarılır; rolün beklediği tablo
% önekiyle (DS12 / DS34 / D12) bloğun kullandığı önek karşılaştırılır; yalnız
% DS34 <-> D12 farkı varsa önekle başlayan BÜTÜN diyalog parametreleri
% (Vf, Ron, Goff, CJ, c_param, iRM, iF, didt, trr, Qrr, Vr, Ls) yeni önekle
% yeniden yazılır. Sayı olarak yazılmış değerler (CJ0, Tdevice, thermal_mass)
% değişmez (D-10).
%   * PreLoadFcn (D-03): parametre dosyası, modelin bulunduğu klasörden yükleme
%     öncesinde taban çalışma alanında çalıştırılır (yeni ada göre yazılır).
%   * Yeni model kaynakla aynı klasöre <new_name>.slx olarak kaydedilir; kaynak
%     dosya değişmez.
%   * Denetim: <klasör>/../inspection/<new_name>_diyot_esleme.txt (+ .csv):
%     takas öncesi ve sonrası her diyotun rolü, A/K düğümleri, öneki ve temel
%     değerleri; temiz çalışma alanında yeniden yükleme ve derleme (update).
%
% Çağrı (proje kökünden):
%   matlab -batch "addpath('scripts'); fix_diode_mapping_20261027( ...
%       'runs/2026-10-27_diyot_esleme/model/inverter_senaryo3.slx', 'inverter_senaryo3_d08')"
% Tekrar çalıştırılabilir: her seferinde kaynak dosyadan başlar.

root_dir = fileparts(fileparts(mfilename('fullpath')));
src_slx = char(src_slx); new_name = char(new_name);
if isfile(fullfile(root_dir, src_slx)), src_slx = fullfile(root_dir, src_slx); end  % göreli: proje köküne göre
assert(isfile(src_slx), 'Kaynak model yok: %s', src_slx);
[model_dir, src_mdl] = fileparts(src_slx);
par_file = fullfile(model_dir, 'inverter_common_parameters.m');
assert(isfile(par_file), 'Parametre dosyası model klasöründe yok: %s', par_file);
ins_dir = fullfile(fileparts(model_dir), 'inspection');
if ~exist(ins_dir, 'dir'), mkdir(ins_dir); end
new_file = fullfile(model_dir, [new_name '.slx']);
src_hash = file_hash(src_slx);

cd(model_dir);  % slprj / önbellek bu klasörde kalır; which() yerel kopyayı bulur
for m = {new_name, src_mdl}
    if bdIsLoaded(m{1}), close_system(m{1}, 0); end
end
% D-03: parametre dosyası load_system'dan önce taban çalışma alanında
evalin('base', sprintf('run(''%s'');', par_file));
load_system(src_slx);
mdl = src_mdl;

% 1) Rol çıkarımı ve takas öncesi durum
before = diode_table(mdl);
assert(~isempty(before), 'diode_thermal bloğu bulunamadı');
assert(~any(strcmp({before.role}, '?')), 'Rolü çözülemeyen diyot var: %s', ...
    strjoin({before(strcmp({before.role}, '?')).name}, ', '));

% 2) Takas: yalnız DS34 <-> D12 (DS12 dış kol diyotlarına dokunulmaz)
blocks_before = find_system(mdl, 'LookUnderMasks', 'all', 'FollowLinks', 'on', 'Type', 'Block');
n_changed = 0; changed_params = {};
for k = 1:numel(before)
    d = before(k);
    if strcmp(d.prefix, d.expected), continue, end
    assert(all(ismember({d.prefix, d.expected}, {'DS34', 'D12'})), ...
        '%s: beklenmeyen önek farkı %s -> %s (yalnız DS34<->D12 takası yapılır)', d.name, d.prefix, d.expected);
    [names, vals] = prefixed_params(d.block, d.prefix);
    % etkin 12 elektriksel parametre mutlaka bulunmalı; enum/ısıl seçim parametreleri
    % (model türü, toparlanma, kesinlik, sıcaklık, ısıl ağ) de aynı önekle takas edilir
    core = {'Vf', 'Ron', 'Goff', 'CJ', 'C_param', 'iRM', 'iF', 'didt', 'trr', 'Qrr', 'Vr', 'Ls'};
    assert(all(ismember(core, names)), '%s: eksik çekirdek parametre: %s', d.name, ...
        strjoin(setdiff(core, names), ', '));
    for q = 1:numel(names)
        nv = regexprep(vals{q}, ['^' d.prefix '_'], [d.expected '_']);
        assert(evalin('base', sprintf('exist(''%s'', ''var'')', strtok(nv, ' ()*+-/'))) == 1, ...
            '%s.%s: %s taban çalışma alanında tanımlı değil', d.name, names{q}, nv);
        set_param(d.block, names{q}, nv);
    end
    n_changed = n_changed + 1;
    changed_params{end+1} = sprintf('%s: %s', d.name, strjoin(names, ', ')); %#ok<AGROW>
end
blocks_after = find_system(mdl, 'LookUnderMasks', 'all', 'FollowLinks', 'on', 'Type', 'Block');
assert(isequal(sort(blocks_before), sort(blocks_after)), 'Blok kümesi değişti');

% 3) PreLoadFcn (D-03) ve açıklama
pre = ['d08_pre_dir = fileparts(which(''' new_name ''')); ' ...
    'if isempty(d08_pre_dir), d08_pre_dir = pwd; end; ' ...
    'run(fullfile(d08_pre_dir, ''inverter_common_parameters.m'')); clear d08_pre_dir'];
old_pre = get_param(mdl, 'PreLoadFcn');
set_param(mdl, 'PreLoadFcn', pre);
set_param(mdl, 'Description', sprintf(['%s\n\n[27.10.2026, fix_diode_mapping_20261027.m] D-08/K-18: ' ...
    'harici D1-D2 diyotlari D12_* (DSEI2x61-12B), notr IGBT ters paralel diyotlari DS3-DS4 ' ...
    'DS34_* (IXYN ic FRD) parametrelerine alindi (%d blok); baglanti degismedi; PreLoadFcn ' ...
    'yeni ada gore yazildi. Kaynak: %s.slx'], get_param(mdl, 'Description'), n_changed, src_mdl));
save_system(mdl, new_file);
close_system(new_name, 0);
assert(strcmp(file_hash(src_slx), src_hash), 'Kaynak dosya değişti!');
fprintf('kaydedildi: %s (%d diyot takaslandı)\n', new_file, n_changed);

% 4) Temiz çalışma alanında yeniden yükleme: PreLoadFcn + kalıcılık + derleme
evalin('base', 'clear');
load_system(new_file);
pre_ok = evalin('base', 'exist(''D12_Qrr'', ''var'') == 1 && exist(''DS34_Qrr'', ''var'') == 1');
assert(pre_ok, 'PreLoadFcn parametre dosyasını çalıştırmadı');
after = diode_table(new_name);
assert(all(strcmp({after.prefix}, {after.expected})), 'Takas sonrası uyumsuz diyot kaldı');
assert(isequal([after.A], [before.A]) && isequal([after.K], [before.K]) && ...
    isequal({after.name}, {before.name}), 'Diyot düğümleri değişti');
set_param(new_name, 'SimulationCommand', 'update');
upd = 'başarılı';
fprintf('derleme denetimi: %s\n', upd);
close_system(new_name, 0);

% 5) Denetim dosyaları
txt_file = fullfile(ins_dir, [new_name '_diyot_esleme.txt']);
fid = fopen(txt_file, 'w', 'n', 'UTF-8');
c = onCleanup(@() fclose(fid));
fprintf(fid, 'fix_diode_mapping_20261027 — %s — MATLAB %s\n', char(datetime('now')), version);
fprintf(fid, 'Kaynak: %s (SHA-256 %s, değişmedi)\nYeni:   %s\n', src_slx, src_hash, new_file);
fprintf(fid, 'Parametre dosyası: %s (load_system öncesi taban çalışma alanında)\n', par_file);
fprintf(fid, 'Önceki PreLoadFcn: %s\nYeni PreLoadFcn:   %s\n', iff(isempty(old_pre), '(yok)', old_pre), pre);
fprintf(fid, 'Blok kümesi değişmedi (%d blok); bağlantı değişmedi (A/K düğümleri önce = sonra).\n', numel(blocks_before));
fprintf(fid, 'Takaslanan diyot: %d\n', n_changed);
fprintf(fid, '  %s\n', changed_params{:});
fprintf(fid, 'Temiz çalışma alanında yükleme: PreLoadFcn D12_Qrr/DS34_Qrr tanımladı = %d\n', pre_ok);
fprintf(fid, 'Derleme (SimulationCommand=update): %s\n\n', upd);
fprintf(fid, '%s', format_table('TAKAS ÖNCESİ', before));
fprintf(fid, '\n%s', format_table('TAKAS SONRASI (diskten yeniden yüklenen model)', after));
rows = {};
for k = 1:numel(before)
    rows(end+1, :) = {before(k).circuit, before(k).name, before(k).role, before(k).A_lbl, before(k).K_lbl, ...
        before(k).prefix, after(k).prefix, before(k).expected, before(k).Vf, after(k).Vf, ...
        before(k).Qrr, after(k).Qrr, before(k).trr, after(k).trr, before(k).iRM, after(k).iRM}; %#ok<AGROW>
end
writetable(cell2table(rows, 'VariableNames', {'devre', 'blok', 'rol', 'A', 'K', 'onek_once', ...
    'onek_sonra', 'onek_beklenen', 'Vf_once', 'Vf_sonra', 'Qrr_once', 'Qrr_sonra', 'trr_once', ...
    'trr_sonra', 'iRM_once', 'iRM_sonra'}), fullfile(ins_dir, [new_name '_diyot_esleme.csv']), ...
    'Encoding', 'UTF-8');
fprintf('denetim: %s\n', txt_file);
report = struct('before', before, 'after', after, 'n_changed', n_changed, 'file', new_file);
end

% ---------------------------------------------------------------------------
function T = diode_table(mdl)
% Üst düzey Simscape bloklarından fiziksel düğümler (union-find, çizgi ağacı)
% ve diode_thermal bloklarının T-tipi bacaktaki rolü.
ssc = find_system(mdl, 'SearchDepth', 1, 'BlockType', 'SimscapeBlock');
sf = get_param(ssc, 'SourceFile');
phs = {};
for k = 1:numel(ssc)
    ph = get_param(ssc{k}, 'PortHandles');
    phs{k} = struct('L', ph.LConn, 'R', ph.RConn); %#ok<AGROW>
end
% union-find: port tutamacı ↔ çizgi tutamacı ↔ çizgi ağacı
keys_ = []; parent = [];
    function i = id(h)
        i = find(keys_ == h, 1);
        if isempty(i), keys_(end+1) = h; parent(end+1) = numel(keys_); i = numel(keys_); end
    end
    function r = root(i)
        while parent(i) ~= i, parent(i) = parent(parent(i)); i = parent(i); end
        r = i;
    end
    function unite(a, b)
        ra = root(id(a)); rb = root(id(b));
        if ra ~= rb, parent(ra) = rb; end
    end
all_phys = find_system(mdl, 'SearchDepth', 1, 'Type', 'Block');
for k = 1:numel(all_phys)
    ph = get_param(all_phys{k}, 'PortHandles');
    for h = [ph.LConn ph.RConn]
        id(h);
        L = get_param(h, 'Line');
        if L > 0
            unite(h, L);
            ch = get_param(L, 'LineChildren'); for p = 1:numel(ch), unite(L, ch(p)); end
            pa = get_param(L, 'LineParent'); if pa > 0, unite(L, pa); end
        end
    end
end
lines_all = find_system(mdl, 'SearchDepth', 1, 'FindAll', 'on', 'Type', 'line');
for k = 1:numel(lines_all)
    L = lines_all(k);
    ch = get_param(L, 'LineChildren'); for p = 1:numel(ch), unite(L, ch(p)); end
    pa = get_param(L, 'LineParent'); if pa > 0, unite(L, pa); end
end
node = @(h) root(id(h));
% IGBT'ler (L1=G, L2=H, R1=C, R2=E), DA kapasitörleri (L1=+, R1=-)
ig = struct('name', {}, 'tbl', {}, 'C', {}, 'E', {});
caps = zeros(0, 2);
for k = 1:numel(ssc)
    if contains(sf{k}, 'igbt')
        ig(end+1) = struct('name', ssc{k}, 'tbl', table_prefix(ssc{k}, {'S12', 'S34'}), ...
            'C', node(phs{k}.R(1)), 'E', node(phs{k}.R(2))); %#ok<AGROW>
    elseif contains(sf{k}, 'ee.passive.capacitor')
        caps(end+1, :) = [node(phs{k}.L(1)) node(phs{k}.R(1))]; %#ok<AGROW>
    end
end
outer = ig(strcmp({ig.tbl}, 'S12'));
neut = ig(strcmp({ig.tbl}, 'S34'));
% her devre: alt dış IGBT'nin E'si DA−; üst dış IGBT'nin E'si alt dış IGBT'nin C'si
T = struct('circuit', {}, 'name', {}, 'block', {}, 'role', {}, 'A', {}, 'K', {}, 'A_lbl', {}, ...
    'K_lbl', {}, 'prefix', {}, 'expected', {}, 'Vf', {}, 'Qrr', {}, 'trr', {}, 'iRM', {});
circ = 0;
di = find(contains(sf, 'diode_thermal'));
for lo = 1:numel(outer)
    up = find([outer.E] == outer(lo).C, 1);
    if isempty(up), continue, end
    circ = circ + 1;
    dcp = outer(up).C; dcn = outer(lo).E; jx = outer(lo).C;
    % orta nokta: DA+–x ve x–DA− kapasitör çifti
    mid = NaN;
    for a = 1:size(caps, 1)
        if caps(a, 1) == dcp && any(caps(:, 1) == caps(a, 2) & caps(:, 2) == dcn), mid = caps(a, 2); end
    end
    nm = neut([neut.C] == mid);
    assert(~isempty(nm), 'Devre %d: orta noktaya bağlı nötr IGBT yok', circ);
    np = neut([neut.E] == nm(1).E & [neut.C] ~= mid);
    ce = nm(1).E; ph_ = np(1).C;
    lbl = containers.Map({dcp, dcn, jx, mid, ce, ph_}, {'DA+', 'DA−', 'dış orta', 'orta nokta', 'ortak E', 'faz'});
    for k = di'
        A = node(phs{k}.L(1)); K = node(phs{k}.R(1));
        if ~all(isKey(lbl, {A, K})), continue, end
        if A == jx && K == dcp, r = 'DS1 (S1 ters paralel)'; e = 'DS12';
        elseif A == dcn && K == jx, r = 'DS2 (S2 ters paralel)'; e = 'DS12';
        elseif A == ce && K == mid, r = 'DS3 (S3 ters paralel)'; e = 'DS34';
        elseif A == ce && K == ph_, r = 'DS4 (S4 ters paralel)'; e = 'DS34';
        elseif A == ph_ && K == dcp, r = 'D1 harici (faz -> DA+)'; e = 'D12';
        elseif A == dcn && K == ph_, r = 'D2 harici (DA- -> faz)'; e = 'D12';
        else, r = '?'; e = '?';
        end
        p = table_prefix(ssc{k}, {'DS12', 'DS34', 'D12'});
        T(end+1) = struct('circuit', sprintf('%d (%s)', circ, get_param(outer(up).name, 'Name')), ...
            'name', get_param(ssc{k}, 'Name'), 'block', ssc{k}, 'role', r, 'A', A, 'K', K, ...
            'A_lbl', lbl(A), 'K_lbl', lbl(K), 'prefix', p, 'expected', e, ...
            'Vf', evalin('base', get_param(ssc{k}, 'Vf')), 'Qrr', evalin('base', get_param(ssc{k}, 'Qrr')), ...
            'trr', evalin('base', get_param(ssc{k}, 'trr')), 'iRM', evalin('base', get_param(ssc{k}, 'iRM'))); %#ok<AGROW>
    end
end
assert(numel(T) == numel(di), 'Rolü çıkarılamayan diode_thermal bloğu var (%d/%d)', numel(T), numel(di));
[~, o] = sort({T.name}); T = T(o);
end

function p = table_prefix(blk, allowed)
% Bloğun diyalog parametrelerinde kullanılan tablo öneki (tek olmalı)
p = {};
dp = fieldnames(get_param(blk, 'DialogParameters'));
for q = 1:numel(dp)
    v = get_param(blk, dp{q});
    if ~ischar(v), continue, end
    t = regexp(v, '^([A-Z][A-Za-z0-9]*?)_', 'tokens', 'once');
    if ~isempty(t) && ismember(t{1}, allowed), p{end+1} = t{1}; end %#ok<AGROW>
end
p = unique(p);
assert(numel(p) == 1, '%s: tablo öneki tek değil (%s)', blk, strjoin(p, ','));
p = p{1};
end

function [names, vals] = prefixed_params(blk, prefix)
names = {}; vals = {};
dp = fieldnames(get_param(blk, 'DialogParameters'));
for q = 1:numel(dp)
    v = get_param(blk, dp{q});
    if ischar(v) && startsWith(v, [prefix '_'])
        names{end+1} = dp{q}; vals{end+1} = v; %#ok<AGROW>
    end
end
end

function s = format_table(title, T)
s = sprintf('%s\n%-7s %-9s %-24s %-11s %-11s %-6s %-9s %-8s %-6s %-9s %-9s %s\n', title, 'devre', 'blok', 'rol', 'A', 'K', ...
    'önek', 'beklenen', 'durum', 'Vf[V]', 'Qrr[µC]', 'trr[ns]', 'iRM[A]');
for k = 1:numel(T)
    d = T(k);
    s = [s sprintf('%-7s %-9s %-24s %-11s %-11s %-6s %-9s %-8s %-6.2f %-9.2f %-9.0f %g\n', strtok(d.circuit), d.name, ...
        d.role, d.A_lbl, d.K_lbl, d.prefix, d.expected, iff(strcmp(d.prefix, d.expected), 'UYGUN', 'UYUMSUZ'), ...
        d.Vf, d.Qrr*1e6, d.trr*1e9, d.iRM)]; %#ok<AGROW>
end
end

function h = file_hash(f)
md = java.security.MessageDigest.getInstance('SHA-256');
fh = fopen(f, 'r'); b = fread(fh, inf, '*uint8'); fclose(fh);
md.update(b);
h = lower(reshape(dec2hex(typecast(md.digest(), 'uint8'))', 1, []));
end

function y = iff(c, a, b)
if c, y = a; else, y = b; end
end
