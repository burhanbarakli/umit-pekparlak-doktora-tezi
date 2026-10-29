function run_tez_sekilleri_20261029(case_id)
% İP-11: tez şekilleri için kalibre S1, S2, S3 modellerinin yeniden koşusu.
% Kalibrasyon koşuları (runs/2026-10-28_kalibrasyon) yalnız v_inv, v_ac, i_ac
% dalga biçimlerini saklamıştı; tezdeki eski düşük çözünürlüklü L1 akımı ve kapı
% darbesi ekranlarının yerine vektör şekil üretmek için L1 akımı ve kapı işaretleri
% de gerekir. Model ve kalibrasyon değerleri değişmez (K-20).
%
% Kaynak : runs/2026-10-28_parametre_tablosu/model/tez/ (kalibre modeller + *_kalibrasyon.m)
% Koşu   : runs/2026-10-29_tez_sekilleri/model_<case>/ (her senaryo ayrı klasör, paralel güvenli)
% Çıktı  : runs/2026-10-29_tez_sekilleri/results/<case>/sekil_kayit.mat (t >= 0,075 s; git'e girmez),
%          sinyal_listesi.csv, kosu_bilgisi.txt
% Çağrı (proje kökünden):
%   matlab -batch "addpath('scripts'); run_tez_sekilleri_20261029('s1')"   % 's1' | 's2' | 's3'
root_dir = fileparts(fileparts(mfilename('fullpath')));
src_dir = fullfile(root_dir, 'runs', '2026-10-28_parametre_tablosu', 'model', 'tez');
run_dir = fullfile(root_dir, 'runs', '2026-10-29_tez_sekilleri');
switch case_id
    case 's1', mdl = 'inverter_s1_kal';
    case 's2', mdl = 'inverter_s2_kal';
    case 's3', mdl = 'inverter_senaryo3_kal';
    otherwise, error('case_id: s1 | s2 | s3');
end
mdir = fullfile(run_dir, ['model_' case_id]);
odir = fullfile(run_dir, 'results', case_id);
if ~exist(mdir, 'dir'), mkdir(mdir); end
if ~exist(odir, 'dir'), mkdir(odir); end
for f = {[mdl '.slx'], [mdl '_kalibrasyon.m'], 'inverter_common_parameters.m'}
    copyfile(fullfile(src_dir, f{1}), mdir);
end
cd(mdir);
evalin('base', 'clear');
evalin('base', sprintf('run(''%s'');', fullfile(mdir, 'inverter_common_parameters.m')));
evalin('base', sprintf('run(''%s'');', fullfile(mdir, [mdl '_kalibrasyon.m'])));
load_system(fullfile(mdir, [mdl '.slx']));

% Kayıt: bütün PS-Simulink dönüştürücü çıkışları (L1 akımı dahil) ve mevcut kayıtlı işaretler
ps = find_system(mdl, 'LookUnderMasks', 'all', 'FollowLinks', 'on', 'MaskType', 'PS-Simulink Converter');
ps = [ps; find_system(mdl, 'LookUnderMasks', 'all', 'FollowLinks', 'on', 'ReferenceBlock', 'nesl_utility/PS-Simulink Converter')];
ps = unique(ps);
n_ps = 0;
for k = 1:numel(ps)
    if strcmp(get_param(ps{k}, 'Commented'), 'on'), continue; end
    ph = get_param(ps{k}, 'PortHandles');
    if isempty(ph.Outport), continue; end
    nm = ['ps_' regexprep(get_param(ps{k}, 'Name'), '\W', '_')];
    set_param(ph.Outport(1), 'DataLogging', 'on', 'DataLoggingNameMode', 'Custom', 'DataLoggingName', nm);
    n_ps = n_ps + 1;
end
set_param(mdl, 'SignalLogging', 'on', 'SignalLoggingName', 'logsout', 'ReturnWorkspaceOutputs', 'on');

info = struct('case', case_id, 'model', mdl, 'start', char(datetime('now')), 'mode', 'accelerator', 'prev', '');
wall = tic;
try
    so = sim(mdl, 'SimulationMode', 'accelerator');
    info.status = 'tamamlandi';
catch err
    info.prev = sprintf('accelerator hata: %s', err.message);
    info.mode = 'normal';
    so = sim(mdl, 'SimulationMode', 'normal');
    info.status = 'tamamlandi';
end
info.wall_s = toc(wall);
L = so.logsout;
E = struct(); rows = {};
for k = 1:L.numElements
    el = L.getElement(k);
    if ~isa(el.Values, 'timeseries'), continue; end
    t = el.Values.Time; v = squeeze(el.Values.Data);
    if size(v, 1) ~= numel(t), v = v.'; end
    keep = t >= 0.075;
    fn = matlab.lang.makeValidName(el.Name);
    if isfield(E, fn), fn = sprintf('%s_%d', fn, k); end
    bp = el.BlockPath.getBlock(1);
    E.(fn) = struct('t', t(keep), 'v', v(keep, :), 'ad', el.Name, 'blok', bp);
    rows(end+1, :) = {fn, el.Name, strrep(bp, newline, ' '), size(v, 2), sum(keep), double(max(abs(v(keep, 1))))}; %#ok<AGROW>
end
save(fullfile(odir, 'sekil_kayit.mat'), 'E', '-v7.3');
writetable(cell2table(rows, 'VariableNames', {'alan', 'sinyal', 'blok', 'kanal', 'ornek', 'tepe'}), ...
    fullfile(odir, 'sinyal_listesi.csv'), 'Encoding', 'UTF-8');
fid = fopen(fullfile(odir, 'kosu_bilgisi.txt'), 'w', 'n', 'UTF-8');
fprintf(fid, 'model: %s\nbaslangic: %s\nbitis: %s\nmod: %s\ndurum: %s\nduvar_suresi_s: %.1f\nps_kayit: %d\n%s\n', ...
    mdl, info.start, char(datetime('now')), info.mode, info.status, info.wall_s, n_ps, info.prev);
fclose(fid);
close_system(mdl, 0);
fprintf('%s tamam: %.0f s, %d işaret\n', case_id, info.wall_s, size(rows, 1));
end
