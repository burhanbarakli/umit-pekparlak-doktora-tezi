% İP-6 (K-07, katman 3): ortalama model tahmini ile anahtarlamalı S4 ölçümünün
% karşılaştırılması.
%  1) Ton frekanslarında L, S, T, P (bitki), C, G_v = i_L1/v_inv ve etkin köprü kazancı
%     K_ef = v_inv/u_x: analitik (A) ↔ ortalama Simulink modeli (aynı tahminci) ↔
%     anahtarlamalı model (25 A K34 açık/kapalı, 10 A, 2,3 A)
%  2) Temel ve 3. harmonik (80 ms pencere, tonlara dik): K34 açık/kapalı farkı
%     anahtarlamalı ↔ ortalama (S(jω)·K_pwm·G·ΔU_ff tahmini)
%  3) 10 → 25 A basamağı: K34 açık (İP-5 KC_PI_basamak_10_25A) / kapalı (İP-6) ve ortalama
%     modelin iki karşılığı; geçici bileşen ve zarf
% Çıktı: runs/2026-10-28_kararlilik/karsilastirma/ (CSV + vektör PDF + 300 dpi PNG)
% Çağrı (proje kökünden): matlab -batch "addpath('scripts'); karsilastir_kararlilik_20261028"

root_dir = fileparts(fileparts(mfilename('fullpath')));
run_dir = fullfile(root_dir, 'runs', '2026-10-28_kararlilik');
out_dir = fullfile(run_dir, 'karsilastirma'); if ~exist(out_dir, 'dir'), mkdir(out_dir); end
KO = kararlilik_ortak_20261028(); p = KO.parametreler(root_dir);
G = KO.bitki(p, 0, 'tam');
CA = KO.denetleyiciler(p, 0);
an = @(k, f) squeeze(freqresp(CA{k}, 2*pi*f(:))).*p.Kpwm.*squeeze(freqresp(G(1, 1), 2*pi*f(:))) ...
    ./(1 + 1j*f(:)/p.f_lp).*exp(-1j*2*pi*f(:)*p.Td_A);
anP = @(f) p.Kpwm*squeeze(freqresp(G(1, 1), 2*pi*f(:)))./(1 + 1j*f(:)/p.f_lp).*exp(-1j*2*pi*f(:)*p.Td_A);
anG = @(f) squeeze(freqresp(G(1, 1), 2*pi*f(:)));
cidx = struct('P', 1, 'PI', 2, 'PIR', 3);

% ---- 1) ton ölçümleri -------------------------------------------------------------------------
kos = {   % etiket, tür (a: anahtarlamalı, o: ortalama), klasör/dosya, kip
    'ort 25 A K34', 'o', 'ort_PI25_K34_A', 'PI'
    'ort 25 A K34', 'o', 'ort_PI25_K34_B', 'PI'
    'ort 25 A K34=0', 'o', 'ort_PI25_K340_A', 'PI'
    'ort 10 A K34', 'o', 'ort_PI10_K34_A', 'PI'
    'anh 25 A K34', 'a', 'PI25_K34_A', 'PI'
    'anh 25 A K34', 'a', 'PI25_K34_B', 'PI'
    'anh 25 A K34=0', 'a', 'PI25_K340_A', 'PI'
    'anh 25 A K34=0', 'a', 'PI25_K340_B', 'PI'
    'anh 10 A K34', 'a', 'PI10_K34_A', 'PI'
    'anh 10 A K34', 'a', 'PI10_K34_B', 'PI'
    'anh 2,3 A K34', 'a', 'PI2p3_K34_A', 'PI'};
rows = {}; harm = {}; eksik = {};
for c = 1:size(kos, 1)
    if kos{c, 2} == 'o'
        fn = fullfile(run_dir, 'ortalama', [kos{c, 3} '.mat']);
    else
        fn = fullfile(run_dir, 'results', kos{c, 3}, 'olcum.mat');
    end
    if ~isfile(fn), eksik{end+1} = kos{c, 3}; continue, end %#ok<SAGROW>
    S = load(fn);
    o = S.olcum;
    if isfield(S, 'ton'), ton = S.ton; else, ton = S.opts.tonlar; end
    Tt = KO.ton_analizi(o, ton, p.Kpwm);
    k = cidx.(kos{c, 4});
    % belirsizlik: tona komşu, harmonik ve ton olmayan ızgara noktalarındaki u_x düzeyi
    % (d = 0 olduğundan orada u_x = u_fb: anahtarlama/kip dönüşümü kaynaklı arka plan n).
    % L = -U_fb/U_x için göreli belirsizlik δ ≈ n/|U_x| + n/|U_fb|.
    ph1 = @(sg, ff) 2*mean(sg(:).*exp(-1j*2*pi*ff*o.t(:)));
    nbg = zeros(numel(ton), 1); dl = zeros(numel(ton), 1);
    for q = 1:numel(ton)
        fb = ton(q) + 12.5*[-3 -1 1 3]; fb = fb(mod(round(fb/12.5), 4) ~= 0 & ~ismember(round(fb*10), round(ton*10)));
        nbg(q) = sqrt(mean(abs(arrayfun(@(ff) ph1(o.u_x, ff), fb)).^2));
        dl(q) = nbg(q)/Tt.UX(q) + nbg(q)/abs(complex(Tt.L_re(q), Tt.L_im(q))*Tt.UX(q));
    end
    La = an(k, ton); Pa = anP(ton); Ga = anG(ton);
    for q = 1:numel(ton)
        Lm = complex(Tt.L_re(q), Tt.L_im(q)); Pm = complex(Tt.P_re(q), Tt.P_im(q));
        Cm = complex(Tt.C_re(q), Tt.C_im(q)); Ca = squeeze(freqresp(CA{k}, 2*pi*ton(q)));
        Sm = complex(Tt.S_re(q), Tt.S_im(q)); Kef = complex(Tt.Kef_re(q), Tt.Kef_im(q));
        Gvm = Pm*(1 + 1j*ton(q)/p.f_lp)/Kef;          % i_L1 / v_inv (ölçüm süzgeci çıkarılmış)
        rows(end+1, :) = {kos{c, 1}, kos{c, 3}, ton(q), Tt.D(q), Tt.YM_A(q), ...
            20*log10(abs(La(q))), angle(La(q))*180/pi, 20*log10(abs(Lm)), angle(Lm)*180/pi, ...
            20*log10(abs(Lm/La(q))), wrap(angle(Lm/La(q))*180/pi), ...
            20*log10(abs(Sm)), 20*log10(abs(1/(1 + La(q)))), ...
            abs(Pm/Pa(q)), wrap(angle(Pm/Pa(q))*180/pi), abs(Cm/Ca), wrap(angle(Cm/Ca)*180/pi), ...
            abs(Kef), wrap(angle(Kef)*180/pi), abs(Kef)/p.Kpwm, abs(Gvm/Ga(q)), wrap(angle(Gvm/Ga(q))*180/pi), ...
            nbg(q), 20*log10(1 + dl(q)), asind(min(dl(q), 1))}; %#ok<SAGROW>
    end
    % temel ve 3. harmonik, 80 ms pencere (tonlara dik)
    ph = @(s, h) 2*mean(s(:).*exp(-1j*2*pi*50*h*o.t(:)));
    I1 = ph(o.iL1, 1); I3 = ph(o.iL1, 3); R1 = ph(o.i_ref, 1);
    harm(end+1, :) = {kos{c, 1}, kos{c, 3}, abs(I1)/sqrt(2), 100*(abs(I1)/abs(R1) - 1), angle(I1/R1)*180/pi, ...
        real(I1), imag(I1), abs(I3)/sqrt(2), angle(I3)*180/pi, real(I3), imag(I3), max(abs(o.u_top))}; %#ok<SAGROW>
end
TT = cell2table(rows, 'VariableNames', {'kosu', 'kaynak', 'f_Hz', 'D', 'YM_A', 'L_analitik_dB', 'L_analitik_deg', ...
    'L_olcum_dB', 'L_olcum_deg', 'dL_dB', 'dL_deg', 'S_olcum_dB', 'S_analitik_dB', 'P_oran', 'P_faz_farki_deg', ...
    'C_oran', 'C_faz_farki_deg', 'Kef_V', 'Kef_deg', 'Kef_bolu_Kpwm', 'Gv_oran', 'Gv_faz_farki_deg', ...
    'arka_plan_ux', 'belirsizlik_dB', 'belirsizlik_deg'});
writetable(TT, fullfile(out_dir, 'ton_karsilastirma.csv'));
HT = cell2table(harm, 'VariableNames', {'kosu', 'kaynak', 'IL1_1_rms_A', 'genlik_hatasi_pct', 'faz_hatasi_deg', ...
    'I1_re', 'I1_im', 'IL1_3_rms_A', 'I3_faz_deg', 'I3_re', 'I3_im', 'u_top_max'});
writetable(HT, fullfile(out_dir, 'harmonik_80ms.csv'));
disp(TT(:, {'kosu', 'f_Hz', 'L_analitik_dB', 'L_olcum_dB', 'dL_dB', 'dL_deg', 'belirsizlik_dB', 'belirsizlik_deg', 'P_oran', 'P_faz_farki_deg', 'C_oran', 'Kef_bolu_Kpwm', 'Kef_deg', 'Gv_oran', 'Gv_faz_farki_deg'}));
disp(HT);
if ~isempty(eksik), fprintf('eksik kosular: %s\n', strjoin(eksik, ', ')); end

% K34 açık/kapalı farkı: anahtarlamalı ↔ ortalama (kesin doğrusal tahmin)
dh = {};
pairs = {'PI25_K34_A', 'PI25_K340_A', 'ort_PI25_K34_A', 'ort_PI25_K340_A'};
ia = find(strcmp(HT.kaynak, pairs{1})); ib = find(strcmp(HT.kaynak, pairs{2}));
oa = find(strcmp(HT.kaynak, pairs{3})); ob = find(strcmp(HT.kaynak, pairs{4}));
if ~isempty(ia) && ~isempty(ib) && ~isempty(oa) && ~isempty(ob)
    for h = [1 3]
        if h == 1, re = 'I1_re'; im = 'I1_im'; else, re = 'I3_re'; im = 'I3_im'; end
        dsw = complex(HT.(re)(ia) - HT.(re)(ib), HT.(im)(ia) - HT.(im)(ib));
        dav = complex(HT.(re)(oa) - HT.(re)(ob), HT.(im)(oa) - HT.(im)(ob));
        dh(end+1, :) = {h, abs(dsw)/sqrt(2), angle(dsw)*180/pi, abs(dav)/sqrt(2), angle(dav)*180/pi, ...
            100*(abs(dsw)/abs(dav) - 1), wrap(angle(dsw/dav)*180/pi)}; %#ok<SAGROW>
    end
    DH = cell2table(dh, 'VariableNames', {'harmonik', 'dI_anahtarlamali_rms_A', 'dI_anahtarlamali_faz_deg', ...
        'dI_ortalama_rms_A', 'dI_ortalama_faz_deg', 'genlik_farki_pct', 'faz_farki_deg'});
    writetable(DH, fullfile(out_dir, 'k34_harmonik_farki.csv'));
    disp(DH);
end

% ---- 2) şekil: L Bode, analitik + ölçüm noktaları -------------------------------------------------
fr = logspace(log10(100), log10(5000), 3000).';
LaC = an(2, fr);
fh = figure('Visible', 'off', 'Position', [100 100 820 640]);
tl = tiledlayout(fh, 2, 1, 'TileSpacing', 'compact');
ax1 = nexttile(tl); hold(ax1, 'on'); grid(ax1, 'on'); set(ax1, 'XScale', 'log');
ax2 = nexttile(tl); hold(ax2, 'on'); grid(ax2, 'on'); set(ax2, 'XScale', 'log');
semilogx(ax1, fr, 20*log10(abs(LaC)), 'k-', 'LineWidth', 1.3, 'DisplayName', 'analitik (ortalama model), PI');
semilogx(ax2, fr, angle(LaC)*180/pi, 'k-', 'LineWidth', 1.3, 'HandleVisibility', 'off');
mk = {'ort 25 A K34', 'o', [0.3 0.3 0.3]; 'anh 25 A K34', 's', [0 0.45 0.74]; 'anh 25 A K34=0', 'x', [0.85 0.33 0.1]; ...
    'anh 10 A K34', '^', [0.47 0.67 0.19]; 'anh 2,3 A K34', 'd', [0.49 0.18 0.56]};
etk = {'ortalama Simulink modeli, 25 A', 'anahtarlamalı, 25 A, K_{34} açık', 'anahtarlamalı, 25 A, K_{34} = 0', ...
    'anahtarlamalı, 10 A', 'anahtarlamalı, 2,3 A'};
for m = 1:size(mk, 1)
    s = strcmp(TT.kosu, mk{m, 1}); if ~any(s), continue, end
    semilogx(ax1, TT.f_Hz(s), TT.L_olcum_dB(s), mk{m, 2}, 'Color', mk{m, 3}, 'MarkerSize', 8, 'LineWidth', 1.3, 'DisplayName', etk{m});
    semilogx(ax2, TT.f_Hz(s), TT.L_olcum_deg(s), mk{m, 2}, 'Color', mk{m, 3}, 'MarkerSize', 8, 'LineWidth', 1.3, 'HandleVisibility', 'off');
end
yline(ax1, 0, 'k:', 'HandleVisibility', 'off'); yline(ax2, -180, 'k:', 'HandleVisibility', 'off');
ylabel(ax1, '|L| [dB]'); ylabel(ax2, '\angle L [°]'); xlabel(ax2, 'f [Hz]'); xlim(ax1, [100 5000]); xlim(ax2, [100 5000]);
legend(ax1, 'Location', 'southwest', 'FontSize', 8);
title(ax1, 'L(j\omega): ortalama model ve anahtarlamalı modelde enjeksiyon ölçümü (PI)');
kaydet(fh, out_dir, 'kararlilik_L_olcum_karsilastirma');

% ---- 3) basamak ---------------------------------------------------------------------------------
bs = {'anahtarlamalı, K_{34} açık', fullfile(root_dir, 'runs', '2026-10-28_s4_kapali_cevrim', 'results', 'KC_PI_basamak_10_25A', 'dalga.mat')
    'anahtarlamalı, K_{34} = 0', fullfile(run_dir, 'results', 'PI_basamak_10_25A_K340', 'olcum.mat')
    'ortalama, K_{34} açık', fullfile(run_dir, 'ortalama', 'ort_PI_basamak_K34.mat')
    'ortalama, K_{34} = 0', fullfile(run_dir, 'ortalama', 'ort_PI_basamak_K340.mat')};
ts = 0.055; Tg = 0.02; brow = {}; tr = {};
for c = 1:size(bs, 1)
    if ~isfile(bs{c, 2}), continue, end
    S = load(bs{c, 2}); u = S.tum;
    t = u.t(:); x = u.iL1_avg(:); r = u.i_ref(:);
    dt = median(diff(t));
    % geçici bileşen: x(t) - x(t + 20 ms) (son durum periyodik); t ∈ [ts, t_end - 20 ms)
    m0 = t >= ts & t < t(end) - Tg - dt/2;
    xs = interp1(t, x, t(m0) + Tg);
    tr{end+1} = [t(m0) - ts, x(m0) - xs]; %#ok<SAGROW>
    % yarım periyot tepe zarfı
    nh = floor((t(end) - ts)/(Tg/2)); pk = nan(nh, 1);
    for q = 1:nh, b = t >= ts + (q - 1)*Tg/2 & t < ts + q*Tg/2; pk(q) = max(abs(x(b))); end
    b0 = t >= ts - Tg & t < ts; pk0 = max(abs(x(b0)));
    e = r - x; wl = t >= t(end) - Tg; band = max(abs(e(wl))) + 0.02*sqrt(2)*25;
    kk = find(t >= ts & abs(e) > band, 1, 'last');
    brow(end+1, :) = {bs{c, 1}, pk0, pk(end), 100*(max(pk(1:2)) - pk(end))/pk(end), ...
        1e3*(t(kk) - ts), mat2str(pk.', 4)}; %#ok<SAGROW>
end
if ~isempty(brow)
    BT = cell2table(brow, 'VariableNames', {'kosu', 'zarf_once_A', 'zarf_son_A', 'zarf_asim_pct', 'yerlesme_hata_ms', 'zarf_tepeleri_A'});
    writetable(BT, fullfile(out_dir, 'basamak_karsilastirma.csv')); disp(BT);
    % geçici bileşenler arası fark (ilk 15 ms), basamak genliğine göre
    if numel(tr) == 4
        dr = {}; eslek = [3 4 3 4];
        for c = 1:4
            ref = tr{eslek(c)};
            a = tr{c}; s = a(:, 1) >= 0 & a(:, 1) < 0.015;
            ai = interp1(ref(:, 1), ref(:, 2), a(s, 1), 'linear', 'extrap');
            dr(end+1, :) = {bs{c, 1}, max(abs(a(s, 2))), rms(a(s, 2) - ai), 100*rms(a(s, 2) - ai)/(sqrt(2)*15)}; %#ok<SAGROW>
        end
        s1 = tr{1}(:, 1) >= 0 & tr{1}(:, 1) < 0.015; a2 = interp1(tr{2}(:, 1), tr{2}(:, 2), tr{1}(s1, 1), 'linear', 'extrap');
        dr(end+1, :) = {'anahtarlamalı açık - kapalı', NaN, rms(tr{1}(s1, 2) - a2), 100*rms(tr{1}(s1, 2) - a2)/(sqrt(2)*15)};
        writetable(cell2table(dr, 'VariableNames', {'kosu', 'gecici_tepe_A', 'rms_fark_ayni_K34_ortalamaya_gore_A', ...
            'rms_fark_basamak_tepesine_gore_pct'}), fullfile(out_dir, 'basamak_gecici_fark.csv'));
        disp(cell2table(dr));
    end
    fh = figure('Visible', 'off', 'Position', [100 100 820 600]);
    tl = tiledlayout(fh, 2, 1, 'TileSpacing', 'compact');
    ax = nexttile(tl); hold(ax, 'on'); grid(ax, 'on');
    st = {'-', '--', '-', ':'}; cc = {[0 0.45 0.74], [0.85 0.33 0.1], [0 0 0], [0.5 0.5 0.5]};
    for c = 1:size(bs, 1)
        if ~isfile(bs{c, 2}), continue, end
        S = load(bs{c, 2}); u = S.tum; sel = u.t >= ts - 0.01 & u.t <= ts + 0.03;
        plot(ax, 1e3*(u.t(sel) - ts), u.iL1_avg(sel), st{c}, 'Color', cc{c}, 'LineWidth', 1.1, 'DisplayName', bs{c, 1});
    end
    ylabel(ax, 'i_{L1} (periyot ortalaması) [A]'); legend(ax, 'Location', 'southwest', 'FontSize', 8);
    title(ax, 'PI, 10 \rightarrow 25 A basamağı (t = 55 ms)');
    ax = nexttile(tl); hold(ax, 'on'); grid(ax, 'on');
    for c = 1:numel(tr)
        plot(ax, 1e3*tr{c}(:, 1), tr{c}(:, 2), st{c}, 'Color', cc{c}, 'LineWidth', 1.1);
    end
    xlim(ax, [-10 30]); xlabel(ax, 't - t_{basamak} [ms]'); ylabel(ax, 'geçici bileşen [A]');
    title(ax, 'Geçici bileşen i_{L1}(t) - i_{L1}(t + 20 ms)');
    kaydet(fh, out_dir, 'kararlilik_basamak_K34');
end

function d = wrap(d)
d = mod(d + 180, 360) - 180;
end

function kaydet(fh, d, ad)
exportgraphics(fh, fullfile(d, [ad '.pdf']), 'ContentType', 'vector');
exportgraphics(fh, fullfile(d, [ad '.png']), 'Resolution', 300);
close(fh);
end
