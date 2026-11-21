function uret_s4_nyquist_20261121
% Tezde incelenen S4 analog esdegerinin Nyquist grafigini uretir.
% Guclendirilmis gecikme senaryolari bu sekle dahil edilmez.
% Kaynak: kararlilik_ortak_20261028; ayni parametreler, bitki ve denetleyiciler.
root = fileparts(fileparts(mfilename('fullpath')));
addpath(fullfile(root, 'scripts'));
out = fullfile(fileparts(root), 'yeni_tez', 'sekiller', 'b5');
scratch = fullfile(root, 'tmp', 'nyquist_20261121');
if ~isfolder(scratch), mkdir(scratch); end
K = kararlilik_ortak_20261028();
p = K.parametreler(root);
G = K.bitki(p, 0, 'tam');
C = K.denetleyiciler(p, 0);
f = logspace(0, log10(5e4), 30000).';
w = 2*pi*f;
Gw = squeeze(freqresp(G(1,1), w));
Hm = 1./(1+1j*w/(2*pi*p.f_lp));
D = exp(-1j*w*p.Td_A);
names = {'P', 'PI', 'PIR'};
colors = [0 0.25 0.70; 0.70 0.15 0.08; 0.05 0.42 0.16];
styles = {'-', '--', '-.'};
expectedPM = [55.2 54.2 53.5];
fh = figure('Visible', 'off', 'Units', 'points', ...
    'Position', [80 80 430 285], 'Color', 'w');
ax = axes(fh, 'Position', [0.13 0.19 0.60 0.75], ...
    'FontName', 'Arial', 'FontSize', 13, ...
    'XColor', 'k', 'YColor', 'k', 'LineWidth', 0.9);
hold(ax, 'on'); grid(ax, 'on'); box(ax, 'on');
summary = zeros(3,4);
for k = 1:3
    Cw = squeeze(freqresp(C{k}, w));
    Lw = Cw.*p.Kpwm.*Gw.*Hm.*D;
    R = K.marjlar(f, Lw, 0);
    assert(R.nyquist_net == 0, 'Nyquist sonucu degisti: %s', names{k});
    assert(abs(R.PMmin-expectedPM(k)) < 0.15);
    summary(k,:) = [R.PMmin R.GMup 1e6*R.DMmin R.nyquist_net];
    plot(ax, real(Lw), imag(Lw), 'Color', colors(k,:), ...
        'LineStyle', styles{k}, 'LineWidth', 1.6, 'DisplayName', names{k});
    plot(ax, real(Lw), -imag(Lw), 'Color', colors(k,:), ...
        'LineStyle', styles{k}, 'LineWidth', 1.2, 'HandleVisibility', 'off');
end
th = linspace(0, 2*pi, 400);
plot(ax, cos(th), sin(th), ':', 'Color', [0.35 0.35 0.35], ...
    'LineWidth', 0.7, 'HandleVisibility', 'off');
plot(ax, -1, 0, 'kx', 'MarkerSize', 10, 'LineWidth', 1.8, 'HandleVisibility', 'off');
text(ax, -1.15, 0.17, '-1', 'FontName', 'Arial', 'FontSize', 13, 'Color', 'k');
axis(ax, 'equal'); xlim(ax, [-2 2]); ylim(ax, [-2 2]);
xticks(ax, -2:1:2); yticks(ax, -2:1:2);
xlabel(ax, 'Re L', 'FontSize', 13); ylabel(ax, 'Im L', 'FontSize', 13);
legend(ax, 'Location', 'eastoutside', 'FontName', 'Arial', ...
    'FontSize', 13, 'TextColor', 'k', 'Box', 'off');
exportgraphics(fh, fullfile(out, 'kararlilik_nyquist_A.pdf'), ...
    'ContentType', 'vector', 'BackgroundColor', 'white');
exportgraphics(fh, fullfile(scratch, 'kararlilik_nyquist_A.png'), 'Resolution', 180);
savefig(fh, fullfile(scratch, 'kararlilik_nyquist_A.fig'));
T = array2table(summary, 'VariableNames', {'PM_min_deg','GM_dB','DM_us','Nyquist'});
T.Controller = names.'; T = movevars(T, 'Controller', 'Before', 1);
writetable(T, fullfile(scratch, 'marjlar_A.csv'));
disp(T);
close(fh);
end
