% Senaryo 1 R2025b Simscape donusum adayini ayri bir kopyada dogrular.
%
% Ortam degiskenleri:
%   SCENARIO1_RUN_LABEL       : cikti/model etiketi
%   SCENARIO1_STOP_TIME       : saniye (varsayilan 0.04)
%   SCENARIO1_DIODE_FIDELITY  : full veya ideal (varsayilan full)
%   SCENARIO1_LOCAL_SOLVER    : on veya off (varsayilan on)
%   SCENARIO1_LOCAL_STEP      : saniye (varsayilan 2e-7)
%   SCENARIO1_SIM_MODE        : normal veya accelerator (varsayilan normal)
%   SCENARIO1_MAX_STEP        : global azami adim (yerel aciksa 2e-6, yoksa 1e-7)
%   SCENARIO1_L1_H, SCENARIO1_L1R_OHM, SCENARIO1_CF_F,
%   SCENARIO1_CFR_OHM, SCENARIO1_L2_H, SCENARIO1_L2R_OHM
%
% Kaynak SLX dosyasina dokunulmaz. Her kosu yeni bir model kopyasi uretir.

root_dir = fileparts(fileparts(mfilename('fullpath')));
source_file = fullfile(root_dir,'models', ...
    'Inverter2_senaryo1_20260816_simscape_conversion_candidate.slx');

run_label = getenv('SCENARIO1_RUN_LABEL');
if isempty(run_label), run_label = 'local_full'; end
stop_time = getenv('SCENARIO1_STOP_TIME');
if isempty(stop_time), stop_time = '0.04'; end
diode_fidelity = lower(getenv('SCENARIO1_DIODE_FIDELITY'));
if isempty(diode_fidelity), diode_fidelity = 'full'; end
local_solver = lower(getenv('SCENARIO1_LOCAL_SOLVER'));
if isempty(local_solver), local_solver = 'on'; end
local_step = getenv('SCENARIO1_LOCAL_STEP');
if isempty(local_step), local_step = '2e-7'; end
sim_mode = lower(getenv('SCENARIO1_SIM_MODE'));
if isempty(sim_mode), sim_mode = 'normal'; end
if ~ismember(sim_mode,{'normal','accelerator'})
    error('SCENARIO1_SIM_MODE normal veya accelerator olmalidir.');
end
max_step = getenv('SCENARIO1_MAX_STEP');
if isempty(max_step)
    if strcmp(local_solver,'on'), max_step = '2e-6'; else, max_step = '1e-7'; end
end
l1_h = env_or_default('SCENARIO1_L1_H','600e-6');
l1r_ohm = env_or_default('SCENARIO1_L1R_OHM','0.02');
cf_f = env_or_default('SCENARIO1_CF_F','8e-6');
cfr_ohm = env_or_default('SCENARIO1_CFR_OHM','0.01');
l2_h = env_or_default('SCENARIO1_L2_H','200e-6');
l2r_ohm = env_or_default('SCENARIO1_L2R_OHM','0.02');

safe_label = regexprep(run_label,'[^A-Za-z0-9_]','_');
work_file = fullfile(root_dir,'models', ...
    ['Inverter2_senaryo1_R2025b_L2_200uH_' safe_label '.slx']);
out_dir = fullfile(root_dir,'results','scenario1_r2025b_validation',safe_label);
if ~exist(out_dir,'dir'), mkdir(out_dir); end

[~,source_name] = fileparts(source_file);
load_system(source_file);
source_cleanup = onCleanup(@()close_if_loaded(source_name));
save_system(source_name,work_file);
close_system(source_name,0);
clear source_cleanup

[~,model_name] = fileparts(work_file);
load_system(work_file);
model_cleanup = onCleanup(@()close_if_loaded(model_name));

% 2026-08-26 tarihinde kaynaklar arasi capraz kontrolle secilen LCL takimi.
set_param([model_name '/Inductor'],'l',l1_h,'l_unit','H', ...
    'r',l1r_ohm,'r_unit','Ohm');
set_param([model_name '/Capacitor2'],'c',cf_f,'c_unit','F', ...
    'r',cfr_ohm,'r_unit','Ohm');
set_param([model_name '/CL1'],'l',l2_h,'l_unit','H', ...
    'r',l2r_ohm,'r_unit','Ohm');

diodes = find_system(model_name,'SearchDepth',1,'RegExp','on', ...
    'BlockType','SimscapeBlock','Name','^Diode');
if strcmp(diode_fidelity,'ideal')
    for k = 1:numel(diodes)
        set_param(diodes{k},'fidelity_level','ee.enum.diode.fidelity.idealSwitch');
        params = get_param(diodes{k},'ObjectParameters');
        if isfield(params,'tFilter')
            set_param(diodes{k},'tFilter','1e-8','tFilter_unit','s');
        end
    end
elseif ~strcmp(diode_fidelity,'full')
    error('SCENARIO1_DIODE_FIDELITY full veya ideal olmalidir.');
end

solver_blocks = find_system(model_name,'SearchDepth',1,'RegExp','on', ...
    'BlockType','SubSystem','Name','^Solver');
assert(numel(solver_blocks)==1,'Tek bir Solver Configuration blogu bekleniyordu.');
set_param(solver_blocks{1},'UseLocalSolver',local_solver, ...
    'LocalSolverChoice','NE_BACKWARD_EULER_ADVANCER', ...
    'LocalSolverSampleTime',local_step,'MaxNonlinIter','25','MaxModeIter','10');

set_param(model_name,'Solver','ode23t','MaxStep',max_step,'RelTol','1e-4', ...
    'StopTime',stop_time,'SimulationMode',sim_mode, ...
    'SignalLogging','on','SignalLoggingName','logsout', ...
    'SimscapeLogType','none','SimscapeLogSimulationStatistics','off');

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

raw_tags = {'v_dc','i_dc','v_ac','i_ac'};
raw_names = {'raw_vdc_V','raw_idc_A','raw_vac_V','raw_iac_A'};
for k = 1:numel(raw_tags)
    goto_blocks = find_system(model_name,'LookUnderMasks','all', ...
        'FollowLinks','off','BlockType','Goto','GotoTag',raw_tags{k});
    assert(numel(goto_blocks)==1,'Tek bir %s Goto blogu bekleniyordu.',raw_tags{k});
    ports = get_param(goto_blocks{1},'PortHandles');
    line = get_param(ports.Inport,'Line');
    set_param(line,'Name',raw_names{k});
    source_port = get_param(line,'SrcPortHandle');
    source_block = get_param(source_port,'Parent');
    source_port_number = get_param(source_port,'PortNumber');
    Simulink.sdi.markSignalForStreaming(source_block,source_port_number,'on');
end

save_system(model_name);

metadata_file = fullfile(out_dir,'run_metadata.txt');
fid = fopen(metadata_file,'w');
assert(fid~=-1,'Metadata dosyasi acilamadi.');
fprintf(fid,'SourceModel=%s\n',source_file);
fprintf(fid,'WorkingModel=%s\n',work_file);
fprintf(fid,'RunLabel=%s\n',run_label);
fprintf(fid,'StopTime=%s\n',stop_time);
fprintf(fid,'DiodeFidelity=%s\n',diode_fidelity);
if strcmp(diode_fidelity,'ideal'), fprintf(fid,'DiodeLossFilterTime_s=1e-8\n'); end
fprintf(fid,'UseLocalSolver=%s\n',local_solver);
fprintf(fid,'LocalSolverChoice=NE_BACKWARD_EULER_ADVANCER\n');
fprintf(fid,'LocalSolverSampleTime=%s\n',local_step);
fprintf(fid,'SimulationMode=%s\n',sim_mode);
fprintf(fid,'GlobalSolver=ode23t\nMaxStep=%s\nRelTol=1e-4\n',max_step);
fprintf(fid,'L1_H=%s\nL1r_Ohm=%s\nCf_F=%s\nCfr_Ohm=%s\n', ...
    l1_h,l1r_ohm,cf_f,cfr_ohm);
fprintf(fid,'L2_H=%s\nL2r_Ohm=%s\n',l2_h,l2r_ohm);
fprintf(fid,'Status=STARTED\n');
fprintf(fid,'Started=%s\n',char(datetime('now','TimeZone','local')));
fclose(fid);

fprintf('RUN_START label=%s stop=%s fidelity=%s local=%s step=%s mode=%s\n', ...
    run_label,stop_time,diode_fidelity,local_solver,local_step,sim_mode);
tic;
try
    sim_out = sim(model_name,'ReturnWorkspaceOutputs','on');
    elapsed = toc;
catch ME
    elapsed = toc;
    fid = fopen(metadata_file,'a');
    fprintf(fid,'Status=FAILED\nElapsedSeconds=%.6f\n',elapsed);
    fprintf(fid,'FailureIdentifier=%s\nFailureMessage=%s\n', ...
        ME.identifier,regexprep(ME.message,'[\r\n]+',' | '));
    fclose(fid);
    report = getReport(ME,'extended','hyperlinks','off');
    fid = fopen(fullfile(out_dir,'failure_report.txt'),'w');
    fprintf(fid,'%s',report);
    fclose(fid);
    fprintf(2,'RUN_FAILED elapsed=%.3f s\n%s\n',elapsed,report);
    rethrow(ME);
end

logs = sim_out.logsout;
last_value = nan(numel(signal_names),1);
sample_count = zeros(numel(signal_names),1);
last_time = nan(numel(signal_names),1);
for k = 1:numel(signal_names)
    element = logs.get(signal_names{k});
    values = element.Values;
    data = squeeze(values.Data);
    if ~isvector(data), data = data(:,1); end
    data = data(:);
    time = values.Time(:);
    good = find(isfinite(data),1,'last');
    if ~isempty(good)
        last_value(k) = data(good);
        last_time(k) = time(good);
    end
    sample_count(k) = numel(data);
end

summary = table(string(signal_names(:)),last_value,last_time,sample_count, ...
    'VariableNames',{'Metric','FinalValue','FinalTime_s','SampleCount'});
writetable(summary,fullfile(out_dir,'final_displays.csv'));

raw_mean = nan(numel(raw_names),1);
raw_rms = nan(numel(raw_names),1);
raw_min = nan(numel(raw_names),1);
raw_max = nan(numel(raw_names),1);
tail_mean = nan(numel(raw_names),1);
tail_rms = nan(numel(raw_names),1);
raw_count = zeros(numel(raw_names),1);
raw_signals = struct;
for k = 1:numel(raw_names)
    element = logs.get(raw_names{k});
    values = element.Values;
    data = squeeze(values.Data);
    if ~isvector(data), data = data(:,1); end
    data = data(:);
    time = values.Time(:);
    finite = isfinite(data);
    data_good = data(finite);
    time_good = time(finite);
    raw_count(k) = numel(data_good);
    if ~isempty(data_good)
        raw_mean(k) = mean(data_good);
        raw_rms(k) = sqrt(mean(data_good.^2));
        raw_min(k) = min(data_good);
        raw_max(k) = max(data_good);
        tail = time_good >= 0.8*time_good(end);
        tail_mean(k) = mean(data_good(tail));
        tail_rms(k) = sqrt(mean(data_good(tail).^2));
    end
    raw_signals.(raw_names{k}) = struct('Time_s',time,'Data',data);
end
raw_summary = table(string(raw_names(:)),raw_mean,raw_rms,raw_min,raw_max, ...
    tail_mean,tail_rms,raw_count,'VariableNames', ...
    {'Signal','Mean','RMS','Min','Max','Tail20pctMean','Tail20pctRMS','SampleCount'});
writetable(raw_summary,fullfile(out_dir,'raw_signal_summary.csv'));
save(fullfile(out_dir,'raw_signals.mat'),'raw_signals','-v7.3');

fid = fopen(metadata_file,'a');
fprintf(fid,'Status=SUCCESS\nElapsedSeconds=%.6f\n',elapsed);
fprintf(fid,'Finished=%s\n',char(datetime('now','TimeZone','local')));
fclose(fid);
fprintf('RUN_SUCCESS elapsed=%.3f s\n',elapsed);
disp(summary);
disp(raw_summary);

function close_if_loaded(model_name)
if bdIsLoaded(model_name), close_system(model_name,0); end
end

function value = env_or_default(name,default_value)
value = getenv(name);
if isempty(value), value = default_value; end
end
