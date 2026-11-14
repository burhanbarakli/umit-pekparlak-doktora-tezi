% Kalibre S1, S2, S3 koşularından L1 akımı ve kapı komutu şekilleri (İP-11, K-25).
% Yalnız koşu kayıtlarını okur; benzetim koşturmaz.
%   Girdi : tez-matlab-simulink/runs/2026-10-29_tez_sekilleri/results/{s1,s2,s3}/sekil_kayit.mat
%           (run_tez_sekilleri_20261029.m; t >= 0,075 s)
%   Çıktı : bu klasörde s1_kapi_isaretleri.pdf, s1_s2_kalibre_l1.pdf, s3_kalibre_l1.pdf,
%           l1_metrikleri.csv
% Çağrı  : matlab -batch "run('<bu dosya>')"
here = fileparts(mfilename('fullpath'));
kok = fullfile(here, '..', '..', '..', 'tez-matlab-simulink', 'runs', '2026-10-29_tez_sekilleri', 'results');
ta = 0.08; tb = 0.10;                 % son tam şebeke periyodu
if ~exist('ZA', 'var'), ZA = 0.0806; end
za = ZA; zb = ZA + 400e-6;            % düşük akım bölgesinde 400 us
renk = {[0 0.447 0.741], [0.850 0.325 0.098], [0.466 0.674 0.188]};
ad = {'S1 (klasik)', 'S2 (susturma)', 'S3 (susturma + Sin^3)'};
E = cell(1, 3); iL = cell(1, 3); ig = cell(1, 3);
rows = {};
for k = 1:3
    S = load(fullfile(kok, sprintf('s%d', k), 'sekil_kayit.mat'), 'E'); E{k} = S.E;
    [iL{k}, nmL] = bul(E{k}, 'PS-Simulink Converter5$', 'PS-Simulink Converter3$');
    [ig{k}, nmG] = bul(E{k}, 'AC Current Sensor\d*/PS-Simulink Converter$', '');
    % doğrulama: son periyotta temel bileşenler (iL1 ≈ ig + Cf akımı)
    [a1, ~] = temel(iL{k}, ta, tb); [g1, ~] = temel(ig{k}, ta, tb);
    m = iL{k}.t >= ta & iL{k}.t <= tb; vv = iL{k}.v(m, 1);
    % oranlar eşit zaman ızgarasında (değişken adımlı örnekler sıfır geçişlerinde sıklaşır)
    [~, vp] = esit(iL{k}.t, iL{k}.v(:, 1), ta, ta + 0.01, 0.1e-6);
    ters = mean(vp < -0.05); sifir = mean(abs(vp) <= 0.05);
    rows(end+1, :) = {ad{k}, nmL, nmG, a1/sqrt(2), g1/sqrt(2), max(vv), min(vv), ters, sifir}; %#ok<AGROW>
end
T = cell2table(rows, 'VariableNames', {'senaryo', 'iL1_blok', 'ig_blok', 'IL1_1_rms', 'Ig_1_rms', ...
    'iL1_max', 'iL1_min', 'poz_yari_ters_orani', 'poz_yari_sifir_orani'});
writetable(T, fullfile(here, 'l1_metrikleri.csv'), 'Encoding', 'UTF-8');
disp(T);

% (1) S1 ve S2 L1 akımı
f = figure('Units', 'centimeters', 'Position', [2 2 16 13], 'Color', 'w', 'Visible', 'off');
tl = tiledlayout(f, 2, 2, 'TileSpacing', 'compact', 'Padding', 'compact');
for k = 1:2
    ax = nexttile(tl, 2*k - 1); hold(ax, 'on');
    [tt, vv] = zarf(iL{k}.t, iL{k}.v(:, 1), ta, tb, 10e-6);
    plot(ax, (tt - ta)*1e3, vv, '-', 'Color', renk{k}, 'LineWidth', 0.4);
    [tt, vv] = zarf(ig{k}.t, ig{k}.v(:, 1), ta, tb, 20e-6);
    plot(ax, (tt - ta)*1e3, vv, '-', 'Color', [0.2 0.2 0.2], 'LineWidth', 1.0);
    yline(ax, 0, ':', 'Color', [0.4 0.4 0.4]);
    xlim(ax, [0 20]); ylim(ax, [-9 9]); grid(ax, 'on'); ylabel(ax, 'akım [A]');
    title(ax, sprintf('(%s) %s, son periyot', char('a' + 2*(k-1)), ad{k}), 'FontWeight', 'normal');
    if k == 1, legend(ax, {'i_{L1}', 'i_{g}'}, 'Location', 'southwest', 'FontSize', 7, 'Box', 'off'); end
    if k == 2, xlabel(ax, 't - 80 ms [ms]'); end
    ax = nexttile(tl, 2*k); hold(ax, 'on');
    [tt, vv] = esit(iL{k}.t, iL{k}.v(:, 1), za, zb, 0.2e-6);
    plot(ax, (tt - za)*1e6, vv, '-', 'Color', renk{k}, 'LineWidth', 0.9);
    yline(ax, 0, ':', 'Color', [0.4 0.4 0.4]);
    xlim(ax, [0 (zb - za)*1e6]); grid(ax, 'on'); ylabel(ax, 'i_{L1} [A]');
    title(ax, sprintf('(%s) %s, 400 \\mus kesit', char('b' + 2*(k-1)), ad{k}), 'FontWeight', 'normal');
    if k == 2, xlabel(ax, ['t - ' strrep(num2str(za*1e3, '%.1f'), '.', ',') ' ms [\mus]']); end
end
yl = [min([iL{1}.v(:); iL{2}.v(:)]) max([iL{1}.v(:); iL{2}.v(:)])];
set(findall(f, 'Type', 'axes'), 'FontName', 'Arial', 'FontSize', 8);
exportgraphics(f, fullfile(here, 's1_s2_kalibre_l1.pdf'), 'ContentType', 'vector');
close(f);

% (2) S3 L1 akımı, S2 ile aynı eksende
f = figure('Units', 'centimeters', 'Position', [2 2 16 7], 'Color', 'w', 'Visible', 'off');
tl = tiledlayout(f, 1, 2, 'TileSpacing', 'compact', 'Padding', 'compact');
ax = nexttile(tl); hold(ax, 'on');
[tt, vv] = zarf(iL{3}.t, iL{3}.v(:, 1), ta, tb, 10e-6);
plot(ax, (tt - ta)*1e3, vv, '-', 'Color', renk{3}, 'LineWidth', 0.4);
[tt, vv] = zarf(ig{3}.t, ig{3}.v(:, 1), ta, tb, 20e-6);
plot(ax, (tt - ta)*1e3, vv, '-', 'Color', [0.2 0.2 0.2], 'LineWidth', 1.0);
[tt, vv] = zarf(ig{2}.t, ig{2}.v(:, 1), ta, tb, 20e-6);
plot(ax, (tt - ta)*1e3, vv, '--', 'Color', renk{2}, 'LineWidth', 0.8);
yline(ax, 0, ':', 'Color', [0.4 0.4 0.4]);
xlim(ax, [0 20]); ylim(ax, [-9 9]); grid(ax, 'on'); ylabel(ax, 'akım [A]'); xlabel(ax, 't - 80 ms [ms]');
legend(ax, {'i_{L1} (S3)', 'i_{g} (S3)', 'i_{g} (S2)'}, 'Location', 'southwest', 'FontSize', 7, 'Box', 'off');
title(ax, '(a) S3, son periyot', 'FontWeight', 'normal');
ax = nexttile(tl); hold(ax, 'on');
[tt, vv] = esit(iL{3}.t, iL{3}.v(:, 1), za, zb, 0.2e-6);
plot(ax, (tt - za)*1e6, vv, '-', 'Color', renk{3}, 'LineWidth', 0.9);
yline(ax, 0, ':', 'Color', [0.4 0.4 0.4]);
xlim(ax, [0 (zb - za)*1e6]); grid(ax, 'on'); ylabel(ax, 'i_{L1} [A]');
xlabel(ax, ['t - ' strrep(num2str(za*1e3, '%.1f'), '.', ',') ' ms [\mus]']);
title(ax, '(b) S3, 400 \mus kesit', 'FontWeight', 'normal');
set(findall(f, 'Type', 'axes'), 'FontName', 'Arial', 'FontSize', 8);
exportgraphics(f, fullfile(here, 's3_kalibre_l1.pdf'), 'ContentType', 'vector');
close(f);

% (3) S1 kapı komutları (s2_kapi_isaretleri.pdf ile aynı düzen)
% S1 modelinde mantık düzeyinde kapı kaydı yoktur; kapı sürücüsü çıkışları (0/15 V) kayıtlıdır.
% Sürücü -> Q eşlemesi S2'de mantık işaretleriyle (g12, g22, g32, g42 -> Q1..Q4) karşılaştırılarak
% bulunur; S1'de sürücüler aynı sırayla (Gate Drive5..8 <-> Gate Drive1..4) yer alır.
% 15.11.2026 (K-31): Q3 faz tarafı (g32), Q4 orta nokta tarafı (g42); tümleyen çiftler Q1-Q3, Q2-Q4.
etk = {'q_1', 'q_2', 'q_3', 'q_4'};
g2 = {'g12_S2', 'g22_S2', 'g32_S2', 'g42_S2'};
sur = @(Ek, n) Ek.(bulad(Ek, sprintf('Gate Drive%d/PS-Simulink Converter8$', n)));
es = zeros(1, 4);
for i = 1:4
    L = E{2}.(g2{i}); best = -inf;
    for n = 1:4
        D = sur(E{2}, n);
        dv = interp1(D.t, double(D.v(:, 1) > 7.5), L.t, 'previous', 0);
        c = mean(dv == double(L.v(:, 1) > 0.5));
        if c > best, best = c; es(i) = n; end
    end
    fprintf('S2 %s <- Gate Drive%d (uyum %.4f)\n', etk{i}, es(i), best);
end
GS1 = cell(1, 4);
for i = 1:4
    D = sur(E{1}, es(i) + 4);
    GS1{i} = struct('t', D.t, 'v', double(D.v(:, 1) > 7.5));
end
f = figure('Units', 'centimeters', 'Position', [2 2 16 11], 'Color', 'w', 'Visible', 'off');
tl = tiledlayout(f, 4, 2, 'TileSpacing', 'compact', 'Padding', 'compact', 'TileIndexing', 'columnmajor');
for pencere = 1:2
    if pencere == 1, a = ta; b = tb; olc = 1e3; xl = [0 20]; xt = 't - 80 ms [ms]';
    else, a = za; b = zb; olc = 1e6; xl = [0 (zb - za)*1e6]; xt = ['t - ' strrep(num2str(za*1e3, '%.1f'), '.', ',') ' ms [\mus]']; end
    for i = 1:4
        ax = nexttile(tl);
        G = GS1{i};
        [tt, vv] = kenar(G.t, G.v(:, 1), a, b);
        stairs(ax, (tt - a)*olc, vv, 'Color', renk{1}, 'LineWidth', 0.6);
        ylim(ax, [-0.2 1.2]); xlim(ax, xl); yticks(ax, [0 1]); grid(ax, 'on'); ylabel(ax, etk{i});
        if i < 4, ax.XTickLabel = []; else, xlabel(ax, xt); end
    end
end
set(findall(f, 'Type', 'axes'), 'FontName', 'Arial', 'FontSize', 8);
exportgraphics(f, fullfile(here, 's1_kapi_isaretleri.pdf'), 'ContentType', 'vector');
close(f);
% kapı darbe sayıları (son periyot, yarım periyot başına geçiş)
for i = 1:4
    for k = [1 2]
        if k == 1, G = GS1{i}; else, G = E{2}.(g2{i}); end
        for y = 0:1
            m = G.t >= ta + y*0.01 & G.t < ta + (y + 1)*0.01;
            v = G.v(m, 1);
            fprintf('S%d %s yarı %d: geçiş %d, ortalama %.3f\n', k, etk{i}, y + 1, sum(abs(diff(v)) > 0.5), mean(v));
        end
    end
end
disp('tamam');

function [x, nm] = bul(E, desen, yedek)
fn = fieldnames(E);
bl = cellfun(@(c) E.(c).blok, fn, 'UniformOutput', false);
j = find(~cellfun(@isempty, regexp(bl, desen, 'once')));
if isempty(j) && ~isempty(yedek), j = find(~cellfun(@isempty, regexp(bl, yedek, 'once'))); end
assert(~isempty(j), 'işaret bulunamadı: %s', desen);
x = E.(fn{j(1)}); nm = bl{j(1)};
end
function f = bulad(E, desen)
fn = fieldnames(E);
bl = cellfun(@(c) E.(c).blok, fn, 'UniformOutput', false);
j = find(~cellfun(@isempty, regexp(bl, desen, 'once')));
assert(numel(j) == 1, 'işaret bulunamadı ya da birden çok: %s', desen);
f = fn{j};
end
function [A, ph] = temel(x, a, b)
m = x.t >= a & x.t <= b; t = x.t(m); v = double(x.v(m, 1));
w = 2*pi*50;
A = abs(2/(b - a)*trapz(t, v.*exp(-1i*w*t))); ph = 0;
end
function [to, vo] = zarf(t, v, a, b, dt)
t = t(:); v = double(v(:)); m = t >= a & t <= b; t = t(m); v = v(m);
kut = floor((t - a)/dt); [u, ~, j] = unique(kut);
vmin = accumarray(j, v, [], @min); vmax = accumarray(j, v, [], @max);
tc = a + (u + 0.5)*dt;
to = reshape([tc tc]', [], 1); vo = reshape([vmin vmax]', [], 1);
end
function [to, vo] = esit(t, v, a, b, dt)
t = t(:); v = double(v(:)); [t, iu] = unique(t); v = v(iu);
to = (a:dt:b)'; vo = interp1(t, v, to, 'linear');
end
function [to, vo] = kenar(t, v, a, b)
t = t(:); v = double(v(:)); m = t >= a & t <= b; t = t(m); v = v(m);
d = [true; diff(v) ~= 0]; d(end) = true; to = t(d); vo = v(d);
end
