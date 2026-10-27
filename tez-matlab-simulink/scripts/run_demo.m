% Kompanzasyonsuz ve Sin^3 kompanzasyonlu denemeyi çalıştırır.

root_dir = fileparts(fileparts(mfilename('fullpath')));
run(fullfile(root_dir,'parameters','thesis_demo_parameters.m'));
model_file = fullfile(root_dir,'models','t_type_lcl_sin3_demo.slx');
result_dir = fullfile(root_dir,'results');
if ~exist(result_dir,'dir'), mkdir(result_dir); end
cache_dir = fullfile(root_dir,'build','cache');
codegen_dir = fullfile(root_dir,'build','codegen');
Simulink.fileGenControl('set','CacheFolder',cache_dir, ...
    'CodeGenFolder',codegen_dir,'createDir',true);

if ~exist(model_file,'file')
    run(fullfile(root_dir,'scripts','build_demo_model.m'));
end
load_system(model_file);

in0 = Simulink.SimulationInput('t_type_lcl_sin3_demo');
in0 = in0.setVariable('sin3_enable',0);
out0 = sim(in0);

in1 = Simulink.SimulationInput('t_type_lcl_sin3_demo');
in1 = in1.setVariable('sin3_enable',1);
out1 = sim(in1);

tq = (analysis_start:1/analysis_fs:t_stop).';
ref0 = interp1(out0.i_ref_log.Time,out0.i_ref_log.Data,tq,'linear');
i0 = interp1(out0.i_grid_log.Time,out0.i_grid_log.Data,tq,'linear');
i1 = interp1(out1.i_grid_log.Time,out1.i_grid_log.Data,tq,'linear');

rmse0 = sqrt(mean((ref0-i0).^2));
rmse1 = sqrt(mean((ref0-i1).^2));
thd0 = local_harmonic_thd(i0,tq,f_grid,20);
thd1 = local_harmonic_thd(i1,tq,f_grid,20);

metrics = table(["Sin3 kapalı";"Sin3 açık"],[rmse0;rmse1],[thd0;thd1], ...
    'VariableNames',{'Yontem','Akım_RMSE_A','THD_yuzde'});
writetable(metrics,fullfile(result_dir,'metrics.csv'));
disp(metrics);

fig = figure('Color','w','Position',[100 100 1100 700]);
tiledlayout(2,1,'TileSpacing','compact');
nexttile;
plot(tq,ref0,'k--','LineWidth',1.2); hold on;
plot(tq,i0,'Color',[0.85 0.2 0.15],'LineWidth',1.0);
grid on; ylabel('Akım (A)');
title(sprintf('Sin^3 kapalı: RMSE %.3f A, THD %.2f%%',rmse0,thd0));
legend('Referans','Şebeke akımı','Location','best');
nexttile;
plot(tq,ref0,'k--','LineWidth',1.2); hold on;
plot(tq,i1,'Color',[0.1 0.55 0.25],'LineWidth',1.0);
grid on; ylabel('Akım (A)'); xlabel('Zaman (s)');
title(sprintf('Sin^3 açık: RMSE %.3f A, THD %.2f%%',rmse1,thd1));
legend('Referans','Şebeke akımı','Location','best');
exportgraphics(fig,fullfile(result_dir,'comparison.png'),'Resolution',200);
savefig(fig,fullfile(result_dir,'comparison.fig'));
close(fig);

open_system('t_type_lcl_sin3_demo');
fprintf('Sonuçlar: %s\n',result_dir);

function thd_pct = local_harmonic_thd(x,t,f0,max_h)
    x = x(:)-mean(x);
    amps = zeros(max_h,1);
    for h = 1:max_h
        A = [sin(2*pi*h*f0*t), cos(2*pi*h*f0*t)];
        c = A\x;
        amps(h) = hypot(c(1),c(2));
    end
    thd_pct = 100*sqrt(sum(amps(2:end).^2))/amps(1);
end
