% Fiziksel üç faz kapalı çevrim modelini koşturur ve doğrular.

root_dir=fileparts(fileparts(mfilename('fullpath')));
run(fullfile(root_dir,'parameters','closed_loop_demo_parameters.m'));
model_name='t_type_three_phase_q1q4_closed_loop';
model_file=fullfile(root_dir,'models',[model_name '.slx']);
if ~exist(model_file,'file')
    run(fullfile(root_dir,'scripts','build_three_phase_switching_closed_loop.m'));
end
load_system(model_file);
sim_out=sim(model_name,'StopTime','0.08','ReturnWorkspaceOutputs','on');

phase_names={'A','B','C'};
phase_logs={'ig_a_3sw_log','ig_b_3sw_log','ig_c_3sw_log'};
ref_logs={'i_ref_a_3cl_log','i_ref_b_3cl_log','i_ref_c_3cl_log'};
gate_prefix={'a','b','c'};
t_start=0.04;
metrics=table('Size',[3 5], ...
    'VariableTypes',{'string','double','double','double','double'}, ...
    'VariableNames',{'Phase','Grid_RMS_A','RMSE_A','THD_pct','Invalid_State_Count'});
currents=cell(1,3);refs=cell(1,3);
for p=1:3
    its=sim_out.get(phase_logs{p});rts=sim_out.get(ref_logs{p});
    t=its.Time(:);i=its.Data(:);r=interp1(rts.Time(:),rts.Data(:),t,'linear','extrap');
    mask=t>=t_start; currents{p}=[t(mask),i(mask)]; refs{p}=[t(mask),r(mask)];
    rms_i=sqrt(mean(i(mask).^2));rmse=sqrt(mean((i(mask)-r(mask)).^2));
    thd=local_thd(t(mask),i(mask),f_grid_sw);
    q=zeros(numel(sim_out.get([gate_prefix{p} '_q1_3sw_log']).Data),4);
    for k=1:4
        q(:,k)=round(sim_out.get(sprintf('%s_q%d_3sw_log',gate_prefix{p},k)).Data(:));
    end
    allowed=ismember(q,[1 0 1 0;0 0 1 1;0 1 0 1;0 0 1 0;0 0 0 1;0 0 0 0],'rows');
    shoot=(q(:,1)==1 & q(:,2)==1);
    metrics(p,:)={string(phase_names{p}),rms_i,rmse,thd,sum(~allowed|shoot)};
end

nts=sim_out.get('i_neutral_3sw_log');nm=nts.Time>=t_start;
neutral_rms=sqrt(mean(nts.Data(nm).^2));
out_dir=fullfile(root_dir,'results','three_phase_switching_closed_loop');
if ~exist(out_dir,'dir'),mkdir(out_dir);end
writetable(metrics,fullfile(out_dir,'phase_metrics.csv'));
fid=fopen(fullfile(out_dir,'neutral_metric.txt'),'w');
fprintf(fid,'Neutral_RMS_A=%.9g\n',neutral_rms);fclose(fid);

fig=figure('Color','w','Position',[80 80 1500 900]);
subplot(2,1,1);hold on;
colors=lines(3);
for p=1:3
    plot(currents{p}(:,1),currents{p}(:,2),'Color',colors(p,:),'LineWidth',1.0);
    plot(refs{p}(:,1),refs{p}(:,2),'--','Color',colors(p,:),'LineWidth',0.8);
end
grid on;xlabel('Zaman (s)');ylabel('Faz akımı (A)');
title('12 IGBT''li üç faz fiziksel kapalı çevrim');
legend('i_a','i_a^*','i_b','i_b^*','i_c','i_c^*','Location','eastoutside');
subplot(2,1,2);plot(nts.Time(nm),nts.Data(nm),'k','LineWidth',1.0);grid on;
xlabel('Zaman (s)');ylabel('Nötr akımı (A)');
title(sprintf('Nötr RMS = %.4f A',neutral_rms));
exportgraphics(fig,fullfile(out_dir,'closed_loop_currents.png'),'Resolution',180);
savefig(fig,fullfile(out_dir,'closed_loop_currents.fig'));close(fig);
disp(metrics);fprintf('Nötr RMS: %.6f A\n',neutral_rms);
assert(all(metrics.Invalid_State_Count==0),'Geçersiz kapı durumu bulundu.');
close_system(model_name,0);

function value=local_thd(t,x,f0)
    % Değişken adımlı Simscape çıktısında harmonik regresyonu FFT'den
    % daha güvenlidir; 1.-19. harmoniklerin sinüs/kosinüs katsayılarını uydurur.
    t=t(:);x=x(:)-mean(x);amps=zeros(19,1);
    for h=1:19
        A=[sin(2*pi*h*f0*t),cos(2*pi*h*f0*t)];
        c=A\x;amps(h)=hypot(c(1),c(2));
    end
    value=100*sqrt(sum(amps(2:end).^2))/max(amps(1),eps);
end
