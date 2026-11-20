function guncelle_sin3_taramasi_20261120
% Eski Tablo 4.3 kosullarini guncel parcali modele uygular ve Sekil 5.2'yi uretir.
root = fileparts(fileparts(mfilename('fullpath')));
out = fullfile(root, 'results', 'sin3_rescan_20261120');
figureOut = fullfile(fileparts(root), 'yeni_tez', 'sekiller', 'b5');
if ~isfolder(out), mkdir(out); end
addpath(fullfile(root, 'scripts'));

p = struct('Vh', 431.5/2, 'Vm', 169.4, 'L', 600e-6, ...
    'fs', 10000, 'f0', 50);
values = (10:50)/100;
records = zeros(numel(values)^2, 9);
ratioMap = zeros(numel(values));
feasibleMap = false(numel(values));
n = 0;
for a = 1:numel(values)
    for b = 1:numel(values)
        k1 = values(a); k3 = values(b);
        [~, current, ccmCount] = current_half(k1, k3, p);
        [i1, i3, irms, thd] = spectrum(current);
        ratio = 100*i3/i1;
        n = n + 1;
        records(n,:) = [k1, k3, irms, i1, i3, ratio, thd, k1+k3, ccmCount];
        ratioMap(b,a) = ratio;
        feasibleMap(b,a) = irms > 2.2 && ratio < 5;
    end
end
scan = array2table(records, 'VariableNames', {'k1', 'k3', 'Irms_A', ...
    'I1_peak_A', 'I3_peak_A', 'I3_over_I1_pct', 'THD_to49_pct', ...
    'd_peak', 'CCM_periods'});
accepted = scan(scan.Irms_A > 2.2 & scan.I3_over_I1_pct < 5, :);
assert(height(accepted) == 23, 'Beklenen uygun katsayi sayisi degisti.');
[~, bestIndex] = min(accepted.I3_over_I1_pct);
best = accepted(bestIndex,:);
assert(abs(best.k1-0.36) < 1e-12 && abs(best.k3-0.42) < 1e-12);
assert(abs(best.Irms_A-2.24383140467867) < 1e-9);
assert(abs(best.I3_over_I1_pct-0.3153718434803) < 1e-9);
writetable(scan, fullfile(out, 'katsayi_taramasi.csv'));
writetable(accepted, fullfile(out, 'uygun_katsayilar.csv'));
writetable(best, fullfile(out, 'en_iyi_aday.csv'));

% Saf sinusun temel akim genligini yeni adayin temel bilesenine esitle.
low = 0.1; high = 0.7;
for iteration = 1:50
    dm = (low+high)/2;
    [~, sinusCurrent] = current_half(dm, 0, p);
    sinusI1 = spectrum(sinusCurrent);
    if sinusI1 < best.I1_peak_A, low = dm; else, high = dm; end
end
dm = (low+high)/2;
[theta, sinusCurrent] = current_half(dm, 0, p);
[~, bestCurrent] = current_half(best.k1, best.k3, p);
[sinusI1, sinusI3] = spectrum(sinusCurrent);
assert(abs(sinusI1-best.I1_peak_A) < 1e-10);

fg = figure('Visible', 'off', 'Units', 'points', ...
    'Position', [80 80 650 420], 'Color', 'w');
layout = tiledlayout(fg, 1, 2, 'TileSpacing', 'compact', 'Padding', 'compact');
ax = nexttile(layout);
imagesc(ax, values, values, min(ratioMap, 60));
axis(ax, 'xy'); hold(ax, 'on');
colormap(ax, parula);
clim(ax, [0 60]);
cb = colorbar(ax); cb.Label.String = 'I_3/I_1 (%)';
contour(ax, values, values, ratioMap, [5 5], 'w-', 'LineWidth', 1.1);
[row, col] = find(feasibleMap);
plot(ax, values(col), values(row), 'wo', 'MarkerSize', 3.8, ...
    'MarkerFaceColor', 'w', 'LineWidth', 0.7);
plot(ax, best.k1, best.k3, 'p', 'Color', 'k', ...
    'MarkerFaceColor', [0.95 0.15 0.1], 'MarkerSize', 11);
xlabel(ax, 'k_1 (temel katsayı)');
ylabel(ax, 'k_3 (Sin^3 katsayısı)');
title(ax, 'Üçüncü harmonik oranı');
xticks(ax, 0.1:0.1:0.5); yticks(ax, 0.1:0.1:0.5);

ax = nexttile(layout);
plot(ax, theta/pi, bestCurrent, 'Color', [0 0.25 0.75], 'LineWidth', 1.1);
hold(ax, 'on');
plot(ax, theta/pi, sinusCurrent, '--', 'Color', [0.75 0.1 0.05], 'LineWidth', 1.1);
plot(ax, theta/pi, best.I1_peak_A*sin(theta), 'k:', 'LineWidth', 1.1);
grid(ax, 'on');
xlabel(ax, '\theta/\pi'); ylabel(ax, 'Ortalama L_1 akımı (A)');
xlim(ax, [0 1]);
title(ax, 'Pozitif alternans ortalama akım zarfı');
legend(ax, {'k_1 = 0,36, k_3 = 0,42 (I_3/I_1 = %0,315)', ...
    strrep(sprintf('Saf sinüs, d_m = %.4f (I_3/I_1 = %%%.2f)', ...
    dm, 100*sinusI3/sinusI1), '.', ','), 'Temel bileşen'}, ...
    'Location', 'southoutside', 'Box', 'off');

% Yerlesim oncesi kaynak sekil, ortak tez sekli duzenleyicisinde de kullanilir.
savefig(fg, fullfile(out, 'sin3_katsayi_taramasi_20261120.fig'));
set(findall(fg, '-property', 'FontName'), 'FontName', 'Arial');
b5_olcek(fg, 450, 10);
for axesHandle = findall(fg, 'Type', 'axes')'
    axesHandle.Title.String = '';
end
b5_son(fg, 'sin3_katsayi_taramasi');
b5_virgul(fg);
exportgraphics(fg, fullfile(figureOut, 'sin3_katsayi_taramasi.pdf'), 'ContentType', 'vector');
exportgraphics(fg, fullfile(out, 'sin3_katsayi_taramasi.png'), 'Resolution', 180);
close(fg);
fid = fopen(fullfile(out, 'OZET.txt'), 'w', 'n', 'UTF-8');
closer = onCleanup(@() fclose(fid));
fprintf(fid, 'S1: Vdc=431.5 V, Vm=169.4 V, L1=600 uH, fs=10000 Hz, f0=50 Hz\n');
fprintf(fid, 'Tarama: 0.10 <= k1,k3 <= 0.50; adim 0.01; Irms > 2.2 A; I3/I1 < %%5\n');
fprintf(fid, '1681 cift; %d uygun; %d tam DCM; %d DCM/CCM\n', ...
    height(accepted), sum(accepted.CCM_periods==0), sum(accepted.CCM_periods>0));
fprintf(fid, 'En iyi: k1=%.2f, k3=%.2f, Irms=%.12f A, I3/I1=%%%.12f, THD=%%%.12f\n', ...
    best.k1, best.k3, best.Irms_A, best.I3_over_I1_pct, best.THD_to49_pct);
fprintf(fid, 'Ayni temel bilesenli saf sinus: dm=%.12f, I3/I1=%%%.12f\n', dm, 100*sinusI3/sinusI1);
disp(best);
end

function [theta, current, ccmCount] = current_half(k1, k3, p)
count = round(p.fs/p.f0/2);
theta = pi*((1:count)-0.5)/count;
current = zeros(1,count);
initial = 0; ccmCount = 0;
for index = 1:count
    vg = p.Vm*sin(theta(index));
    duty = k1*sin(theta(index))+k3*sin(theta(index))^3;
    assert(duty >= 0 && duty <= 1, 'Gorev orani siniri asildi.');
    on = duty/p.fs; off = (1-duty)/p.fs;
    peak = initial+(p.Vh-vg)/p.L*on;
    fall = peak*p.L/vg;
    final = max(0,peak-vg/p.L*off);
    if fall >= off
        offArea = (peak+final)*off/2;
    else
        offArea = peak*fall/2;
    end
    current(index) = ((initial+peak)*on/2+offArea)*p.fs;
    ccmCount = ccmCount+(final > 1e-10);
    initial = final;
end
end

function [i1, i3, irms, thd] = spectrum(current)
count = numel(current);
theta = pi*((1:count)-0.5)/count;
full = [current,-current];
angle = [theta,theta+pi];
amplitude = zeros(1,49);
for harmonic = 1:49
    sine = 2/numel(full)*sum(full.*sin(harmonic*angle));
    cosine = 2/numel(full)*sum(full.*cos(harmonic*angle));
    amplitude(harmonic) = hypot(sine,cosine);
end
i1 = amplitude(1); i3 = amplitude(3);
irms = sqrt(mean(full.^2));
thd = 100*sqrt(sum(amplitude(2:end).^2))/i1;
end
