% Donusum adayini ayri bir calisma kopyasinda kademeli olarak yoklar.
% Secenekler kapaliyken elektriksel parametreler korunur; acikken filtre,
% yariletken sablonlari veya cozucu denemeleri izlenebilir bicimde uygulanir.
% SCENARIO1_APPLY_FILTER=on ise yalniz LCL degerleri ortam degiskenlerinden
% uygulanir; yariiletken ve cozucu ayarlari yine degistirilmez.
% SCENARIO1_APPLY_DIODE_SET=on ise DSEI parametreleri yalniz harici D1-D2
% diyotlarina (Diode6 ve Diode7) uygulanir. IGBT ic diyotlari degistirilmez.
% SCENARIO1_APPLY_DEVICE_BLOCKS=on ise modeldeki dogrulanmis SKM ve IXYN
% sablon parametreleri devredeki S1-S2 ve S3-S4 bloklarina kopyalanir.
% SCENARIO1_PRECHARGE_DCLINK=on ise iki 470 uF bara kondansatoru kaynak
% geriliminin yarisiyla baslatilir.
% SCENARIO1_ROBUST_SOLVER=on yalniz Newton/mod iterasyon sinirlarini artirir.
% SCENARIO1_APPLY_GATE_TIMING=on e-postadaki ortak S12/S34 zamanlarini dort
% Gate Driver bloguna uygular (165/400/600/600 ns).
% SCENARIO1_APPLY_IGBT_TIMING=on ayni zamanlari dogru katman olan devredeki
% S1-S4 IGBT bloklarina uygular.

root_dir = fileparts(fileparts(mfilename('fullpath')));
source_file = fullfile(root_dir,'models', ...
    'Inverter2_senaryo1_20260816_simscape_conversion_candidate.slx');
stop_time = getenv('SCENARIO1_STOP_TIME');
if isempty(stop_time), stop_time = '0.005'; end
sim_mode = lower(getenv('SCENARIO1_SIM_MODE'));
if isempty(sim_mode), sim_mode = 'normal'; end
label = getenv('SCENARIO1_RUN_LABEL');
if isempty(label), label = 'baseline_probe'; end
safe_label = regexprep(label,'[^A-Za-z0-9_]','_');
apply_filter = lower(getenv('SCENARIO1_APPLY_FILTER'));
if isempty(apply_filter), apply_filter = 'off'; end
apply_diode_set = lower(getenv('SCENARIO1_APPLY_DIODE_SET'));
if isempty(apply_diode_set), apply_diode_set = 'off'; end
apply_device_blocks = lower(getenv('SCENARIO1_APPLY_DEVICE_BLOCKS'));
if isempty(apply_device_blocks), apply_device_blocks = 'off'; end
precharge_dclink = lower(getenv('SCENARIO1_PRECHARGE_DCLINK'));
if isempty(precharge_dclink), precharge_dclink = 'off'; end
robust_solver = lower(getenv('SCENARIO1_ROBUST_SOLVER'));
if isempty(robust_solver), robust_solver = 'off'; end
apply_gate_timing = lower(getenv('SCENARIO1_APPLY_GATE_TIMING'));
if isempty(apply_gate_timing), apply_gate_timing = 'off'; end
apply_igbt_timing = lower(getenv('SCENARIO1_APPLY_IGBT_TIMING'));
if isempty(apply_igbt_timing), apply_igbt_timing = 'off'; end

work_file = fullfile(root_dir,'models', ...
    ['Inverter2_senaryo1_R2025b_baseline_' safe_label '.slx']);
out_dir = fullfile(root_dir,'results','scenario1_r2025b_validation',safe_label);
if ~exist(out_dir,'dir'), mkdir(out_dir); end

[~,source_name] = fileparts(source_file);
load_system(source_file);
save_system(source_name,work_file);
close_system(source_name,0);

[~,model_name] = fileparts(work_file);
load_system(work_file);
cleanup = onCleanup(@()close_if_loaded(model_name));
if strcmp(apply_filter,'on')
    l1_h = env_or_default('SCENARIO1_L1_H','600e-6');
    l1r_ohm = env_or_default('SCENARIO1_L1R_OHM','0.02');
    cf_f = env_or_default('SCENARIO1_CF_F','8e-6');
    cfr_ohm = env_or_default('SCENARIO1_CFR_OHM','0.01');
    l2_h = env_or_default('SCENARIO1_L2_H','200e-6');
    l2r_ohm = env_or_default('SCENARIO1_L2R_OHM','0.02');
    set_param([model_name '/Inductor'],'l',l1_h,'l_unit','H', ...
        'r',l1r_ohm,'r_unit','Ohm');
    set_param([model_name '/Capacitor2'],'c',cf_f,'c_unit','F', ...
        'r',cfr_ohm,'r_unit','Ohm');
    set_param([model_name '/CL1'],'l',l2_h,'l_unit','H', ...
        'r',l2r_ohm,'r_unit','Ohm');
elseif ~strcmp(apply_filter,'off')
    error('SCENARIO1_APPLY_FILTER on veya off olmalidir.');
end
dsei_diodes = {'Diode6','Diode7'};
if strcmp(apply_diode_set,'on')
    for k = 1:numel(dsei_diodes)
        set_param([model_name '/' dsei_diodes{k}], ...
            'Vf','1.35','Vf_unit','V', ...
            'Ron','8.5','Ron_unit','mOhm', ...
            'Goff','1e-8','Goff_unit','S', ...
            'CJ','31','CJ_unit','pF', ...
            'iRM','-13','iRM_unit','A', ...
            'iF','60','iF_unit','A', ...
            'didt','-300','didt_unit','A/us', ...
            'trr','380','trr_unit','ns', ...
            'fidelity_level','ee.enum.diode.fidelity.includeChargeDyn');
    end
elseif ~strcmp(apply_diode_set,'off')
    error('SCENARIO1_APPLY_DIODE_SET on veya off olmalidir.');
end
if strcmp(apply_device_blocks,'on')
    skm_template = [model_name '/N-Channel IGBT1'];
    skm_targets = {[model_name '/N-Channel IGBT'], ...
        [model_name '/N-Channel IGBT4']};
    ixyn_template = [model_name '/N-Channel IGBT6'];
    ixyn_targets = {[model_name '/N-Channel IGBT2'], ...
        [model_name '/N-Channel IGBT3']};
    for k = 1:numel(skm_targets)
        copy_dialog_parameters(skm_template,skm_targets{k});
    end
    for k = 1:numel(ixyn_targets)
        copy_dialog_parameters(ixyn_template,ixyn_targets{k});
    end
elseif ~strcmp(apply_device_blocks,'off')
    error('SCENARIO1_APPLY_DEVICE_BLOCKS on veya off olmalidir.');
end
if strcmp(precharge_dclink,'on')
    dc_voltage = str2double(get_param([model_name '/Voltage Source'],'dc_voltage'));
    assert(isfinite(dc_voltage) && dc_voltage>0,'DC kaynak gerilimi okunamadi.');
    cap_init_v = dc_voltage/2;
    cap_init_text = sprintf('%.12g',cap_init_v);
    for cap_name = {'Capacitor','Capacitor1'}
        set_param([model_name '/' cap_name{1}], ...
            'vc_specify','on','vc_priority','Low', ...
            'vc',cap_init_text,'vc_unit','V');
    end
elseif ~strcmp(precharge_dclink,'off')
    error('SCENARIO1_PRECHARGE_DCLINK on veya off olmalidir.');
end
if strcmp(robust_solver,'on')
    solver_blocks = find_system(model_name,'SearchDepth',1,'RegExp','on', ...
        'BlockType','SubSystem','Name','^Solver');
    assert(numel(solver_blocks)==1,'Tek bir Solver Configuration blogu bekleniyordu.');
    set_param(solver_blocks{1},'MaxNonlinIter','50','MaxModeIter','10', ...
        'NumHomotopyIterations','200');
    set_param(model_name,'NumberNewtonIterations',3, ...
        'SolverResetMethod','Robust','MaxConsecutiveMinStep','1000');
elseif ~strcmp(robust_solver,'off')
    error('SCENARIO1_ROBUST_SOLVER on veya off olmalidir.');
end
if strcmp(apply_gate_timing,'on')
    gate_drivers = find_system(model_name,'LookUnderMasks','all', ...
        'FollowLinks','off','RegExp','on','BlockType','SimscapeBlock', ...
        'Name','^Gate Driver');
    assert(numel(gate_drivers)==4,'Dort Gate Driver blogu bekleniyordu.');
    for k = 1:numel(gate_drivers)
        set_param(gate_drivers{k}, ...
            'tHigh','165','tHigh_unit','ns', ...
            'tLow','400','tLow_unit','ns', ...
            'tRise','600','tRise_unit','ns', ...
            'tFall','600','tFall_unit','ns');
    end
elseif ~strcmp(apply_gate_timing,'off')
    error('SCENARIO1_APPLY_GATE_TIMING on veya off olmalidir.');
end
active_igbts = {'N-Channel IGBT','N-Channel IGBT2', ...
    'N-Channel IGBT3','N-Channel IGBT4'};
if strcmp(apply_igbt_timing,'on')
    for k = 1:numel(active_igbts)
        set_param([model_name '/' active_igbts{k}], ...
            't_on','165','t_on_unit','ns', ...
            't_off','400','t_off_unit','ns', ...
            't_rise','600','t_rise_unit','ns', ...
            't_fall','600','t_fall_unit','ns');
    end
elseif ~strcmp(apply_igbt_timing,'off')
    error('SCENARIO1_APPLY_IGBT_TIMING on veya off olmalidir.');
end
set_param(model_name,'StopTime',stop_time,'SimulationMode',sim_mode, ...
    'SignalLogging','on','SignalLoggingName','logsout');

display_names = {'Vdc','Idc','DC Güç','AC Aktif Güç','AC Reaktif Güç', ...
    'AC Akım RMS','AC Akım THD','cosfi','Verim'};
display_signal_names = {'Vdc_V','Idc_A','Pdc_W','Pac_W','Qac_var', ...
    'Iac_RMS_A','Iac_THD_pct','cos_phi','Efficiency_pct'};
for k = 1:numel(display_names)
    block = [model_name '/' display_names{k}];
    ports = get_param(block,'PortHandles');
    line = get_param(ports.Inport,'Line');
    set_param(line,'Name',display_signal_names{k});
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

fid = fopen(fullfile(out_dir,'run_metadata.txt'),'w');
fprintf(fid,'SourceModel=%s\nWorkingModel=%s\n',source_file,work_file);
fprintf(fid,'ProbeType=PARAMETERIZED_R2025B_CONVERSION_PROBE\n');
fprintf(fid,'ApplyFilter=%s\n',apply_filter);
fprintf(fid,'ApplyCommonDSEIDiodeSet=%s\n',apply_diode_set);
fprintf(fid,'ApplyValidatedDeviceBlocks=%s\n',apply_device_blocks);
fprintf(fid,'PrechargeDCLink=%s\n',precharge_dclink);
fprintf(fid,'RobustSolverIterations=%s\n',robust_solver);
fprintf(fid,'ApplyCommonGateTiming=%s\n',apply_gate_timing);
fprintf(fid,'ApplyCommonIGBTTiming=%s\n',apply_igbt_timing);
if strcmp(apply_igbt_timing,'on')
    fprintf(fid,['ActiveIGBTs=N-Channel IGBT,N-Channel IGBT2,' ...
        'N-Channel IGBT3,N-Channel IGBT4\n' ...
        'IGBTTurnOnDelay_ns=165\nIGBTTurnOffDelay_ns=400\n' ...
        'IGBTRiseTime_ns=600\nIGBTFallTime_ns=600\n']);
end
if strcmp(apply_gate_timing,'on')
    fprintf(fid,['GateTurnOnDelay_ns=165\nGateTurnOffDelay_ns=400\n' ...
        'GateRiseTime_ns=600\nGateFallTime_ns=600\n']);
end
if strcmp(robust_solver,'on')
    fprintf(fid,['SolverMaxNonlinearIterations=50\nSolverMaxModeIterations=10\n' ...
        'SolverHomotopyIterations=200\nSimulinkNewtonIterations=3\n' ...
        'SolverResetMethod=Robust\nMaxConsecutiveMinStep=1000\n']);
end
if strcmp(precharge_dclink,'on')
    fprintf(fid,'DCLinkCapacitorInitialVoltage_V=%.12g\n',cap_init_v);
end
if strcmp(apply_diode_set,'on')
    fprintf(fid,['DSEIDiodes=Diode6,Diode7\n' ...
        'DiodeVf_V=1.35\nDiodeRon_mOhm=8.5\nDiodeGoff_S=1e-8\n' ...
        'DiodeCj_pF=31\nDiodeiRM_A=-13\nDiodeiF_A=60\n' ...
        'DiodeDidt_A_per_us=-300\nDiodeTrr_ns=380\n']);
end
if strcmp(apply_device_blocks,'on')
    fprintf(fid,['SKMTemplate=N-Channel IGBT1\n' ...
        'SKMTargets=N-Channel IGBT,N-Channel IGBT4\n' ...
        'IXYNTemplate=N-Channel IGBT6\n' ...
        'IXYNTargets=N-Channel IGBT2,N-Channel IGBT3\n']);
end
if strcmp(apply_filter,'on')
    fprintf(fid,'L1_H=%s\nL1r_Ohm=%s\nCf_F=%s\nCfr_Ohm=%s\n', ...
        l1_h,l1r_ohm,cf_f,cfr_ohm);
    fprintf(fid,'L2_H=%s\nL2r_Ohm=%s\n',l2_h,l2r_ohm);
end
fprintf(fid,'StopTime=%s\nSimulationMode=%s\n',stop_time,sim_mode);
fprintf(fid,'Solver=%s\nMaxStep=%s\nRelTol=%s\n',get_param(model_name,'Solver'), ...
    get_param(model_name,'MaxStep'),get_param(model_name,'RelTol'));
fprintf(fid,'Status=STARTED\n');
fclose(fid);

fprintf('BASELINE_START stop=%s mode=%s solver=%s maxstep=%s reltol=%s\n', ...
    stop_time,sim_mode,get_param(model_name,'Solver'), ...
    get_param(model_name,'MaxStep'),get_param(model_name,'RelTol'));
tic;
try
    sim_out = sim(model_name,'ReturnWorkspaceOutputs','on');
    elapsed = toc;
catch ME
    elapsed = toc;
    fid = fopen(fullfile(out_dir,'run_metadata.txt'),'a');
    fprintf(fid,'Status=FAILED\nElapsedSeconds=%.6f\n',elapsed);
    fprintf(fid,'FailureIdentifier=%s\nFailureMessage=%s\n', ...
        ME.identifier,regexprep(ME.message,'[\r\n]+',' | '));
    fclose(fid);
    report = getReport(ME,'extended','hyperlinks','off');
    fid = fopen(fullfile(out_dir,'failure_report.txt'),'w');
    fprintf(fid,'%s',report);
    fclose(fid);
    fprintf(2,'BASELINE_FAILED elapsed=%.3f s\n%s\n',elapsed,report);
    rethrow(ME);
end

logs = sim_out.logsout;
n_display = numel(display_signal_names);
display_final = nan(n_display,1); display_time = nan(n_display,1);
display_count = zeros(n_display,1);
for k = 1:n_display
    values = logs.get(display_signal_names{k}).Values;
    data = squeeze(values.Data);
    if ~isvector(data), data = data(:,1); end
    data = data(:); time = values.Time(:);
    good = find(isfinite(data),1,'last');
    if ~isempty(good)
        display_final(k) = data(good); display_time(k) = time(good);
    end
    display_count(k) = numel(data);
end
display_summary = table(string(display_signal_names(:)),display_final, ...
    display_time,display_count,'VariableNames', ...
    {'Metric','FinalValue','FinalTime_s','SampleCount'});
writetable(display_summary,fullfile(out_dir,'final_displays.csv'));

n = numel(raw_names);
mean_value = nan(n,1); rms_value = nan(n,1);
min_value = nan(n,1); max_value = nan(n,1);
tail_mean = nan(n,1); tail_rms = nan(n,1); sample_count = zeros(n,1);
raw_signals = struct;
for k = 1:n
    values = logs.get(raw_names{k}).Values;
    data = squeeze(values.Data);
    if ~isvector(data), data = data(:,1); end
    data = data(:); time = values.Time(:);
    finite = isfinite(data);
    data_good = data(finite); time_good = time(finite);
    sample_count(k) = numel(data_good);
    if ~isempty(data_good)
        mean_value(k) = mean(data_good);
        rms_value(k) = sqrt(mean(data_good.^2));
        min_value(k) = min(data_good); max_value(k) = max(data_good);
        tail = time_good >= 0.8*time_good(end);
        tail_mean(k) = mean(data_good(tail));
        tail_rms(k) = sqrt(mean(data_good(tail).^2));
    end
    raw_signals.(raw_names{k}) = struct('Time_s',time,'Data',data);
end
summary = table(string(raw_names(:)),mean_value,rms_value,min_value,max_value, ...
    tail_mean,tail_rms,sample_count,'VariableNames', ...
    {'Signal','Mean','RMS','Min','Max','Tail20pctMean','Tail20pctRMS','SampleCount'});
writetable(summary,fullfile(out_dir,'raw_signal_summary.csv'));
save(fullfile(out_dir,'raw_signals.mat'),'raw_signals','-v7.3');
fid = fopen(fullfile(out_dir,'run_metadata.txt'),'a');
fprintf(fid,'Status=SUCCESS\nElapsedSeconds=%.6f\n',elapsed);
fclose(fid);
fprintf('BASELINE_SUCCESS elapsed=%.3f s\n',elapsed);
disp(display_summary);
disp(summary);

function close_if_loaded(model_name)
if bdIsLoaded(model_name), close_system(model_name,0); end
end

function value = env_or_default(name,default_value)
value = getenv(name);
if isempty(value), value = default_value; end
end

function copy_dialog_parameters(source_block,target_block)
source_parameters = get_param(source_block,'DialogParameters');
target_parameters = get_param(target_block,'DialogParameters');
parameter_names = intersect(fieldnames(source_parameters), ...
    fieldnames(target_parameters),'stable');
for k = 1:numel(parameter_names)
    name = parameter_names{k};
    value = get_param(source_block,name);
    try
        set_param(target_block,name,value);
    catch ME
        error('Parametre kopyalanamadi: %s -> %s, %s (%s)', ...
            source_block,target_block,name,ME.message);
    end
end
end
