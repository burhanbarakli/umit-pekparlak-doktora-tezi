% Ölçülen nötr akımına dayalı 150 Hz geri besleme kazancını tarar.

root_dir=fileparts(fileparts(mfilename('fullpath')));
run(fullfile(root_dir,'parameters','closed_loop_demo_parameters.m'));
model_name='t_type_three_phase_zero_sequence_feedback';
model_file=fullfile(root_dir,'models',[model_name '.slx']);
if ~exist(model_file,'file'),run(fullfile(root_dir,'scripts','build_zero_sequence_feedback_model.m'));end
load_system(model_file);
if ~exist('result_subdir','var'),result_subdir='zero_sequence_feedback';end
out_dir=fullfile(root_dir,'results',result_subdir);
if ~exist(out_dir,'dir'),mkdir(out_dir);end

if exist('gain_values_override','var'),gains=gain_values_override;else,gains=[-40 -20 -10 -5 0 5 10 20 40];end
n=1+numel(gains);
Method=strings(n,1);Kzero3_V_per_A=zeros(n,1);Neutral_RMS_A=zeros(n,1);
Mean_THD_pct=zeros(n,1);Mean_RMSE_A=zeros(n,1);Max_Vzero_V=zeros(n,1);Invalid_State_Count=zeros(n,1);
best=inf;best_wave=struct();
supp=[0 ones(1,numel(gains))];kg=[0 gains];
set_param(model_name,'FastRestart','on');cleanup=onCleanup(@()local_close(model_name));
for k=1:n
    in=Simulink.SimulationInput(model_name);
    in=in.setVariable('neutral_suppression_3ph',supp(k));in=in.setVariable('Kzero3_cl',kg(k));
    in=in.setModelParameter('StopTime','0.06');
    fprintf('Sıfır-dizi koşusu %d/%d: suppression=%d, Kzero3=%g V/A\n',k,n,supp(k),kg(k));
    out=sim(in);[row,wave]=local_metrics(out,0.04,f_grid_sw);
    if k==1,Method(k)="Klasik";elseif kg(k)==0,Method(k)="Nötr susturma";else,Method(k)="Nötr susturma + 150Hz geri besleme";end
    Kzero3_V_per_A(k)=kg(k);Neutral_RMS_A(k)=row.neutral;Mean_THD_pct(k)=mean(row.thd);
    Mean_RMSE_A(k)=mean(row.rmse);Max_Vzero_V(k)=row.max_vzero;Invalid_State_Count(k)=sum(row.invalid);
    fprintf('  neutral %.5f A, THD %.3f%%, Vzero %.3f V, invalid %d\n', ...
        Neutral_RMS_A(k),Mean_THD_pct(k),Max_Vzero_V(k),Invalid_State_Count(k));
    if k>1 && row.neutral<best,best=row.neutral;best_wave=wave;best_wave.index=k;end
end
set_param(model_name,'FastRestart','off');
all_results=table(Method,Kzero3_V_per_A,Neutral_RMS_A,Mean_THD_pct,Mean_RMSE_A,Max_Vzero_V,Invalid_State_Count);
writetable(all_results,fullfile(out_dir,'gain_sweep.csv'));
idx_supp=find(supp==1 & kg==0,1);idx_best=best_wave.index;
comparison=all_results([1 idx_supp idx_best],:);comparison.Method=["Klasik";"Nötr susturma";"En iyi 150Hz geri besleme"];
writetable(comparison,fullfile(out_dir,'comparison.csv'));

fig=figure('Color','w','Position',[100 100 1250 650]);yyaxis left;
plot(gains,Neutral_RMS_A(2:end),'-o','LineWidth',1.5);ylabel('Nötr RMS (A)');
yyaxis right;plot(gains,Mean_THD_pct(2:end),'-s','LineWidth',1.5);ylabel('Ortalama faz THD (%)');
grid on;xlabel('K_{zero3} (V/A)');title('Ölçülen 150 Hz nötr akımı geri besleme taraması');
exportgraphics(fig,fullfile(out_dir,'gain_sweep.png'),'Resolution',190);savefig(fig,fullfile(out_dir,'gain_sweep.fig'));close(fig);

fig=figure('Color','w','Position',[100 100 1450 820]);
subplot(2,1,1);hold on;colors=lines(3);
for p=1:3,plot(best_wave.t{p},best_wave.i{p},'Color',colors(p,:));plot(best_wave.t{p},best_wave.r{p},'--','Color',colors(p,:));end
grid on;ylabel('Faz akımı (A)');title(sprintf('En iyi geri besleme, K_{zero3}=%g V/A',kg(idx_best)));
subplot(2,1,2);plot(best_wave.tn,best_wave.in,'k');grid on;xlabel('Zaman (s)');ylabel('Nötr akımı (A)');
title(sprintf('Nötr RMS %.4f A',Neutral_RMS_A(idx_best)));
exportgraphics(fig,fullfile(out_dir,'best_waveforms.png'),'Resolution',190);savefig(fig,fullfile(out_dir,'best_waveforms.fig'));close(fig);
disp(comparison);assert(all(Invalid_State_Count==0),'Geçersiz kapı durumu bulundu.');

function [row,wave]=local_metrics(out,t0,f0)
    il={'ig_a_3sw_log','ig_b_3sw_log','ig_c_3sw_log'};rl={'i_ref_a_3cl_log','i_ref_b_3cl_log','i_ref_c_3cl_log'};
    pf={'a','b','c'};row.thd=zeros(1,3);row.rmse=zeros(1,3);row.invalid=zeros(1,3);wave.t=cell(1,3);wave.i=cell(1,3);wave.r=cell(1,3);
    for p=1:3
        its=out.get(il{p});rts=out.get(rl{p});m=its.Time>=t0;t=its.Time(m);i=its.Data(m);r=interp1(rts.Time,rts.Data,t);
        row.thd(p)=local_thd(t,i,f0);row.rmse(p)=sqrt(mean((i-r).^2));wave.t{p}=t;wave.i{p}=i;wave.r{p}=r;
        q=zeros(numel(out.get([pf{p} '_q1_3sw_log']).Data),4);for z=1:4,q(:,z)=round(out.get(sprintf('%s_q%d_3sw_log',pf{p},z)).Data(:));end
        ok=ismember(q,[1 0 1 0;0 0 1 1;0 1 0 1;0 0 1 0;0 0 0 1;0 0 0 0],'rows');row.invalid(p)=sum(~ok|(q(:,1)&q(:,2)));
    end
    nts=out.get('i_neutral_3sw_log');m=nts.Time>=t0;wave.tn=nts.Time(m);wave.in=nts.Data(m);row.neutral=sqrt(mean(wave.in.^2));
    vz=out.get('vzero_3cl_log');mv=vz.Time>=t0;row.max_vzero=max(abs(vz.Data(mv)));
end
function v=local_thd(t,x,f0)
    t=t(:);x=x(:)-mean(x);a=zeros(19,1);for h=1:19,A=[sin(2*pi*h*f0*t),cos(2*pi*h*f0*t)];c=A\x;a(h)=hypot(c(1),c(2));end
    v=100*sqrt(sum(a(2:end).^2))/max(a(1),eps);
end
function local_close(m)
    if bdIsLoaded(m),try,set_param(m,'FastRestart','off');catch,end;close_system(m,0);end
end
