% Susturmalı faz kolunda üçüncü harmonik oluşum mekanizması (ilk tez Şekil 3.13'ün
% kalibre parametrelerle yeniden üretimi). Kesim 5.3, Eşitlik dcm-tepe-akimi ...
% dcm-ccm-parcali-model ile aynı parçalı model kullanılır.
%   Çalışma noktası: kalibre S2 (susturma) koşusu; V_dc, V_g, L_1, f_s Tablo
%   sistem-parametreleri; d_m, analitik L1 temel bileşeni kalibre S2 koşusundaki
%   L1 temel bileşenine (l1_metrikleri.csv) eşitlenerek bulunur.
%   Girdi : tez-matlab-simulink/runs/2026-10-29_tez_sekilleri/results/s2/sekil_kayit.mat
%   Çıktı : bu klasörde harmonik_olusum_mekanizmasi.pdf, harmonik_mekanizma_metrikleri.csv
% Çağrı  : matlab -batch "run('<bu dosya>')"
here = 'C:/CODES/ümit abi/tez-matlab-simulink/results/bolum5_sekiller_20261117';
kok = 'C:/CODES/ümit abi/tez-matlab-simulink/runs/2026-10-29_tez_sekilleri/results';

Vdc = 395.0; Vh = Vdc/2;              % S2 DA bara (deney özeti = parametre dosyası)
Vm  = 121.00*sqrt(2);                 % S2 şebeke tepe gerilimi
L   = 600e-6; fs = 10e3; Ts = 1/fs; f0 = 50; w0 = 2*pi*f0;
Nh  = round(fs/f0)/2;                 % yarım periyottaki anahtarlama periyodu (100)

% kalibre S2 koşusu: L1 akımı ve şebeke gerilimi
S = load(fullfile(kok, 's2', 'sekil_kayit.mat'), 'E'); E = S.E;
iL = bul(E, 'PS-Simulink Converter5$');
vg = enkucuk_tepe(E, 'AC Voltage Sensor\d*/PS-Simulink Converter$');
ta = 0.08; tb = 0.10;
[Ag1, ~] = temel(iL, ta, tb, 1); IL1_sim = Ag1/sqrt(2);

% d_m: analitik L1 temel bileşeni = kalibre S2 L1 temel bileşeni
hedef = @(dm) harm(yarim(dm, Vh, Vm, L, Ts, Nh), 1)/sqrt(2) - IL1_sim;
dm = fzero(hedef, [0.2 0.85]);
P = yarim(dm, Vh, Vm, L, Ts, Nh);
I1 = harm(P, 1); I3 = harm(P, 3);
fprintf('d_m = %.4f, I1 = %.4f A (tepe), I3/I1 = %.2f %%\n', dm, I1, 100*I3/I1);

% simülasyonda pozitif alternansın başlangıcı: v_g'nin ta sonrası ilk yükselen sıfır geçişi
[tv, vv] = esit(vg.t, vg.v(:, 1), ta - 0.002, tb - 0.011, 1e-6);   % geçiş tam 80 ms çevresinde
k0 = find(vv(1:end-1) < 0 & vv(2:end) >= 0, 1);
t0 = tv(k0) - vv(k0)*(tv(k0+1) - tv(k0))/(vv(k0+1) - vv(k0));
[ts, is] = esit(iL.t, iL.v(:, 1), t0, t0 + 0.5/f0, 0.1e-6);
ibar_sim = mean(reshape(is(1:Nh*1000), 1000, Nh), 1);   % anahtarlama periyodu ortalaması
fprintf('t0 = %.6f s, NaN = %d, benzetim ortalama zarf tepesi = %.3f A\n', t0, sum(isnan(is)), max(ibar_sim));
% simülasyonun üçüncü harmonik oranı (son tam periyot)
[As1, ~] = temel(iL, ta, tb, 1); [As3, ~] = temel(iL, ta, tb, 3);
fprintf('kalibre S2 L1: I1 = %.4f A (tepe), I3/I1 = %.2f %%\n', As1, 100*As3/As1);

writetable(table(dm, Vdc, Vm, L*1e6, fs, I1, 100*I3/I1, As1, 100*As3/As1, ...
    'VariableNames', {'d_m', 'Vdc_V', 'Vm_V', 'L1_uH', 'fs_Hz', 'I1_analitik_A', ...
    'I3_I1_analitik_yuzde', 'I1_kalibre_S2_A', 'I3_I1_kalibre_S2_yuzde'}), ...
    fullfile(here, 'harmonik_mekanizma_metrikleri.csv'), 'Encoding', 'UTF-8');

% ---------------- şekil ----------------
tms = P.theta/w0*1e3;                 % periyot orta zamanları [ms]
f = figure('Units', 'centimeters', 'Position', [2 2 16 19], 'Color', 'w', 'Visible', 'off');
tl = tiledlayout(f, 5, 1, 'TileSpacing', 'compact', 'Padding', 'compact');
mavi = [0 0.447 0.741]; tur = [0.850 0.325 0.098]; yes = [0.466 0.674 0.188]; gri = [0.55 0.55 0.55];

ax = nexttile(tl); hold(ax, 'on');
plot(ax, tms, P.d, '-', 'Color', mavi, 'LineWidth', 1.2);
plot(ax, tms, Vm*sin(P.theta)/Vh, '--', 'Color', tur, 'LineWidth', 1.0);
ylabel(ax, 'görev oranı'); ylim(ax, [0 1.3]);
legend(ax, {sprintf('d(\\theta) = %s sin\\theta', virgul(dm, 3)), 'd_{krit}(\theta) = v_g/V_h'}, ...
    'Location', 'north', 'Orientation', 'horizontal', 'Box', 'off');
title(ax, '(a) Sinüzoidal görev oranı ve süreksiz iletim sınırı', 'FontWeight', 'normal');

ax = nexttile(tl); hold(ax, 'on');
plot(ax, tms, Vh - Vm*sin(P.theta), '-', 'Color', yes, 'LineWidth', 1.2);
plot(ax, tms, Vm*sin(P.theta), ':', 'Color', [0.2 0.2 0.2], 'LineWidth', 1.0);
ylabel(ax, 'gerilim (V)'); ylim(ax, [0 270]);
legend(ax, {'V_h - v_g(\theta)  (iletimde L_1 gerilimi)', 'v_g(\theta)'}, ...
    'Location', 'north', 'Orientation', 'horizontal', 'Box', 'off');
title(ax, '(b) İletimde endüktör gerilimi', 'FontWeight', 'normal');

ax = nexttile(tl); hold(ax, 'on');
plot(ax, tms, P.ipk, '-', 'Color', [0.494 0.184 0.556], 'LineWidth', 1.2);
plot(ax, tms, max(P.ipk)*sin(P.theta), '--', 'Color', [0.494 0.184 0.556 0.55], 'LineWidth', 1.0);
ylabel(ax, 'I_{pk} (A)'); ylim(ax, [0 10.5]);
legend(ax, {'I_{pk}(\theta)', 'aynı tepeli sinüs'}, 'Location', 'north', ...
    'Orientation', 'horizontal', 'Box', 'off');
title(ax, '(c) Anahtarlama periyodu tepe akımı', 'FontWeight', 'normal');

ax = nexttile(tl); hold(ax, 'on');
plot(ax, tms, ibar_sim, '-', 'Color', gri, 'LineWidth', 2.2);
plot(ax, tms, P.ibar, '-', 'Color', [0.85 0.1 0.1], 'LineWidth', 1.2);
plot(ax, tms, I1*sin(P.theta), ':', 'Color', [0.2 0.2 0.2], 'LineWidth', 1.0);
ylabel(ax, '\langle i_{L1}\rangle_{T_s} (A)'); ylim(ax, [0 5.2]);
legend(ax, {'S2 benzetimi', 'parçalı analitik model', 'analitik temel bileşen'}, ...
    'Location', 'north', 'Box', 'off', 'Orientation', 'horizontal');
title(ax, sprintf('(d) Ortalama akım zarfı: alternans ortasında çökme, I_3/I_1 = %%%s', ...
    virgul(100*I3/I1, 1)), 'FontWeight', 'normal');

ax = nexttile(tl); hold(ax, 'on');
plot(ax, (ts - t0)*1e3, is, '-', 'Color', gri, 'LineWidth', 0.5);
plot(ax, P.tn*1e3, P.in, '-', 'Color', [0 0.5 0.5], 'LineWidth', 0.6);
yline(ax, 0, ':', 'Color', [0.4 0.4 0.4]);
ylabel(ax, 'i_{L1} (A)'); ylim(ax, [-0.5 11.5]); xlabel(ax, 'pozitif alternans, t (ms)  (\theta = \omega_0 t)');
legend(ax, {'S2 benzetimi', 'parçalı analitik model'}, 'Location', 'north', ...
    'Orientation', 'horizontal', 'Box', 'off');
title(ax, '(e) Anlık endüktör akımı: üçgen darbeler, akım sıfırda kesilir', 'FontWeight', 'normal');

ax = findall(f, 'Type', 'axes');
set(ax, 'FontName', 'Arial', 'FontSize', 8, 'XLim', [0 10], 'Box', 'on');
for a = ax', grid(a, 'on'); end
b5_olcek(f, 430, 8); b5_son(f, 'harmonik_olusum_mekanizmasi'); b5_virgul(f); exportgraphics(f, 'C:/CODES/ümit abi/yeni_tez/sekiller/b5/harmonik_olusum_mekanizmasi.pdf', 'ContentType', 'vector');
close(f);
fprintf('DURUM: BASARILI\n');

% ---------------- yardımcılar ----------------
function P = yarim(dm, Vh, Vm, L, Ts, Nh)
% Susturmalı faz kolunun pozitif yarım periyodu, anahtarlama periyodu bazında
% parçalı doğrusal çözüm (Kesim 5.4 taramasıyla aynı model).
P.theta = zeros(1, Nh); P.d = P.theta; P.ipk = P.theta; P.ibar = P.theta;
tn = zeros(1, 4*Nh); in = tn; I0 = 0;
for k = 1:Nh
    th = pi*(k - 0.5)/Nh; vg = Vm*sin(th);
    d = min(max(dm*sin(th), 0), 1); ton = d*Ts; toff = Ts - ton;
    ipk = I0 + (Vh - vg)/L*ton;
    tf = ipk*L/max(vg, 1e-9);
    if tf >= toff, Ie = ipk - vg/L*toff; aoff = 0.5*(ipk + Ie)*toff; tz = Ts;
    else, Ie = 0; aoff = 0.5*ipk*tf; tz = ton + tf; end
    P.theta(k) = th; P.d(k) = d; P.ipk(k) = ipk;
    P.ibar(k) = (0.5*(I0 + ipk)*ton + aoff)/Ts;
    t = (k - 1)*Ts; j = 4*(k - 1);
    tn(j+1:j+4) = [t, t + ton, t + tz, t + Ts]; in(j+1:j+4) = [I0, ipk, Ie, Ie];
    I0 = Ie;
end
P.tn = tn; P.in = in;
end
function A = harm(P, h)
% tek (yarım dalga) simetriyle tam periyot sinüs katsayısının genliği
th = [P.theta, P.theta + pi]; i = [P.ibar, -P.ibar]; w = 2*pi/numel(th);
A = hypot(sum(i.*sin(h*th))*w/pi, sum(i.*cos(h*th))*w/pi);
end
function s = virgul(x, n)
s = strrep(sprintf(['%.' num2str(n) 'f'], x), '.', ',');
end
function x = bul(E, desen)
fn = fieldnames(E);
bl = cellfun(@(c) E.(c).blok, fn, 'UniformOutput', false);
j = find(~cellfun(@isempty, regexp(bl, desen, 'once')));
assert(~isempty(j), 'işaret bulunamadı: %s', desen);
x = E.(fn{j(1)});
end
function x = enkucuk_tepe(E, desen)
% birden çok gerilim algılayıcısından tepe değeri en küçük olan (şebeke tarafı)
fn = fieldnames(E);
bl = cellfun(@(c) E.(c).blok, fn, 'UniformOutput', false);
j = find(~cellfun(@isempty, regexp(bl, desen, 'once')));
assert(~isempty(j), 'işaret bulunamadı: %s', desen);
tp = arrayfun(@(q) max(abs(double(E.(fn{q}).v(:, 1)))), j);
[~, m] = min(tp); x = E.(fn{j(m)});
end
function [A, ph] = temel(x, a, b, h)
m = x.t >= a & x.t <= b; t = x.t(m); v = double(x.v(m, 1));
w = 2*pi*50*h;
A = abs(2/(b - a)*trapz(t, v.*exp(-1i*w*t))); ph = 0;
end
function [to, vo] = esit(t, v, a, b, dt)
t = t(:); v = double(v(:)); [t, iu] = unique(t); v = v(iu);
to = (a:dt:b)'; vo = interp1(t, v, to, 'linear');
end
