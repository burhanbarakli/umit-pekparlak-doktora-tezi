function run_q_isaret_dalga_20261027(mdl, sim_mode)
% İP-3 / D-06: Q işareti analizi için ham dalga biçimi kaydı.
% 27.10.2026 ilk koşusunda (runs/2026-10-27_dort_senaryo_ilk_kosu) sensör alt
% sistemlerinin çıkışı Goto ile verildiğinden (Outport yok) v_ac, i_ac, v_inv
% kaydedilmemişti. Bu betik 12.10 paketini kendi koşu klasörüne kopyalar ve
% devreye, parametreye, çözücüye dokunmadan yalnız bellekte şu sinyallerin
% kaydını açar (model dosyası kaydedilmez):
%   v_ac  : AC Voltage Sensor1 (L2 öncesi düğüm C − şebeke dönüşü)
%   i_ac  : AC Current Sensor1 (dönüş iletkeni; + → − yönü)
%   v_inv : AC Voltage Sensor2 (L1 girişi düğüm A − DA orta nokta N)
%   i_L1  : Current Sensor1 → PS-Simulink Converter3 (faz düğümü → L1)
% ve karşılaştırma için Display kaynakları (Power3 P/Q, Mean9/10/11, RMS1, THD).
% Her model ayrı alt klasörde (model_<ad>) derlenir; Accelerator derlemeleri
% çakışmaz. Pencere 0,05–0,1 s kaydedilir.
% Çağrı (proje kökünden):
%   matlab -batch "addpath('scripts'); run_q_isaret_dalga_20261027('inverter_senaryo3')"
% S1+S2 modelinin Accelerator derlemesi bu makinede LCC bağlama hatası verir
% (rt_InitInfAndNaN tanımsız; eşzamanlılıkla ilgisiz). Bu model için
% sim_mode = 'normal' verilir; yalnız yürütme biçimi değişir.
root_dir = fileparts(fileparts(mfilename('fullpath')));
pkg_dir = fullfile(root_dir, 'incoming_real_data', 'models', '2026-10-12_dort_senaryo_paketi');
run_dir = fullfile(root_dir, 'runs', '2026-10-27_q_isaret_dalga');
model_dir = fullfile(run_dir, ['model_' mdl]);
out_dir = fullfile(run_dir, 'results', mdl);
if ~exist(model_dir, 'dir'), mkdir(model_dir); end
if ~exist(out_dir, 'dir'), mkdir(out_dir); end
copyfile(fullfile(pkg_dir, [mdl '.slx']), model_dir);
copyfile(fullfile(pkg_dir, 'inverter_common_parameters.m'), model_dir);

cd(model_dir);  % InitFcn parametre dosyasını buradan okur; slprj burada kalır
evalin('base', sprintf('run(''%s'');', fullfile(model_dir, 'inverter_common_parameters.m')));
load_system(fullfile(model_dir, [mdl '.slx']));

% Ham dalga biçimleri
wave = {
    'AC Voltage Sensor1/PS-Simulink Converter', 'v_ac'
    'AC Voltage Sensor2/PS-Simulink Converter', 'v_inv'
    'AC Current Sensor1/PS-Simulink Converter', 'i_ac'
    'PS-Simulink Converter3', 'i_L1'
    };
for k = 1:size(wave, 1)
    ph = get_param([mdl '/' wave{k, 1}], 'PortHandles');
    set_param(ph.Outport(1), 'DataLogging', 'on', 'DataLoggingNameMode', 'Custom', ...
        'DataLoggingName', wave{k, 2});
end
% Display kaynakları (ilk koşuyla karşılaştırma için)
srcs = {'Power3', 1, 'P1_Power3'; 'Power3', 2, 'Q1_Power3'; 'Mean9', 1, 'P_Mean9'; ...
    'Mean10', 1, 'Q_Mean10'; 'Mean11', 1, 'P_Mean11'; 'RMS1', 1, 'Iac_RMS1'; ...
    'THD', 1, 'THD_I'; 'THD2', 1, 'THD_V'; 'Mean1', 1, 'Pdc_Mean1'};
for k = 1:size(srcs, 1)
    b = [mdl '/' srcs{k, 1}];
    if getSimulinkBlockHandle(b) < 0, continue, end
    ph = get_param(b, 'PortHandles');
    set_param(ph.Outport(srcs{k, 2}), 'DataLogging', 'on', 'DataLoggingNameMode', 'Custom', ...
        'DataLoggingName', srcs{k, 3});
end
set_param(mdl, 'SignalLogging', 'on', 'SignalLoggingName', 'logsout', ...
    'ReturnWorkspaceOutputs', 'on');

if nargin < 2 || isempty(sim_mode), sim_mode = get_param(mdl, 'SimulationMode'); end
info = struct('model', mdl, 'matlab', version, 'start', char(datetime('now')), ...
    'mod', sim_mode);
wall = tic;
try
    out = sim(mdl, 'SimulationMode', sim_mode);
    info.status = 'tamamlandi'; info.message = '';
catch err
    out = []; info.status = 'hata';
    info.message = getReport(err, 'extended', 'hyperlinks', 'off');
end
info.wall_s = toc(wall);

if ~isempty(out)
    logs = out.logsout;
    W = struct();
    for k = 1:logs.numElements
        el = logs.getElement(k);
        t = el.Values.Time; v = squeeze(el.Values.Data);
        keep = t >= 0.05;
        W.(el.Name).t = t(keep);
        W.(el.Name).v = v(keep);
    end
    W.meta = info;
    save(fullfile(out_dir, 'dalga_0p05_0p1.mat'), 'W', '-v7.3');
end
fid = fopen(fullfile(out_dir, 'kosu_bilgisi.txt'), 'w', 'n', 'UTF-8');
fprintf(fid, 'model: %s\nmatlab: %s\nbaslangic: %s\nmod: %s\ndurum: %s\nduvar_suresi_s: %.1f\n%s\n', ...
    info.model, info.matlab, info.start, info.mod, info.status, info.wall_s, info.message);
fclose(fid);
close_system(mdl, 0);
fprintf('%s: %s (%.1f s)\n', mdl, info.status, info.wall_s);
end
