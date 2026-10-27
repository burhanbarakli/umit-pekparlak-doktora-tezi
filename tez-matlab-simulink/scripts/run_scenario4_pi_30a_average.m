% Senaryo 4 için L1 akım geri beslemeli ortalama-değer PI fizibilite deneyi.
%
% Bu deney anahtarlama kaybı/verim kanıtı değildir. Gelen notta 30 A'nın tepe
% mi RMS mi olduğu belirtilmediği için iki yorum da aynı modelle sınanır.

root_dir = fileparts(fileparts(mfilename('fullpath')));
out_dir = fullfile(root_dir,'results','scenario4_pi_30a_average');
if ~exist(out_dir,'dir'), mkdir(out_dir); end
set(groot,'defaultFigureColor','w','defaultAxesColor','w', ...
    'defaultAxesXColor','k','defaultAxesYColor','k','defaultTextColor','k');

p.Vdc = 431;
p.Vgrid_rms = 120;
p.Vgrid_pk = sqrt(2)*p.Vgrid_rms;
p.f = 50;
p.w = 2*pi*p.f;
p.L1 = 600e-6;
p.R1 = 0.02;
p.K3 = -2.0;
p.Kp = 3.00;
p.Ki = 100.0;
p.mod_limit = 0.95;
p.v_limit = p.mod_limit*p.Vdc/2;
p.dt = 1e-6;
p.Ts_control = 100e-6;
p.t_stop = 0.30;
p.t_analysis = 0.20;

definitions = ["30_A_peak";"30_A_RMS"];
reference_rms = [30/sqrt(2);30];
methods = ["K1sin_K3sin3_open_loop";"K1sin_K3sin3_plus_PI"];
n = numel(definitions)*numel(methods);
Definition = strings(n,1); Method = strings(n,1);
Reference_RMS_A = zeros(n,1); Measured_RMS_A = zeros(n,1);
Tracking_RMSE_A = zeros(n,1); THD_pct = zeros(n,1);
Fundamental_RMS_A = zeros(n,1); Max_Modulation = zeros(n,1);
Saturation_Fraction_pct = zeros(n,1); PI_Enabled = zeros(n,1);
wave = cell(numel(definitions),numel(methods));

row = 0;
for d = 1:numel(definitions)
    for m = 1:numel(methods)
        row = row+1;
        pi_enable = (m==2);
        result = local_simulate(p,reference_rms(d),pi_enable);
        wave{d,m} = result;
        Definition(row) = definitions(d); Method(row) = methods(m);
        Reference_RMS_A(row) = reference_rms(d);
        Measured_RMS_A(row) = result.rms;
        Tracking_RMSE_A(row) = result.rmse;
        THD_pct(row) = result.thd;
        Fundamental_RMS_A(row) = result.fundamental_rms;
        Max_Modulation(row) = result.max_modulation;
        Saturation_Fraction_pct(row) = result.saturation_fraction_pct;
        PI_Enabled(row) = pi_enable;
    end
end

metrics = table(Definition,Method,Reference_RMS_A,Measured_RMS_A, ...
    Tracking_RMSE_A,THD_pct,Fundamental_RMS_A,Max_Modulation, ...
    Saturation_Fraction_pct,PI_Enabled);
writetable(metrics,fullfile(out_dir,'scenario4_metrics.csv'));

fid = fopen(fullfile(out_dir,'scenario4_parameters.txt'),'w');
fields = fieldnames(p);
for k = 1:numel(fields)
    fprintf(fid,'%s=%.12g\n',fields{k},p.(fields{k}));
end
fprintf(fid,'Interpretation=30 A ambiguity tested as peak and RMS\n');
fprintf(fid,'EvidenceLevel=average-value control feasibility; no semiconductor loss model\n');
fclose(fid);

fig = figure('Color','w','Position',[80 80 1450 900]);
tiledlayout(2,2,'TileSpacing','compact');
for d = 1:2
    nexttile; hold on;
    r = wave{d,2}; mask = r.t >= p.t_stop-2/p.f;
    plot(r.t(mask),r.ref(mask),'k--','LineWidth',1.1);
    plot(r.t(mask),r.i(mask),'b','LineWidth',1.1);
    grid on; xlabel('Zaman (s)'); ylabel('L_1 akımı (A)');
    title(sprintf('%s: PI ile RMSE %.3f A, THD %.3f%%', ...
        strrep(definitions(d),'_',' '),r.rmse,r.thd));
    legend('Referans','i_{L1}','Location','best');
end
nexttile;
sel = metrics.Definition=="30_A_peak";
bar(categorical(["İleri besleme";"İleri besleme+PI"]), ...
    [metrics.Tracking_RMSE_A(sel),metrics.THD_pct(sel)]);
grid on; ylabel('Sayısal değer'); title('30 A tepe yorumunda kontrol karşılaştırması');
legend('RMSE (A)','THD (%)','Location','best');
nexttile;
sel = metrics.PI_Enabled==1;
bar(categorical(["30 A tepe";"30 A RMS"]),[metrics.Max_Modulation(sel), ...
    metrics.Saturation_Fraction_pct(sel)]);
grid on; ylabel('Sayısal değer'); title('PI koşularında modülasyon payı');
legend('|m|_{max}','Doyum süresi (%)','Location','best');
exportgraphics(fig,fullfile(out_dir,'scenario4_pi_30a.png'),'Resolution',200);
savefig(fig,fullfile(out_dir,'scenario4_pi_30a.fig'));
close(fig);

disp(metrics);

function result = local_simulate(p,reference_rms,pi_enable)
    t = (0:p.dt:p.t_stop).'; n = numel(t);
    i = zeros(n,1); ref = sqrt(2)*reference_rms*sin(p.w*t);
    vcmd = zeros(n,1); integ = 0; held_v = 0;
    control_stride = round(p.Ts_control/p.dt);
    i_pk = sqrt(2)*reference_rms;
    fundamental_sine = p.Vgrid_pk + p.R1*i_pk;
    fundamental_cos = p.w*p.L1*i_pk;
    K1 = hypot(fundamental_sine,fundamental_cos);
    phi = atan2(fundamental_cos,fundamental_sine);
    saturated = false(n,1);
    for k = 1:n-1
        if mod(k-1,control_stride)==0
            theta = p.w*t(k);
            vff = K1*sin(theta+phi) + p.K3*sin(theta)^3;
            error = ref(k)-i(k);
            v_unsat = vff + pi_enable*(p.Kp*error + p.Ki*integ);
            held_v = min(max(v_unsat,-p.v_limit),p.v_limit);
            if pi_enable
                % Koşullu integrasyon: çıkış doyumdaysa hatayı büyüten yönde birikme yoktur.
                drives_further = (v_unsat>p.v_limit && error>0) || ...
                    (v_unsat<-p.v_limit && error<0);
                if ~drives_further, integ = integ + p.Ts_control*error; end
            end
        end
        vcmd(k) = held_v;
        saturated(k) = abs(held_v)>=p.v_limit*(1-1e-12);
        vgrid = p.Vgrid_pk*sin(p.w*t(k));
        di = (held_v-vgrid-p.R1*i(k))/p.L1;
        i(k+1) = i(k)+p.dt*di;
    end
    vcmd(end)=vcmd(end-1); saturated(end)=saturated(end-1);
    mask = t>=p.t_analysis;
    tm=t(mask); im=i(mask); rm=ref(mask);
    im_ac=im-mean(im); amps=zeros(39,1);
    for h=1:39
        A=[sin(2*pi*h*p.f*tm),cos(2*pi*h*p.f*tm)]; c=A\im_ac;
        amps(h)=hypot(c(1),c(2));
    end
    result.t=t; result.i=i; result.ref=ref; result.vcmd=vcmd;
    result.rms=sqrt(mean(im.^2));
    result.rmse=sqrt(mean((im-rm).^2));
    result.fundamental_rms=amps(1)/sqrt(2);
    result.thd=100*sqrt(sum(amps(2:end).^2))/max(amps(1),eps);
    result.max_modulation=max(abs(vcmd(mask)))/(p.Vdc/2);
    result.saturation_fraction_pct=100*mean(saturated(mask));
end
