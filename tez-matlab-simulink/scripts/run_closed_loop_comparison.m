% Klasik, nötr susturmalı ve Sin^3 destekli kapalı çevrim karşılaştırması.

root_dir=fileparts(fileparts(mfilename('fullpath')));
run(fullfile(root_dir,'parameters','closed_loop_demo_parameters.m'));
Simulink.fileGenControl('set', ...
    'CacheFolder',fullfile(root_dir,'build','cache'), ...
    'CodeGenFolder',fullfile(root_dir,'build','codegen'),'createDir',true);
model_file=fullfile(root_dir,'models','t_type_q1q4_closed_loop_demo.slx');
result_dir=fullfile(root_dir,'results','closed_loop');
if ~exist(result_dir,'dir'),mkdir(result_dir);end
if ~exist(model_file,'file')
    run(fullfile(root_dir,'scripts','build_closed_loop_ttype_model.m'));
end
load_system(model_file);

scenario_names=["Klasik ideal";"Klasik + ölü zaman";"Nötr susturma";"Nötr susturma + Sin3"];
suppression=[0;0;1;1];
sin3_enable=[0;0;0;1];
dead_time=[1e-12;dead_time_cl;dead_time_cl;dead_time_cl];
outs=cell(4,1);
for k=1:4
    in=Simulink.SimulationInput('t_type_q1q4_closed_loop_demo');
    in=in.setVariable('neutral_suppression_enable',suppression(k));
    in=in.setVariable('sin3_enable_cl',sin3_enable(k));
    in=in.setVariable('dead_time_cl',dead_time(k));
    outs{k}=sim(in);
end

t_metric=(analysis_start_sw:1/50000:t_stop_sw).';
rmse=zeros(4,1); thd=zeros(4,1); irms=zeros(4,1); invalid=zeros(4,1);
for k=1:4
    ref=interp1(outs{k}.i_ref_cl_log.Time,outs{k}.i_ref_cl_log.Data,t_metric,'linear');
    ig=interp1(outs{k}.i_grid_sw_log.Time,outs{k}.i_grid_sw_log.Data,t_metric,'linear');
    rmse(k)=sqrt(mean((ref-ig).^2));
    irms(k)=sqrt(mean(ig.^2));
    thd(k)=harmonic_thd(ig,t_metric,f_grid_sw,39);
    gates=zeros(numel(t_metric),4);
    for q=1:4
        lq=outs{k}.(sprintf('q%d_log',q));
        gates(:,q)=round(interp1(lq.Time,double(lq.Data),t_metric,'previous'));
    end
    % P/O/N yanında yalnız ölü-zaman ve diyot-benzetimi geçiş durumları kabul edilir.
    allowed=[1 0 1 0;0 0 1 1;0 1 0 1;0 0 1 0;0 0 0 1;0 0 0 0];
    invalid(k)=nnz(~ismember(gates,allowed,'rows'));
    % Q1 ve Q2'nin birlikte iletimi DA bara kısa devresidir ve ayrıca yasaktır.
    invalid(k)=invalid(k)+nnz(gates(:,1)&gates(:,2));
end

metrics=table(scenario_names,irms,rmse,thd,invalid, ...
    'VariableNames',{'Yontem','Grid_RMS_A','Tracking_RMSE_A','THD_pct','Invalid_State_Count'});
writetable(metrics,fullfile(result_dir,'closed_loop_metrics.csv'));
disp(metrics);

tp=linspace(t_stop_sw-1/f_grid_sw,t_stop_sw,5000).';
fig=figure('Color','w','Position',[100 100 1200 850]);
tiledlayout(4,1,'TileSpacing','compact');
for k=1:4
    nexttile;
    ref=interp1(outs{k}.i_ref_cl_log.Time,outs{k}.i_ref_cl_log.Data,tp,'linear');
    ig=interp1(outs{k}.i_grid_sw_log.Time,outs{k}.i_grid_sw_log.Data,tp,'linear');
    plot(tp,ref,'k--','LineWidth',1.1); hold on;
    plot(tp,ig,'LineWidth',1.1); grid on;
    ylabel('Akım (A)');
    title(sprintf('%s: RMSE %.3f A, THD %.2f%%',scenario_names(k),rmse(k),thd(k)));
    legend('Referans','Şebeke akımı','Location','eastoutside');
end
xlabel('Zaman (s)');
exportgraphics(fig,fullfile(result_dir,'closed_loop_comparison.png'),'Resolution',200);
savefig(fig,fullfile(result_dir,'closed_loop_comparison.fig'));
close(fig);

if any(invalid~=0)
    error('Kapalı çevrim karşılaştırmasında geçersiz anahtarlama durumu oluştu.');
end
open_system('t_type_q1q4_closed_loop_demo');

function thd_pct=harmonic_thd(x,t,f0,max_h)
    x=x(:)-mean(x); amps=zeros(max_h,1);
    for h=1:max_h
        A=[sin(2*pi*h*f0*t),cos(2*pi*h*f0*t)];
        c=A\x; amps(h)=hypot(c(1),c(2));
    end
    thd_pct=100*sqrt(sum(amps(2:end).^2))/amps(1);
end
