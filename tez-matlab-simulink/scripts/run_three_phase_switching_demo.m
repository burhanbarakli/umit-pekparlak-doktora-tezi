% Ortak DA baralı 12 IGBT'li üç faz fiziksel modeli çalıştırır.

root_dir=fileparts(fileparts(mfilename('fullpath')));
run(fullfile(root_dir,'parameters','closed_loop_demo_parameters.m'));
Simulink.fileGenControl('set','CacheFolder',fullfile(root_dir,'build','cache'), ...
    'CodeGenFolder',fullfile(root_dir,'build','codegen'),'createDir',true);
model_file=fullfile(root_dir,'models','t_type_three_phase_q1q4_switching.slx');
result_dir=fullfile(root_dir,'results','three_phase_switching');
if ~exist(result_dir,'dir'),mkdir(result_dir);end
if ~exist(model_file,'file')
    run(fullfile(root_dir,'scripts','build_three_phase_switching_model.m'));
end
load_system(model_file);out=sim('t_type_three_phase_q1q4_switching');

tq=(0.04:1/50000:0.06).';phase_names={'a','b','c'};
rms_phase=zeros(3,1);thd_phase=zeros(3,1);invalid=zeros(3,1);
allowed=[1 0 1 0;0 0 1 1;0 1 0 1;0 0 1 0;0 0 0 1;0 0 0 0];
currents=zeros(numel(tq),3);
for p=1:3
    ph=phase_names{p};
    logi=out.(sprintf('ig_%s_3sw_log',ph));
    currents(:,p)=interp1(logi.Time,logi.Data,tq,'linear');
    rms_phase(p)=sqrt(mean(currents(:,p).^2));
    thd_phase(p)=harmonic_thd(currents(:,p),tq,f_grid_sw,39);
    gates=zeros(numel(tq),4);
    for q=1:4
        lg=out.(sprintf('%s_q%d_3sw_log',ph,q));
        gates(:,q)=round(interp1(lg.Time,double(lg.Data),tq,'previous'));
    end
    invalid(p)=nnz(~ismember(gates,allowed,'rows'))+nnz(gates(:,1)&gates(:,2));
end
neutral=interp1(out.i_neutral_3sw_log.Time,out.i_neutral_3sw_log.Data,tq,'linear');
neutral_rms=sqrt(mean(neutral.^2));
metrics=table(["A";"B";"C"],rms_phase,thd_phase,invalid, ...
    'VariableNames',{'Phase','Grid_RMS_A','THD_pct','Invalid_State_Count'});
writetable(metrics,fullfile(result_dir,'phase_metrics.csv'));
fid=fopen(fullfile(result_dir,'neutral_metric.txt'),'w');
fprintf(fid,'Neutral RMS current: %.9f A\n',neutral_rms);fclose(fid);
disp(metrics);fprintf('Nötr RMS: %.6f A\n',neutral_rms);
if any(invalid~=0),error('Üç faz modelde geçersiz kapı durumu oluştu.');end

tp=linspace(0.04,0.06,7000).';
ia=interp1(out.ig_a_3sw_log.Time,out.ig_a_3sw_log.Data,tp,'linear');
ib=interp1(out.ig_b_3sw_log.Time,out.ig_b_3sw_log.Data,tp,'linear');
ic=interp1(out.ig_c_3sw_log.Time,out.ig_c_3sw_log.Data,tp,'linear');
in0=interp1(out.i_neutral_3sw_log.Time,out.i_neutral_3sw_log.Data,tp,'linear');
fig=figure('Color','w','Position',[100 100 1150 750]);
tiledlayout(2,1,'TileSpacing','compact');
nexttile;plot(tp,[ia ib ic],'LineWidth',1.0);grid on;ylabel('Faz akımı (A)');
legend('i_a','i_b','i_c','Location','eastoutside');title('12 IGBT''li üç faz T-tipi fiziksel model');
nexttile;plot(tp,in0,'k','LineWidth',1.0);grid on;ylabel('Nötr akımı (A)');xlabel('Zaman (s)');
title(sprintf('Nötr RMS = %.4f A',neutral_rms));
exportgraphics(fig,fullfile(result_dir,'three_phase_switching_currents.png'),'Resolution',200);
savefig(fig,fullfile(result_dir,'three_phase_switching_currents.fig'));close(fig);
open_system('t_type_three_phase_q1q4_switching');

function thd_pct=harmonic_thd(x,t,f0,max_h)
    x=x(:)-mean(x);amps=zeros(max_h,1);
    for h=1:max_h
        A=[sin(2*pi*h*f0*t),cos(2*pi*h*f0*t)];c=A\x;amps(h)=hypot(c(1),c(2));
    end
    thd_pct=100*sqrt(sum(amps(2:end).^2))/amps(1);
end
