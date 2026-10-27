% rescan_sin3_coefficients_20260901.m
%
% Eski tez Tablo 4.1 (tam-DCM harmonik genlikleri) ve Tablo 4.3 / Sekil 4.28
% (katsayi taramasi) sonuclarinin DOGRU sin^3 ozdesligiyle ve dogrulanmis
% 2026-08-22 parametre setiyle yeniden hesabi.
%
% Ozdeslik: sin^3(x) = [3sin(x) - sin(3x)]/4  (kaynak PDF'deki katsayi hatasi
% tasinmaz; TODO maddesi "Dogru ozdesligi kullanma").
%
% Model: notr anahtar susturulmus T-tipi faz kolunun pozitif yarim periyot
% senkron-buck esdegeri. Anahtarlama periyodu bazinda parcali dogrusal
% cozum; akim negatife gidemez (susturma nedeniyle diyot engeli), DCM/CCM
% gecisi I0 baslangic akimiyla dogal olarak olusur. Negatif alternans tek
% (yarim-dalga) simetriyle turetilir.
%
% Gorev orani parametrelemeleri:
%   (P1) d(t) = D1*sin(th) + D3*sin(th)^3        (eski tez gosterimi, V1m/V3m)
%   (P2) d(t) = A1*sin(th) + A3*sin(3*th)        (dogrudan 3. harmonik)
%   Donusum: A1 = D1 + (3/4)*D3,  A3 = -(1/4)*D3.
%
% Cikti: results/sin3_rescan_20260901/ altina CSV + PNG + PDF.

root_dir = fileparts(fileparts(mfilename('fullpath')));
out_dir = fullfile(root_dir, 'results', 'sin3_rescan_20260901');
if ~exist(out_dir, 'dir'); mkdir(out_dir); end

% ---- Dogrulanmis / kaynakli parametreler -------------------------------
Vdc = 431.5;          % V, model anlik goruntusu (2026-08-22)
Vh  = Vdc/2;          % V, T-tipi yarim bara
Vm  = 169.4;          % V, sebeke tepe gerilimi (model anlik goruntusu)
f0  = 50;             % Hz
fs  = 10e3;           % Hz (kaynak model PWM)
L   = 600e-6;         % H, L1 (dogrulanmis filtre seti 2026-08-26)
Ts  = 1/fs;
Nsw = round(fs/f0);   % temel periyottaki anahtarlama periyodu sayisi (200)
Nsub = 40;            % anahtarlama periyodu ici ornek sayisi
H_MAX = 49;           % THD harmonik ust siniri

fprintf('sin3 rescan 20260901: Vh=%.2f V, Vm=%.1f V, L=%g H, fs=%g Hz\n', Vh, Vm, L, fs);

% ---- Yardimci: bir temel periyodun ortalama-akim dalga bicimi -----------
% Pozitif yarim periyotta anahtarlama periyodu bazinda cozum, negatif
% yarim periyot tek simetri ile. Donus: [theta_grid, i_avg_grid]
    function [th, iavg, dmaxeff, clipped] = half_cycle_current(D1, D3, Vh, Vm, L, Ts, Nsw, Nsub)
        Nh = Nsw/2;                       % yarim periyottaki periyot sayisi
        th = zeros(1, Nh); iavg = zeros(1, Nh);
        I0 = 0; clipped = false; dmaxeff = 0;
        for k = 1:Nh
            thk = pi*(k-0.5)/Nh;          % periyot orta acisi
            vg  = Vm*sin(thk);
            d   = D1*sin(thk) + D3*sin(thk)^3;
            if d > 1; d = 1; clipped = true; end
            if d < 0; d = 0; clipped = true; end
            dmaxeff = max(dmaxeff, d);
            ton = d*Ts; toff = Ts - ton;
            % iletim: egim (Vh-vg)/L ; kesim: egim -vg/L, taban 0'da kesilir
            ipk = I0 + (Vh - vg)/L*ton;
            if ipk < 0; ipk = 0; end      % teorik guvenlik
            % kesim suresince akim
            tfall = ipk*L/max(vg, 1e-9);  % sifira inme suresi
            if tfall >= toff
                Iend = ipk - vg/L*toff;   % CCM: periyot sonunda pozitif
                area_off = 0.5*(ipk + Iend)*toff;
            else
                Iend = 0;                 % DCM: sifira oturur (susturma)
                area_off = 0.5*ipk*tfall;
            end
            area_on = 0.5*(I0 + ipk)*ton;
            iavg(k) = (area_on + area_off)/Ts;
            th(k) = thk;
            I0 = Iend;
        end
    end

% ---- Yardimci: harmonik analiz (tek simetri) ---------------------------
    function [I1, Ih, thd, irms] = harmonics_from_half(th, iavg, H_MAX)
        % tam periyot: i(th+pi) = -i(th)
        th_full = [th, th+pi];
        i_full  = [iavg, -iavg];
        n = numel(th_full);
        w = 2*pi/n;                            % esit aralikli orta noktalar
        Ih = zeros(1, H_MAX);
        for h = 1:H_MAX
            Bh = sum(i_full.*sin(h*th_full))*w/pi;
            Ah = sum(i_full.*cos(h*th_full))*w/pi;
            Ih(h) = hypot(Ah, Bh);
        end
        I1 = Ih(1);
        thd = 100*sqrt(sum(Ih(2:end).^2))/max(I1, 1e-12);
        irms = sqrt(mean(i_full.^2));
    end

% ========================================================================
% 1) Tam-DCM saf sinus taramasi (eski Tablo 4.1'in yeniden hesabi)
% ========================================================================
dm_list = 0.1:0.1:0.8;
tab1 = zeros(numel(dm_list), 7);
for i = 1:numel(dm_list)
    [th, iavg] = half_cycle_current(dm_list(i), 0, Vh, Vm, L, Ts, Nsw, Nsub);
    [I1, Ih, thd, irms] = harmonics_from_half(th, iavg, H_MAX);
    tab1(i,:) = [dm_list(i), I1, Ih(3), Ih(5), Ih(7), Ih(9), 100*Ih(3)/I1];
end
T1 = array2table(tab1, 'VariableNames', ...
    {'dm','I1_A','I3_A','I5_A','I7_A','I9_A','I3_over_I1_pct'});
writetable(T1, fullfile(out_dir, 'saf_sinus_dcm_harmonikleri.csv'));
fprintf('Saf sinus taramasi: I3/I1 orani %.2f%% - %.2f%% araliginda.\n', ...
    min(tab1(:,7)), max(tab1(:,7)));

% ========================================================================
% 2) (D1, D3) katsayi taramasi - dogru ozdeslikle
% ========================================================================
D1_list = 0.10:0.01:0.60;
D3_list = -0.20:0.01:0.60;
n1 = numel(D1_list); n3 = numel(D3_list);
RATIO = nan(n3, n1); THD = nan(n3, n1); I1M = nan(n3, n1);
IRMS = nan(n3, n1); DMAX = nan(n3, n1); CLIP = false(n3, n1);
for a = 1:n1
    for b = 1:n3
        [th, iavg, dmx, clp] = half_cycle_current(D1_list(a), D3_list(b), Vh, Vm, L, Ts, Nsw, Nsub);
        [I1, Ih, thd, irms] = harmonics_from_half(th, iavg, H_MAX);
        RATIO(b,a) = 100*Ih(3)/max(I1,1e-12);
        THD(b,a) = thd; I1M(b,a) = I1; IRMS(b,a) = irms;
        DMAX(b,a) = dmx; CLIP(b,a) = clp;
    end
end

% Uzun bicimli CSV
[D1g, D3g] = meshgrid(D1_list, D3_list);
Tscan = table(D1g(:), D3g(:), I1M(:), IRMS(:), RATIO(:), THD(:), DMAX(:), CLIP(:), ...
    'VariableNames', {'D1','D3','I1_A','Irms_A','I3_over_I1_pct','THD_pct','d_max','clipped'});
writetable(Tscan, fullfile(out_dir, 'katsayi_taramasi.csv'));

% Kisit: Excel dusuk guc noktasina uyum (Irms ~ 2.26 A) ve kirpilmamis gorev
feas = ~CLIP & IRMS >= 2.0 & IRMS <= 2.6;
RATIO_f = RATIO; RATIO_f(~feas) = NaN;
[best_ratio, idx] = min(RATIO_f(:));
[bb, ba] = ind2sub(size(RATIO_f), idx);
best = struct('D1', D1_list(ba), 'D3', D3_list(bb), ...
    'I1', I1M(bb,ba), 'Irms', IRMS(bb,ba), 'ratio', RATIO(bb,ba), ...
    'thd', THD(bb,ba), 'dmax', DMAX(bb,ba));
best.A1 = best.D1 + 0.75*best.D3; best.A3 = -0.25*best.D3;
fprintf(['En iyi kirpilmamis nokta (2.0<=Irms<=2.6 A): D1=%.2f, D3=%.2f ' ...
    '-> I3/I1=%.2f%%, THD=%.2f%%, Irms=%.3f A, dmax=%.3f\n'], ...
    best.D1, best.D3, best.ratio, best.thd, best.Irms, best.dmax);
fprintf('Esdeger dogrudan-harmonik katsayilari: A1=%.4f, A3=%.4f\n', best.A1, best.A3);

% Ilk 25 uygun aday
Tf = Tscan(~Tscan.clipped & Tscan.Irms_A>=2.0 & Tscan.Irms_A<=2.6, :);
Tf = sortrows(Tf, 'I3_over_I1_pct');
writetable(Tf(1:min(25,height(Tf)),:), fullfile(out_dir, 'en_iyi_adaylar.csv'));

% Eski tez aday noktalarinin dogru modelle kontrolu
old_pts = [0.45 0.37; 0.44 0.38; 0.41 0.41];
Told = zeros(size(old_pts,1), 6);
for i = 1:size(old_pts,1)
    [th, iavg] = half_cycle_current(old_pts(i,1), old_pts(i,2), Vh, Vm, L, Ts, Nsw, Nsub);
    [I1, Ih, thd, irms] = harmonics_from_half(th, iavg, H_MAX);
    Told(i,:) = [old_pts(i,:), I1, irms, 100*Ih(3)/I1, thd];
end
T3 = array2table(Told, 'VariableNames', {'D1','D3','I1_A','Irms_A','I3_over_I1_pct','THD_pct'});
writetable(T3, fullfile(out_dir, 'eski_aday_noktalarin_kontrolu.csv'));
disp(T3);

% ========================================================================
% 3) Grafikler
% ========================================================================
fig = figure('Visible','off','Position',[80 80 1250 520],'Color','w');
tiledlayout(fig, 1, 2, 'Padding', 'compact', 'TileSpacing', 'compact');

nexttile;
imagesc(D1_list, D3_list, min(RATIO, 60)); axis xy; hold on;
colormap(parula); cb = colorbar; cb.Label.String = 'I_3/I_1 (%)';
contour(D1_list, D3_list, RATIO, [5 5], 'w-', 'LineWidth', 1.4);
[rowF, colF] = find(feas);
plot(D1_list(colF), D3_list(rowF), '.', 'Color', [1 1 1 0.5], 'MarkerSize', 4);
plot(best.D1, best.D3, 'rp', 'MarkerSize', 14, 'MarkerFaceColor', 'r');
xlabel('D_1 (temel katsayi)'); ylabel('D_3 (sin^3 katsayisi)');
title(sprintf(['Ucuncu harmonik orani; beyaz: Irms uyumlu bolge, ' ...
    'yildiz: en iyi nokta (D_1=%.2f, D_3=%.2f)'], best.D1, best.D3));

nexttile;
% En iyi nokta ile saf sinusun dalga bicimi karsilastirmasi
[thA, iA] = half_cycle_current(best.D1, best.D3, Vh, Vm, L, Ts, Nsw, Nsub);
% saf sinus referansi: ayni temel bilesene en yakin dm
[~, idm] = min(abs(tab1(:,2) - best.I1));
[thB, iB] = half_cycle_current(dm_list(idm), 0, Vh, Vm, L, Ts, Nsw, Nsub);
plot(thA/pi, iA, 'b-', 'LineWidth', 1.3); hold on;
plot(thB/pi, iB, 'r--', 'LineWidth', 1.1);
plot(thA/pi, best.I1*sin(thA), 'k:', 'LineWidth', 1.0);
grid on; xlabel('\theta/\pi'); ylabel('Ortalama L_1 akimi (A)');
legend({sprintf('D_1=%.2f, D_3=%.2f (I_3/I_1=%.1f%%)', best.D1, best.D3, best.ratio), ...
    sprintf('Saf sinus d_m=%.2f (I_3/I_1=%.1f%%)', dm_list(idm), tab1(idm,7)), ...
    'Temel bilesen'}, 'Location', 'south');
title('Pozitif alternans ortalama akim zarfi');

exportgraphics(fig, fullfile(out_dir, 'sin3_katsayi_taramasi_20260901.png'), 'Resolution', 220);
exportgraphics(fig, fullfile(out_dir, 'sin3_katsayi_taramasi_20260901.pdf'), 'ContentType', 'vector');
savefig(fig, fullfile(out_dir, 'sin3_katsayi_taramasi_20260901.fig'));
close(fig);

% Ozet metni
fid = fopen(fullfile(out_dir, 'OZET.txt'), 'w');
fprintf(fid, 'sin3 rescan 20260901\n');
fprintf(fid, 'Parametreler: Vdc=%.1f V (Vh=%.2f), Vm=%.1f V, L=%g H, f0=%g Hz, fs=%g Hz\n', Vdc, Vh, Vm, L, f0, fs);
fprintf(fid, 'Saf sinus DCM taramasi I3/I1: %.2f%%..%.2f%%\n', min(tab1(:,7)), max(tab1(:,7)));
fprintf(fid, 'En iyi nokta: D1=%.2f D3=%.2f -> I3/I1=%.2f%%, THD=%.2f%%, I1=%.3f A, Irms=%.3f A, dmax=%.3f\n', ...
    best.D1, best.D3, best.ratio, best.thd, best.I1, best.Irms, best.dmax);
fprintf(fid, 'Esdeger (A1,A3)=(%.4f, %.4f); A1=D1+3D3/4, A3=-D3/4\n', best.A1, best.A3);
fclose(fid);

fprintf('DURUM: BASARILI - ciktilar %s\n', out_dir);
