% Geçici modelde Sin^3 kazancının işaret ve büyüklük taraması.

root_dir=fileparts(fileparts(mfilename('fullpath')));
run(fullfile(root_dir,'parameters','closed_loop_demo_parameters.m'));
Simulink.fileGenControl('set', ...
    'CacheFolder',fullfile(root_dir,'build','cache'), ...
    'CodeGenFolder',fullfile(root_dir,'build','codegen'),'createDir',true);
load_system(fullfile(root_dir,'models','t_type_q1q4_closed_loop_demo.slx'));
result_dir=fullfile(root_dir,'results','closed_loop');
if ~exist(result_dir,'dir'),mkdir(result_dir);end

gain_candidates=[-8 -6 -4 -2 0 2 4 6 8];
thd=zeros(numel(gain_candidates),1);
rmse=zeros(numel(gain_candidates),1);
t_metric=(analysis_start_sw:1/50000:t_stop_sw).';
for k=1:numel(gain_candidates)
    in=Simulink.SimulationInput('t_type_q1q4_closed_loop_demo');
    in=in.setVariable('neutral_suppression_enable',1);
    in=in.setVariable('sin3_enable_cl',1);
    in=in.setVariable('Ksin3_cl',gain_candidates(k));
    in=in.setVariable('dead_time_cl',2e-6);
    out=sim(in);
    ref=interp1(out.i_ref_cl_log.Time,out.i_ref_cl_log.Data,t_metric,'linear');
    ig=interp1(out.i_grid_sw_log.Time,out.i_grid_sw_log.Data,t_metric,'linear');
    rmse(k)=sqrt(mean((ref-ig).^2));
    thd(k)=harmonic_thd(ig,t_metric,f_grid_sw,39);
end
tuning=table(gain_candidates(:),rmse,thd, ...
    'VariableNames',{'Ksin3_V','Tracking_RMSE_A','THD_pct'});
writetable(tuning,fullfile(result_dir,'sin3_gain_sweep.csv'));
disp(tuning);
[~,best_idx]=min(thd);
fprintf('En düşük THD kazancı: Ksin3=%.3f V, THD=%.3f%%\n', ...
    gain_candidates(best_idx),thd(best_idx));

fig=figure('Color','w');
yyaxis left; plot(gain_candidates,thd,'o-','LineWidth',1.2); ylabel('THD (%)');
yyaxis right; plot(gain_candidates,rmse,'s-','LineWidth',1.2); ylabel('RMSE (A)');
grid on; xlabel('K_{sin^3} (V)'); title('Geçici Sin^3 kazanç taraması');
exportgraphics(fig,fullfile(result_dir,'sin3_gain_sweep.png'),'Resolution',200);
close(fig);

function thd_pct=harmonic_thd(x,t,f0,max_h)
    x=x(:)-mean(x); amps=zeros(max_h,1);
    for h=1:max_h
        A=[sin(2*pi*h*f0*t),cos(2*pi*h*f0*t)];
        c=A\x; amps(h)=hypot(c(1),c(2));
    end
    thd_pct=100*sqrt(sum(amps(2:end).^2))/amps(1);
end
