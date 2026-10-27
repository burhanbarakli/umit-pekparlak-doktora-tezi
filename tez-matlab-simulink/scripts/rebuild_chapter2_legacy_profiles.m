%% Bölüm 2 - önceki tezdeki çalışma profillerinin yeniden üretimi
% Kaynak: tez_tumu_8.docx içindeki Şekil 2.1--2.10 ve Tablo 2.1--2.4.
% Amaç: eski tezdeki sayısal dizileri izlenebilir CSV ve vektör PDF olarak
% yeniden üretmek. Buradaki eğriler yeni deney sonucu değildir.

clear; close all; clc;

scriptDir = fileparts(mfilename('fullpath'));
projectDir = fileparts(scriptDir);
workspaceDir = fileparts(projectDir);
resultDir = fullfile(projectDir, 'results', 'chapter2_profiles');
latexDir = fullfile(workspaceDir, 'tez-latex', 'figures', 'literatur');
if ~exist(resultDir, 'dir'), mkdir(resultDir); end
if ~exist(latexDir, 'dir'), mkdir(latexDir); end

set(groot, 'defaultAxesFontName', 'Arial');
set(groot, 'defaultTextFontName', 'Arial');
set(groot, 'defaultAxesFontSize', 10);

%% Eski tezdeki temsilî güneş profili ve aylık dizi
hour = (5:0.25:19)';
dailyPowerPct = 100 .* sin(pi .* (hour - 5) ./ 14);
dailyPowerPct(dailyPowerPct < 0) = 0;

month = (1:12)';
monthlyIrradiation = [35; 50; 80; 120; 160; 190; 205; 190; 145; 95; 55; 35];

% Şekil 2.4'teki 144 noktanın 5 puanlık güç sınıflarına dağılımı.
powerEdges = (0:5:100)';
powerCounts = [12; 22; 16; 12; 10; 4; 10; 6; 9; 5; 2; 8; 2; 5; 5; 2; 4; 3; 5; 2];
assert(sum(powerCounts) == 144, 'Eski tezdeki 144 nokta dağılımı korunamadı.');
powerShare = 100 .* powerCounts ./ sum(powerCounts);
powerLabels = compose('%d-%d', powerEdges(1:end-1), powerEdges(2:end));

% Eski Tablo 2.1'deki değerler Şekil 2.4 ile tutarsızdı. Düzeltilmiş
% altı sınıf, 144 noktanın yukarıdaki sayımlarından yeniden toplandı.
coarseLabels = ["0-10"; "10-20"; "20-40"; "40-60"; "60-80"; "80-100"];
coarseCounts = [sum(powerCounts(1:2)); sum(powerCounts(3:4)); ...
    sum(powerCounts(5:8)); sum(powerCounts(9:12)); ...
    sum(powerCounts(13:16)); sum(powerCounts(17:20))];
coarseShare = 100 .* coarseCounts ./ sum(coarseCounts);

writetable(table(hour, dailyPowerPct), ...
    fullfile(resultDir, 'daily_normalized_power.csv'));
writetable(table(month, monthlyIrradiation), ...
    fullfile(resultDir, 'legacy_monthly_irradiation.csv'));
writetable(table(powerLabels, powerCounts, powerShare), ...
    fullfile(resultDir, 'power_duration_5pct_bins.csv'));
writetable(table(coarseLabels, coarseCounts, coarseShare), ...
    fullfile(resultDir, 'power_duration_corrected_bins.csv'));

f1 = figure('Color', 'w', 'Position', [100 100 1180 760]);
tiledlayout(f1, 2, 2, 'TileSpacing', 'compact', 'Padding', 'compact');
nexttile;
plot(hour, dailyPowerPct, 'LineWidth', 2.0); grid on;
xlabel('Saat'); ylabel('Normalize çıkış gücü (%)');
title('(a) Temsilî günlük üretim profili'); xlim([5 19]); ylim([0 105]);
nexttile;
plot(month, monthlyIrradiation, '-o', 'LineWidth', 2.0, 'MarkerFaceColor', [0.12 0.47 0.71]); grid on;
xticks(1:12); xticklabels({'Oca','Şub','Mar','Nis','May','Haz','Tem','Ağu','Eyl','Eki','Kas','Ara'});
xlabel('Ay'); ylabel('Aylık temsilî ışınım (kWh/m^2)');
title('(b) Eski tezde kullanılan aylık dizi');
nexttile;
bar(powerShare, 0.8, 'FaceColor', [0.12 0.47 0.71]); grid on;
xticks(1:20); xticklabels(powerLabels); xtickangle(90);
xlabel('Normalize güç aralığı (%)'); ylabel('Zaman oranı (%)');
title('(c) 144 noktanın 5 puanlık dağılımı');
nexttile;
bar(coarseShare, 0.7, 'FaceColor', [0.20 0.63 0.17]); grid on;
xticks(1:6); xticklabels(coarseLabels);
xlabel('Normalize güç aralığı (%)'); ylabel('Çalışma süresi (%)');
title('(d) Şekil 2.4''ten düzeltilmiş toplulaştırma');
for k = 1:numel(coarseShare)
    text(k, coarseShare(k) + 0.6, sprintf('%.1f', coarseShare(k)), ...
        'HorizontalAlignment', 'center', 'FontSize', 9);
end
exportgraphics(f1, fullfile(resultDir, 'chapter2_power_profiles.pdf'), 'ContentType', 'vector');
exportgraphics(f1, fullfile(resultDir, 'chapter2_power_profiles.png'), 'Resolution', 300);
exportgraphics(f1, fullfile(latexDir, 'matlab_b2_guc_profilleri.pdf'), 'ContentType', 'vector');

%% Eski tezdeki tipik verim ve THD dizileri
loadPct = [5 10 15 20 40 60 80 100]';
efficiencyPct = [91.5 94.5 95.8 96.8 97.8 98.4 98.7 98.3]';
thdPct = [9.5 7.0 5.8 5.0 3.8 3.2 2.8 2.5]';
efficiencyLabels = ["90-91"; "91-92"; "92-93"; "93-94"; "94-95"; ...
    "95-96"; "96-97"; "97-98"; "98-99"; "99-100"];
efficiencyTimeShare = [0; 8.3; 4.2; 5.6; 9.7; 6.9; 15.3; 22.2; 27.8; 0];
thdLabels = ["2-3"; "3-4"; "4-5"; "5-6"; "6-7"; "7-8"; "8-9"; "9-10"];
thdTimeShare = [13.9; 25.0; 18.1; 12.5; 5.6; 11.1; 5.6; 8.3];

writetable(table(loadPct, efficiencyPct, thdPct), ...
    fullfile(resultDir, 'legacy_efficiency_thd_curves.csv'));
writetable(table(efficiencyLabels, efficiencyTimeShare), ...
    fullfile(resultDir, 'legacy_efficiency_duration.csv'));
writetable(table(thdLabels, thdTimeShare), ...
    fullfile(resultDir, 'legacy_thd_duration.csv'));

f2 = figure('Color', 'w', 'Position', [120 80 1180 760]);
tiledlayout(f2, 2, 2, 'TileSpacing', 'compact', 'Padding', 'compact');
nexttile;
plot(loadPct, efficiencyPct, '-o', 'LineWidth', 2.0, 'MarkerFaceColor', [0.12 0.47 0.71]); grid on;
xlabel('Çıkış gücü (%P_n)'); ylabel('Verim (%)'); ylim([90 100]);
title('(a) Eski tezdeki tipik verim eğrisi');
nexttile;
bar(efficiencyTimeShare, 0.75, 'FaceColor', [0.12 0.47 0.71]); grid on;
xticks(1:10); xticklabels(efficiencyLabels); xtickangle(45);
xlabel('Verim aralığı (%)'); ylabel('Çalışma süresi (%)');
title('(b) Verim düzeylerine göre zaman dağılımı');
nexttile;
plot(loadPct, thdPct, '-o', 'LineWidth', 2.0, 'MarkerFaceColor', [0.84 0.15 0.16]); grid on;
xlabel('Çıkış gücü (%P_n)'); ylabel('Akım THD''si (%)');
title('(c) Eski tezdeki güç--THD eğrisi');
nexttile;
bar(thdTimeShare, 0.75, 'FaceColor', [0.84 0.15 0.16]); grid on;
xticks(1:8); xticklabels(thdLabels); xtickangle(45);
xlabel('THD aralığı (%)'); ylabel('Çalışma süresi (%)');
title('(d) THD düzeylerine göre zaman dağılımı');
exportgraphics(f2, fullfile(resultDir, 'chapter2_efficiency_thd_profiles.pdf'), 'ContentType', 'vector');
exportgraphics(f2, fullfile(resultDir, 'chapter2_efficiency_thd_profiles.png'), 'Resolution', 300);
exportgraphics(f2, fullfile(latexDir, 'matlab_b2_verim_thd_profilleri.pdf'), 'ContentType', 'vector');

%% Eski Tablo 2.4'teki ticari evirici kaydı
timeLabel = ["Devreye giriş"; "07:50"; "08:00"; "08:10"; "08:35"; ...
    "08:50"; "09:05"; "09:18"; "09:26"; "09:42"];
powerW = [100; 500; 580; 729; 1060; 1320; 1450; 1720; 1880; 2200];
powerPctMeasured = [1; 5; 5.8; 7.29; 10.6; 13.2; 14.5; 17.2; 18.8; 22];
measuredThdPct = [400; 34; 27; 26; 17; 14; 14; 13; 9; 8];
writetable(table(timeLabel, powerW, powerPctMeasured, measuredThdPct), ...
    fullfile(resultDir, 'legacy_commercial_inverter_record.csv'));

f3 = figure('Color', 'w', 'Position', [140 120 840 520]);
semilogy(powerPctMeasured, measuredThdPct, '-o', 'LineWidth', 2.0, ...
    'MarkerFaceColor', [0.84 0.15 0.16]); grid on;
xlabel('Çıkış gücü (%P_n)'); ylabel('Akım THD''si (%)');
title('Eski tezdeki ticari evirici kaydı');
xlim([0 24]); ylim([5 500]);
exportgraphics(f3, fullfile(resultDir, 'legacy_commercial_inverter_thd.pdf'), 'ContentType', 'vector');
exportgraphics(f3, fullfile(resultDir, 'legacy_commercial_inverter_thd.png'), 'Resolution', 300);
exportgraphics(f3, fullfile(latexDir, 'matlab_b2_ticari_evirici_thd.pdf'), 'ContentType', 'vector');

fprintf('Bölüm 2 profilleri üretildi: %s\n', resultDir);
