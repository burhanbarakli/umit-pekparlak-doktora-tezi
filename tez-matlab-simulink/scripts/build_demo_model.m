% T-tipi/LCL/Sin^3 ortalama değer modelini programatik olarak kurar.

root_dir = fileparts(fileparts(mfilename('fullpath')));
run(fullfile(root_dir,'parameters','thesis_demo_parameters.m'));
model_dir = fullfile(root_dir,'models');
if ~exist(model_dir,'dir'), mkdir(model_dir); end
cache_dir = fullfile(root_dir,'build','cache');
codegen_dir = fullfile(root_dir,'build','codegen');
Simulink.fileGenControl('set','CacheFolder',cache_dir, ...
    'CodeGenFolder',codegen_dir,'createDir',true);
model_name = 't_type_lcl_sin3_demo';
model_file = fullfile(model_dir,[model_name '.slx']);

if bdIsLoaded(model_name), close_system(model_name,0); end
if exist(model_file,'file'), delete(model_file); end
new_system(model_name);
open_system(model_name);

set_param(model_name, ...
    'Solver','ode23tb', ...
    'StopTime','t_stop', ...
    'MaxStep','max_step', ...
    'ReturnWorkspaceOutputs','on', ...
    'SignalLogging','off');
set_param(model_name,'PreLoadFcn', ...
    "demo_root=fileparts(fileparts(get_param(bdroot,'FileName'))); run(fullfile(demo_root,'parameters','thesis_demo_parameters.m')); clear demo_root;");

% Kaynaklar
add_block('simulink/Sources/Sine Wave',[model_name '/i_ref'], ...
    'Amplitude','I_ref_pk','Frequency','w_grid','Position',[35 60 95 90]);
add_block('simulink/Sources/Sine Wave',[model_name '/v_grid'], ...
    'Amplitude','V_grid_pk','Frequency','w_grid','Position',[35 320 95 350]);
add_block('simulink/Sources/Sine Wave',[model_name '/sin_theta'], ...
    'Amplitude','1','Frequency','w_grid','Position',[35 185 95 215]);
add_block('simulink/User-Defined Functions/Fcn',[model_name '/sin3_shape'], ...
    'Expr','u^3','Position',[125 180 190 220]);

% Denetim ve düşük güç eşdeğeri
add_block('simulink/Math Operations/Sum',[model_name '/current_error'], ...
    'Inputs','+-','Position',[155 55 180 95]);
add_block('simulink/Math Operations/Gain',[model_name '/P_controller'], ...
    'Gain','Kp','Position',[215 58 280 92]);
add_block('simulink/Math Operations/Gain',[model_name '/low_power_disturbance'], ...
    'Gain','Kdist','Position',[225 165 320 195]);
add_block('simulink/Math Operations/Gain',[model_name '/Sin3_compensation'], ...
    'Gain','Ksin3','Position',[225 220 320 250]);
add_block('simulink/Sources/Constant',[model_name '/sin3_enable'], ...
    'Value','sin3_enable','Position',[245 270 300 300]);
add_block('simulink/Sources/Constant',[model_name '/zero'], ...
    'Value','0','Position',[245 315 300 345]);
add_block('simulink/Signal Routing/Switch',[model_name '/enable_compensation'], ...
    'Criteria','u2 ~= 0','Threshold','0.5','Position',[350 225 395 275]);
add_block('simulink/Math Operations/Sum',[model_name '/modulation_sum'], ...
    'Inputs','++++','Position',[440 120 470 210]);
add_block('simulink/Discontinuities/Saturation',[model_name '/dc_bus_limit'], ...
    'UpperLimit','Vdc/2','LowerLimit','-Vdc/2','Position',[510 145 585 185]);

% LCL durum denklemleri
add_block('simulink/Math Operations/Sum',[model_name '/L1_voltage'], ...
    'Inputs','+---','Position',[630 120 660 205]);
add_block('simulink/Math Operations/Gain',[model_name '/inv_L1'], ...
    'Gain','1/L1','Position',[700 135 760 175]);
add_block('simulink/Continuous/Integrator',[model_name '/i1'], ...
    'InitialCondition','0','Position',[800 135 835 175]);
add_block('simulink/Math Operations/Gain',[model_name '/R1_drop'], ...
    'Gain','R1','Position',[785 225 845 255]);

add_block('simulink/Math Operations/Sum',[model_name '/C_current'], ...
    'Inputs','+-','Position',[880 120 910 175]);
add_block('simulink/Math Operations/Gain',[model_name '/inv_Cf'], ...
    'Gain','1/Cf','Position',[945 130 1005 170]);
add_block('simulink/Math Operations/Gain',[model_name '/Rd_drop'], ...
    'Gain','Rd','Position',[945 205 1005 235]);
add_block('simulink/Continuous/Integrator',[model_name '/v_cap'], ...
    'InitialCondition','0','Position',[1045 130 1080 170]);

add_block('simulink/Math Operations/Sum',[model_name '/L2_voltage'], ...
    'Inputs','++--','Position',[1115 120 1145 205]);
add_block('simulink/Math Operations/Gain',[model_name '/inv_L2Lg'], ...
    'Gain','1/(L2+Lg)','Position',[1185 135 1265 175]);
add_block('simulink/Continuous/Integrator',[model_name '/i_grid'], ...
    'InitialCondition','0','Position',[1305 135 1340 175]);
add_block('simulink/Math Operations/Gain',[model_name '/R2_drop'], ...
    'Gain','R2','Position',[1290 225 1350 255]);

% Kayıt ve görünüm
add_block('simulink/Signal Routing/Mux',[model_name '/scope_mux'], ...
    'Inputs','3','Position',[1390 55 1395 170]);
add_block('simulink/Sinks/Scope',[model_name '/Scope'], ...
    'Position',[1440 85 1490 135]);
add_block('simulink/Sinks/To Workspace',[model_name '/save_i_ref'], ...
    'VariableName','i_ref_log','SaveFormat','Timeseries','Position',[95 15 175 40]);
add_block('simulink/Sinks/To Workspace',[model_name '/save_i_grid'], ...
    'VariableName','i_grid_log','SaveFormat','Timeseries','Position',[1375 190 1460 220]);
add_block('simulink/Sinks/To Workspace',[model_name '/save_v_mod'], ...
    'VariableName','v_mod_log','SaveFormat','Timeseries','Position',[505 85 585 115]);
add_block('simulink/Sinks/To Workspace',[model_name '/save_sin3'], ...
    'VariableName','sin3_log','SaveFormat','Timeseries','Position',[350 165 425 195]);

% Bağlantılar: denetim
add_line(model_name,'i_ref/1','current_error/1','autorouting','on');
add_line(model_name,'current_error/1','P_controller/1','autorouting','on');
add_line(model_name,'sin_theta/1','sin3_shape/1','autorouting','on');
add_line(model_name,'sin3_shape/1','low_power_disturbance/1','autorouting','on');
add_line(model_name,'sin3_shape/1','Sin3_compensation/1','autorouting','on');
add_line(model_name,'Sin3_compensation/1','enable_compensation/1','autorouting','on');
add_line(model_name,'sin3_enable/1','enable_compensation/2','autorouting','on');
add_line(model_name,'zero/1','enable_compensation/3','autorouting','on');
add_line(model_name,'P_controller/1','modulation_sum/1','autorouting','on');
add_line(model_name,'v_grid/1','modulation_sum/2','autorouting','on');
add_line(model_name,'low_power_disturbance/1','modulation_sum/3','autorouting','on');
add_line(model_name,'enable_compensation/1','modulation_sum/4','autorouting','on');
add_line(model_name,'modulation_sum/1','dc_bus_limit/1','autorouting','on');

% Bağlantılar: LCL
add_line(model_name,'dc_bus_limit/1','L1_voltage/1','autorouting','on');
add_line(model_name,'v_cap/1','L1_voltage/2','autorouting','on');
add_line(model_name,'i1/1','R1_drop/1','autorouting','on');
add_line(model_name,'R1_drop/1','L1_voltage/3','autorouting','on');
add_line(model_name,'Rd_drop/1','L1_voltage/4','autorouting','on');
add_line(model_name,'L1_voltage/1','inv_L1/1','autorouting','on');
add_line(model_name,'inv_L1/1','i1/1','autorouting','on');
add_line(model_name,'i1/1','C_current/1','autorouting','on');
add_line(model_name,'i_grid/1','C_current/2','autorouting','on');
add_line(model_name,'C_current/1','inv_Cf/1','autorouting','on');
add_line(model_name,'C_current/1','Rd_drop/1','autorouting','on');
add_line(model_name,'inv_Cf/1','v_cap/1','autorouting','on');
add_line(model_name,'v_cap/1','L2_voltage/1','autorouting','on');
add_line(model_name,'Rd_drop/1','L2_voltage/2','autorouting','on');
add_line(model_name,'v_grid/1','L2_voltage/3','autorouting','on');
add_line(model_name,'i_grid/1','R2_drop/1','autorouting','on');
add_line(model_name,'R2_drop/1','L2_voltage/4','autorouting','on');
add_line(model_name,'L2_voltage/1','inv_L2Lg/1','autorouting','on');
add_line(model_name,'inv_L2Lg/1','i_grid/1','autorouting','on');
add_line(model_name,'i_grid/1','current_error/2','autorouting','on');

% Kayıt bağlantıları
add_line(model_name,'i_ref/1','save_i_ref/1','autorouting','on');
add_line(model_name,'i_grid/1','save_i_grid/1','autorouting','on');
add_line(model_name,'dc_bus_limit/1','save_v_mod/1','autorouting','on');
add_line(model_name,'enable_compensation/1','save_sin3/1','autorouting','on');
add_line(model_name,'i_ref/1','scope_mux/1','autorouting','on');
add_line(model_name,'i_grid/1','scope_mux/2','autorouting','on');
add_line(model_name,'dc_bus_limit/1','scope_mux/3','autorouting','on');
add_line(model_name,'scope_mux/1','Scope/1','autorouting','on');

% Görsel gruplama
set_param([model_name '/P_controller'],'BackgroundColor','orange');
set_param([model_name '/Sin3_compensation'],'BackgroundColor','green');
set_param([model_name '/low_power_disturbance'],'BackgroundColor','yellow');
set_param([model_name '/i1'],'BackgroundColor','lightBlue');
set_param([model_name '/v_cap'],'BackgroundColor','lightBlue');
set_param([model_name '/i_grid'],'BackgroundColor','lightBlue');

note1 = Simulink.Annotation(model_name, ...
    'YEŞİL: Sin^3 kompanzasyonu | SARI: düşük güç bozucu eşdeğeri | MAVİ: LCL durumları');
note1.Position = [430 20];
note2 = Simulink.Annotation(model_name, ...
    'JÜRİ KONTROLÜ: sonraki aşamada Q1-Q4 anahtarlamalı T-tipi güç katı eklenecek');
note2.Position = [610 300];

save_system(model_name,model_file);
close_system(model_name,0);
fprintf('Model oluşturuldu: %s\n',model_file);
