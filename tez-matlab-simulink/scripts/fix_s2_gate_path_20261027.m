function fix_s2_gate_path_20261027(varargin)
% D-01 / K-04 düzeltmesi (İP-1): S1+S2 modelinde S2 devresinin kapı yolunu kurar.
%
% Sorun: S2 devresinin Gate Drive1–4 alt sistemleri g12/g22/g32/g42 etiketlerini
% okur, bu etiketlerin Goto'su yoktur; S2 IGBT'leri hiç anahtarlanmaz.
% Tez tanımı (K-03): S2 = nötr IGBT'lerde tamamlayıcı anahtarlama iptal,
% alternans boyunca 1/0 (susturma). Bu, S3 modelinin susturmalı PWM yoludur;
% S2'de Sin³ katkısı yoktur (K-04: K3 = 0).
%
% Yapılan (en küçük değişiklik, S1 devresine dokunulmaz):
%   * S3 modelinden kopyalanan referans zinciri:
%       Sine Wave (faz phase_deg2) -> K1 (K12) --+
%       sin·sin·sin -> K3 (= 0, yalnız bu blokta) --+--> Sum -> PWM alt sistemi
%     K3 değişkeni (K33) global olarak değiştirilmez; kopya K3 bloğunun kazancı 0'dır.
%   * S3'ün susturmalı PWM alt sistemi (Subsystem2) kopyası; Out1..Out4 ->
%     global Goto g12/g22/g32/g42 (S1'deki g11..g41 ve S3'teki g13..g43 ile aynı
%     port sırası: dış üst, dış alt, nötr (pozitif alternansta 0), nötr (pozitif
%     alternansta 1)).
%   * PWM çıkışlarına sinyal kaydı (g12_S2 … g42_S2).
%   * PreLoadFcn: parametre dosyası model yüklenmeden önce çalışır (D-03).
%   * Sonuç: runs/2026-10-27_s2_kapi_onarimi/model/inverter_s1s2_s2onarim.slx
%     (kaynak kopya inverter_scenario1_parametric5_etiquetli.slx değişmez).
%
% Ardından: derleme denetimi (update), kapı mantığı testi (yalnız denetim yolu,
% 40 ms) ve isteğe bağlı kısa tam model duman koşusu.
%
% Çağrı (proje kökünden):
%   matlab -batch "addpath('scripts'); fix_s2_gate_path_20261027"
%   matlab -batch "addpath('scripts'); fix_s2_gate_path_20261027('smoke')"   % + 5 ms duman koşusu
% Tekrar çalıştırılabilir: her seferinde değişmemiş kopyadan başlar.

root_dir = fileparts(fileparts(mfilename('fullpath')));
run_dir = fullfile(root_dir, 'runs', '2026-10-27_s2_kapi_onarimi');
model_dir = fullfile(run_dir, 'model');
ins_dir = fullfile(run_dir, 'inspection');
pkg_dir = fullfile(root_dir, 'incoming_real_data', 'models', '2026-10-12_dort_senaryo_paketi');
src_mdl = 'inverter_scenario1_parametric5_etiquetli';
s3_mdl = 'inverter_senaryo3';
new_mdl = 'inverter_s1s2_s2onarim';
do_smoke = any(strcmpi(varargin, 'smoke'));

% 1) Run klasörü ve paket kopyası (ham pakete yazılmaz; yalnız okunur)
if ~exist(model_dir, 'dir'), mkdir(model_dir); end
if ~exist(ins_dir, 'dir'), mkdir(ins_dir); end
pkg_files = {[src_mdl '.slx'], [s3_mdl '.slx'], 'inverter_senaryo4.slx', 'inverter_common_parameters.m'};
for k = 1:numel(pkg_files)
    dst = fullfile(model_dir, pkg_files{k});
    if ~isfile(dst)
        copyfile(fullfile(pkg_dir, pkg_files{k}), dst);
    end
    assert(same_file(fullfile(pkg_dir, pkg_files{k}), dst), ...
        'Kopya paketle aynı değil: %s', dst);
end

cd(model_dir);  % slprj / önbellek bu klasörde kalır
for m = {new_mdl, src_mdl, s3_mdl}
    if bdIsLoaded(m{1}), close_system(m{1}, 0); end
end
% D-03: parametre dosyası load_system'dan önce taban çalışma alanında
evalin('base', sprintf('run(''%s'');', fullfile(model_dir, 'inverter_common_parameters.m')));
load_system(fullfile(model_dir, [s3_mdl '.slx']));
load_system(fullfile(model_dir, [src_mdl '.slx']));
mdl = src_mdl;

% Kaynak modelde beklenen durum: g12..g42 From var, Goto yok
tags = {'g12', 'g22', 'g32', 'g42'};
for k = 1:numel(tags)
    assert(~isempty(find_system(mdl, 'LookUnderMasks', 'all', 'BlockType', 'From', 'GotoTag', tags{k})), ...
        'From %s bulunamadı', tags{k});
    assert(isempty(find_system(mdl, 'LookUnderMasks', 'all', 'BlockType', 'Goto', 'GotoTag', tags{k})), ...
        'Goto %s zaten var: kaynak model beklenen durumda değil', tags{k});
end
blocks_before = find_system(mdl, 'LookUnderMasks', 'all', 'FollowLinks', 'on', 'Type', 'Block');

% 2) Yerleşim: mevcut blokların altına
top = find_system(mdl, 'SearchDepth', 1, 'Type', 'Block');
pos = cell2mat(cellfun(@(b) get_param(b, 'Position'), top(2:end), 'UniformOutput', false));
x0 = min(pos(:, 1)); y0 = max(pos(:, 4)) + 150;
place = @(dx, dy, w, h) [x0 + dx, y0 + dy, x0 + dx + w, y0 + dy + h];

% 3) S3 referans zincirinin kopyası (K3 = 0, faz phase_deg2, genlik K12)
P = struct();
P.sine = add_block([s3_mdl '/Sine Wave3'], [mdl '/S2 Sine Wave'], 'Position', place(0, 40, 40, 40));
set_param(P.sine, 'Phase', 'phase_deg2*pi/180');
P.k1 = add_block([s3_mdl '/K1'], [mdl '/S2 K1'], 'Position', place(200, 40, 50, 40));
set_param(P.k1, 'Gain', 'K12');
P.sq = add_block([s3_mdl '/Product15'], [mdl '/S2 sin2'], 'Position', place(120, 140, 40, 40));
P.cube = add_block([s3_mdl '/Product1'], [mdl '/S2 sin3'], 'Position', place(200, 140, 40, 40));
P.k3 = add_block([s3_mdl '/K3'], [mdl '/S2 K3'], 'Position', place(280, 140, 50, 40));
set_param(P.k3, 'Gain', '0');  % K-04: S2'de Sin³ katkısı yok; K33 değişkenine dokunulmaz
P.sum = add_block([s3_mdl '/Sum'], [mdl '/S2 Sum'], 'Position', place(400, 70, 30, 60));
P.pwm = add_block([s3_mdl '/Subsystem2'], [mdl '/S2 PWM susturma'], 'Position', place(500, 20, 620, 260));
assert(strcmp(get_param(P.sum, 'Inputs'), '|++'));
assert(strcmp(get_param(P.k1, 'Gain'), 'K12') && strcmp(get_param(P.k3, 'Gain'), '0'));

add_line(mdl, 'S2 Sine Wave/1', 'S2 K1/1', 'autorouting', 'on');
add_line(mdl, 'S2 Sine Wave/1', 'S2 sin2/1', 'autorouting', 'on');
add_line(mdl, 'S2 Sine Wave/1', 'S2 sin2/2', 'autorouting', 'on');
add_line(mdl, 'S2 sin2/1', 'S2 sin3/1', 'autorouting', 'on');
add_line(mdl, 'S2 Sine Wave/1', 'S2 sin3/2', 'autorouting', 'on');
add_line(mdl, 'S2 sin3/1', 'S2 K3/1', 'autorouting', 'on');
add_line(mdl, 'S2 K1/1', 'S2 Sum/1', 'autorouting', 'on');
add_line(mdl, 'S2 K3/1', 'S2 Sum/2', 'autorouting', 'on');
add_line(mdl, 'S2 Sum/1', 'S2 PWM susturma/1', 'autorouting', 'on');

% 4) PWM çıkışları -> global Goto g12..g42 (+ sinyal kaydı)
gph = get_param(P.pwm, 'PortHandles');
gto_src = find_system(mdl, 'SearchDepth', 1, 'BlockType', 'Goto', 'GotoTag', 'g11');
for k = 1:numel(tags)
    nm = sprintf('S2 Goto %s', tags{k});
    add_block(gto_src{1}, [mdl '/' nm], 'Position', place(1220, 30 + 55*(k-1), 60, 30));
    set_param([mdl '/' nm], 'GotoTag', tags{k}, 'TagVisibility', 'global');
    add_line(mdl, sprintf('S2 PWM susturma/%d', k), [nm '/1'], 'autorouting', 'on');
    set_param(gph.Outport(k), 'DataLogging', 'on', 'DataLoggingNameMode', 'Custom', ...
        'DataLoggingName', [tags{k} '_S2']);
end

% 5) PreLoadFcn (D-03): parametre dosyası model yüklenmeden önce taban çalışma alanında
pre = ['s2_pre_dir = fileparts(which(''' new_mdl ''')); ' ...
    'if isempty(s2_pre_dir), s2_pre_dir = pwd; end; ' ...
    'run(fullfile(s2_pre_dir, ''inverter_common_parameters.m'')); clear s2_pre_dir'];
set_param(mdl, 'PreLoadFcn', pre);
set_param(mdl, 'Description', sprintf(['%s\n\n[27.10.2026, fix_s2_gate_path_20261027.m] D-01/K-04: ' ...
    'S2 devresine S3 susturmalı PWM yolu (K12, phase_deg2, K3=0) ve g12..g42 Goto eklendi; ' ...
    'PreLoadFcn eklendi. Kaynak: %s.slx'], get_param(mdl, 'Description'), src_mdl));

% Değişiklik dökümü: yalnız eklenen bloklar; mevcut bloklar aynı kalmalı
blocks_after = find_system(mdl, 'LookUnderMasks', 'all', 'FollowLinks', 'on', 'Type', 'Block');
added = setdiff(blocks_after, blocks_before);
assert(isempty(setdiff(blocks_before, blocks_after)), 'Mevcut blok silinmiş/yeniden adlandırılmış');
assert(all(startsWith(added, [mdl '/S2 '])), 'Beklenmeyen yeni blok');

close_system(s3_mdl, 0);
new_file = fullfile(model_dir, [new_mdl '.slx']);
save_system(mdl, new_file);
mdl = new_mdl;
fprintf('kaydedildi: %s (%d yeni blok)\n', new_file, numel(added));

% 6) Denetimler
fid = fopen(fullfile(ins_dir, 'fix_s2_denetim.txt'), 'w', 'n', 'UTF-8');
c = onCleanup(@() fclose(fid));
fprintf(fid, 'fix_s2_gate_path_20261027 — %s — MATLAB %s\n', char(datetime('now')), version);
added_rel = strrep(extractAfter(added, [src_mdl '/']), newline, ' ');
added_top = added_rel(~contains(added_rel, '/'));
fprintf(fid, ['Model: %s\nKaynak: %s.slx (değişmedi)\n\nEklenen üst düzey bloklar (%d; alt sistem ' ...
    'içleriyle birlikte toplam %d blok; silinen/yeniden adlandırılan mevcut blok yok):\n'], ...
    new_file, src_mdl, numel(added_top), numel(added));
fprintf(fid, '  %s\n', added_top{:});

% 6a) Goto/From eşleşmesi ve sürülen IGBT'ler
fprintf(fid, '\nGoto/From eşleşmesi ve sürülen IGBT (parametre grubu):\n');
for k = 1:numel(tags)
    g = find_system(mdl, 'LookUnderMasks', 'all', 'BlockType', 'Goto', 'GotoTag', tags{k});
    f = find_system(mdl, 'LookUnderMasks', 'all', 'BlockType', 'From', 'GotoTag', tags{k});
    gd = get_param(f{1}, 'Parent');
    fprintf(fid, '  %s: Goto=%d From=%d  %s -> %s\n', tags{k}, numel(g), numel(f), ...
        clean(gd), igbt_info(gd));
end
for k = 1:4
    t1 = sprintf('g%d1', k);
    f = find_system(mdl, 'LookUnderMasks', 'all', 'BlockType', 'From', 'GotoTag', t1);
    gd = get_param(f{1}, 'Parent');
    fprintf(fid, '  %s (S1, karşılaştırma): %s -> %s\n', t1, clean(gd), igbt_info(gd));
end

% 6b) Temiz taban çalışma alanında PreLoadFcn denetimi
close_system(mdl, 0);
evalin('base', 'clear');
load_system(new_file);
pre_ok = evalin('base', 'exist(''K12'', ''var'') == 1 && exist(''DS12_Qrr'', ''var'') == 1');
fprintf(fid, '\nPreLoadFcn: temiz çalışma alanında yükleme sonrası K12/DS12_Qrr tanımlı = %d\n', pre_ok);
assert(pre_ok, 'PreLoadFcn parametre dosyasını çalıştırmadı');

% 6c) Derleme denetimi
set_param(mdl, 'SimulationCommand', 'update');
fprintf(fid, 'Derleme (SimulationCommand=update): başarılı\n');
fprintf('derleme denetimi: başarılı\n');

% 6d) Kapı mantığı testi: yalnız eklenen denetim yolu, 40 ms (iki tam periyot)
logic = gate_logic_test(mdl, ins_dir);
fprintf(fid, '\nKapı mantığı testi (yalnız denetim yolu, 0–40 ms, K12=%.4g, phase_deg2=%g):\n', ...
    evalin('base', 'K12'), evalin('base', 'phase_deg2'));
fprintf(fid, '%s', logic);

% 6e) İsteğe bağlı: tam model kısa duman koşusu (Normal mod)
if do_smoke
    smk = smoke_run(mdl, 0.005);
    fprintf(fid, '\nDuman koşusu (tam model, Normal mod, 0–5 ms):\n%s', smk);
end
close_system(mdl, 0);
fprintf('denetim: %s\n', fullfile(ins_dir, 'fix_s2_denetim.txt'));
end

% ---------------------------------------------------------------------------
function txt = gate_logic_test(mdl, ins_dir)
tm = 's2_kapi_mantik_testi';
if bdIsLoaded(tm), close_system(tm, 0); end
new_system(tm);
names = {'S2 Sine Wave', 'S2 K1', 'S2 sin2', 'S2 sin3', 'S2 K3', 'S2 Sum', 'S2 PWM susturma'};
for k = 1:numel(names)
    add_block([mdl '/' names{k}], [tm '/' names{k}], 'Position', get_param([mdl '/' names{k}], 'Position'));
end
add_line(tm, 'S2 Sine Wave/1', 'S2 K1/1');
add_line(tm, 'S2 Sine Wave/1', 'S2 sin2/1');
add_line(tm, 'S2 Sine Wave/1', 'S2 sin2/2');
add_line(tm, 'S2 sin2/1', 'S2 sin3/1');
add_line(tm, 'S2 Sine Wave/1', 'S2 sin3/2');
add_line(tm, 'S2 sin3/1', 'S2 K3/1');
add_line(tm, 'S2 K1/1', 'S2 Sum/1');
add_line(tm, 'S2 K3/1', 'S2 Sum/2');
add_line(tm, 'S2 Sum/1', 'S2 PWM susturma/1');
ph = get_param([tm '/S2 PWM susturma'], 'PortHandles');
sph = get_param([tm '/S2 Sum'], 'PortHandles');
set_param(sph.Outport(1), 'DataLogging', 'on', 'DataLoggingNameMode', 'Custom', 'DataLoggingName', 'ref');
tags = {'g12', 'g22', 'g32', 'g42'};
for k = 1:4
    set_param(ph.Outport(k), 'DataLogging', 'on', 'DataLoggingNameMode', 'Custom', 'DataLoggingName', tags{k});
end
set_param(tm, 'StopTime', '0.04', 'Solver', 'ode45', 'MaxStep', '1e-7', ...
    'SignalLogging', 'on', 'SignalLoggingName', 'logsout', 'ReturnWorkspaceOutputs', 'on');
out = sim(tm);
L = out.logsout;
r = L.getElement('ref').Values;
rows = {};
txt = sprintf('  %-4s %-28s %-28s\n', 'kapı', 'pozitif alternans (1–9 ms)', 'negatif alternans (11–19 ms)');
for k = 1:4
    v = L.getElement(tags{k}).Values;
    t = v.Time; d = double(squeeze(v.Data));
    s = '';
    for w = [0.001 0.009; 0.011 0.019]'
        idx = t >= w(1) & t <= w(2);
        dd = d(idx);
        n_sw = sum(abs(diff(dd)) > 0.5);
        duty = trapz(t(idx), dd) / (w(2) - w(1));
        s = [s sprintf('%-28s ', sprintf('geçiş=%d, ort=%.3f', n_sw, duty))]; %#ok<AGROW>
        rows(end+1, :) = {tags{k}, w(1), w(2), n_sw, duty, min(dd), max(dd)}; %#ok<AGROW>
    end
    txt = [txt sprintf('  %-4s %s\n', tags{k}, s)]; %#ok<AGROW>
end
% ikinci periyotta aynı mı (21–29 / 31–39 ms)?
txt = [txt sprintf('  referans: tepe=%.4f (beklenen K12·pwm_ref_amp)\n', max(abs(r.Data)))];
% Örtüşme denetimi: aynı anda iletimde olmaması gereken çiftler
g = cell(1, 4);
tt = L.getElement('g12').Values.Time;
for k = 1:4
    v = L.getElement(tags{k}).Values;
    g{k} = interp1(v.Time, double(squeeze(v.Data)), tt, 'previous', 'extrap');
end
txt = [txt sprintf('  örtüşme süresi g12&g32 = %.3g s, g22&g42 = %.3g s, g12&g22 = %.3g s\n', ...
    overlap(tt, g{1}, g{3}), overlap(tt, g{2}, g{4}), overlap(tt, g{1}, g{2}))];
writetable(cell2table(rows, 'VariableNames', {'kapi', 't_bas', 't_bit', 'gecis', 'ortalama', 'min', 'max'}), ...
    fullfile(ins_dir, 's2_kapi_mantik_testi.csv'));
% Şekil
fig = figure('Visible', 'off', 'Position', [100 100 900 700]);
subplot(5, 1, 1); plot(r.Time*1e3, squeeze(r.Data)); ylabel('ref'); grid on
for k = 1:4
    v = L.getElement(tags{k}).Values;
    subplot(5, 1, k+1); stairs(v.Time*1e3, double(squeeze(v.Data))); ylim([-0.2 1.2]); ylabel(tags{k}); grid on
end
xlabel('t [ms]');
exportgraphics(fig, fullfile(ins_dir, 's2_kapi_mantik_testi.png'), 'Resolution', 200);
close(fig);
close_system(tm, 0);
end

function s = overlap(t, a, b)
both = (a > 0.5) & (b > 0.5);
s = sum(diff(t) .* both(1:end-1));
end

function txt = smoke_run(mdl, tstop)
% Gate Drive1–4 (S2) ve 5–8 (S1) çıkışlarını bellekte kaydet; model kaydedilmez.
gds = find_system(mdl, 'SearchDepth', 1, 'Regexp', 'on', 'Name', '^Gate.Drive[1-8]$');
for k = 1:numel(gds)
    ph = get_param(gds{k}, 'PortHandles');
    set_param(ph.Outport(1), 'DataLogging', 'on', 'DataLoggingNameMode', 'Custom', ...
        'DataLoggingName', regexprep(clean(get_param(gds{k}, 'Name')), '\W', '_'));
end
set_param(mdl, 'SignalLogging', 'on', 'SignalLoggingName', 'logsout', 'ReturnWorkspaceOutputs', 'on');
w = tic;
out = sim(mdl, 'StopTime', num2str(tstop), 'SimulationMode', 'normal');
txt = sprintf('  duvar süresi %.0f s\n', toc(w));
L = out.logsout;
for e = 1:L.numElements
    el = L.getElement(e);
    t = el.Values.Time; d = double(squeeze(el.Values.Data));
    if size(d, 1) ~= numel(t), d = d.'; end
    d = d(:, 1);
    idx = t >= 0.001;
    txt = [txt sprintf('  %-22s min=%9.4g max=%9.4g geçiş(>orta)=%d son=%9.4g\n', el.Name, ...
        min(d(idx)), max(d(idx)), sum(abs(diff(d(idx) > (min(d(idx)) + max(d(idx)))/2))), d(end))]; %#ok<AGROW>
end
end

function s = igbt_info(gd)
% Gate Drive çıkışının bağlı olduğu IGBT ve parametre grubu (S12_/S34_)
% (fiziksel uçlara doğrudan çizgiyle bağlı IGBT; ara düğümler izlenmez)
s = '';
ph = get_param(gd, 'PortHandles');
dst = [];
for h = [ph.LConn ph.RConn]
    l = get_param(h, 'Line');
    if l < 0, continue, end
    b = [get_param(l, 'SrcBlockHandle'), reshape(get_param(l, 'DstBlockHandle'), 1, [])];
    dst = [dst b(b > 0)]; %#ok<AGROW>
end
dst = unique(dst);
for d = dst
    nm = getfullname(d);
    if ~contains(nm, 'IGBT'), continue, end
    grp = '?';
    try
        p = fieldnames(get_param(nm, 'DialogParameters'));
        for q = 1:numel(p)
            v = get_param(nm, p{q});
            if ischar(v)
                tok = regexp(v, '\<(S12|S34)_', 'tokens', 'once');
                if ~isempty(tok), grp = tok{1}; break, end
            end
        end
    catch
    end
    s = [s sprintf('%s [%s] ', clean(nm), grp)]; %#ok<AGROW>
end
end

function tf = same_file(a, b)
fa = fopen(a, 'r'); da = fread(fa, inf, '*uint8'); fclose(fa);
fb = fopen(b, 'r'); db = fread(fb, inf, '*uint8'); fclose(fb);
tf = isequal(da, db);
end

function s = clean(s)
s = strrep(s, newline, ' ');
end
