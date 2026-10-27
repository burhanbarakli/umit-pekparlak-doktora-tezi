% Üç faz dört telli ortalama modelde klasik, bozucu ve Sin^3 karşılaştırması.

root_dir=fileparts(fileparts(mfilename('fullpath')));
run(fullfile(root_dir,'parameters','three_phase_demo_parameters.m'));
Simulink.fileGenControl('set','CacheFolder',fullfile(root_dir,'build','cache'), ...
    'CodeGenFolder',fullfile(root_dir,'build','codegen'),'createDir',true);
model_file=fullfile(root_dir,'models','t_type_three_phase_four_wire_average.slx');
result_dir=fullfile(root_dir,'results','three_phase');
if ~exist(result_dir,'dir'),mkdir(result_dir);end
if ~exist(model_file,'file')
    run(fullfile(root_dir,'scripts','build_three_phase_average_model.m'));
end
load_system(model_file);

names=["Klasik";"Nötr susturma eşdeğeri";"Nötr susturma + Sin3"];
dist_enable=[0;1;1]; comp_enable=[0;0;1];
outs=cell(3,1);
for k=1:3
    in=Simulink.SimulationInput('t_type_three_phase_four_wire_average');
    in=in.setVariable('suppression_effect_enable_3ph',dist_enable(k));
    in=in.setVariable('sin3_enable_3ph',comp_enable(k));
    outs{k}=sim(in);
end

tq=(analysis_start_3ph:1/50000:t_stop_3ph).';
thd_a=zeros(3,1); thd_b=zeros(3,1); thd_c=zeros(3,1);
neutral_rms=zeros(3,1); tracking_rmse=zeros(3,1);
for k=1:3
    ia=interp1(outs{k}.i_a_3ph_log.Time,outs{k}.i_a_3ph_log.Data,tq,'linear');
    ib=interp1(outs{k}.i_b_3ph_log.Time,outs{k}.i_b_3ph_log.Data,tq,'linear');
    ic=interp1(outs{k}.i_c_3ph_log.Time,outs{k}.i_c_3ph_log.Data,tq,'linear');
    ra=interp1(outs{k}.ref_a_3ph_log.Time,outs{k}.ref_a_3ph_log.Data,tq,'linear');
    rb=interp1(outs{k}.ref_b_3ph_log.Time,outs{k}.ref_b_3ph_log.Data,tq,'linear');
    rc=interp1(outs{k}.ref_c_3ph_log.Time,outs{k}.ref_c_3ph_log.Data,tq,'linear');
    in0=interp1(outs{k}.i_neutral_3ph_log.Time,outs{k}.i_neutral_3ph_log.Data,tq,'linear');
    thd_a(k)=harmonic_thd(ia,tq,f_grid_sw,39);
    thd_b(k)=harmonic_thd(ib,tq,f_grid_sw,39);
    thd_c(k)=harmonic_thd(ic,tq,f_grid_sw,39);
    neutral_rms(k)=sqrt(mean(in0.^2));
    tracking_rmse(k)=sqrt(mean(([ia;ib;ic]-[ra;rb;rc]).^2));
end
metrics=table(names,thd_a,thd_b,thd_c,neutral_rms,tracking_rmse, ...
    'VariableNames',{'Yontem','THD_A_pct','THD_B_pct','THD_C_pct', ...
    'Neutral_RMS_A','ThreePhase_Tracking_RMSE_A'});
writetable(metrics,fullfile(result_dir,'three_phase_metrics.csv'));
disp(metrics);

tp=linspace(t_stop_3ph-1/f_grid_sw,t_stop_3ph,4000).';
fig=figure('Color','w','Position',[100 100 1200 900]);
tiledlayout(3,2,'TileSpacing','compact');
for k=1:3
    ia=interp1(outs{k}.i_a_3ph_log.Time,outs{k}.i_a_3ph_log.Data,tp,'linear');
    ib=interp1(outs{k}.i_b_3ph_log.Time,outs{k}.i_b_3ph_log.Data,tp,'linear');
    ic=interp1(outs{k}.i_c_3ph_log.Time,outs{k}.i_c_3ph_log.Data,tp,'linear');
    in0=interp1(outs{k}.i_neutral_3ph_log.Time,outs{k}.i_neutral_3ph_log.Data,tp,'linear');
    nexttile; plot(tp,[ia ib ic],'LineWidth',1.0); grid on;
    ylabel('Faz akımı (A)'); title(names(k));
    if k==1,legend('i_a','i_b','i_c','Location','eastoutside');end
    nexttile; plot(tp,in0,'k','LineWidth',1.1); grid on;
    ylabel('Nötr akımı (A)'); title(sprintf('I_n RMS = %.3f A',neutral_rms(k)));
end
xlabel('Zaman (s)');
exportgraphics(fig,fullfile(result_dir,'three_phase_comparison.png'),'Resolution',200);
savefig(fig,fullfile(result_dir,'three_phase_comparison.fig')); close(fig);
open_system('t_type_three_phase_four_wire_average');

function thd_pct=harmonic_thd(x,t,f0,max_h)
    x=x(:)-mean(x);amps=zeros(max_h,1);
    for h=1:max_h
        A=[sin(2*pi*h*f0*t),cos(2*pi*h*f0*t)];c=A\x;
        amps(h)=hypot(c(1),c(2));
    end
    thd_pct=100*sqrt(sum(amps(2:end).^2))/amps(1);
end
