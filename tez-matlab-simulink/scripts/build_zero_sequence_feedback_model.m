% Ölçülen nötr akımının 150 Hz bileşenini ortak-mod gerilimle bastırır.

root_dir=fileparts(fileparts(mfilename('fullpath')));
run(fullfile(root_dir,'parameters','closed_loop_demo_parameters.m'));
base_file=fullfile(root_dir,'models','t_type_three_phase_q1q4_closed_loop.slx');
if ~exist(base_file,'file'),run(fullfile(root_dir,'scripts','build_three_phase_switching_closed_loop.m'));end
base_name='t_type_three_phase_q1q4_closed_loop';
model_name='t_type_three_phase_zero_sequence_feedback';
model_file=fullfile(root_dir,'models',[model_name '.slx']);
if bdIsLoaded(base_name),close_system(base_name,0);end
if bdIsLoaded(model_name),close_system(model_name,0);end
load_system(base_file);save_system(base_name,model_file);close_system(base_name,0);load_system(model_file);
set_param(model_name,'PreLoadFcn', ...
    "demo_root=fileparts(fileparts(get_param(bdroot,'FileName'))); run(fullfile(demo_root,'parameters','closed_loop_demo_parameters.m')); clear demo_root;");

% Faz başına açık çevrim Sin^3 enjeksiyonunu ayır.
phase_names={'A','B','C'};
for p=1:3
    ph=phase_names{p};ports=get_param([model_name '/voltage_command_' ph],'PortHandles');
    old_line=get_param(ports.Inport(4),'Line');if old_line~=-1,delete_line(old_line);end
end

% Nötr akımı -> bir PWM gecikmesi -> 150 Hz bant/rezonans -> kazanç -> sınır.
add_block('simulink/Discrete/Unit Delay',[model_name '/neutral_sample_delay'], ...
    'SampleTime','Ts_control_cl','InitialCondition','0','Position',[2750 180 2810 215]);
add_block('simulink/Continuous/Transfer Fcn',[model_name '/neutral_150Hz_filter'], ...
    'Numerator','[2*wc_zero3_cl 0]', ...
    'Denominator','[1 2*wc_zero3_cl (3*w_grid_sw)^2]', ...
    'Position',[2840 175 2940 220]);
add_block('simulink/Math Operations/Gain',[model_name '/zero_sequence_gain'], ...
    'Gain','Kzero3_cl','Position',[2970 180 3035 215]);
add_block('simulink/Discontinuities/Saturation',[model_name '/zero_sequence_limit'], ...
    'UpperLimit','Vzero_limit_cl','LowerLimit','-Vzero_limit_cl', ...
    'Position',[3065 175 3135 220]);
add_block('simulink/Sinks/To Workspace',[model_name '/save_zero_sequence_voltage'], ...
    'VariableName','vzero_3cl_log','SaveFormat','Timeseries','Position',[3165 175 3250 210]);
add_line(model_name,'neutral_sign/1','neutral_sample_delay/1','autorouting','on');
add_line(model_name,'neutral_sample_delay/1','neutral_150Hz_filter/1','autorouting','on');
add_line(model_name,'neutral_150Hz_filter/1','zero_sequence_gain/1','autorouting','on');
add_line(model_name,'zero_sequence_gain/1','zero_sequence_limit/1','autorouting','on');
add_line(model_name,'zero_sequence_limit/1','save_zero_sequence_voltage/1','autorouting','on');
for p=1:3
    add_line(model_name,'zero_sequence_limit/1',['voltage_command_' phase_names{p} '/4'],'autorouting','on');
end
set_param([model_name '/neutral_150Hz_filter'],'BackgroundColor','cyan');
set_param([model_name '/zero_sequence_gain'],'BackgroundColor','green');
note=Simulink.Annotation(model_name, ...
    'YARIN KARŞILAŞTIRILACAK: ölçülen nötr akımından 150 Hz kapalı çevrim ortak-mod kompanzasyonu');
note.Position=[2410 120];
save_system(model_name,model_file);close_system(model_name,0);
fprintf('Sıfır-dizi geri besleme modeli oluşturuldu: %s\n',model_file);
