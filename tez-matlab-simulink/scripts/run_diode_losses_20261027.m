function run_diode_losses_20261027(mdl, run_name, sim_mode, history_steps, stop_time)
% D-08 etkisinin ayrıştırılması (İP-2b): yarı iletken ve pasif eleman kayıplarını
% blok bazında çıkarır. Model dosyasına dokunmaz; yalnız bellekte Simscape
% kaydını açar (SimscapeLogType = all, son history_steps adımı tutulur) ve
% ee_getPowerLossSummary ile son 20 ms (bir şebeke periyodu) ortalamasını alır.
% Ayrıca her diode_thermal bloğunun ortalama ve RMS akımı aynı pencerede yazılır.
%
% Çalışma klasörü: runs/<run_name>/kayip/model/ (ana koşu klasöründeki Accelerator
% derlemesiyle çakışmasın diye ayrı); model ve parametre dosyası yoksa
% runs/<run_name>/model/ altından kopyalanır.
% Çıktı: runs/<run_name>/kayip/results/<mdl>/{kayip_ozeti.csv, diyot_akimlari.csv, kosu_bilgisi.txt}
% Çağrı (proje kökünden):
%   matlab -batch "addpath('scripts'); run_diode_losses_20261027('inverter_senaryo3_d08', '2026-10-27_diyot_esleme', 'accelerator')"
if nargin < 3 || isempty(sim_mode), sim_mode = 'accelerator'; end
if nargin < 4 || isempty(history_steps), history_steps = 1.2e6; end
if nargin < 5, stop_time = ''; end  % boş: modelin StopTime değeri (0,1 s); yalnız deneme için kısaltılır
root_dir = fileparts(fileparts(mfilename('fullpath')));
src_dir = fullfile(root_dir, 'runs', run_name, 'model');
work_dir = fullfile(root_dir, 'runs', run_name, 'kayip', 'model');
out_dir = fullfile(root_dir, 'runs', run_name, 'kayip', 'results', mdl);
if ~exist(work_dir, 'dir'), mkdir(work_dir); end
if ~exist(out_dir, 'dir'), mkdir(out_dir); end
for f = {[mdl '.slx'], 'inverter_common_parameters.m'}
    if ~isfile(fullfile(work_dir, f{1})), copyfile(fullfile(src_dir, f{1}), fullfile(work_dir, f{1})); end
end
cd(work_dir);
evalin('base', sprintf('run(''%s'');', fullfile(work_dir, 'inverter_common_parameters.m')));
load_system(mdl);
set_param(mdl, 'SimscapeLogType', 'all', 'SimscapeLogName', 'simlog', ...
    'SimscapeLogLimitData', 'on', 'SimscapeLogDataHistory', history_steps, ...
    'SimscapeLogDecimation', 1, 'SignalLogging', 'off', 'ReturnWorkspaceOutputs', 'on');
if ~isempty(stop_time), set_param(mdl, 'StopTime', num2str(stop_time)); end
fid = fopen(fullfile(out_dir, 'kosu_bilgisi.txt'), 'w', 'n', 'UTF-8');
c = onCleanup(@() fclose(fid));
fprintf(fid, 'model: %s\nmatlab: %s\nbaslangic: %s\nmod: %s\nSimscapeLogDataHistory: %d\n', ...
    mdl, version, char(datetime('now')), sim_mode, history_steps);
wall = tic;
try
    out = sim(mdl, 'SimulationMode', sim_mode);
catch err
    fprintf(fid, 'accelerator hata (%.0f s): %s\n', toc(wall), err.message);
    sim_mode = 'normal';
    out = sim(mdl, 'SimulationMode', 'normal');
end
fprintf(fid, 'duvar_suresi_s: %.1f\nmod_son: %s\n', toc(wall), sim_mode);
sl = out.simlog;
dio = find_system(mdl, 'SearchDepth', 1, 'BlockType', 'SimscapeBlock');
dio = dio(contains(get_param(dio, 'SourceFile'), 'diode_thermal'));
t = sl.(matlab.lang.makeValidName(get_param(dio{1}, 'Name'))).i.series.time;
t_end = t(end);
t0w = max(t_end - 0.02, t(1));
fprintf(fid, 'kayit_penceresi_s: %.6f - %.6f (%d adım tutuldu)\nortalama_penceresi_s: %.6f - %.6f\n', ...
    t(1), t_end, numel(t), t0w, t_end);
if t_end - t0w < 0.02 - 1e-6
    fprintf(fid, 'UYARI: pencere 20 ms''den kısa (%.3f ms); history_steps artırılmalı\n', 1e3*(t_end - t0w));
end
T = ee_getPowerLossSummary(sl, t0w, t_end);
T.Total = T.Power + T.SwitchingLosses;
T.LoggingNode = string(T.LoggingNode);
writetable(T, fullfile(out_dir, 'kayip_ozeti.csv'), 'Encoding', 'UTF-8');
fprintf(fid, 'toplam_kayip_W: %.4f\n', sum(T.Total));
rows = {};
for k = 1:numel(dio)
    nm = get_param(dio{k}, 'Name');
    s = sl.(matlab.lang.makeValidName(nm)).i.series;
    ti = s.time; iv = s.values('A');
    w = ti >= t0w;
    tw = ti(w); x = iv(w);
    pref = regexp(get_param(dio{k}, 'Vf'), '^([A-Z][A-Za-z0-9]*?)_', 'tokens', 'once');
    rows(end+1, :) = {nm, pref{1}, trapz(tw, x) / (tw(end) - tw(1)), ...
        sqrt(trapz(tw, x.^2) / (tw(end) - tw(1))), max(x), min(x)}; %#ok<AGROW>
end
writetable(cell2table(rows, 'VariableNames', {'blok', 'onek', 'i_ort_A', 'i_rms_A', 'i_max_A', 'i_min_A'}), ...
    fullfile(out_dir, 'diyot_akimlari.csv'), 'Encoding', 'UTF-8');
close_system(mdl, 0);
fprintf('%s: kayip ozeti yazildi (%.0f s)\n', mdl, toc(wall));
end
