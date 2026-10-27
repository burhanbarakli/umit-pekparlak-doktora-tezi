% L2=200/400/600 uH adaylarinin kaynak ve LCL duyarlilik karsilastirmasi.
%
% Bu betik bir anahtarlamali verim/THD deneyi degildir. Adaylarin ideal LCL
% rezonans frekansini, 50 Hz seri reaktansini ve 10 kHz'deki ideal
% evirici-gerilimi/sebeke-akimi admitansini ayni kosullarda hesaplar.

root_dir = fileparts(fileparts(mfilename('fullpath')));
out_dir = fullfile(root_dir,'results','l2_candidate_evaluation_20260826');
if ~exist(out_dir,'dir'), mkdir(out_dir); end
set(groot,'defaultFigureColor','w','defaultAxesColor','w', ...
    'defaultAxesXColor','k','defaultAxesYColor','k','defaultTextColor','k');

L1_H = 600e-6;
Cf_F = 8e-6;
f_grid_Hz = 50;
f_switch_Hz = 10000;
I_s1_rms_A = 2.26;
L2_uH = [200;400;600];
L2_H = L2_uH*1e-6;

resonance_Hz = (1/(2*pi))*sqrt((L1_H+L2_H)./(L1_H.*L2_H.*Cf_F));
resonance_over_switching = resonance_Hz/f_switch_Hz;
margin_to_fs_over_2_Hz = f_switch_Hz/2-resonance_Hz;
L2_reactance_50Hz_ohm = 2*pi*f_grid_Hz*L2_H;
total_L_reactance_50Hz_ohm = 2*pi*f_grid_Hz*(L1_H+L2_H);
total_L_drop_at_2p26A_V = I_s1_rms_A*total_L_reactance_50Hz_ohm;

w_s = 2*pi*f_switch_Hz;
switching_admittance_A_per_V = 1./abs(w_s*(L1_H+L2_H) ...
    -w_s^3*L1_H.*L2_H*Cf_F);
switching_current_relative_to_200 = switching_admittance_A_per_V ...
    /switching_admittance_A_per_V(1);

source_role = ["Nihai L2: e-posta + gercek uygulama Excel"; ...
    "Eski Senaryo 1 modelindeki CL1"; ...
    "Tam topolojide faz-B bobini; LCL-L2 degil"];
decision = ["SELECTED";"LEGACY_MODEL";"PHASE_LABEL_NOT_L2"];

metrics = table(L2_uH,resonance_Hz,resonance_over_switching, ...
    margin_to_fs_over_2_Hz,L2_reactance_50Hz_ohm, ...
    total_L_reactance_50Hz_ohm,total_L_drop_at_2p26A_V, ...
    switching_admittance_A_per_V,switching_current_relative_to_200, ...
    source_role,decision);
writetable(metrics,fullfile(out_dir,'l2_candidate_metrics.csv'));

fid = fopen(fullfile(out_dir,'decision.txt'),'w');
fprintf(fid,'Final_L1_H=%.12g\n',L1_H);
fprintf(fid,'Final_Cf_F=%.12g\n',Cf_F);
fprintf(fid,'Final_L2_H=%.12g\n',L2_H(1));
fprintf(fid,'Decision=L2=200 uH\n');
fprintf(fid,['Reason=600 uH labels are the three phase inductors in the full ' ...
    'topology; 200 uH is independently present in the latest parameter note ' ...
    'and real-application workbook; 400 uH is the legacy CL1 model value.\n']);
fprintf(fid,['Limit=Analytical LCL sensitivity only; the R2025b source-model ' ...
    'conversion still requires solver repair before switching validation.\n']);
fclose(fid);

labels = categorical(string(L2_uH)+" uH",string(L2_uH)+" uH");
bar_colors = [0.10 0.55 0.32; 0.90 0.55 0.12; 0.45 0.48 0.52];
fig = figure('Color','w','Position',[80 80 1500 600]);
tiledlayout(1,3,'TileSpacing','compact','Padding','compact');

nexttile;
b = bar(labels,resonance_Hz/1000,'FaceColor','flat');
b.CData = bar_colors;
yline(f_switch_Hz/2000,'k--','f_s/2','LabelHorizontalAlignment','left');
grid on; ylabel('Rezonans frekansi (kHz)');
ylim([0 5.3]);
title('Ideal LCL rezonansi');

nexttile;
b = bar(labels,switching_current_relative_to_200,'FaceColor','flat');
b.CData = bar_colors;
grid on; ylabel('Goreli 10 kHz akim iletimi');
title('Anahtarlama frekansi duyarliligi');

nexttile;
b = bar(labels,total_L_drop_at_2p26A_V,'FaceColor','flat');
b.CData = bar_colors;
grid on; ylabel('50 Hz enduktif gerilim (V RMS)');
title('2.26 A icin temel bilesen etkisi');

sgtitle('L_1=600 uH, C_f=8 uF icin L_2 aday duyarliligi', ...
    'Color','k','FontWeight','bold');
exportgraphics(fig,fullfile(out_dir,'l2_candidate_evaluation.png'),'Resolution',220);
savefig(fig,fullfile(out_dir,'l2_candidate_evaluation.fig'));
close(fig);

disp(metrics);
