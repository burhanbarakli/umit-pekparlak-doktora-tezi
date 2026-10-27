% Q1-Q4 IGBT'li tek faz T-tipi Simscape Electrical modelini kurar.

root_dir = fileparts(fileparts(mfilename('fullpath')));
run(fullfile(root_dir,'parameters','switching_demo_parameters.m'));
model_dir = fullfile(root_dir,'models');
if ~exist(model_dir,'dir'), mkdir(model_dir); end
Simulink.fileGenControl('set', ...
    'CacheFolder',fullfile(root_dir,'build','cache'), ...
    'CodeGenFolder',fullfile(root_dir,'build','codegen'),'createDir',true);

model_name = 't_type_q1q4_switching_demo';
model_file = fullfile(model_dir,[model_name '.slx']);
if bdIsLoaded(model_name), close_system(model_name,0); end
if exist(model_file,'file'), delete(model_file); end
new_system(model_name);
open_system(model_name);
load_system('ee_lib');
load_system('nesl_utility');

set_param(model_name, ...
    'Solver','ode23t', ...
    'StopTime','t_stop_sw', ...
    'MaxStep','max_step_sw', ...
    'ReturnWorkspaceOutputs','on');
set_param(model_name,'PreLoadFcn', ...
    "demo_root=fileparts(fileparts(get_param(bdroot,'FileName'))); run(fullfile(demo_root,'parameters','switching_demo_parameters.m')); clear demo_root;");

% PWM ve durum mantığı
add_block('simulink/Sources/Sine Wave',[model_name '/modulation_ref'], ...
    'Amplitude','m_index','Frequency','w_grid_sw','Position',[30 55 90 85]);
add_block('simulink/Math Operations/Abs',[model_name '/abs_ref'], ...
    'Position',[125 52 165 88]);
add_block('simulink/Sources/Repeating Sequence',[model_name '/carrier_0_1'], ...
    'rep_seq_t','[0 T_switch/2 T_switch]', ...
    'rep_seq_y','[0 1 0]','Position',[30 125 105 155]);
add_block('simulink/Logic and Bit Operations/Relational Operator',[model_name '/pwm_active'], ...
    'Operator','>=','Position',[210 75 250 115]);
add_block('simulink/Sources/Constant',[model_name '/zero_ref'], ...
    'Value','0','Position',[120 180 160 210]);
add_block('simulink/Logic and Bit Operations/Relational Operator',[model_name '/positive_half'], ...
    'Operator','>=','Position',[210 160 250 200]);
add_block('simulink/Logic and Bit Operations/Logical Operator',[model_name '/negative_half'], ...
    'Operator','NOT','Position',[285 160 325 200]);
add_block('simulink/Logic and Bit Operations/Logical Operator',[model_name '/not_pwm'], ...
    'Operator','NOT','Position',[285 85 325 115]);
add_block('simulink/Logic and Bit Operations/Logical Operator',[model_name '/Q1_gate'], ...
    'Operator','AND','Inputs','2','Position',[370 35 420 70]);
add_block('simulink/Logic and Bit Operations/Logical Operator',[model_name '/Q2_gate'], ...
    'Operator','AND','Inputs','2','Position',[370 90 420 125]);
add_block('simulink/Logic and Bit Operations/Logical Operator',[model_name '/Q3_gate'], ...
    'Operator','OR','Inputs','2','Position',[370 145 420 180]);
add_block('simulink/Logic and Bit Operations/Logical Operator',[model_name '/Q4_gate'], ...
    'Operator','OR','Inputs','2','Position',[370 200 420 235]);

add_line(model_name,'modulation_ref/1','abs_ref/1','autorouting','on');
add_line(model_name,'abs_ref/1','pwm_active/1','autorouting','on');
add_line(model_name,'carrier_0_1/1','pwm_active/2','autorouting','on');
add_line(model_name,'modulation_ref/1','positive_half/1','autorouting','on');
add_line(model_name,'zero_ref/1','positive_half/2','autorouting','on');
add_line(model_name,'positive_half/1','negative_half/1','autorouting','on');
add_line(model_name,'pwm_active/1','not_pwm/1','autorouting','on');
add_line(model_name,'positive_half/1','Q1_gate/1','autorouting','on');
add_line(model_name,'pwm_active/1','Q1_gate/2','autorouting','on');
add_line(model_name,'negative_half/1','Q2_gate/1','autorouting','on');
add_line(model_name,'pwm_active/1','Q2_gate/2','autorouting','on');
add_line(model_name,'positive_half/1','Q3_gate/1','autorouting','on');
add_line(model_name,'not_pwm/1','Q3_gate/2','autorouting','on');
add_line(model_name,'negative_half/1','Q4_gate/1','autorouting','on');
add_line(model_name,'not_pwm/1','Q4_gate/2','autorouting','on');

% Simulink -> fiziksel kapı gerilimleri
for q = 1:4
    add_block('simulink/Signal Attributes/Data Type Conversion', ...
        [model_name sprintf('/Q%d_to_double',q)], ...
        'OutDataTypeStr','double', ...
        'Position',[435 28+55*(q-1) 455 62+55*(q-1)]);
    add_block('nesl_utility/Simulink-PS Converter', ...
        [model_name sprintf('/Q%d_PS',q)],'Unit','V', ...
        'FilteringAndDerivatives','zero','Position',[465 25+55*(q-1) 515 65+55*(q-1)]);
    add_line(model_name,sprintf('Q%d_gate/1',q),sprintf('Q%d_to_double/1',q),'autorouting','on');
    add_line(model_name,sprintf('Q%d_to_double/1',q),sprintf('Q%d_PS/1',q),'autorouting','on');
end

% Fiziksel güç elemanları
add_block('ee_lib/Sources/Voltage Source',[model_name '/DC_top'], ...
    'dc_voltage','Vdc_sw/2','ac_voltage','0','Position',[610 300 660 360]);
add_block('ee_lib/Sources/Voltage Source',[model_name '/DC_bottom'], ...
    'dc_voltage','Vdc_sw/2','ac_voltage','0','Position',[610 410 660 470]);
add_block('ee_lib/Sources/Voltage Source',[model_name '/Grid_source'], ...
    'dc_voltage','0','ac_voltage','V_grid_pk_sw','ac_frequency','f_grid_sw', ...
    'Position',[1420 390 1470 460]);

for q = 1:4
    add_block('ee_lib/Semiconductors & Converters/IGBT (Ideal, Switching)', ...
        [model_name sprintf('/Q%d',q)], ...
        'Vf','Vf_sw','Ron','Ron_sw','Goff','Goff_sw','Vth','Vth_sw', ...
        'diode_param','ee.enum.semiconductors.protectionDiode.nodynamics', ...
        'Position',[760+130*mod(q-1,2) 300+115*floor((q-1)/2) 820+130*mod(q-1,2) 380+115*floor((q-1)/2)]);
    ph_ps = get_param([model_name sprintf('/Q%d_PS',q)],'PortHandles');
    ph_q = get_param([model_name sprintf('/Q%d',q)],'PortHandles');
    add_line(model_name,ph_ps.RConn(1),ph_q.LConn(1),'autorouting','on');
end

add_block('ee_lib/Sensors & Transducers/Current Sensor',[model_name '/L1_current_sensor'], ...
    'Position',[1010 325 1070 375]);
add_block('ee_lib/Passive/Inductor',[model_name '/L1'], ...
    'l','L1_sw','r','R1_sw','Position',[1110 330 1180 370]);
add_block('ee_lib/Passive/Inductor',[model_name '/L2'], ...
    'l','L2_sw','r','R2_sw','Position',[1280 330 1350 370]);
add_block('ee_lib/Sensors & Transducers/Current Sensor',[model_name '/Grid_current_sensor'], ...
    'Position',[1365 325 1425 375]);
add_block('ee_lib/Passive/Resistor',[model_name '/Rd'], ...
    'R','Rd_sw','Position',[1210 445 1270 485]);
add_block('ee_lib/Passive/Capacitor',[model_name '/Cf'], ...
    'c','Cf_sw','Position',[1210 515 1270 555]);
add_block('ee_lib/Sensors & Transducers/Voltage Sensor',[model_name '/Pole_voltage_sensor'], ...
    'Position',[980 455 1040 515]);
add_block('ee_lib/Connectors & References/Electrical Reference',[model_name '/Electrical_reference'], ...
    'Position',[700 555 740 595]);
add_block('nesl_utility/Solver Configuration',[model_name '/Solver_Configuration'], ...
    'Position',[790 555 845 605]);

% Fiziksel düğümleri connection label ile kur
connect_electrical_node(model_name,'DC_top','LConn',1,'P',[590 270]);
connect_electrical_node(model_name,'DC_top','RConn',1,'N',[680 340]);
connect_electrical_node(model_name,'DC_bottom','LConn',1,'N',[590 390]);
connect_electrical_node(model_name,'DC_bottom','RConn',1,'M',[680 470]);

connect_electrical_node(model_name,'Q1','RConn',1,'P',[735 295]);
connect_electrical_node(model_name,'Q1','RConn',2,'X',[835 340]);
connect_electrical_node(model_name,'Q2','RConn',1,'X',[865 295]);
connect_electrical_node(model_name,'Q2','RConn',2,'M',[965 340]);
connect_electrical_node(model_name,'Q3','RConn',1,'N',[735 410]);
connect_electrical_node(model_name,'Q3','RConn',2,'Z',[835 455]);
connect_electrical_node(model_name,'Q4','RConn',1,'X',[865 410]);
connect_electrical_node(model_name,'Q4','RConn',2,'Z',[965 455]);

connect_electrical_node(model_name,'L1_current_sensor','LConn',1,'X',[985 315]);
connect_electrical_node(model_name,'L1_current_sensor','RConn',2,'I1N',[1080 315]);
connect_electrical_node(model_name,'L1','LConn',1,'I1N',[1090 300]);
connect_electrical_node(model_name,'L1','RConn',1,'C_NODE',[1190 315]);
connect_electrical_node(model_name,'L2','LConn',1,'C_NODE',[1260 300]);
connect_electrical_node(model_name,'L2','RConn',1,'L2_OUT',[1360 300]);
connect_electrical_node(model_name,'Grid_current_sensor','LConn',1,'L2_OUT',[1345 390]);
connect_electrical_node(model_name,'Grid_current_sensor','RConn',2,'GRID',[1435 315]);
connect_electrical_node(model_name,'Rd','LConn',1,'C_NODE',[1185 425]);
connect_electrical_node(model_name,'Rd','RConn',1,'CF_TOP',[1280 425]);
connect_electrical_node(model_name,'Cf','LConn',1,'CF_TOP',[1185 495]);
connect_electrical_node(model_name,'Cf','RConn',1,'N',[1280 545]);
connect_electrical_node(model_name,'Grid_source','LConn',1,'GRID',[1390 375]);
connect_electrical_node(model_name,'Grid_source','RConn',1,'N',[1490 455]);
connect_electrical_node(model_name,'Pole_voltage_sensor','LConn',1,'X',[955 440]);
connect_electrical_node(model_name,'Pole_voltage_sensor','RConn',2,'N',[1060 500]);
connect_electrical_node(model_name,'Electrical_reference','LConn',1,'N',[680 535]);
connect_electrical_node(model_name,'Solver_Configuration','RConn',1,'N',[760 535]);

% Ölçümleri Simulink tarafına aktar
add_block('nesl_utility/PS-Simulink Converter',[model_name '/IL1_PS_to_SL'], ...
    'Unit','A','Position',[1090 235 1150 275]);
add_block('nesl_utility/PS-Simulink Converter',[model_name '/Igrid_PS_to_SL'], ...
    'Unit','A','Position',[1370 235 1430 275]);
add_block('nesl_utility/PS-Simulink Converter',[model_name '/Vpole_PS_to_SL'], ...
    'Unit','V','Position',[1065 475 1125 515]);
ph_i1 = get_param([model_name '/L1_current_sensor'],'PortHandles');
ph_i1p = get_param([model_name '/IL1_PS_to_SL'],'PortHandles');
add_line(model_name,ph_i1.RConn(1),ph_i1p.LConn(1),'autorouting','on');
ph_i = get_param([model_name '/Grid_current_sensor'],'PortHandles');
ph_ip = get_param([model_name '/Igrid_PS_to_SL'],'PortHandles');
add_line(model_name,ph_i.RConn(1),ph_ip.LConn(1),'autorouting','on');
ph_v = get_param([model_name '/Pole_voltage_sensor'],'PortHandles');
ph_vp = get_param([model_name '/Vpole_PS_to_SL'],'PortHandles');
add_line(model_name,ph_v.RConn(1),ph_vp.LConn(1),'autorouting','on');

add_block('simulink/Sinks/To Workspace',[model_name '/save_i_l1'], ...
    'VariableName','i_l1_sw_log','SaveFormat','Timeseries','Position',[1180 230 1270 260]);
add_block('simulink/Sinks/To Workspace',[model_name '/save_i_grid'], ...
    'VariableName','i_grid_sw_log','SaveFormat','Timeseries','Position',[1450 235 1535 265]);
add_block('simulink/Sinks/To Workspace',[model_name '/save_v_pole'], ...
    'VariableName','v_pole_sw_log','SaveFormat','Timeseries','Position',[1145 480 1235 510]);
add_line(model_name,'IL1_PS_to_SL/1','save_i_l1/1','autorouting','on');
add_line(model_name,'Igrid_PS_to_SL/1','save_i_grid/1','autorouting','on');
add_line(model_name,'Vpole_PS_to_SL/1','save_v_pole/1','autorouting','on');

% Kapı ve referans kayıtları
for q = 1:4
    add_block('simulink/Sinks/To Workspace',[model_name sprintf('/save_Q%d',q)], ...
        'VariableName',sprintf('q%d_log',q),'SaveFormat','Timeseries', ...
        'Position',[535 15+55*(q-1) 600 45+55*(q-1)]);
    add_line(model_name,sprintf('Q%d_gate/1',q),sprintf('save_Q%d/1',q),'autorouting','on');
end
add_block('simulink/Sinks/To Workspace',[model_name '/save_mod_ref'], ...
    'VariableName','mod_ref_log','SaveFormat','Timeseries','Position',[30 15 100 40]);
add_block('simulink/Sinks/To Workspace',[model_name '/save_carrier'], ...
    'VariableName','carrier_log','SaveFormat','Timeseries','Position',[30 165 100 190]);
add_line(model_name,'modulation_ref/1','save_mod_ref/1','autorouting','on');
add_line(model_name,'carrier_0_1/1','save_carrier/1','autorouting','on');

set_param([model_name '/Q1_gate'],'BackgroundColor','green');
set_param([model_name '/Q2_gate'],'BackgroundColor','green');
set_param([model_name '/Q3_gate'],'BackgroundColor','yellow');
set_param([model_name '/Q4_gate'],'BackgroundColor','yellow');
note = Simulink.Annotation(model_name, ...
    'JÜRİ KONTROLÜ: izinli durumlar P=1010, O=0011, N=0101');
note.Position = [760 230];

save_system(model_name,model_file);
close_system(model_name,0);
fprintf('Anahtarlamalı model oluşturuldu: %s\n',model_file);

function connect_electrical_node(model_name,block_name,port_group,port_index,node_label,pos)
    persistent label_counter
    if isempty(label_counter), label_counter = 0; end
    label_counter = label_counter + 1;
    label_name = sprintf('node_%s_%03d',node_label,label_counter);
    add_block('nesl_utility/Connection Label',[model_name '/' label_name], ...
        'Label',node_label,'Position',[pos(1) pos(2) pos(1)+25 pos(2)+18]);
    ph_block = get_param([model_name '/' block_name],'PortHandles');
    ph_label = get_param([model_name '/' label_name],'PortHandles');
    add_line(model_name,ph_block.(port_group)(port_index),ph_label.LConn(1),'autorouting','on');
end
