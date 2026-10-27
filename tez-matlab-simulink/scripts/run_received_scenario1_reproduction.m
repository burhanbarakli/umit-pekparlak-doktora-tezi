% Gelen Senaryo 1 modelini değiştirmeden koşturur ve gösterge girişlerini kaydeder.
%
% Dosya adı ve proje yolundaki Türkçe/boşluk karakterleri bazı Simulink
% sürümlerinde model adı doğrulamasına takılabildiği için modelin SHA-256 ile
% doğrulanmış ASCII adlı çalışma kopyası RECEIVED_SCENARIO1_MODEL ile verilir.

model_file = getenv('RECEIVED_SCENARIO1_MODEL');
out_dir = getenv('RECEIVED_SCENARIO1_OUTDIR');
if isempty(model_file)
    error('RECEIVED_SCENARIO1_MODEL tanımlanmalıdır.');
end
if isempty(out_dir)
    error('RECEIVED_SCENARIO1_OUTDIR tanımlanmalıdır.');
end
if ~exist(out_dir,'dir'), mkdir(out_dir); end

[~,model_name] = fileparts(model_file);
load_system(model_file);
cleanup = onCleanup(@()close_system(model_name,0));
set_param(model_name,'SignalLogging','on','SignalLoggingName','logsout');

display_names = {'Vdc','Idc','DC Güç','AC Aktif Güç','AC Reaktif Güç', ...
    'AC Akım RMS','AC Akım THD','cosfi','Verim'};
signal_names = {'Vdc_V','Idc_A','Pdc_W','Pac_W','Qac_var', ...
    'Iac_RMS_A','Iac_THD_pct','cos_phi','Efficiency_pct'};
for k = 1:numel(display_names)
    block = [model_name '/' display_names{k}];
    ports = get_param(block,'PortHandles');
    line = get_param(ports.Inport,'Line');
    set_param(line,'Name',signal_names{k});
    source_port = get_param(line,'SrcPortHandle');
    source_block = get_param(source_port,'Parent');
    source_port_number = get_param(source_port,'PortNumber');
    Simulink.sdi.markSignalForStreaming(source_block,source_port_number,'on');
end

started = datetime('now','TimeZone','local');
fprintf('Senaryo 1 kaynak modeli başlatıldı: %s\n',char(started));
sim_out = sim(model_name,'ReturnWorkspaceOutputs','on');
finished = datetime('now','TimeZone','local');
fprintf('Senaryo 1 kaynak modeli tamamlandı: %s\n',char(finished));

logs = sim_out.logsout;
last_value = nan(numel(signal_names),1);
sample_count = zeros(numel(signal_names),1);
for k = 1:numel(signal_names)
    element = logs.get(signal_names{k});
    values = element.Values;
    data = squeeze(values.Data);
    if ~isvector(data), data = data(:,1); end
    data = data(:);
    good = find(isfinite(data),1,'last');
    if ~isempty(good), last_value(k) = data(good); end
    sample_count(k) = numel(data);
end

summary = table(string(signal_names(:)),last_value,sample_count, ...
    'VariableNames',{'Metric','FinalValue','SampleCount'});
writetable(summary,fullfile(out_dir,'source_model_final_displays.csv'));

fid = fopen(fullfile(out_dir,'source_model_run_metadata.txt'),'w');
fprintf(fid,'ModelFile=%s\n',model_file);
fprintf(fid,'ModelName=%s\n',model_name);
fprintf(fid,'StopTime=%s\n',get_param(model_name,'StopTime'));
fprintf(fid,'Solver=%s\n',get_param(model_name,'Solver'));
fprintf(fid,'MaxStep=%s\n',get_param(model_name,'MaxStep'));
fprintf(fid,'Started=%s\n',char(started));
fprintf(fid,'Finished=%s\n',char(finished));
fprintf(fid,'ElapsedSeconds=%.6f\n',seconds(finished-started));
fclose(fid);

disp(summary);
