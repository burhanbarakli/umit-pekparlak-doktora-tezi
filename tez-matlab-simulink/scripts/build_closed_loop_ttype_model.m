% Çalışan Q1-Q4 modelinden kapalı çevrim/susturma/Sin^3 sürümü üretir.

root_dir = fileparts(fileparts(mfilename('fullpath')));
run(fullfile(root_dir,'parameters','closed_loop_demo_parameters.m'));
Simulink.fileGenControl('set', ...
    'CacheFolder',fullfile(root_dir,'build','cache'), ...
    'CodeGenFolder',fullfile(root_dir,'build','codegen'),'createDir',true);

base_file = fullfile(root_dir,'models','t_type_q1q4_switching_demo.slx');
if ~exist(base_file,'file')
    run(fullfile(root_dir,'scripts','build_switching_ttype_model.m'));
end
base_name = 't_type_q1q4_switching_demo';
model_name = 't_type_q1q4_closed_loop_demo';
model_file = fullfile(root_dir,'models',[model_name '.slx']);
if bdIsLoaded(base_name), close_system(base_name,0); end
if bdIsLoaded(model_name), close_system(model_name,0); end
load_system(base_file);
save_system(base_name,model_file);
close_system(base_name,0);
load_system(model_file);

set_param(model_name,'PreLoadFcn', ...
    "demo_root=fileparts(fileparts(get_param(bdroot,'FileName'))); run(fullfile(demo_root,'parameters','closed_loop_demo_parameters.m')); clear demo_root;");

% Gerçek kapı yoluna yükselen-kenar ölü zamanı ekle:
% min(raw, delayed(raw)) yükselişi geciktirir, düşüşü anında kapatır.
for q=1:4
    raw_block=[model_name sprintf('/Q%d_to_double',q)];
    ps_block=[model_name sprintf('/Q%d_PS',q)];
    save_block=[model_name sprintf('/save_Q%d',q)];
    ph_ps=get_param(ps_block,'PortHandles');
    old_line=get_param(ph_ps.Inport(1),'Line');
    if old_line~=-1,delete_line(old_line);end
    ph_save=get_param(save_block,'PortHandles');
    old_line=get_param(ph_save.Inport(1),'Line');
    if old_line~=-1,delete_line(old_line);end
    add_block('simulink/Continuous/Transport Delay', ...
        [model_name sprintf('/Q%d_turn_on_delay',q)], ...
        'DelayTime','dead_time_cl','InitialOutput','0', ...
        'Position',[525 25+55*(q-1) 570 55+55*(q-1)]);
    add_block('simulink/Math Operations/MinMax', ...
        [model_name sprintf('/Q%d_deadtime_gate',q)], ...
        'Function','min','Inputs','2', ...
        'Position',[600 22+55*(q-1) 640 60+55*(q-1)]);
    add_line(model_name,[sprintf('Q%d_to_double/1',q)], ...
        [sprintf('Q%d_turn_on_delay/1',q)],'autorouting','on');
    add_line(model_name,[sprintf('Q%d_to_double/1',q)], ...
        [sprintf('Q%d_deadtime_gate/1',q)],'autorouting','on');
    add_line(model_name,[sprintf('Q%d_turn_on_delay/1',q)], ...
        [sprintf('Q%d_deadtime_gate/2',q)],'autorouting','on');
    add_line(model_name,[sprintf('Q%d_deadtime_gate/1',q)], ...
        [sprintf('Q%d_PS/1',q)],'autorouting','on');
    add_line(model_name,[sprintf('Q%d_deadtime_gate/1',q)], ...
        [sprintf('save_Q%d/1',q)],'autorouting','on');
end

% Açık çevrim modülasyon kaynağını kapalı çevrim komutuyla değiştir
delete_block([model_name '/modulation_ref']);
for dst = {'abs_ref','positive_half','save_mod_ref'}
    ph_dst = get_param([model_name '/' dst{1}],'PortHandles');
    old_line = get_param(ph_dst.Inport(1),'Line');
    if old_line ~= -1, delete_line(old_line); end
end
add_block('simulink/Sources/Sine Wave',[model_name '/i_ref_cl'], ...
    'Amplitude','I_ref_pk_cl','Frequency','w_grid_sw','Position',[20 20 80 50]);
add_block('simulink/Sources/Sine Wave',[model_name '/v_grid_ff'], ...
    'Amplitude','V_grid_pk_sw','Frequency','w_grid_sw','Position',[20 60 80 90]);
add_block('simulink/Sources/Sine Wave',[model_name '/sin_theta_cl'], ...
    'Amplitude','1','Frequency','w_grid_sw','Position',[20 245 80 275]);
add_block('simulink/Math Operations/Sum',[model_name '/current_error_cl'], ...
    'Inputs','+-','Position',[125 15 155 55]);
add_block('simulink/Discrete/Unit Delay',[model_name '/current_sample_delay_cl'], ...
    'SampleTime','Ts_control_cl','InitialCondition','0', ...
    'Position',[65 145 115 180]);
add_block('simulink/Math Operations/Gain',[model_name '/P_controller_cl'], ...
    'Gain','Kp_cl','Position',[190 5 255 35]);
add_block('simulink/Continuous/Transfer Fcn',[model_name '/Resonant_controller_cl'], ...
    'Numerator','[2*Kr_cl*wc_cl 0]', ...
    'Denominator','[1 2*wc_cl w_grid_sw^2]', ...
    'Position',[190 55 285 90]);
add_block('simulink/User-Defined Functions/Fcn',[model_name '/sin3_shape_cl'], ...
    'Expr','u^3','Position',[115 240 175 280]);
add_block('simulink/Math Operations/Gain',[model_name '/Sin3_gain_cl'], ...
    'Gain','Ksin3_cl','Position',[205 235 275 265]);
add_block('simulink/Sources/Constant',[model_name '/sin3_enable_cl'], ...
    'Value','sin3_enable_cl','Position',[205 285 265 315]);
add_block('simulink/Sources/Constant',[model_name '/zero_sin3_cl'], ...
    'Value','0','Position',[205 325 265 355]);
add_block('simulink/Signal Routing/Switch',[model_name '/Sin3_enable_switch_cl'], ...
    'Criteria','u2 ~= 0','Threshold','0.5','Position',[310 245 355 300]);
add_block('simulink/Math Operations/Sum',[model_name '/voltage_command_cl'], ...
    'Inputs','++++','Position',[325 45 355 135]);
add_block('simulink/Math Operations/Gain',[model_name '/normalize_vdc_cl'], ...
    'Gain','2/Vdc_sw','Position',[390 70 455 105]);
add_block('simulink/Discontinuities/Saturation',[model_name '/modulation_ref'], ...
    'UpperLimit','modulation_limit_cl','LowerLimit','-modulation_limit_cl', ...
    'Position',[485 65 550 110]);

add_line(model_name,'i_ref_cl/1','current_error_cl/1','autorouting','on');
add_line(model_name,'Igrid_PS_to_SL/1','current_sample_delay_cl/1','autorouting','on');
add_line(model_name,'current_sample_delay_cl/1','current_error_cl/2','autorouting','on');
add_line(model_name,'current_error_cl/1','P_controller_cl/1','autorouting','on');
add_line(model_name,'current_error_cl/1','Resonant_controller_cl/1','autorouting','on');
add_line(model_name,'P_controller_cl/1','voltage_command_cl/1','autorouting','on');
add_line(model_name,'Resonant_controller_cl/1','voltage_command_cl/2','autorouting','on');
add_line(model_name,'v_grid_ff/1','voltage_command_cl/3','autorouting','on');
add_line(model_name,'sin_theta_cl/1','sin3_shape_cl/1','autorouting','on');
add_line(model_name,'sin3_shape_cl/1','Sin3_gain_cl/1','autorouting','on');
add_line(model_name,'Sin3_gain_cl/1','Sin3_enable_switch_cl/1','autorouting','on');
add_line(model_name,'sin3_enable_cl/1','Sin3_enable_switch_cl/2','autorouting','on');
add_line(model_name,'zero_sin3_cl/1','Sin3_enable_switch_cl/3','autorouting','on');
add_line(model_name,'Sin3_enable_switch_cl/1','voltage_command_cl/4','autorouting','on');
add_line(model_name,'voltage_command_cl/1','normalize_vdc_cl/1','autorouting','on');
add_line(model_name,'normalize_vdc_cl/1','modulation_ref/1','autorouting','on');
add_line(model_name,'modulation_ref/1','abs_ref/1','autorouting','on');
add_line(model_name,'modulation_ref/1','positive_half/1','autorouting','on');
add_line(model_name,'modulation_ref/1','save_mod_ref/1','autorouting','on');

% Nötr anahtar susturma: O durumundaki ikinci nötr kapı komutunu kaldırır
q3_port = get_param([model_name '/Q3_gate'],'PortHandles');
q4_port = get_param([model_name '/Q4_gate'],'PortHandles');
delete_line(get_param(q3_port.Inport(2),'Line'));
delete_line(get_param(q4_port.Inport(2),'Line'));
add_block('simulink/Sources/Constant',[model_name '/neutral_suppression_enable'], ...
    'Value','neutral_suppression_enable','Position',[285 335 355 365]);
add_block('simulink/Logic and Bit Operations/Logical Operator',[model_name '/not_suppression'], ...
    'Operator','NOT','Position',[385 330 425 370]);
add_block('simulink/Logic and Bit Operations/Logical Operator',[model_name '/classical_zero_enable'], ...
    'Operator','AND','Inputs','2','Position',[455 325 505 370]);
add_line(model_name,'neutral_suppression_enable/1','not_suppression/1','autorouting','on');
add_line(model_name,'not_pwm/1','classical_zero_enable/1','autorouting','on');
add_line(model_name,'not_suppression/1','classical_zero_enable/2','autorouting','on');
add_line(model_name,'classical_zero_enable/1','Q3_gate/2','autorouting','on');
add_line(model_name,'classical_zero_enable/1','Q4_gate/2','autorouting','on');

% Referans ve hata kayıtları
add_block('simulink/Sinks/To Workspace',[model_name '/save_i_ref_cl'], ...
    'VariableName','i_ref_cl_log','SaveFormat','Timeseries','Position',[20 105 95 135]);
add_block('simulink/Sinks/To Workspace',[model_name '/save_error_cl'], ...
    'VariableName','error_cl_log','SaveFormat','Timeseries','Position',[170 105 245 135]);
add_line(model_name,'i_ref_cl/1','save_i_ref_cl/1','autorouting','on');
add_line(model_name,'current_error_cl/1','save_error_cl/1','autorouting','on');

set_param([model_name '/P_controller_cl'],'BackgroundColor','orange');
set_param([model_name '/Resonant_controller_cl'],'BackgroundColor','orange');
set_param([model_name '/Sin3_gain_cl'],'BackgroundColor','green');
set_param([model_name '/neutral_suppression_enable'],'BackgroundColor','yellow');
note=Simulink.Annotation(model_name, ...
    'JÜRİ KONTROLÜ: kapalı çevrim + ölü zaman + nötr susturma + Sin^3 ayrı seçilebilir');
note.Position=[565 20];

save_system(model_name,model_file);
close_system(model_name,0);
fprintf('Kapalı çevrim model oluşturuldu: %s\n',model_file);
