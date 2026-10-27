% Q1-Q4 anahtarlamalı T-tipi faz kolunu çalıştırır ve durumları doğrular.

root_dir = fileparts(fileparts(mfilename('fullpath')));
run(fullfile(root_dir,'parameters','switching_demo_parameters.m'));
Simulink.fileGenControl('set', ...
    'CacheFolder',fullfile(root_dir,'build','cache'), ...
    'CodeGenFolder',fullfile(root_dir,'build','codegen'),'createDir',true);
model_file = fullfile(root_dir,'models','t_type_q1q4_switching_demo.slx');
result_dir = fullfile(root_dir,'results','switching');
if ~exist(result_dir,'dir'), mkdir(result_dir); end
if ~exist(model_file,'file')
    run(fullfile(root_dir,'scripts','build_switching_ttype_model.m'));
end
load_system(model_file);
out = sim('t_type_q1q4_switching_demo');

% Ortak zaman ekseninde kapı durumlarını denetle
tq = (analysis_start_sw:max_step_sw:t_stop_sw).';
q1 = interp1(out.q1_log.Time,double(out.q1_log.Data),tq,'previous');
q2 = interp1(out.q2_log.Time,double(out.q2_log.Data),tq,'previous');
q3 = interp1(out.q3_log.Time,double(out.q3_log.Data),tq,'previous');
q4 = interp1(out.q4_log.Time,double(out.q4_log.Data),tq,'previous');
states = round([q1 q2 q3 q4]);
unique_states = unique(states,'rows');
allowed = [1 0 1 0; 0 0 1 1; 0 1 0 1];
invalid = ~ismember(states,allowed,'rows');
invalid_count = nnz(invalid);

state_names = strings(size(unique_states,1),1);
for k=1:size(unique_states,1)
    if isequal(unique_states(k,:),allowed(1,:)), state_names(k)="P";
    elseif isequal(unique_states(k,:),allowed(2,:)), state_names(k)="O";
    elseif isequal(unique_states(k,:),allowed(3,:)), state_names(k)="N";
    else, state_names(k)="GEÇERSİZ";
    end
end
state_table = array2table([unique_states], ...
    'VariableNames',{'Q1','Q2','Q3','Q4'});
state_table.Durum = state_names;
writetable(state_table,fullfile(result_dir,'observed_switching_states.csv'));

% Son temel periyodu çiz
t0 = t_stop_sw-1/f_grid_sw;
tp = linspace(t0,t_stop_sw,6000).';
mod_ref = interp1(out.mod_ref_log.Time,out.mod_ref_log.Data,tp,'linear');
carrier = interp1(out.carrier_log.Time,out.carrier_log.Data,tp,'linear');
vpole = interp1(out.v_pole_sw_log.Time,out.v_pole_sw_log.Data,tp,'linear');
igrid = interp1(out.i_grid_sw_log.Time,out.i_grid_sw_log.Data,tp,'linear');
il1 = interp1(out.i_l1_sw_log.Time,out.i_l1_sw_log.Data,tp,'linear');
gates = zeros(numel(tp),4);
for q=1:4
    logq = out.(sprintf('q%d_log',q));
    gates(:,q) = interp1(logq.Time,double(logq.Data),tp,'previous');
end

fig=figure('Color','w','Position',[100 100 1200 850]);
tiledlayout(4,1,'TileSpacing','compact');
nexttile; plot(tp,abs(mod_ref),'b','LineWidth',1.1); hold on; plot(tp,carrier,'k');
grid on; ylabel('Görev'); legend('|m sin(\theta)|','Taşıyıcı','Location','eastoutside');
title('Q1-Q4 anahtarlamalı T-tipi tek faz kolu');
nexttile; stairs(tp,gates,'LineWidth',1.0); grid on; ylim([-0.2 1.2]);
ylabel('Kapı'); legend('Q1','Q2','Q3','Q4','Location','eastoutside');
nexttile; plot(tp,vpole,'Color',[0.55 0.1 0.65]); grid on;
ylabel('v_{xN} (V)');
nexttile; plot(tp,il1,'Color',[0.85 0.25 0.15],'LineWidth',0.8); hold on;
plot(tp,igrid,'Color',[0.1 0.5 0.25],'LineWidth',1.1); grid on;
ylabel('Akım (A)'); xlabel('Zaman (s)');
legend('i_{L1}','i_g','Location','eastoutside');
exportgraphics(fig,fullfile(result_dir,'switching_waveforms.png'),'Resolution',200);
savefig(fig,fullfile(result_dir,'switching_waveforms.fig'));
close(fig);

fid=fopen(fullfile(result_dir,'validation.txt'),'w');
fprintf(fid,'Geçersiz anahtarlama örneği: %d\n',invalid_count);
fprintf(fid,'Gözlenen benzersiz durum sayısı: %d\n',size(unique_states,1));
fprintf(fid,'Beklenen durumlar: P=1010, O=0011, N=0101\n');
fclose(fid);

% Şebeke akımının ilk çalışma metriği (tez sonucu değildir)
t_metric = (analysis_start_sw:1/50000:t_stop_sw).';
i_metric = interp1(out.i_grid_sw_log.Time,out.i_grid_sw_log.Data,t_metric,'linear');
grid_rms = sqrt(mean(i_metric.^2));
grid_thd = harmonic_thd(i_metric,t_metric,f_grid_sw,39);
metric_table = table(grid_rms,grid_thd, ...
    'VariableNames',{'Grid_Current_RMS_A','Grid_Current_THD_pct'});
writetable(metric_table,fullfile(result_dir,'switching_metrics.csv'));

disp(state_table);
fprintf('Geçersiz durum sayısı: %d\n',invalid_count);
if invalid_count ~= 0
    error('İzin verilmeyen Q1-Q4 anahtarlama durumu gözlendi.');
end
open_system('t_type_q1q4_switching_demo');

function thd_pct = harmonic_thd(x,t,f0,max_h)
    x=x(:)-mean(x);
    amps=zeros(max_h,1);
    for h=1:max_h
        A=[sin(2*pi*h*f0*t),cos(2*pi*h*f0*t)];
        c=A\x;
        amps(h)=hypot(c(1),c(2));
    end
    thd_pct=100*sqrt(sum(amps(2:end).^2))/amps(1);
end
