function out = calibrate_s1s3_20261028(action, varargin)
% İP-4: S1, S2 ve S3'ün ortak parametre kalibrasyonu (K-01, K-02a, İ5).
%
% Taban model: runs/2026-10-27_diyot_esleme/model/*_d08.slx (D-01 + D-03 + D-08).
% Bu betik D-09'u (K-17) uygular ve senaryo başına iki serbest değişkeni
% (modülasyon genliği ölçeği s ve referans fazı) deney özet tablosuna göre ayarlar.
% Devre parametreleri değişmez. S3'te K13 ve K33 aynı s ile ölçeklenir (K33/K13 sabit).
%
% Eylemler (proje kökünden; tek MATLAB süreci tek eylem):
%   calibrate_s1s3_20261028('prepare')
%       Koşu klasörü runs/2026-10-28_kalibrasyon/ altında model kopyaları:
%         model_s3/inverter_senaryo3_kal.slx    S3, D-08 + D-09
%         model_s1/inverter_s1_kal.slx          S1+S2 modelinden yalnız S1 devresi, D-08 + D-09
%         model_s1/inverter_s1_esd.slx          aynı ayırma, yalnız D-08 (birleşik modelle eşdeğerlik denetimi)
%         model_s2/inverter_s2_kal.slx, inverter_s2_esd.slx   S2 devresi için aynısı
%       Ayırma: diğer devrenin fiziksel ağı ve ona bağlı sinyal blokları (çizgi + global
%       Goto/From etiketi bileşeni) Commented = 'on' yapılır; blok silinmez.
%       D-09: Capacitor6/Capacitor7  c = EMC_Cx_eq, r = EMC_Rx_eq.
%       InitFcn'e kalibrasyon kancası eklenir: parametre dosyasından sonra, model
%       klasöründe <model>_kalibrasyon.m varsa çalıştırılır (yalnız K1x/K33/phase_deg*).
%   calibrate_s1s3_20261028('run', case_id, tag, s, phase_deg)
%       case_id: 's3' | 's1' | 's2' | 's1_esd' | 's2_esd'. s: genlik ölçeği (1 = m-dosyası),
%       phase_deg: referans fazı [°]. Accelerator modunda 0,1 s koşar; çıktı
%       runs/2026-10-28_kalibrasyon/results/<tag>/ (metrikler.csv, fazorler.csv,
%       kosu_bilgisi.txt, ozet.mat, dalga.mat [git'e girmez]).
%   calibrate_s1s3_20261028('predict', case_id, {tag1, tag2, ...})
%       Son koşunun ölçülen C noktası fazörlerinden LCL + EMC ağ modeliyle (İP-3,
%       analyze_q_sign_20261027.m ile aynı ağ) hedef P_ac ve |Q1| için gereken evirici
%       temel gerilimini (V_A) çözer; V_A ↔ (s, faz) kazancını önceki koşulardan
%       tahmin eder (yoksa 1) ve bir sonraki (s, faz) önerisini yazar.
%       NOT (28.10.2026): bu tahmin köprüyü sert gerilim kaynağı sayar; koşular köprünün
%       sert olmadığını gösterdi (S1 ölü zaman, S2/S3 süreksiz iletim). İlk adımdan sonra
%       aşağıdaki iki ampirik tahminci kullanıldı.
%   calibrate_s1s3_20261028('predict_emp', case_id, {tag1, tag2, tag3, ...})
%       (ln s, φ) -> (P_ac, Q1) düzlemi koşulara en küçük kareyle oturtulur, Newton adımı.
%   calibrate_s1s3_20261028('predict_th', case_id, {..., tag_n-1, tag_n})
%       Thevenin köprü modeli: V_int = s·V0∠φ, V_A = V_int − Z_th·I_L1; Z_th son iki
%       koşudan çözülür, ağ modeliyle hedef (s, φ) bulunur.
%   calibrate_s1s3_20261028('dcm', {tags})
%       Kutup gerilimi ara seviye (süreksiz iletim) zaman oranı -> sureksiz_iletim.csv
%   calibrate_s1s3_20261028('table')
%       runs/2026-10-28_kalibrasyon/kalibrasyon_tablosu.csv (tablo_secimi.json'daki
%       önce/sonra koşularından).
%
% Sayılar tez bulgusu değildir (İ5): kalibre benzetim, deneyin özet tablosunu
% belirtilen hata ile yeniden üretir.

root_dir = fileparts(fileparts(mfilename('fullpath')));
run_dir = fullfile(root_dir, 'runs', '2026-10-28_kalibrasyon');
src_dir = fullfile(root_dir, 'runs', '2026-10-27_diyot_esleme', 'model');
switch lower(action)
    case 'prepare', out = do_prepare(run_dir, src_dir);
    case 'run',     out = do_run(run_dir, varargin{:});
    case 'predict', out = do_predict(run_dir, varargin{:});
    case 'table',   out = do_table(run_dir, root_dir);
    case 'dcm',     out = do_dcm(run_dir, varargin{:});
    case 'predict_emp', out = do_predict_emp(run_dir, varargin{:});
    case 'predict_th', out = do_predict_th(run_dir, varargin{:});
    otherwise, error('Bilinmeyen eylem: %s', action);
end
end

% =====================================================================
function C = case_def(id)
% Senaryo tanımları. Ölçüm kaynakları Display bloklarının kaynak blok/port
% eşlemesinden (D-04; review/2026-10-27_D08_DIYOT_ESLEME.md ile aynı).
srcA = {'Pac','Mean9',1; 'Q','Mean10',1; 'Irms','RMS1',1; 'THD','THD',1; 'Pdc','Mean1',1; ...
    'Idc','Mean3',1; 'Vdc','Mean2',1; 'eta','Divide3',1; 'cosfi','Divide1',1; ...
    'P1','Power3',1; 'Q1','Power3',2; 'cosfi1','Divide5',1; 'THDv','THD2',1};
srcB = {'Pac','Mean8',1; 'Q','Mean5',1; 'Irms','RMS2',1; 'THD','THD1',1; 'Pdc','Mean4',1; ...
    'Idc','Mean7',1; 'Vdc','Mean6',1; 'eta','Divide4',1; 'cosfi','Divide2',1; ...
    'P1','Power1',1; 'Q1','Power1',2; 'cosfi1','Divide6',1; 'THDv','THD3',1};
switch id
    case 's3'
        C = struct('id', id, 'scen', 'S3', 'folder', 'model_s3', 'src', 'inverter_senaryo3_d08', ...
            'model', 'inverter_senaryo3_kal', 'd09', true, 'drop', '', 'keep', 'Voltage Source', ...
            'kvars', {{'K13', 'K33'}}, 'phvar', 'phase_deg3', 'n', 3, 'src_map', {srcA}, 'wsuf', '1');
    case {'s1', 's1_esd'}
        C = struct('id', id, 'scen', 'S1', 'folder', 'model_s1', 'src', 'inverter_s1s2_s2onarim_d08', ...
            'model', 'inverter_s1_kal', 'd09', true, 'drop', 'Voltage Source1', 'keep', 'Voltage Source', ...
            'kvars', {{'K11'}}, 'phvar', 'phase_deg1', 'n', 1, 'src_map', {srcA}, 'wsuf', '1');
    case {'s2', 's2_esd'}
        C = struct('id', id, 'scen', 'S2', 'folder', 'model_s2', 'src', 'inverter_s1s2_s2onarim_d08', ...
            'model', 'inverter_s2_kal', 'd09', true, 'drop', 'Voltage Source', 'keep', 'Voltage Source1', ...
            'kvars', {{'K12'}}, 'phvar', 'phase_deg2', 'n', 2, 'src_map', {srcB}, 'wsuf', '2');
    otherwise
        error('case_id: s3 | s1 | s2 | s1_esd | s2_esd');
end
if endsWith(id, '_esd')
    C.model = strrep(C.model, '_kal', '_esd');
    C.d09 = false;   % eşdeğerlik denetimi: birleşik D-08 modeliyle aynı devre
end
end

function T = targets(scen)
% inverter_common_parameters.m satır 262–271 (= değerler.xlsx 17.08.2026) ve K-02a bantları
switch scen
    case 'S1', T = struct('Vdc', 431.50, 'Idc', 0.624, 'Irms', 2.26, 'Pac', 249.60, 'Pdc', 269.26, ...
            'cosfi', 1.000, 'THD', 15.0, 'Qabs', 0.00, 'Qband', [0 7.9], 'eta', 92.50, 'Vac', 119.80);
    case 'S2', T = struct('Vdc', 395.00, 'Idc', 0.684, 'Irms', 2.33, 'Pac', 253.20, 'Pdc', 270.18, ...
            'cosfi', 0.995, 'THD', 47.0, 'Qabs', 25.42, 'Qband', [24.1 26.7], 'eta', 94.20, 'Vac', 121.00);
    case 'S3', T = struct('Vdc', 427.50, 'Idc', 0.697, 'Irms', 2.31, 'Pac', 281.20, 'Pdc', 297.97, ...
            'cosfi', 0.997, 'THD', 14.0, 'Qabs', 21.83, 'Qband', [19.9 23.6], 'eta', 94.50, 'Vac', 124.30);
end
end

% =====================================================================
function out = do_prepare(run_dir, src_dir)
if ~exist(run_dir, 'dir'), mkdir(run_dir); end
ins_dir = fullfile(run_dir, 'inspection');
if ~exist(ins_dir, 'dir'), mkdir(ins_dir); end
log = {};
for id = {'s3', 's1_esd', 's1', 's2_esd', 's2'}
    C = case_def(id{1});
    mdir = fullfile(run_dir, C.folder);
    if ~exist(mdir, 'dir'), mkdir(mdir); end
    copyfile(fullfile(src_dir, 'inverter_common_parameters.m'), mdir);
    cd(mdir);
    for m = {C.src, C.model}
        if bdIsLoaded(m{1}), close_system(m{1}, 0); end
    end
    evalin('base', 'clear');
    evalin('base', sprintf('run(''%s'');', fullfile(mdir, 'inverter_common_parameters.m')));
    load_system(fullfile(src_dir, [C.src '.slx']));
    mdl = C.src;
    lines = {sprintf('== %s (%s) <- %s.slx', C.model, C.scen, C.src)};
    % D-09 / K-17
    caps = find_system(mdl, 'SearchDepth', 1, 'Regexp', 'on', 'Name', '^Capacitor[67]$');
    for k = 1:numel(caps)
        old = sprintf('c=%s r=%s', get_param(caps{k}, 'c'), get_param(caps{k}, 'r'));
        if C.d09
            set_param(caps{k}, 'c', 'EMC_Cx_eq', 'r', 'EMC_Rx_eq');
        end
        lines{end+1} = sprintf('D-09 %s: %s -> c=%s r=%s', strrep(caps{k}, [mdl '/'], ''), old, ...
            get_param(caps{k}, 'c'), get_param(caps{k}, 'r')); %#ok<AGROW>
    end
    % S1+S2 ayırma
    if ~isempty(C.drop)
        [dropped, rep] = split_circuit(mdl, C.keep, C.drop);
        for k = 1:numel(dropped), set_param(dropped{k}, 'Commented', 'on'); end
        lines = [lines, rep]; %#ok<AGROW>
    end
    % InitFcn kalibrasyon kancası ve PreLoadFcn (D-03, yeni ada göre)
    init0 = get_param(mdl, 'InitFcn');
    hook = sprintf(['\nkal_dosya = fullfile(fileparts(get_param(bdroot,''FileName'')), [bdroot ''_kalibrasyon.m'']); ' ...
        'if isfile(kal_dosya), run(kal_dosya); end; clear kal_dosya']);
    set_param(mdl, 'InitFcn', [init0 hook]);
    set_param(mdl, 'PreLoadFcn', strrep(get_param(mdl, 'PreLoadFcn'), C.src, C.model));
    lines{end+1} = sprintf('InitFcn: %s', strrep(get_param(mdl, 'InitFcn'), newline, ' | ')); %#ok<AGROW>
    lines{end+1} = sprintf('PreLoadFcn: %s', get_param(mdl, 'PreLoadFcn')); %#ok<AGROW>
    set_param(mdl, 'Description', sprintf(['%s\n28.10.2026 İP-4 (calibrate_s1s3_20261028.m): %s; ' ...
        'InitFcn kalibrasyon kancası.'], get_param(mdl, 'Description'), ...
        ternary(C.d09, 'D-09 Capacitor6/7 = EMC_Cx_eq/EMC_Rx_eq', 'D-09 uygulanmadı (eşdeğerlik kopyası)')));
    save_system(mdl, fullfile(mdir, [C.model '.slx']));
    close_system(C.model, 0);
    % Temiz çalışma alanında yeniden yükleme + derleme denetimi
    evalin('base', 'clear');
    load_system(fullfile(mdir, [C.model '.slx']));
    ok_pre = evalin('base', 'exist(''EMC_Cx_eq'', ''var'') == 1');
    try
        set_param(C.model, 'SimulationCommand', 'update');
        ok = 'derleme (update) başarılı';
    catch err
        ok = ['derleme HATASI: ' err.message];
    end
    caps = find_system(C.model, 'SearchDepth', 1, 'Regexp', 'on', 'Name', '^Capacitor[67]$');
    for k = 1:numel(caps)
        lines{end+1} = sprintf('kayıtlı %s: c=%s r=%s Commented=%s', strrep(caps{k}, [C.model '/'], ''), ...
            get_param(caps{k}, 'c'), get_param(caps{k}, 'r'), get_param(caps{k}, 'Commented')); %#ok<AGROW>
    end
    lines{end+1} = sprintf('PreLoadFcn parametreleri tanımladı: %d; %s', ok_pre, ok); %#ok<AGROW>
    close_system(C.model, 0);
    fprintf('%s\n', lines{:});
    log = [log, lines, {''}]; %#ok<AGROW>
end
fid = fopen(fullfile(ins_dir, 'hazirlik.txt'), 'w', 'n', 'UTF-8');
fprintf(fid, '%s\n', log{:});
fclose(fid);
out = log;
end

function [dropped, rep] = split_circuit(mdl, keep_src, drop_src)
% Üst düzey blokları bağlantı bileşenlerine ayırır: çizgiler (sinyal + fiziksel,
% PortConnectivity) ve global Goto/From etiketleri. drop_src'yi içeren bileşen
% (diğer devre) döndürülür; keep_src ile aynı bileşene düşerse hata verir.
top = find_system(mdl, 'SearchDepth', 1, 'Type', 'Block');
top(strcmp(top, mdl)) = [];
n = numel(top);
hh = cellfun(@(b) get_param(b, 'Handle'), top);
par = 1:n;
    function r = fnd(ii)
        r = ii; while par(r) ~= r, r = par(r); end
        par(ii) = r;
    end
    function uni(ii, jj)
        ra = fnd(ii); rb = fnd(jj); if ra ~= rb, par(rb) = ra; end
    end
for i = 1:n
    pc = get_param(top{i}, 'PortConnectivity');
    for q = 1:numel(pc)
        nb = [pc(q).SrcBlock(:); pc(q).DstBlock(:)];
        for bh = nb.'
            j = find(hh == bh, 1);
            if ~isempty(j), uni(i, j); end
        end
    end
end
gf = [find_system(mdl, 'LookUnderMasks', 'all', 'FollowLinks', 'on', 'BlockType', 'Goto'); ...
      find_system(mdl, 'LookUnderMasks', 'all', 'FollowLinks', 'on', 'BlockType', 'From')];
tags = cellfun(@(b) get_param(b, 'GotoTag'), gf, 'UniformOutput', false);
anc = zeros(numel(gf), 1);
for k = 1:numel(gf)
    cur = gf{k};
    while ~strcmp(get_param(cur, 'Parent'), mdl), cur = get_param(cur, 'Parent'); end
    anc(k) = find(hh == get_param(cur, 'Handle'), 1);
end
ut = unique(tags);
for t = 1:numel(ut)
    ix = anc(strcmp(tags, ut{t}));
    for k = 2:numel(ix), uni(ix(1), ix(k)); end
end
roots = arrayfun(@fnd, 1:n);
ik = find(strcmp(top, [mdl '/' keep_src])); idr = find(strcmp(top, [mdl '/' drop_src]));
assert(~isempty(ik) && ~isempty(idr), 'Kaynak blok bulunamadı');
assert(roots(ik) ~= roots(idr), 'İki devre aynı bağlantı bileşeninde; ayırma yapılamaz');
dropped = top(roots == roots(idr));
% Denetim: iki şebeke kaynağı ve iki çözücü yapılandırması farklı bileşenlerde olmalı
rep_side = struct();
for gname = {'Grid1', 'Grid2', 'Solver Configuration1', 'Solver Configuration2'}
    ig = find(strcmp(top, [mdl '/' gname{1}]));
    if ~isempty(ig)
        rep_side.(strrep(gname{1}, ' ', '_')) = ternary(roots(ig) == roots(idr), 'kapatılan', ...
            ternary(roots(ig) == roots(ik), 'korunan', 'bağımsız')); %#ok<STRNU>
    end
end
kept = top(roots == roots(ik));
other = top(roots ~= roots(idr) & roots ~= roots(ik));
nm = @(c) strjoin(strrep(strrep(c, [mdl '/'], ''), newline, ' '), ', ');
rep = {sprintf('Ayırma: %d üst düzey blok; korunan devre (%s) bileşeni %d blok, kapatılan (%s) bileşeni %d blok, bağımsız %d blok', ...
    n, keep_src, numel(kept), drop_src, numel(dropped), numel(other)), ...
    ['  kapatılan (Commented=on): ' nm(dropped)], ['  bağımsız (dokunulmadı): ' nm(other)], ...
    ['  denetim: ' strjoin(cellfun(@(f) sprintf('%s=%s', f, rep_side.(f)), fieldnames(rep_side), 'UniformOutput', false), ', ')]};
end

% =====================================================================
function R = do_run(run_dir, id, tag, s, phase)
C = case_def(id);
mdir = fullfile(run_dir, C.folder);
odir = fullfile(run_dir, 'results', tag);
if ~exist(odir, 'dir'), mkdir(odir); end
cd(mdir);
mdl = C.model;
if bdIsLoaded(mdl), close_system(mdl, 0); end
evalin('base', 'clear');
pfile = fullfile(mdir, 'inverter_common_parameters.m');
evalin('base', sprintf('run(''%s'');', pfile));
% Kalibrasyon değerleri (m-dosyası değeri × s, faz)
k0 = cellfun(@(v) evalin('base', v), C.kvars);
ph0 = evalin('base', C.phvar);
if isnan(s), s = 1; end
if isnan(phase), phase = ph0; end   % NaN: m-dosyasındaki değer (kalibrasyonsuz)
kal = fullfile(mdir, [mdl '_kalibrasyon.m']);
fid = fopen(kal, 'w', 'n', 'UTF-8');
fprintf(fid, '%% İP-4 kalibrasyon değerleri, koşu %s (%s). calibrate_s1s3_20261028.m yazar.\n', tag, char(datetime('now')));
fprintf(fid, '%% genlik ölçeği s = %.12g, faz = %.12g derece (m-dosyası: faz %.6g)\n', s, phase, ph0);
for k = 1:numel(C.kvars)
    fprintf(fid, '%s = %.15g;   %% m-dosyası %.6g\n', C.kvars{k}, k0(k)*s, k0(k));
end
fprintf(fid, '%s = %.15g;\n', C.phvar, phase);
fclose(fid);
evalin('base', sprintf('run(''%s'');', kal));
load_system(fullfile(mdir, [mdl '.slx']));

% Kayıt: metrik kaynakları (seyreltilmiş) ve ham dalga biçimleri (V_A, V_C, I_C)
for k = 1:size(C.src_map, 1)
    b = [mdl '/' C.src_map{k, 2}];
    assert(strcmp(get_param(b, 'Commented'), 'off'), 'Kaynak kapalı: %s', b);
    ph = get_param(b, 'PortHandles');
    set_param(ph.Outport(C.src_map{k, 3}), 'DataLogging', 'on', 'DataLoggingNameMode', 'Custom', ...
        'DataLoggingName', ['m_' C.src_map{k, 1}], 'DataLoggingDecimateData', 'on', 'DataLoggingDecimation', '5');
end
wv = {'v_inv', 'v_ac', 'i_ac'};
for k = 1:numel(wv)
    g = find_system(mdl, 'LookUnderMasks', 'all', 'FollowLinks', 'on', 'BlockType', 'Goto', ...
        'GotoTag', [wv{k} C.wsuf]);
    assert(numel(g) == 1, 'Goto %s%s bulunamadı', wv{k}, C.wsuf);
    ph = get_param(g{1}, 'PortHandles');
    src = get_param(get_param(ph.Inport(1), 'Line'), 'SrcPortHandle');
    set_param(src, 'DataLogging', 'on', 'DataLoggingNameMode', 'Custom', 'DataLoggingName', ['w_' wv{k}], ...
        'DataLoggingDecimateData', 'off');
end
set_param(mdl, 'SignalLogging', 'on', 'SignalLoggingName', 'logsout', 'ReturnWorkspaceOutputs', 'on');

info = struct('case', id, 'tag', tag, 'model', mdl, 's', s, 'phase', phase, 'k', k0*s, 'k0', k0, ...
    'start', char(datetime('now')), 'mode', 'accelerator', 'prev', '');
wall = tic;
try
    so = sim(mdl, 'SimulationMode', 'accelerator');
    info.status = 'tamamlandi'; info.message = '';
catch err
    so = []; info.status = 'hata'; info.message = getReport(err, 'extended', 'hyperlinks', 'off');
    info.prev = sprintf('accelerator %.0f s sonra hata: %s', toc(wall), err.message);
    try
        info.mode = 'normal';
        so = sim(mdl, 'SimulationMode', 'normal');
        info.status = 'tamamlandi'; info.message = '';
    catch err2
        info.message = getReport(err2, 'extended', 'hyperlinks', 'off');
    end
end
info.wall_s = toc(wall);
info.end = char(datetime('now'));
R = info;
if ~isempty(so)
    L = so.logsout;
    P = evalin('base', 'struct(''f'', f_grid, ''L1'', L1, ''L1r'', L1r, ''Rp'', L1_core_Rp, ''C'', C, ''Cr'', Cr, ''Rw'', EMC_Rw, ''Lw'', EMC_Lw, ''M'', EMC_M, ''Cx_aux'', C_emc_aux, ''Rx_aux'', R_emc_aux, ''Cx_eq'', EMC_Cx_eq, ''Rx_eq'', EMC_Rx_eq, ''L2'', L2, ''L2r'', L2r)');
    P.Eparam = evalin('base', sprintf('Vac%d_rms', C.n));
    met = struct(); rows = {};
    for k = 1:L.numElements
        el = L.getElement(k);
        t = el.Values.Time; v = squeeze(el.Values.Data);
        if startsWith(el.Name, 'm_')
            nmk = el.Name(3:end);
            sel = t >= 0.08;
            met.(nmk) = v(end);
            rows(end+1, :) = {nmk, v(end), mean(v(sel)), t(end)}; %#ok<AGROW>
        end
    end
    writetable(cell2table(rows, 'VariableNames', {'metrik', 'son_deger', 'ort_0p08_0p10', 't_son'}), ...
        fullfile(odir, 'metrikler.csv'), 'Encoding', 'UTF-8');
    W = struct();
    for k = 1:L.numElements
        el = L.getElement(k);
        if startsWith(el.Name, 'w_')
            t = el.Values.Time; v = squeeze(el.Values.Data);
            keep = t >= 0.06;
            W.(el.Name(3:end)) = struct('t', t(keep), 'v', v(keep));
        end
    end
    save(fullfile(odir, 'dalga.mat'), 'W', '-v7.3');
    R.met = met;
    R.P = P;
    R.ph = phasors(W, P, C.d09);
    R.d09 = C.d09;
    pr = R.ph;
    frow = {'son_periyot_0p08_0p10', abs(pr.VA), pr.angVA_E, abs(pr.VC), pr.angVC_E, abs(pr.IC), pr.angIC_E, ...
        abs(pr.E), real(pr.SC), imag(pr.SC), pr.Pc_true, pr.THDi, pr.Irms, pr.VArms_net, pr.angVA_net_E};
    writetable(cell2table(frow, 'VariableNames', {'pencere', 'VA_rms1', 'VA_aci_E_deg', 'VC_rms1', 'VC_aci_E_deg', ...
        'IC_rms1', 'IC_aci_E_deg', 'E_rms1', 'P1_C_W', 'Q1_C_var', 'P_C_gercek_W', 'THD_I_tumbant', 'I_rms', ...
        'VA_ag_rms1', 'VA_ag_aci_E_deg'}), fullfile(odir, 'fazorler.csv'), 'Encoding', 'UTF-8');
    fprintf('%s: Pac=%.3f W Q1=%+.3f var Irms=%.4f A eta=%.4f THD=%.4f | VA=%.4f V ∠%.5f° (E ref) |E|=%.4f\n', ...
        tag, met.Pac, met.Q1, met.Irms, met.eta, met.THD, abs(pr.VA), pr.angVA_E, abs(pr.E));
end
save(fullfile(odir, 'ozet.mat'), 'R');
fid = fopen(fullfile(odir, 'kosu_bilgisi.txt'), 'w', 'n', 'UTF-8');
fprintf(fid, 'model: %s\ncase: %s\ntag: %s\ns: %.12g\nfaz_deg: %.12g\n%s: %s\nbaslangic: %s\nbitis: %s\nmod: %s\ndurum: %s\nduvar_suresi_s: %.1f\nStopTime: %s\n%s\n%s\n', ...
    mdl, id, tag, s, phase, strjoin(C.kvars, '/'), mat2str(info.k, 12), info.start, info.end, info.mode, ...
    info.status, info.wall_s, get_param(mdl, 'StopTime'), info.prev, info.message);
fclose(fid);
close_system(mdl, 0);
fprintf('%s: %s (%.1f s)\n', tag, info.status, info.wall_s);
end

function ph = phasors(W, P, d09)
% Son periyot (0,08–0,10 s) temel bileşen fazörleri, RMS ölçekli. Açılar şebeke
% EMK'sına (E = V_C − Z2·I_C) göredir; E'nin mutlak fazı koşudan koşuya sabittir.
w0 = 2*pi*P.f; Tw = [0.08 0.10];
VA = fund(W.v_inv.t, W.v_inv.v, w0, Tw);
[VC, ~] = fund(W.v_ac.t, W.v_ac.v, w0, Tw);
[IC, Irms] = fund(W.i_ac.t, W.i_ac.v, w0, Tw);
Z = net_z(P, d09);
E = VC - Z.Z2*IC;
rot = exp(-1j*angle(E));
ph.VA = VA*rot; ph.VC = VC*rot; ph.IC = IC*rot; ph.E = E*rot;
ph.angVA_E = rad2deg(angle(ph.VA)); ph.angVC_E = rad2deg(angle(ph.VC)); ph.angIC_E = rad2deg(angle(ph.IC));
ph.SC = ph.VC*conj(ph.IC);
ph.Irms = Irms;
ph.THDi = sqrt(Irms^2 - abs(IC)^2)/abs(IC);
sel = W.v_ac.t >= Tw(1) & W.v_ac.t <= Tw(2);
t = W.v_ac.t(sel); iv = W.i_ac.v(sel);
if numel(W.i_ac.t) ~= numel(W.v_ac.t) || any(W.i_ac.t ~= W.v_ac.t), iv = interp1(W.i_ac.t, W.i_ac.v, t); end
ph.Pc_true = trapz(t, W.v_ac.v(sel).*iv)/(t(end) - t(1));
nw = propagate(ph.VC, ph.IC, Z);
ph.VArms_net = abs(nw.VA); ph.angVA_net_E = rad2deg(angle(nw.VA));
end

function [X, xrms] = fund(t, x, w0, Tw)
sel = t >= Tw(1) & t <= Tw(2);
t = t(sel); x = x(sel); T = t(end) - t(1);
X = sqrt(2)/T*trapz(t, x.*exp(-1j*w0*t));
xrms = sqrt(trapz(t, x.^2)/T);
end

function Z = net_z(P, d09)
w0 = 2*pi*P.f;
Z.Z1 = par2(P.L1r + 1j*w0*P.L1, P.Rp);
Z.Zcf = P.Cr + 1/(1j*w0*P.C);
Z.Zcm = 2*(P.Rw + 1j*w0*(P.Lw - P.M));
if d09, Z.Zcx = P.Rx_eq + 1/(1j*w0*P.Cx_eq); else, Z.Zcx = P.Rx_aux + 1/(1j*w0*P.Cx_aux); end
Z.Z2 = P.L2r + 1j*w0*P.L2;
end

function z = par2(a, b), z = a*b/(a + b); end

function nw = propagate(VC, IC, Z)
VM = VC + Z.Zcm*IC;  IM = IC + VM/Z.Zcx;
VB = VM + Z.Zcm*IM;  IL1 = IM + VB/Z.Zcf;
nw.VA = VB + Z.Z1*IL1; nw.VG = VC - Z.Z2*IC;
end

function SC = forward(VA, E, Z)
Y = [1/Z.Z1 + 1/Z.Zcf + 1/Z.Zcm, -1/Z.Zcm, 0
    -1/Z.Zcm, 2/Z.Zcm + 1/Z.Zcx, -1/Z.Zcm
    0, -1/Z.Zcm, 1/Z.Zcm + 1/Z.Z2];
v = Y\[VA/Z.Z1; 0; E/Z.Z2];
IC = (v(3) - E)/Z.Z2;
SC = v(3)*conj(IC);
end

% =====================================================================
function nxt = do_predict(run_dir, id, tags, opts)
% tags: bu senaryonun koşuları (eskiden yeniye). Son koşu çalışma noktasıdır.
% opts (isteğe bağlı): struct('a', genlik kazancı, 'b', faz kazancı) — önceki koşu yoksa.
C = case_def(id); T = targets(C.scen);
if ischar(tags), tags = {tags}; end
Rs = cellfun(@(t) getfield(load(fullfile(run_dir, 'results', t, 'ozet.mat')), 'R'), tags); %#ok<GFLD>
last = Rs(end);
% Kalibre edilecek model her zaman D-09'ludur (case 's1','s2','s3')
Zold = net_z(last.P, last.d09); Znew = net_z(last.P, true);
nw = propagate(last.ph.VC, last.ph.IC, Zold);       % ağla tutarlı V_A (E referanslı)
VA0 = nw.VA; E = nw.VG;
S0 = forward(VA0, E, Znew);                          % D-09 modelinde aynı V_A ile (fark: D-09 etkisi)
% Hedefler: P_ac (Display, 0–50. harmonik) ve |Q1| (Power bloğu, temel). Q1 bandın ortası,
% işaret dalı son koşunun işareti (kalibrasyonsuz modele en yakın dal, K-02a).
dPh = last.met.P1 - last.met.Pac;                    % harmonik/ölçüm farkı (koşudan)
dQ1 = last.met.Q1 - imag(last.ph.SC);                % Power bloğu ↔ fazör farkı
Pt1 = T.Pac + dPh;
Qt1 = sign(last.met.Q1)*mean(T.Qband) - dQ1;
x = [0 0];
for it = 1:30
    f = resid(x);
    J = zeros(2); h = [1e-6 1e-5];
    for q = 1:2, e = zeros(1, 2); e(q) = h(q); J(:, q) = (resid(x + e) - f)/h(q); end
    dx = -(J\f).';
    x = x + dx;
    if norm(dx) < 1e-12, break, end
end
    function f = resid(x)
        S = forward(VA0*exp(x(1))*exp(1j*deg2rad(x(2))), E, Znew);
        f = [real(S) - Pt1; imag(S) - Qt1];
    end
% Kazançlar: a = dln|V_A|/dln s, b = d∠V_A/dφ  (önceki koşulardan; yoksa opts ya da 1)
a = 1; b = 1; src = 'varsayılan (1, 1)';
if nargin >= 4 && ~isempty(opts), a = opts.a; b = opts.b; src = 'dışarıdan (opts)'; end
if numel(Rs) >= 2
    p = Rs(end-1); q = Rs(end);
    dlnV = log(abs(q.ph.VA)/abs(p.ph.VA)); dlnS = log(q.s/p.s);
    dang = q.ph.angVA_E - p.ph.angVA_E; dphi = q.phase - p.phase;
    if p.d09 ~= q.d09
        % D-09 değişimi V_A'yı da biraz değiştirir; ağ hesabıyla düzeltilir (aynı V_A varsayımı yerine ölçülen)
        src = 'son iki koşu (D-09 farkı içeriyor)';
    else
        src = 'son iki koşu';
    end
    if abs(dlnS) > 1e-6, a = dlnV/dlnS; end
    if abs(dphi) > 1e-5, b = dang/dphi; end
end
s_new = last.s*exp(x(1)/a);
ph_new = last.phase + x(2)/b;
nxt = struct('case', id, 'from', tags{end}, 's', s_new, 'phase', ph_new, 'a', a, 'b', b, 'kaynak', src, ...
    'dlnVA', x(1), 'dangVA', x(2), 'P_d09_ayni_VA', real(S0), 'Q_d09_ayni_VA', imag(S0), ...
    'Pt1', Pt1, 'Qt1', Qt1);
fprintf(['%s: son koşu %s (s=%.8f, faz=%.6f°): Pac=%.3f Q1=%+.3f | D-09 modelinde aynı V_A ile P1=%.3f Q1=%+.3f\n' ...
    '  gereken V_A değişimi: %+.5f %% genlik, %+.6f° faz; kazanç a=%.4f b=%.4f (%s)\n' ...
    '  ÖNERİ: s = %.10f, faz = %.8f°\n'], id, tags{end}, last.s, last.phase, last.met.Pac, last.met.Q1, ...
    real(S0), imag(S0), 100*x(1), x(2), a, b, src, s_new, ph_new);
save(fullfile(run_dir, 'results', tags{end}, 'oneri.mat'), 'nxt');
end

% =====================================================================
function nxt = do_predict_emp(run_dir, id, tags)
% Ampirik Jacobian (sekant): (ln s, φ) -> (P_ac, Q1) düzlemi verilen koşulara en küçük
% kareler ile oturtulur (en az 3 koşu, aynı D-09 durumu), hedefe Newton adımı atılır.
% Gerekçe (28.10.2026, s3_k0 -> s3_k1): susturmalı S2/S3'te köprü temel gerilimi V_A
% referans fazına ve genliğe neredeyse hiç yanıt vermiyor (süreksiz iletim; köprü akım
% kaynağı gibi davranıyor), bu yüzden V_A tabanlı ağ tahmini (predict) kullanılamaz.
C = case_def(id); T = targets(C.scen);
if ischar(tags), tags = {tags}; end
Rs = cellfun(@(t) getfield(load(fullfile(run_dir, 'results', t, 'ozet.mat')), 'R'), tags); %#ok<GFLD>
X = [ones(numel(Rs), 1), log([Rs.s]).', [Rs.phase].'];
mt = [Rs.met];
Y = [[mt.Pac].', [mt.Q1].'];
B = X\Y;                      % 3x2: sabit, d/dln s, d/dφ
J = B(2:3, :).';               % 2x2: [dP/dlns dP/dφ; dQ/dlns dQ/dφ]
last = Rs(end);
tq = sign(Rs(1).met.Q1)*mean(T.Qband);   % işaret dalı: ilk (kalibrasyonsuza en yakın) koşunun dalı
f = [T.Pac - last.met.Pac; tq - last.met.Q1];
dx = J\f;
s_new = last.s*exp(dx(1)); ph_new = last.phase + dx(2);
res = Y - X*B;
nxt = struct('case', id, 'from', tags{end}, 's', s_new, 'phase', ph_new, 'J', J, 'res', res);
fprintf('%s: Jacobian [dP/dln s  dP/dφ; dQ/dln s  dQ/dφ] = [%.2f %.3f; %.2f %.3f] (W, var; φ derece)\n', id, J.');
fprintf('  oturtma artığı (P, Q): %s\n', mat2str(res, 4));
fprintf('  hedef P=%.2f Q1=%+.2f; son koşu P=%.3f Q1=%+.3f\n', T.Pac, tq, last.met.Pac, last.met.Q1);
fprintf('  ÖNERİ: s = %.10f, faz = %.8f°  (Δln s = %+.5f, Δφ = %+.5f°)\n', s_new, ph_new, dx(1), dx(2));
save(fullfile(run_dir, 'results', tags{end}, 'oneri_emp.mat'), 'nxt');
end

% =====================================================================
function nxt = do_predict_th(run_dir, id, tags)
% Thevenin köprü modeli (28.10.2026): köprü iç gerilimi V_int = s·V0∠φ (genlik ölçeği ve
% referans fazıyla doğrusal) ile kutup noktası A arasında eşdeğer seri empedans Z_th
% (ölü zaman / süreksiz iletim etkisi) vardır: V_A = V_int − Z_th·I_L1. Z_th son iki
% koşudan (aynı D-09 durumu) tam çözülür; ağ (LCL + EMC) analyze_q_sign_20261027 ile
% aynıdır. Hedef P_ac ve |Q1| için (s, φ) Newton ile çözülür. Doğrulama: önceki koşular
% bu Z_th ile son koşudan geriye kestirilir ve ölçülenle karşılaştırılır.
C = case_def(id); T = targets(C.scen);
if ischar(tags), tags = {tags}; end
Rs = cellfun(@(t) getfield(load(fullfile(run_dir, 'results', t, 'ozet.mat')), 'R'), tags); %#ok<GFLD>
p = Rs(end-1); q = Rs(end);
assert(p.d09 == q.d09, 'Z_th için son iki koşu aynı D-09 durumunda olmalı');
Zq = net_z(q.P, q.d09); Zp = net_z(p.P, p.d09);
nwp = propagate(p.ph.VC, p.ph.IC, Zp); nwq = propagate(q.ph.VC, q.ph.IC, Zq);
Ip = il1(p.ph.VC, p.ph.IC, Zp); Iq = il1(q.ph.VC, q.ph.IC, Zq);
rho = (q.s/p.s)*exp(1j*deg2rad(q.phase - p.phase));
Zth = (rho*nwp.VA - nwq.VA)/(Iq - rho*Ip);
Vint_q = nwq.VA + Zth*Iq; E = nwq.VG;
Zt = Zq; Zt.Z1 = Zq.Z1 + Zth;
% geriye doğrulama
for k = 1:numel(Rs)
    r = Rs(k);
    Zr = Zt; if r.d09 ~= q.d09, Zr = net_z(r.P, r.d09); Zr.Z1 = Zr.Z1 + Zth; end
    Sk = forward(Vint_q*(r.s/q.s)*exp(1j*deg2rad(r.phase - q.phase)), E, Zr);
    fprintf('  geriye kestirim %s: P1 %.2f (ölçülen %.2f) Q1 %+.2f (ölçülen %+.2f)%s\n', tags{k}, real(Sk), ...
        r.met.P1, imag(Sk), r.met.Q1, ternary(r.d09 ~= q.d09, ' [D-09 farklı]', ''));
end
dPh = q.met.P1 - q.met.Pac; dQ1 = q.met.Q1 - imag(q.ph.SC);
Pt1 = T.Pac + dPh; Qt1 = sign(Rs(1).met.Q1)*mean(T.Qband) - dQ1;
x = [log(q.s) q.phase];
for it = 1:50
    f = rs_th(x); J = zeros(2); h = [1e-7 1e-6];
    for k = 1:2, e = zeros(1, 2); e(k) = h(k); J(:, k) = (rs_th(x + e) - f)/h(k); end
    dx = -(J\f).'; x = x + dx;
    if norm(dx) < 1e-13, break, end
end
    function f = rs_th(xx)
        S = forward(Vint_q*(exp(xx(1))/q.s)*exp(1j*deg2rad(xx(2) - q.phase)), E, Zt);
        f = [real(S) - Pt1; imag(S) - Qt1];
    end
nxt = struct('case', id, 'from', tags{end}, 's', exp(x(1)), 'phase', x(2), 'Zth', Zth, 'J', J);
fprintf('%s: Z_th = %.4f %+.4fj ohm (|Z|=%.3f, açı %.1f°); son koşu %s P=%.3f Q1=%+.3f\n', id, real(Zth), imag(Zth), ...
    abs(Zth), rad2deg(angle(Zth)), tags{end}, q.met.Pac, q.met.Q1);
fprintf('  Jacobian [dP/dln s dP/dφ; dQ/dln s dQ/dφ] = [%.1f %.2f; %.1f %.2f]\n', J.');
fprintf('  ÖNERİ: s = %.10f, faz = %.8f°\n', exp(x(1)), x(2));
save(fullfile(run_dir, 'results', tags{end}, 'oneri_th.mat'), 'nxt');
end

function I = il1(VC, IC, Z)
VM = VC + Z.Zcm*IC; IM = IC + VM/Z.Zcx; VB = VM + Z.Zcm*IM; I = IM + VB/Z.Zcf;
end

% =====================================================================
function out = do_dcm(run_dir, tags)
% Süreksiz iletim göstergesi: kutup gerilimi v_inv (A − N) üç seviyeden (+Vdc/2, 0, −Vdc/2)
% hiçbirine yakın değilse köprü akımı sıfırdır ve kutup filtre kapasitörü gerilimini izler.
% Pencere 0,08–0,10 s; eşik Vdc/2'nin %5'i. Zaman ağırlıklı oran.
if ischar(tags), tags = {tags}; end
rows = {};
for k = 1:numel(tags)
    S = load(fullfile(run_dir, 'results', tags{k}, 'dalga.mat'), 'W');
    R = getfield(load(fullfile(run_dir, 'results', tags{k}, 'ozet.mat')), 'R'); %#ok<GFLD>
    t = S.W.v_inv.t; v = S.W.v_inv.v; sel = t >= 0.08 & t <= 0.10;
    t = t(sel); v = v(sel); dt = diff(t); v = v(1:end-1);
    h = R.met.Vdc/2; tol = 0.05*h;
    lev = abs(v - h) < tol | abs(v) < tol | abs(v + h) < tol;
    ara = sum(dt(~lev))/sum(dt);
    rows(end+1, :) = {tags{k}, ara, sum(dt(abs(v) < tol))/sum(dt)}; %#ok<AGROW>
    fprintf('%s: ara seviye (süreksiz iletim) zaman oranı %.4f, sıfır seviyesi %.4f\n', tags{k}, rows{end, 2}, rows{end, 3});
end
out = cell2table(rows, 'VariableNames', {'kosu', 'ara_seviye_orani', 'sifir_seviye_orani'});
writetable(out, fullfile(run_dir, 'sureksiz_iletim.csv'), 'Encoding', 'UTF-8');
end

function out = do_table(run_dir, root_dir)
cfg = jsondecode(fileread(fullfile(run_dir, 'tablo_secimi.json')));
% tablo_secimi.json: {"S1": {"case":"s1","once":"tag","sonra":"tag"}, ...}
mets = {'Pac', 'W'; 'Q1abs', 'var'; 'Irms', 'A'; 'eta', '%'; 'THD', '%'; 'Pdc', 'W'; 'Idc', 'A'; ...
    'Vdc', 'V'; 'cosfi1abs', '-'; 'PF', '-'};
rows = {};
for sc = fieldnames(cfg).'
    g = cfg.(sc{1}); C = case_def(g.case); T = targets(C.scen);
    A = getfield(load(fullfile(run_dir, 'results', g.once, 'ozet.mat')), 'R'); %#ok<GFLD>
    B = getfield(load(fullfile(run_dir, 'results', g.sonra, 'ozet.mat')), 'R'); %#ok<GFLD>
    for k = 1:numel(C.kvars)
        rows(end+1, :) = {C.scen, ['serbest:' C.kvars{k}], '-', NaN, NaN, A.k(k), B.k(k), B.k(k) - A.k(k), ...
            100*(B.k(k)/A.k(k) - 1), '', g.once, g.sonra}; %#ok<AGROW>
    end
    rows(end+1, :) = {C.scen, ['serbest:' C.phvar], 'derece', NaN, NaN, A.phase, B.phase, B.phase - A.phase, ...
        NaN, sprintf('%.3f us', (B.phase - A.phase)/360/50*1e6), g.once, g.sonra}; %#ok<AGROW>
    for k = 1:size(mets, 1)
        m = mets{k, 1};
        [va, vb, tg, band] = metric(A, B, T, m);
        dev = vb - tg; rel = 100*dev/tg;
        if strcmp(m, 'Q1abs')
            ok = ternary(vb >= band(1) && vb <= band(2), 'bant içinde', 'bant dışında');
            if sign(B.met.Q1) ~= sign(A.met.Q1), ok = [ok ', ters işaret dalı']; end
        elseif strcmp(m, 'Pac')
            ok = ternary(abs(rel) <= 1, '±%1 içinde', '±%1 dışında');
        else
            ok = 'doğrulama (kalibre edilmedi)';
        end
        rows(end+1, :) = {C.scen, m, mets{k, 2}, tg, va, vb, NaN, dev, rel, ok, g.once, g.sonra}; %#ok<AGROW>
        rows{end, 7} = vb - va;
    end
end
Tt = cell2table(rows, 'VariableNames', {'senaryo', 'buyukluk', 'birim', 'hedef', 'kalibrasyonsuz', ...
    'kalibre', 'degisim', 'fark_hedefe', 'fark_hedefe_yuzde', 'durum', 'kosu_once', 'kosu_sonra'});
writetable(Tt, fullfile(run_dir, 'kalibrasyon_tablosu.csv'), 'Encoding', 'UTF-8');
disp(Tt);
out = Tt;
end

function [va, vb, tg, band] = metric(A, B, T, m)
band = [];
switch m
    case 'Pac', va = A.met.Pac; vb = B.met.Pac; tg = T.Pac;
    case 'Q1abs', va = abs(A.met.Q1); vb = abs(B.met.Q1); tg = T.Qabs; band = T.Qband;
    case 'Irms', va = A.met.Irms; vb = B.met.Irms; tg = T.Irms;
    case 'eta', va = 100*A.met.eta; vb = 100*B.met.eta; tg = T.eta;
    case 'THD', va = 100*A.met.THD; vb = 100*B.met.THD; tg = T.THD;
    case 'Pdc', va = A.met.Pdc; vb = B.met.Pdc; tg = T.Pdc;
    case 'Idc', va = A.met.Idc; vb = B.met.Idc; tg = T.Idc;
    case 'Vdc', va = A.met.Vdc; vb = B.met.Vdc; tg = T.Vdc;
    case 'cosfi1abs', va = abs(A.met.cosfi1); vb = abs(B.met.cosfi1); tg = T.cosfi;
    case 'PF'   % toplam güç faktörü P/(V_rms·I_rms), C noktası
        va = A.met.Pac/(abs(A.ph.VC)*sqrt(1 + A.met.THDv^2)*A.met.Irms);
        vb = B.met.Pac/(abs(B.ph.VC)*sqrt(1 + B.met.THDv^2)*B.met.Irms);
        tg = T.Pac/(T.Vac*T.Irms);
end
end

function s = ternary(c, a, b)
if c, s = a; else, s = b; end
end
