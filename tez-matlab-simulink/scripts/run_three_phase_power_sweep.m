% DÜŞÜK/ORTA/ANMA (DENEME) akımlarında üç yöntemi otomatik koşturur.

root_dir=fileparts(fileparts(mfilename('fullpath')));
run(fullfile(root_dir,'parameters','closed_loop_demo_parameters.m'));
model_name='t_type_three_phase_q1q4_closed_loop';
model_file=fullfile(root_dir,'models',[model_name '.slx']);
if ~exist(model_file,'file'),run(fullfile(root_dir,'scripts','build_three_phase_switching_closed_loop.m'));end
load_system(model_file);
out_dir=fullfile(root_dir,'results','three_phase_power_sweep');
if ~exist(out_dir,'dir'),mkdir(out_dir);end

level_name=["Dusuk" "Orta" "Anma_DENEME"];
current_rms=[0.75 1.50 2.30];
method_name=["Klasik" "Notr_susturma" "Notr_susturma_Sin3"];
suppression=[0 1 1];sin3_gain=[0 0 -2];
n=numel(current_rms)*numel(method_name);k=0;
Level=strings(n,1);Method=strings(n,1);Iref_RMS_A=zeros(n,1);Approx_Power_W=zeros(n,1);
Mean_Phase_RMS_A=zeros(n,1);Mean_RMSE_A=zeros(n,1);Mean_THD_pct=zeros(n,1);
Neutral_RMS_A=zeros(n,1);Invalid_State_Count=zeros(n,1);

set_param(model_name,'FastRestart','on');cleanup=onCleanup(@()local_close(model_name));
for l=1:numel(current_rms)
    for m=1:numel(method_name)
        k=k+1;
        in=Simulink.SimulationInput(model_name);
        in=in.setVariable('I_ref_pk_cl',sqrt(2)*current_rms(l));
        in=in.setVariable('neutral_suppression_3ph',suppression(m));
        in=in.setVariable('Ksin3_3ph',sin3_gain(m));
        in=in.setModelParameter('StopTime','0.06');
        fprintf('Güç koşusu %d/%d: %s, %s, %.2f A RMS\n', ...
            k,n,level_name(l),method_name(m),current_rms(l));
        sim_out=sim(in);
        row=local_metrics(sim_out,0.04,f_grid_sw);
        Level(k)=level_name(l);Method(k)=method_name(m);Iref_RMS_A(k)=current_rms(l);
        Approx_Power_W(k)=3*V_grid_rms_sw*current_rms(l);
        Mean_Phase_RMS_A(k)=mean(row.rms);Mean_RMSE_A(k)=mean(row.rmse);
        Mean_THD_pct(k)=mean(row.thd);Neutral_RMS_A(k)=row.neutral;
        Invalid_State_Count(k)=sum(row.invalid);
        fprintf('  THD %.3f%%, neutral %.5f A, RMSE %.4f A, invalid %d\n', ...
            Mean_THD_pct(k),Neutral_RMS_A(k),Mean_RMSE_A(k),Invalid_State_Count(k));
    end
end
set_param(model_name,'FastRestart','off');
results=table(Level,Method,Iref_RMS_A,Approx_Power_W,Mean_Phase_RMS_A, ...
    Mean_RMSE_A,Mean_THD_pct,Neutral_RMS_A,Invalid_State_Count);
writetable(results,fullfile(out_dir,'power_sweep_metrics.csv'));

fig=figure('Color','w','Position',[100 100 1450 760]);
tiledlayout(1,2,'TileSpacing','compact');
nexttile;hold on;nexttile;hold on;
colors=lines(3);
for m=1:3
    ix=results.Method==method_name(m);
    nexttile(1);plot(results.Iref_RMS_A(ix),results.Mean_THD_pct(ix),'-o', ...
        'LineWidth',1.5,'Color',colors(m,:),'DisplayName',strrep(method_name(m),'_',' '));
    nexttile(2);plot(results.Iref_RMS_A(ix),results.Neutral_RMS_A(ix),'-o', ...
        'LineWidth',1.5,'Color',colors(m,:),'DisplayName',strrep(method_name(m),'_',' '));
end
nexttile(1);grid on;xlabel('Akım referansı (A RMS)');ylabel('Ortalama faz THD (%)');
title('Güç seviyesine göre THD');legend('Location','best');
nexttile(2);grid on;xlabel('Akım referansı (A RMS)');ylabel('Nötr RMS (A)');
title('Güç seviyesine göre nötr akımı');legend('Location','best');
sgtitle('Fiziksel üç faz güç taraması - DENEME seviyeleri');
exportgraphics(fig,fullfile(out_dir,'power_sweep.png'),'Resolution',190);
savefig(fig,fullfile(out_dir,'power_sweep.fig'));close(fig);
disp(results);assert(all(Invalid_State_Count==0),'Güç taramasında geçersiz kapı durumu bulundu.');

function row=local_metrics(out,t0,f0)
    ilogs={'ig_a_3sw_log','ig_b_3sw_log','ig_c_3sw_log'};
    rlogs={'i_ref_a_3cl_log','i_ref_b_3cl_log','i_ref_c_3cl_log'};
    prefixes={'a','b','c'};row.rms=zeros(1,3);row.rmse=zeros(1,3);
    row.thd=zeros(1,3);row.invalid=zeros(1,3);
    for p=1:3
        its=out.get(ilogs{p});rts=out.get(rlogs{p});mask=its.Time>=t0;
        t=its.Time(mask);i=its.Data(mask);r=interp1(rts.Time,rts.Data,t,'linear','extrap');
        row.rms(p)=sqrt(mean(i.^2));row.rmse(p)=sqrt(mean((i-r).^2));row.thd(p)=local_thd(t,i,f0);
        q=zeros(numel(out.get([prefixes{p} '_q1_3sw_log']).Data),4);
        for z=1:4,q(:,z)=round(out.get(sprintf('%s_q%d_3sw_log',prefixes{p},z)).Data(:));end
        allowed=ismember(q,[1 0 1 0;0 0 1 1;0 1 0 1;0 0 1 0;0 0 0 1;0 0 0 0],'rows');
        row.invalid(p)=sum(~allowed | (q(:,1)==1 & q(:,2)==1));
    end
    nts=out.get('i_neutral_3sw_log');nm=nts.Time>=t0;row.neutral=sqrt(mean(nts.Data(nm).^2));
end
function value=local_thd(t,x,f0)
    t=t(:);x=x(:)-mean(x);amps=zeros(19,1);
    for h=1:19,A=[sin(2*pi*h*f0*t),cos(2*pi*h*f0*t)];c=A\x;amps(h)=hypot(c(1),c(2));end
    value=100*sqrt(sum(amps(2:end).^2))/max(amps(1),eps);
end
function local_close(model_name)
    if bdIsLoaded(model_name)
        try,set_param(model_name,'FastRestart','off');catch,end
        close_system(model_name,0);
    end
end
