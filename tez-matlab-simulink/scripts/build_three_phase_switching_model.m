% Ortak DA bara ve nötrlü, 12 IGBT'li üç faz T-tipi Simscape modeli.

root_dir=fileparts(fileparts(mfilename('fullpath')));
run(fullfile(root_dir,'parameters','closed_loop_demo_parameters.m'));
Simulink.fileGenControl('set','CacheFolder',fullfile(root_dir,'build','cache'), ...
    'CodeGenFolder',fullfile(root_dir,'build','codegen'),'createDir',true);
model_name='t_type_three_phase_q1q4_switching';
model_file=fullfile(root_dir,'models',[model_name '.slx']);
if bdIsLoaded(model_name),close_system(model_name,0);end
if exist(model_file,'file'),delete(model_file);end
new_system(model_name);open_system(model_name);
load_system('ee_lib');load_system('nesl_utility');
set_param(model_name,'Solver','ode23t','StopTime','0.06','MaxStep','max_step_sw', ...
    'ReturnWorkspaceOutputs','on');
set_param(model_name,'PreLoadFcn', ...
    "demo_root=fileparts(fileparts(get_param(bdroot,'FileName'))); run(fullfile(demo_root,'parameters','closed_loop_demo_parameters.m')); clear demo_root;");

% Ortak bölünmüş DA bara, referans ve çözücü
add_block('ee_lib/Sources/Voltage Source',[model_name '/DC_top'], ...
    'dc_voltage','Vdc_sw/2','ac_voltage','0','Position',[35 430 85 490]);
add_block('ee_lib/Sources/Voltage Source',[model_name '/DC_bottom'], ...
    'dc_voltage','Vdc_sw/2','ac_voltage','0','Position',[35 540 85 600]);
add_block('ee_lib/Connectors & References/Electrical Reference',[model_name '/Electrical_reference'], ...
    'Position',[115 650 155 690]);
add_block('nesl_utility/Solver Configuration',[model_name '/Solver_Configuration'], ...
    'Position',[190 640 245 695]);
connect_node(model_name,'DC_top','LConn',1,'P',[15 400]);
connect_node(model_name,'DC_top','RConn',1,'N',[100 465]);
connect_node(model_name,'DC_bottom','LConn',1,'N',[15 515]);
connect_node(model_name,'DC_bottom','RConn',1,'M',[100 600]);
connect_node(model_name,'Electrical_reference','LConn',1,'N',[95 625]);
connect_node(model_name,'Solver_Configuration','RConn',1,'N',[170 620]);

phase_names={'A','B','C'};
phase_shift=[0 -2*pi/3 2*pi/3];
phase_colors={'lightBlue','yellow','green'};
for p=1:3
    ph=phase_names{p}; xb=280+(p-1)*820;
    phase_value=sprintf('%.17g',phase_shift(p));

    % Faz kaydırılmış PWM durumu
    add_block('simulink/Sources/Sine Wave',[model_name '/mod_ref_' ph], ...
        'Amplitude','m_index','Frequency','w_grid_sw','Phase',phase_value, ...
        'Position',[xb 30 xb+60 60]);
    add_block('simulink/Math Operations/Abs',[model_name '/abs_' ph], ...
        'Position',[xb+90 27 xb+130 63]);
    add_block('simulink/Sources/Repeating Sequence',[model_name '/carrier_' ph], ...
        'rep_seq_t','[0 T_switch/2 T_switch]','rep_seq_y','[0 1 0]', ...
        'Position',[xb 90 xb+70 120]);
    add_block('simulink/Logic and Bit Operations/Relational Operator',[model_name '/pwm_' ph], ...
        'Operator','>=','Position',[xb+170 45 xb+210 85]);
    add_block('simulink/Sources/Constant',[model_name '/zero_' ph], ...
        'Value','0','Position',[xb+85 145 xb+125 175]);
    add_block('simulink/Logic and Bit Operations/Relational Operator',[model_name '/pos_' ph], ...
        'Operator','>=','Position',[xb+170 125 xb+210 165]);
    add_block('simulink/Logic and Bit Operations/Logical Operator',[model_name '/neg_' ph], ...
        'Operator','NOT','Position',[xb+245 125 xb+285 165]);
    add_block('simulink/Logic and Bit Operations/Logical Operator',[model_name '/not_pwm_' ph], ...
        'Operator','NOT','Position',[xb+245 50 xb+285 80]);

    for q=1:4
        gate_name=sprintf('%s_Q%d_gate',ph,q);
        op='AND'; if q>=3,op='OR';end
        add_block('simulink/Logic and Bit Operations/Logical Operator', ...
            [model_name '/' gate_name],'Operator',op,'Inputs','2', ...
            'Position',[xb+330 20+48*(q-1) xb+380 52+48*(q-1)]);
    end
    add_line(model_name,['mod_ref_' ph '/1'],['abs_' ph '/1'],'autorouting','on');
    add_line(model_name,['abs_' ph '/1'],['pwm_' ph '/1'],'autorouting','on');
    add_line(model_name,['carrier_' ph '/1'],['pwm_' ph '/2'],'autorouting','on');
    add_line(model_name,['mod_ref_' ph '/1'],['pos_' ph '/1'],'autorouting','on');
    add_line(model_name,['zero_' ph '/1'],['pos_' ph '/2'],'autorouting','on');
    add_line(model_name,['pos_' ph '/1'],['neg_' ph '/1'],'autorouting','on');
    add_line(model_name,['pwm_' ph '/1'],['not_pwm_' ph '/1'],'autorouting','on');
    add_line(model_name,['pos_' ph '/1'],[ph '_Q1_gate/1'],'autorouting','on');
    add_line(model_name,['pwm_' ph '/1'],[ph '_Q1_gate/2'],'autorouting','on');
    add_line(model_name,['neg_' ph '/1'],[ph '_Q2_gate/1'],'autorouting','on');
    add_line(model_name,['pwm_' ph '/1'],[ph '_Q2_gate/2'],'autorouting','on');
    add_line(model_name,['pos_' ph '/1'],[ph '_Q3_gate/1'],'autorouting','on');
    add_line(model_name,['not_pwm_' ph '/1'],[ph '_Q3_gate/2'],'autorouting','on');
    add_line(model_name,['neg_' ph '/1'],[ph '_Q4_gate/1'],'autorouting','on');
    add_line(model_name,['not_pwm_' ph '/1'],[ph '_Q4_gate/2'],'autorouting','on');

    % Gerçek kapı yolu: Boolean -> double -> yükselen kenar gecikmesi -> IGBT
    for q=1:4
        yq=20+48*(q-1);
        add_block('simulink/Signal Attributes/Data Type Conversion', ...
            [model_name sprintf('/%s_Q%d_double',ph,q)],'OutDataTypeStr','double', ...
            'Position',[xb+400 yq+2 xb+420 yq+30]);
        add_block('simulink/Continuous/Transport Delay', ...
            [model_name sprintf('/%s_Q%d_delay',ph,q)], ...
            'DelayTime','dead_time_cl','InitialOutput','0', ...
            'Position',[xb+440 yq xb+480 yq+30]);
        add_block('simulink/Math Operations/MinMax', ...
            [model_name sprintf('/%s_Q%d_actual',ph,q)], ...
            'Function','min','Inputs','2','Position',[xb+505 yq xb+545 yq+32]);
        add_block('nesl_utility/Simulink-PS Converter', ...
            [model_name sprintf('/%s_Q%d_PS',ph,q)],'Unit','V', ...
            'FilteringAndDerivatives','zero','Position',[xb+565 yq xb+610 yq+34]);
        add_block('simulink/Sinks/To Workspace', ...
            [model_name sprintf('/save_%s_Q%d',ph,q)], ...
            'VariableName',sprintf('%s_q%d_3sw_log',lower(ph),q), ...
            'SaveFormat','Timeseries','Position',[xb+630 yq xb+700 yq+28]);
        add_line(model_name,[ph sprintf('_Q%d_gate/1',q)], ...
            [ph sprintf('_Q%d_double/1',q)],'autorouting','on');
        add_line(model_name,[ph sprintf('_Q%d_double/1',q)], ...
            [ph sprintf('_Q%d_delay/1',q)],'autorouting','on');
        add_line(model_name,[ph sprintf('_Q%d_double/1',q)], ...
            [ph sprintf('_Q%d_actual/1',q)],'autorouting','on');
        add_line(model_name,[ph sprintf('_Q%d_delay/1',q)], ...
            [ph sprintf('_Q%d_actual/2',q)],'autorouting','on');
        add_line(model_name,[ph sprintf('_Q%d_actual/1',q)], ...
            [ph sprintf('_Q%d_PS/1',q)],'autorouting','on');
        add_line(model_name,[ph sprintf('_Q%d_actual/1',q)], ...
            [sprintf('save_%s_Q%d/1',ph,q)],'autorouting','on');
    end

    % Faz başına dört IGBT ve ortak DA bara
    qx=xb+150; qy=390;
    for q=1:4
        add_block('ee_lib/Semiconductors & Converters/IGBT (Ideal, Switching)', ...
            [model_name sprintf('/%s_Q%d',ph,q)], ...
            'Vf','Vf_sw','Ron','Ron_sw','Goff','Goff_sw','Vth','Vth_sw', ...
            'diode_param','ee.enum.semiconductors.protectionDiode.nodynamics', ...
            'Position',[qx+120*mod(q-1,2) qy+115*floor((q-1)/2) ...
            qx+55+120*mod(q-1,2) qy+75+115*floor((q-1)/2)]);
        ph_ps=get_param([model_name sprintf('/%s_Q%d_PS',ph,q)],'PortHandles');
        ph_q=get_param([model_name sprintf('/%s_Q%d',ph,q)],'PortHandles');
        add_line(model_name,ph_ps.RConn(1),ph_q.LConn(1),'autorouting','on');
    end
    X=['X_' ph];Z=['Z_' ph];I1N=['I1N_' ph];CN=['C_' ph];L2O=['L2O_' ph];GRID=['GRID_' ph];CFT=['CFT_' ph];
    connect_node(model_name,[ph '_Q1'],'RConn',1,'P',[qx-25 qy-25]);
    connect_node(model_name,[ph '_Q1'],'RConn',2,X,[qx+70 qy+70]);
    connect_node(model_name,[ph '_Q2'],'RConn',1,X,[qx+95 qy-25]);
    connect_node(model_name,[ph '_Q2'],'RConn',2,'M',[qx+190 qy+70]);
    connect_node(model_name,[ph '_Q3'],'RConn',1,'N',[qx-25 qy+90]);
    connect_node(model_name,[ph '_Q3'],'RConn',2,Z,[qx+70 qy+185]);
    connect_node(model_name,[ph '_Q4'],'RConn',1,X,[qx+95 qy+90]);
    connect_node(model_name,[ph '_Q4'],'RConn',2,Z,[qx+190 qy+185]);

    % LCL filtresi, şebeke ve iki akım sensörü
    add_block('ee_lib/Sensors & Transducers/Current Sensor',[model_name '/I1_sensor_' ph], ...
        'Position',[xb+410 425 xb+465 475]);
    add_block('ee_lib/Passive/Inductor',[model_name '/L1_' ph], ...
        'l','L1_sw','r','R1_sw','Position',[xb+500 430 xb+565 470]);
    add_block('ee_lib/Passive/Inductor',[model_name '/L2_' ph], ...
        'l','L2_sw','r','R2_sw','Position',[xb+650 430 xb+715 470]);
    add_block('ee_lib/Sensors & Transducers/Current Sensor',[model_name '/Grid_sensor_' ph], ...
        'Position',[xb+745 425 xb+800 475]);
    add_block('ee_lib/Passive/Resistor',[model_name '/Rd_' ph], ...
        'R','Rd_sw','Position',[xb+590 545 xb+645 580]);
    add_block('ee_lib/Passive/Capacitor',[model_name '/Cf_' ph], ...
        'c','Cf_sw','Position',[xb+590 620 xb+645 655]);
    add_block('ee_lib/Sources/Voltage Source',[model_name '/Grid_source_' ph], ...
        'dc_voltage','0','ac_voltage','V_grid_pk_sw','ac_frequency','f_grid_sw', ...
        'ac_shift',phase_value,'Position',[xb+755 560 xb+805 630]);
    connect_node(model_name,['I1_sensor_' ph],'LConn',1,X,[xb+390 405]);
    connect_node(model_name,['I1_sensor_' ph],'RConn',2,I1N,[xb+475 405]);
    connect_node(model_name,['L1_' ph],'LConn',1,I1N,[xb+485 390]);
    connect_node(model_name,['L1_' ph],'RConn',1,CN,[xb+575 405]);
    connect_node(model_name,['L2_' ph],'LConn',1,CN,[xb+635 390]);
    connect_node(model_name,['L2_' ph],'RConn',1,L2O,[xb+725 390]);
    connect_node(model_name,['Grid_sensor_' ph],'LConn',1,L2O,[xb+730 405]);
    connect_node(model_name,['Grid_sensor_' ph],'RConn',2,GRID,[xb+810 405]);
    connect_node(model_name,['Rd_' ph],'LConn',1,CN,[xb+570 520]);
    connect_node(model_name,['Rd_' ph],'RConn',1,CFT,[xb+655 520]);
    connect_node(model_name,['Cf_' ph],'LConn',1,CFT,[xb+570 600]);
    connect_node(model_name,['Cf_' ph],'RConn',1,'N',[xb+655 660]);
    connect_node(model_name,['Grid_source_' ph],'LConn',1,GRID,[xb+735 540]);
    connect_node(model_name,['Grid_source_' ph],'RConn',1,'N',[xb+815 635]);

    % Akım ölçümlerini Simulink'e taşı
    add_block('nesl_utility/PS-Simulink Converter',[model_name '/I1_PS_' ph], ...
        'Unit','A','Position',[xb+420 330 xb+475 365]);
    add_block('nesl_utility/PS-Simulink Converter',[model_name '/Ig_PS_' ph], ...
        'Unit','A','Position',[xb+745 330 xb+800 365]);
    phs=get_param([model_name '/I1_sensor_' ph],'PortHandles');php=get_param([model_name '/I1_PS_' ph],'PortHandles');
    add_line(model_name,phs.RConn(1),php.LConn(1),'autorouting','on');
    phs=get_param([model_name '/Grid_sensor_' ph],'PortHandles');php=get_param([model_name '/Ig_PS_' ph],'PortHandles');
    add_line(model_name,phs.RConn(1),php.LConn(1),'autorouting','on');
    add_block('simulink/Sinks/To Workspace',[model_name '/save_I1_' ph], ...
        'VariableName',['i1_' lower(ph) '_3sw_log'],'SaveFormat','Timeseries', ...
        'Position',[xb+490 330 xb+560 360]);
    add_block('simulink/Sinks/To Workspace',[model_name '/save_Ig_' ph], ...
        'VariableName',['ig_' lower(ph) '_3sw_log'],'SaveFormat','Timeseries', ...
        'Position',[xb+815 330 xb+885 360]);
    add_line(model_name,['I1_PS_' ph '/1'],['save_I1_' ph '/1'],'autorouting','on');
    add_line(model_name,['Ig_PS_' ph '/1'],['save_Ig_' ph '/1'],'autorouting','on');
    set_param([model_name '/Grid_sensor_' ph],'BackgroundColor',phase_colors{p});
end

% Dört telli nötr akımının ölçümsel toplamı
add_block('simulink/Math Operations/Sum',[model_name '/neutral_sum'], ...
    'Inputs','+++','Position',[2750 390 2780 490]);
add_block('simulink/Math Operations/Gain',[model_name '/neutral_sign'], ...
    'Gain','-1','Position',[2810 420 2860 460]);
add_block('simulink/Sinks/To Workspace',[model_name '/save_neutral'], ...
    'VariableName','i_neutral_3sw_log','SaveFormat','Timeseries', ...
    'Position',[2890 425 2970 455]);
for p=1:3
    ph=phase_names{p};
    add_line(model_name,['Ig_PS_' ph '/1'],sprintf('neutral_sum/%d',p),'autorouting','on');
end
add_line(model_name,'neutral_sum/1','neutral_sign/1','autorouting','on');
add_line(model_name,'neutral_sign/1','save_neutral/1','autorouting','on');
note=Simulink.Annotation(model_name, ...
    'JÜRİ KONTROLÜ: ortak DA bara, 12 IGBT, üç LCL, ortak nötr ve faz başına kapı doğrulaması');
note.Position=[1030 250];
save_system(model_name,model_file);close_system(model_name,0);
fprintf('Üç faz anahtarlamalı model oluşturuldu: %s\n',model_file);

function connect_node(model_name,block_name,port_group,port_index,node_label,pos)
    persistent n;if isempty(n),n=0;end;n=n+1;
    b=sprintf('node_%s_%03d',node_label,n);
    add_block('nesl_utility/Connection Label',[model_name '/' b], ...
        'Label',node_label,'Position',[pos(1) pos(2) pos(1)+24 pos(2)+18]);
    phb=get_param([model_name '/' block_name],'PortHandles');
    phl=get_param([model_name '/' b],'PortHandles');
    add_line(model_name,phb.(port_group)(port_index),phl.LConn(1),'autorouting','on');
end
