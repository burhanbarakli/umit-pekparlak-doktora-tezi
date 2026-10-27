% Fiziksel üç faz modelinde nötr susturma ve Sin^3 kazanç taraması.

root_dir=fileparts(fileparts(mfilename('fullpath')));
run(fullfile(root_dir,'parameters','closed_loop_demo_parameters.m'));
model_name='t_type_three_phase_q1q4_closed_loop';
model_file=fullfile(root_dir,'models',[model_name '.slx']);
if ~exist(model_file,'file')
    run(fullfile(root_dir,'scripts','build_three_phase_switching_closed_loop.m'));
end
load_system(model_file);
if ~exist('result_subdir','var'),result_subdir='three_phase_neutral_sin3';end
result_dir=fullfile(root_dir,'results',result_subdir);
if ~exist(result_dir,'dir'),mkdir(result_dir);end
set(groot,'defaultFigureColor','w','defaultAxesColor','w', ...
    'defaultAxesXColor','k','defaultAxesYColor','k','defaultTextColor','k');

if exist('gain_values_override','var')
    gain_values=gain_values_override;
else
    gain_values=[-12 -8 -4 0 4 8 12];
end
n_runs=1+numel(gain_values);
method=strings(n_runs,1);gain_col=zeros(n_runs,1);neutral=zeros(n_runs,1);
mean_rms=zeros(n_runs,1);mean_rmse=zeros(n_runs,1);mean_thd=zeros(n_runs,1);
max_thd=zeros(n_runs,1);invalid=zeros(n_runs,1);
best_neutral=inf;best_data=struct();

% İlk koşu klasik kapı dizisidir; sonraki koşularda susturma açıktır.
scenario_suppression=[0 ones(1,numel(gain_values))];
scenario_gain=[0 gain_values];
set_param(model_name,'FastRestart','on');
cleanup=onCleanup(@()local_close(model_name));
for k=1:n_runs
    in=Simulink.SimulationInput(model_name);
    in=in.setVariable('neutral_suppression_3ph',scenario_suppression(k));
    in=in.setVariable('Ksin3_3ph',scenario_gain(k));
    in=in.setModelParameter('StopTime','0.06');
    fprintf('Koşu %d/%d: suppression=%d, Ksin3=%g V\n', ...
        k,n_runs,scenario_suppression(k),scenario_gain(k));
    out=sim(in);
    [row,wave]=local_metrics(out,0.04,f_grid_sw);
    if k==1,method(k)="Klasik";
    elseif scenario_gain(k)==0,method(k)="Nötr susturma";
    else,method(k)="Nötr susturma + Sin3";end
    gain_col(k)=scenario_gain(k);neutral(k)=row.neutral_rms;
    mean_rms(k)=mean(row.rms);mean_rmse(k)=mean(row.rmse);
    mean_thd(k)=mean(row.thd);max_thd(k)=max(row.thd);invalid(k)=sum(row.invalid);
    fprintf('  Neutral RMS %.5f A, mean THD %.3f%%, invalid %d\n', ...
        neutral(k),mean_thd(k),invalid(k));
    if k>1 && neutral(k)<best_neutral
        best_neutral=neutral(k);best_data=wave;best_data.index=k;
    end
end
set_param(model_name,'FastRestart','off');

all_results=table(method,gain_col,neutral,mean_rms,mean_rmse,mean_thd,max_thd,invalid, ...
    'VariableNames',{'Method','Ksin3_V','Neutral_RMS_A','Mean_Phase_RMS_A', ...
    'Mean_RMSE_A','Mean_THD_pct','Max_THD_pct','Invalid_State_Count'});
writetable(all_results,fullfile(result_dir,'all_scenarios.csv'));
sweep=all_results(2:end,:);writetable(sweep,fullfile(result_dir,'sin3_gain_sweep.csv'));

idx_supp=find(scenario_suppression==1 & scenario_gain==0,1);
idx_best=best_data.index;
comparison=all_results([1 idx_supp idx_best],:);
comparison.Method=["Klasik";"Nötr susturma";"Nötr susturma + en iyi Sin3"];
writetable(comparison,fullfile(result_dir,'comparison.csv'));

fig=figure('Color','w','Position',[100 100 1250 760]);
tiledlayout(2,1,'TileSpacing','compact');
nexttile;yyaxis left;plot(gain_values,neutral(2:end),'-o','LineWidth',1.4);ylabel('Nötr RMS (A)');
yyaxis right;plot(gain_values,mean_thd(2:end),'-s','LineWidth',1.4);ylabel('Ortalama faz THD (%)');
grid on;xlabel('K_{sin3} (V)');title('Fiziksel model Sin^3 kazanç taraması');
nexttile;bar(categorical(comparison.Method),[comparison.Neutral_RMS_A comparison.Mean_THD_pct]);
grid on;ylabel('Sayısal değer');legend('Nötr RMS (A)','Ortalama THD (%)','Location','best');
title(sprintf('En düşük nötr RMS: K_{sin3}=%g V',gain_col(idx_best)));
exportgraphics(fig,fullfile(result_dir,'sin3_gain_sweep.png'),'Resolution',190);
savefig(fig,fullfile(result_dir,'sin3_gain_sweep.fig'));close(fig);

fig=figure('Color','w','Position',[100 100 1450 850]);
subplot(2,1,1);hold on;colors=lines(3);
for p=1:3
    plot(best_data.t{p},best_data.i{p},'Color',colors(p,:),'LineWidth',1.0);
    plot(best_data.t{p},best_data.r{p},'--','Color',colors(p,:),'LineWidth',0.8);
end
grid on;xlabel('Zaman (s)');ylabel('Faz akımı (A)');
title(sprintf('Nötr susturma + Sin^3, K_{sin3}=%g V',gain_col(idx_best)));
legend('i_a','i_a^*','i_b','i_b^*','i_c','i_c^*','Location','eastoutside');
subplot(2,1,2);plot(best_data.tn,best_data.in,'k','LineWidth',1.0);grid on;
xlabel('Zaman (s)');ylabel('Nötr akımı (A)');
title(sprintf('Nötr RMS = %.4f A',neutral(idx_best)));
exportgraphics(fig,fullfile(result_dir,'best_waveforms.png'),'Resolution',190);
savefig(fig,fullfile(result_dir,'best_waveforms.fig'));close(fig);

disp(comparison);
assert(all(invalid==0),'En az bir koşuda geçersiz kapı durumu bulundu.');

function [row,wave]=local_metrics(out,t0,f0)
    ilogs={'ig_a_3sw_log','ig_b_3sw_log','ig_c_3sw_log'};
    rlogs={'i_ref_a_3cl_log','i_ref_b_3cl_log','i_ref_c_3cl_log'};
    prefixes={'a','b','c'};row.rms=zeros(1,3);row.rmse=zeros(1,3);
    row.thd=zeros(1,3);row.invalid=zeros(1,3);wave.t=cell(1,3);wave.i=cell(1,3);wave.r=cell(1,3);
    for p=1:3
        its=out.get(ilogs{p});rts=out.get(rlogs{p});mask=its.Time>=t0;
        t=its.Time(mask);i=its.Data(mask);r=interp1(rts.Time,rts.Data,t,'linear','extrap');
        row.rms(p)=sqrt(mean(i.^2));row.rmse(p)=sqrt(mean((i-r).^2));
        row.thd(p)=local_thd(t,i,f0);wave.t{p}=t;wave.i{p}=i;wave.r{p}=r;
        q=zeros(numel(out.get([prefixes{p} '_q1_3sw_log']).Data),4);
        for n=1:4,q(:,n)=round(out.get(sprintf('%s_q%d_3sw_log',prefixes{p},n)).Data(:));end
        allowed=ismember(q,[1 0 1 0;0 0 1 1;0 1 0 1;0 0 1 0;0 0 0 1;0 0 0 0],'rows');
        row.invalid(p)=sum(~allowed | (q(:,1)==1 & q(:,2)==1));
    end
    nts=out.get('i_neutral_3sw_log');nm=nts.Time>=t0;
    wave.tn=nts.Time(nm);wave.in=nts.Data(nm);row.neutral_rms=sqrt(mean(wave.in.^2));
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
