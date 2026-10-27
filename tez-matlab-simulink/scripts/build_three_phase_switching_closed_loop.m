% 12 IGBT'li üç faz fiziksel modele faz başına PR akım denetimi ekler.

root_dir=fileparts(fileparts(mfilename('fullpath')));
run(fullfile(root_dir,'parameters','closed_loop_demo_parameters.m'));
base_file=fullfile(root_dir,'models','t_type_three_phase_q1q4_switching.slx');
if ~exist(base_file,'file')
    run(fullfile(root_dir,'scripts','build_three_phase_switching_model.m'));
end
base_name='t_type_three_phase_q1q4_switching';
model_name='t_type_three_phase_q1q4_closed_loop';
model_file=fullfile(root_dir,'models',[model_name '.slx']);
if bdIsLoaded(base_name),close_system(base_name,0);end
if bdIsLoaded(model_name),close_system(model_name,0);end
load_system(base_file);
save_system(base_name,model_file);
close_system(base_name,0);
load_system(model_file);
set_param(model_name,'PreLoadFcn', ...
    "demo_root=fileparts(fileparts(get_param(bdroot,'FileName'))); run(fullfile(demo_root,'parameters','closed_loop_demo_parameters.m')); clear demo_root;");

phase_names={'A','B','C'};
phase_shift=[0 -2*pi/3 2*pi/3];
for p=1:3
    ph=phase_names{p};
    xb=280+(p-1)*820;
    phase_value=sprintf('%.17g',phase_shift(p));

    % Açık çevrim sinüs modülasyonunu kaldır; aynı adı denetleyici
    % çıkışına vererek mevcut PWM ve kapı yollarını koru.
    for dst={['abs_' ph],['pos_' ph]}
        dst_ports=get_param([model_name '/' dst{1}],'PortHandles');
        old_line=get_param(dst_ports.Inport(1),'Line');
        if old_line~=-1,delete_line(old_line);end
    end
    delete_block([model_name '/mod_ref_' ph]);
    add_block('simulink/Sources/Sine Wave',[model_name '/i_ref_' ph], ...
        'Amplitude','I_ref_pk_cl','Frequency','w_grid_sw','Phase',phase_value, ...
        'Position',[xb-5 225 xb+55 255]);
    add_block('simulink/Sources/Sine Wave',[model_name '/v_grid_ff_' ph], ...
        'Amplitude','V_grid_pk_sw','Frequency','w_grid_sw','Phase',phase_value, ...
        'Position',[xb-5 270 xb+55 300]);
    add_block('simulink/Discrete/Unit Delay',[model_name '/current_delay_' ph], ...
        'SampleTime','Ts_control_cl','InitialCondition','0', ...
        'Position',[xb+75 325 xb+125 360]);
    add_block('simulink/Math Operations/Sum',[model_name '/current_error_' ph], ...
        'Inputs','+-','Position',[xb+95 220 xb+125 260]);
    add_block('simulink/Math Operations/Gain',[model_name '/P_controller_' ph], ...
        'Gain','Kp_cl','Position',[xb+150 205 xb+210 235]);
    add_block('simulink/Continuous/Transfer Fcn',[model_name '/Resonant_controller_' ph], ...
        'Numerator','[2*Kr_cl*wc_cl 0]', ...
        'Denominator','[1 2*wc_cl w_grid_sw^2]', ...
        'Position',[xb+150 250 xb+240 285]);
    add_block('simulink/Math Operations/Sum',[model_name '/voltage_command_' ph], ...
        'Inputs','++++','Position',[xb+270 220 xb+300 285]);
    add_block('simulink/Sources/Sine Wave',[model_name '/sin_theta_' ph], ...
        'Amplitude','1','Frequency','w_grid_sw','Phase',phase_value, ...
        'Position',[xb+70 295 xb+125 325]);
    add_block('simulink/User-Defined Functions/Fcn',[model_name '/sin3_shape_' ph], ...
        'Expr','u^3','Position',[xb+145 295 xb+195 325]);
    add_block('simulink/Math Operations/Gain',[model_name '/sin3_voltage_' ph], ...
        'Gain','Ksin3_3ph','Position',[xb+215 295 xb+260 325]);
    add_block('simulink/Math Operations/Gain',[model_name '/normalize_vdc_' ph], ...
        'Gain','2/Vdc_sw','Position',[xb+325 235 xb+380 270]);
    add_block('simulink/Discontinuities/Saturation',[model_name '/mod_ref_' ph], ...
        'UpperLimit','modulation_limit_cl','LowerLimit','-modulation_limit_cl', ...
        'Position',[xb+400 230 xb+460 275]);
    add_block('simulink/Sinks/To Workspace',[model_name '/save_i_ref_' ph], ...
        'VariableName',['i_ref_' lower(ph) '_3cl_log'],'SaveFormat','Timeseries', ...
        'Position',[xb-5 185 xb+70 212]);

    add_line(model_name,['i_ref_' ph '/1'],['current_error_' ph '/1'],'autorouting','on');
    add_line(model_name,['i_ref_' ph '/1'],['save_i_ref_' ph '/1'],'autorouting','on');
    add_line(model_name,['Ig_PS_' ph '/1'],['current_delay_' ph '/1'],'autorouting','on');
    add_line(model_name,['current_delay_' ph '/1'],['current_error_' ph '/2'],'autorouting','on');
    add_line(model_name,['current_error_' ph '/1'],['P_controller_' ph '/1'],'autorouting','on');
    add_line(model_name,['current_error_' ph '/1'],['Resonant_controller_' ph '/1'],'autorouting','on');
    add_line(model_name,['P_controller_' ph '/1'],['voltage_command_' ph '/1'],'autorouting','on');
    add_line(model_name,['Resonant_controller_' ph '/1'],['voltage_command_' ph '/2'],'autorouting','on');
    add_line(model_name,['v_grid_ff_' ph '/1'],['voltage_command_' ph '/3'],'autorouting','on');
    add_line(model_name,['sin_theta_' ph '/1'],['sin3_shape_' ph '/1'],'autorouting','on');
    add_line(model_name,['sin3_shape_' ph '/1'],['sin3_voltage_' ph '/1'],'autorouting','on');
    add_line(model_name,['sin3_voltage_' ph '/1'],['voltage_command_' ph '/4'],'autorouting','on');
    add_line(model_name,['voltage_command_' ph '/1'],['normalize_vdc_' ph '/1'],'autorouting','on');
    add_line(model_name,['normalize_vdc_' ph '/1'],['mod_ref_' ph '/1'],'autorouting','on');
    add_line(model_name,['mod_ref_' ph '/1'],['abs_' ph '/1'],'autorouting','on');
    add_line(model_name,['mod_ref_' ph '/1'],['pos_' ph '/1'],'autorouting','on');
    set_param([model_name '/P_controller_' ph],'BackgroundColor','orange');
    set_param([model_name '/Resonant_controller_' ph],'BackgroundColor','orange');
    set_param([model_name '/sin3_voltage_' ph],'BackgroundColor','green');
end

% Nötr susturma etkin olduğunda O durumundaki Q3-Q4 kapı komutunu kaldır.
% P ve N durumlarını oluşturan birinci kapı girdileri değişmeden kalır.
add_block('simulink/Sources/Constant',[model_name '/neutral_suppression_3ph'], ...
    'Value','neutral_suppression_3ph','Position',[1000 125 1070 155]);
add_block('simulink/Logic and Bit Operations/Logical Operator',[model_name '/not_suppression_3ph'], ...
    'Operator','NOT','Position',[1100 120 1140 160]);
add_line(model_name,'neutral_suppression_3ph/1','not_suppression_3ph/1','autorouting','on');
for p=1:3
    ph=phase_names{p};xb=280+(p-1)*820;
    for q=3:4
        q_ports=get_param([model_name sprintf('/%s_Q%d_gate',ph,q)],'PortHandles');
        old_line=get_param(q_ports.Inport(2),'Line');
        if old_line~=-1,delete_line(old_line);end
    end
    add_block('simulink/Logic and Bit Operations/Logical Operator', ...
        [model_name '/classical_zero_enable_' ph], ...
        'Operator','AND','Inputs','2','Position',[xb+285 150 xb+325 185]);
    add_line(model_name,['not_pwm_' ph '/1'],['classical_zero_enable_' ph '/1'],'autorouting','on');
    add_line(model_name,'not_suppression_3ph/1',['classical_zero_enable_' ph '/2'],'autorouting','on');
    add_line(model_name,['classical_zero_enable_' ph '/1'],[ph '_Q3_gate/2'],'autorouting','on');
    add_line(model_name,['classical_zero_enable_' ph '/1'],[ph '_Q4_gate/2'],'autorouting','on');
end
set_param([model_name '/neutral_suppression_3ph'],'BackgroundColor','yellow');

note=Simulink.Annotation(model_name, ...
    'JÜRİ KONTROLÜ: faz başına PR akım denetimi + ileri besleme + bir PWM periyodu gecikme');
note.Position=[1060 180];
save_system(model_name,model_file);
close_system(model_name,0);
fprintf('Üç faz fiziksel kapalı çevrim model oluşturuldu: %s\n',model_file);
