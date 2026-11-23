% İP-6 (K-07, katman 1–2): S4 akım denetiminin frekans alanı kararlılık analizi.
% Ortalama (anahtarlamasız) model; Simulink koşturmaz (~1 dk).
%
%   L(s) = C(s) · K_pwm · e^{-s Td} · G(s) · H_m(s)     (geri besleme yolu)
%   u    = u_ff + u_fb,  u_ff = K14 sin(θ+φ4) + K34 sin³(θ+φ4)   (dış giriş, K-06a)
%   i_L1 = [K_pwm e^{-sTd} G (u_ff + C i_ref) + G_g v_g] / (1 + L)
% Sin³ terimi yalnız sağ taraftaki dış girişi değiştirir; 1 + L = 0 K34'ten bağımsızdır.
% Bu betik bunu ayrıca connect() + AnalysisPoint ile K34 açık/kapalı iki ara bağlantı
% modelinden sayısal olarak gösterir.
%
% Gerçeklemeler:
%   (A)  modeldeki analog eşdeğeri (K-19): sürekli C, 5 kHz ölçüm süzgeci, Td = 2 µs
%   (Ad) aynı yapının 1 µs ayrık karşılığı (modeldeki bloklarla aynı: ileri Euler
%        integratör, ön bükmeli Tustin rezonans, ayrık süzgeç, 1 örnek gecikme)
%   (B)  sayısal gerçekleme: Ts = 100 µs, periyot ortalaması örnekleme, 1 Ts hesaplama
%        gecikmesi, ZOH (İP-5 tasarım betiğindeki tanım)
%   (B2) bilgi için: çift güncelleme, Ts = 50 µs, aynı yapı
% Çıktı: runs/2026-10-28_kararlilik/frekans/ (CSV + vektör PDF + 300 dpi PNG)
% Çağrı (proje kökünden): matlab -batch "addpath('scripts'); analiz_kararlilik_20261028"

root_dir = 'C:/CODES/ümit abi/tez-matlab-simulink';
out_dir = 'C:/CODES/ümit abi/tez-matlab-simulink/results/bolum5_sekiller_20261117/kararlilik';
if ~exist(out_dir, 'dir'), mkdir(out_dir); end
KO = kararlilik_ortak_20261028();
p = KO.parametreler(root_dir);
cn = {'P', 'PI', 'PIR'};
f = logspace(0, log10(5e4), 30000).'; w = 2*pi*f;
fid_log = fopen(fullfile(out_dir, 'analiz_gunlugu.txt'), 'w', 'n', 'UTF-8');
logf = @(varargin) fprintf(fid_log, varargin{:});
logf('analiz_kararlilik_20261028 — %s — %s\n', char(datetime('now')), version);
logf('Kpwm = %.3f V, Td(A) = %.1f us, f_lp = %.0f Hz, Kp = %.3f, Ki = %.4f, Kr = %.3f, wb = %.3f\n', ...
    p.Kpwm, 1e6*p.Td_A, p.f_lp, p.Kp, p.Ki, p.Kr, p.wb);

% ---- 0) bitki: tam/toplu varyant ve İP-5 empedans formülüyle çapraz denetim ---------------
Gt = KO.bitki(p, 0, 'tam'); Gl = KO.bitki(p, 0, 'toplu');
Gtw = squeeze(freqresp(Gt(1, 1), w)); Glw = squeeze(freqresp(Gl(1, 1), w));
Gzw = KO.empedans_G(p, f, 0);
sel10k = f <= 1e4;
d_tl = max(abs(Gtw(sel10k)./Glw(sel10k) - 1)); d_lz = max(abs(Glw./Gzw - 1));
fr = @(G) sort(abs(eig(G.A))/2/pi);
logf('bitki: max|G_tam/G_toplu - 1| (f<=10 kHz) = %.3g; max|G_toplu/G_empedans - 1| = %.3g\n', d_tl, d_lz);
pr = eig(Gt.A); pr = pr(imag(pr) > 0); zr = tzero(Gt(1, 1)); zr = zr(imag(zr) > 0);
logf('G_tam kutuplari (ust yari) f_n [Hz]: %s; zeta: %s\n', mat2str(abs(pr).'/2/pi, 5), mat2str(-real(pr).'./abs(pr).', 3));
logf('G_tam sifirlari (ust yari) f_n [Hz]: %s; zeta: %s\n', mat2str(abs(zr).'/2/pi, 5), mat2str(-real(zr).'./abs(zr).', 3));
G = Gt;          % bundan sonra tam varyant
Gw = Gtw;

% ---- 1) gerçeklemeler ---------------------------------------------------------------------
Hm = tf(1, [1/(2*pi*p.f_lp), 1]);
Dl = pade(tf(1, 1, 'InputDelay', p.Td_A), 2);
CA = KO.denetleyiciler(p, 0);
Hmw = 1 ./ (1 + 1j*w/(2*pi*p.f_lp)); Dw = exp(-1j*w*p.Td_A);
% (Ad): 1 µs
Tc = p.Ts_c;
Pd = c2d(p.Kpwm*G(1, 1), Tc, 'zoh'); Hd = tf(1 - p.lp_a, [1, -p.lp_a], Tc); zd = tf([0 1], [1 0], Tc);  % z^-1
CAd = KO.denetleyiciler(p, Tc);
% (B), (B2)
mkB = @(Ts) minreal(tf([1 -1], [1 0], Ts)/Ts * c2d(p.Kpwm*G(1, 1)*tf(1, [1 0]), Ts, 'zoh') * tf([0 1], [1 0], Ts), 1e-7);
TsB = 1/p.fsw; TsB2 = 0.5/p.fsw;
PB = mkB(TsB); PB2 = mkB(TsB2);
CB = KO.denetleyiciler(p, TsB); CB2 = KO.denetleyiciler(p, TsB2);

% ---- 2) K34 açık/kapalı: ara bağlantı modelleri ve AnalysisPoint ----------------------------
% Bloklar: C (e -> u_fb), u_x = u_fb (çevrim açma noktası), u = u_x + u_ff,
% u_ff = K14 s1 + K34 s3 (s1 = sin, s3 = sin³: dış işaretler), v = K_pwm e^{-sTd} u,
% [i_L1; i2; vb] = G [v; v_g], y_m = H_m i_L1, e = i_ref - y_m
ara = cell(3, 2); Lon = cell(3, 1); dmax = zeros(3, 3);
for k = 1:3
    for q = 1:2
        K34q = p.K34*(q == 1);
        Cb = CA{k}; Cb.InputName = 'e'; Cb.OutputName = 'u_fb';
        Ff = ss([p.K14, K34q]); Ff.InputName = {'s1', 's3'}; Ff.OutputName = 'u_ff';
        Akt = p.Kpwm*Dl; Akt.InputName = 'u'; Akt.OutputName = 'v';
        Gb = G; Gb.InputName = {'v', 'vg'}; Gb.OutputName = {'iL1', 'i2', 'vb'};
        Hb = Hm; Hb.InputName = 'iL1'; Hb.OutputName = 'ym';
        S1 = sumblk('u = u_fb + u_ff'); S2 = sumblk('e = i_ref - ym');
        sys = connect(Cb, Ff, Akt, Gb, Hb, S1, S2, {'i_ref', 's1', 's3', 'vg'}, {'iL1', 'u_fb', 'e'}, {'u_fb'});
        ara{k, q} = sys;
    end
    L1 = getLoopTransfer(ara{k, 1}, 'u_fb', -1); L0 = getLoopTransfer(ara{k, 2}, 'u_fb', -1);
    S1w = squeeze(freqresp(getSensitivity(ara{k, 1}, 'u_fb'), w)); S0w = squeeze(freqresp(getSensitivity(ara{k, 2}, 'u_fb'), w));
    T1w = squeeze(freqresp(getCompSensitivity(ara{k, 1}, 'u_fb'), w)); T0w = squeeze(freqresp(getCompSensitivity(ara{k, 2}, 'u_fb'), w));
    L1w = squeeze(freqresp(L1, w)); L0w = squeeze(freqresp(L0, w));
    dmax(k, :) = [max(abs(L1w - L0w)./abs(L1w)), max(abs(S1w - S0w)./abs(S1w)), max(abs(T1w - T0w)./abs(T1w))];
    Lon{k} = L1;
    % kutupların eşitliği
    pc1 = pole(ara{k, 1}); pc0 = pole(ara{k, 2});
    logf('%s: K34 acik/kapali max goreli fark |dL|/|L| = %.3g, |dS|/|S| = %.3g, |dT|/|T| = %.3g; kapali cevrim kutuplari ayni: %d (max fark %.3g 1/s)\n', ...
        cn{k}, dmax(k, 1), dmax(k, 2), dmax(k, 3), isequal(numel(pc1), numel(pc0)), max(abs(sort(pc1) - sort(pc0))));
end
writetable(table(string(cn.'), dmax(:, 1), dmax(:, 2), dmax(:, 3), 'VariableNames', ...
    {'denetleyici', 'max_rel_dL', 'max_rel_dS', 'max_rel_dT'}), fullfile(out_dir, 'k34_degismezlik.csv'));

% ---- 3) marjlar ve kutuplar ----------------------------------------------------------------
impl = {'A', 'Ad', 'B', 'B2'};
mrows = {}; grows = {}; KT = table();
LwA = cell(3, 1); SwA = cell(3, 1); TwA = cell(3, 1); TrefA = cell(3, 1);
for m = 1:numel(impl)
    for k = 1:3
        for q = 1:2   % K34 açık / kapalı
            K34q = p.K34*(q == 1);
            switch impl{m}
                case 'A'
                    Cw = squeeze(freqresp(CA{k}, w));
                    Lw = Cw.*p.Kpwm.*Gw.*Hmw.*Dw;                       % kesin gecikme
                    if q == 1   % ara bağlantı modelinden de aynı (K34 bağımsızlık kanıtı yukarıda)
                        Lchk = squeeze(freqresp(getLoopTransfer(ara{k, 1}, 'u_fb', -1), w));
                        logf('A %s: max|L_kesin - L_pade2|/|L| (f<=10 kHz) = %.3g\n', cn{k}, max(abs(Lw(sel10k) - Lchk(sel10k))./abs(Lw(sel10k))));
                    end
                    Lq = getLoopTransfer(ara{k, q}, 'u_fb', -1);
                    pl = pole(feedback(Lq, 1)); Ts = 0; fm = f;
                    crit = max(real(pl));
                    if q == 1
                        LwA{k} = Lw; SwA{k} = 1./(1 + Lw); TwA{k} = Lw./(1 + Lw);
                        TrefA{k} = Cw.*p.Kpwm.*Gw.*Dw./(1 + Lw);
                    end
                case 'Ad'
                    Ts = Tc; Lq = CAd{k}*Pd*Hd*zd;
                    fm = f(f < 0.5/Ts); Lw = squeeze(freqresp(Lq, 2*pi*fm));
                    pl = pole(feedback(Lq, 1)); crit = max(abs(pl));
                case {'B', 'B2'}
                    if strcmp(impl{m}, 'B'), Ts = TsB; Lq = CB{k}*PB; else, Ts = TsB2; Lq = CB2{k}*PB2; end
                    fm = f(f < 0.5/Ts); Lw = squeeze(freqresp(Lq, 2*pi*fm));
                    pl = pole(feedback(Lq, 1)); crit = max(abs(pl));
            end
            R = KO.marjlar(fm, Lw, Ts);
            if Ts == 0, kararli = crit < 0; else, kararli = crit < 1; end
            % açık çevrim kararsız kutup sayısı (Nyquist P)
            if Ts == 0, Pol = sum(real(pole(Lq)) > 1e-9); else, Pol = sum(abs(pole(Lq)) > 1 + 1e-9); end
            mrows(end+1, :) = {impl{m}, cn{k}, ternary(q == 1, 'acik', 'kapali'), K34q, Ts, numel(R.fc), ...
                jn('%.0f', R.fc), jn('%.1f', R.PM), R.PMmin, R.fPMmin, ...
                1e6*R.DMmin, jn('%.0f', R.f180), jn('%.1f', R.GM), ...
                R.GMup, R.GMdown, R.Smax_dB, R.fSmax, R.Tmax_dB, R.nyquist_net, Pol, crit, kararli}; %#ok<SAGROW>
            for g = 1:size(R.gecis, 1)
                grows(end+1, :) = {impl{m}, cn{k}, ternary(q == 1, 'acik', 'kapali'), ternary(R.gecis(g, 1) == 1, 'kazanc_gecisi', 'faz_gecisi'), ...
                    R.gecis(g, 2), R.gecis(g, 3), R.gecis(g, 4), R.gecis(g, 5), 1e6*R.gecis(g, 6)}; %#ok<SAGROW>
            end
            if q == 1
                if Ts == 0, fmax = 2e4; else, fmax = inf; end
                KT = [KT; KO.kutup_tablosu(pl, Ts, sprintf('%s_%s', impl{m}, cn{k}), fmax)]; %#ok<AGROW>
            end
        end
    end
end
MT = cell2table(mrows, 'VariableNames', {'gerceklesme', 'denetleyici', 'K34', 'K34_deger', 'Ts_s', 'n_kazanc_gecisi', ...
    'fc_Hz', 'PM_deg', 'PMmin_deg', 'f_PMmin_Hz', 'gecikme_marji_us', 'f180_Hz', 'GM_dB', 'GM_artis_dB', 'GM_azalis_dB', ...
    'Smax_dB', 'f_Smax_Hz', 'Tmax_dB', 'nyquist_net', 'P_acik_cevrim_kararsiz', 'kutup_olcutu', 'kararli'});
writetable(MT, fullfile(out_dir, 'kararlilik_marjlar.csv'));
writetable(cell2table(grows, 'VariableNames', {'gerceklesme', 'denetleyici', 'K34', 'tur', 'f_Hz', ...
    'faz_deg_ya_da_ReL', 'yon', 'PM_deg_ya_da_GM_dB', 'gecikme_marji_us'}), fullfile(out_dir, 'kararlilik_gecisler.csv'));
writetable(KT, fullfile(out_dir, 'kararlilik_kutuplar.csv'));

% ---- 4) Sin³'ün bozucu/referans tarafındaki etkisi (PI ve PIR, A) --------------------------
% Fazör kuralı x(t) = Im{X e^{jωt}}; i_ref = √2 I_ref sin θ, v_g = V_g sin θ, u_ff fazı φ4.
Gg = squeeze(freqresp(G(1, 2), w));
ph4 = p.phase_deg4*pi/180;
srows = {};
for k = 1:3
    for q = 1:2
        K34q = p.K34*(q == 1);
        for h = [1 3]
            wh = h*p.w0; ih = @(X) interp1(w, X, wh);
            Lh = ih(LwA{k}); Gh = ih(Gw); Ggh = ih(Gg); Dh = exp(-1j*wh*p.Td_A); Ch = ih(squeeze(freqresp(CA{k}, w)));
            if h == 1
                Uff = (p.K14 + 3*K34q/4)*exp(1j*ph4); Iref = sqrt(2)*p.Iref; Vg = p.Vg;
            else
                Uff = (-K34q/4)*exp(1j*3*ph4); Iref = 0; Vg = 0;
            end
            I_ol = p.Kpwm*Dh*Gh*Uff + Ggh*Vg;                     % çevrimsiz (S3 benzeri) akım
            I_cl = (p.Kpwm*Dh*Gh*(Uff + Ch*Iref) + Ggh*Vg)/(1 + Lh);
            U_fb = Ch*(Iref - I_cl*interp1(w, Hmw, wh));
            srows(end+1, :) = {cn{k}, ternary(q == 1, 'acik', 'kapali'), h, abs(1/(1 + Lh)), angle(1/(1 + Lh))*180/pi, ...
                abs(Uff), abs(p.Kpwm*Dh*Gh*Uff), abs(I_ol)/sqrt(2), abs(I_cl)/sqrt(2), angle(I_cl)*180/pi, ...
                100*(abs(I_cl)/(sqrt(2)*p.Iref) - 1)*(h == 1) + 100*abs(I_cl)/(sqrt(2)*p.Iref)*(h == 3), abs(U_fb)}; %#ok<SAGROW>
        end
    end
end
ST = cell2table(srows, 'VariableNames', {'denetleyici', 'K34', 'harmonik', 'absS', 'angS_deg', 'absUff', ...
    'Kpwm_G_Uff_Apk', 'I_cevrimsiz_rms_A', 'I_kapali_rms_A', 'I_kapali_faz_deg', 'hata_ya_da_oran_pct', 'absUfb'});
writetable(ST, fullfile(out_dir, 'sin3_bozucu_etkisi.csv'));

% ---- 5) L_g, kazanç (λ) ve gecikme taramaları ------------------------------------------------
Lgv = [0 0.5 1 2 5]*1e-3;
lrows = {};
for a = 1:numel(Lgv)
    Ga = KO.bitki(p, Lgv(a), 'tam'); Gaw = squeeze(freqresp(Ga(1, 1), w));
    pa = eig(Ga.A); pa = pa(imag(pa) > 1); za = tzero(Ga(1, 1)); za = za(imag(za) > 1);
    f_r = max(abs(pa(abs(pa) < 2*pi*2e4)))/2/pi; f_z = max(abs(za(abs(za) < 2*pi*2e4)))/2/pi;
    for k = 1:3
        Cw = squeeze(freqresp(CA{k}, w));
        Lw = Cw.*p.Kpwm.*Gaw.*Hmw.*Dw;
        R = KO.marjlar(f, Lw, 0);
        pl = pole(feedback(CA{k}*p.Kpwm*Ga(1, 1)*Hm*Dl, 1)); KTa = KO.kutup_tablosu(pl, 0, 'x', 2e4);
        PBa = minreal(tf([1 -1], [1 0], TsB)/TsB*c2d(p.Kpwm*Ga(1, 1)*tf(1, [1 0]), TsB, 'zoh')*tf([0 1], [1 0], TsB), 1e-7);
        plB = pole(feedback(CB{k}*PBa, 1));
        RB = KO.marjlar(f(f < 0.5/TsB), squeeze(freqresp(CB{k}*PBa, 2*pi*f(f < 0.5/TsB))), TsB);
        lrows(end+1, :) = {1e3*Lgv(a), cn{k}, f_r, f_z, jn('%.0f', R.fc), ...
            jn('%.1f', R.PM), R.PMmin, 1e6*R.DMmin, R.GMup, R.Smax_dB, R.nyquist_net, ...
            max(real(pl)), KTa.zeta(1), KTa.fn_Hz(1), max(abs(plB)), RB.nyquist_net}; %#ok<SAGROW>
    end
end
LGT = cell2table(lrows, 'VariableNames', {'Lg_mH', 'denetleyici', 'f_rez_Hz', 'f_antirez_Hz', 'fc_Hz', 'PM_deg', ...
    'PMmin_deg', 'gecikme_marji_us', 'GM_artis_dB', 'Smax_dB', 'nyquist_net_A', 'maxRe_A', 'zeta_min_A', ...
    'fn_zeta_min_Hz', 'max_abs_z_B', 'nyquist_net_B'});
writetable(LGT, fullfile(out_dir, 'lg_taramasi.csv'));
% kazanç ölçeği λ (köprünün etkin kazancı: süreksiz iletim, K-02b) ve gecikme Td, PI (A)
lam = [0.05 0.1 0.2 0.3 0.5 0.7 1 1.5 2 5 10 20 50 60 100];
krows = {};
for a = 1:numel(lam)
    for k = 1:3
        Lw = lam(a)*LwA{k}; R = KO.marjlar(f, Lw, 0);
        pl = pole(feedback(lam(a)*CA{k}*p.Kpwm*G(1, 1)*Hm*Dl, 1));
        KTa = KO.kutup_tablosu(pl, 0, 'x', 2e4);
        krows(end+1, :) = {lam(a), cn{k}, jn('%.0f', R.fc), jn('%.1f', R.PM), ...
            R.PMmin, R.Smax_dB, R.nyquist_net, max(real(pl)), KTa.zeta(1), KTa.fn_Hz(1)}; %#ok<SAGROW>
    end
end
writetable(cell2table(krows, 'VariableNames', {'lambda', 'denetleyici', 'fc_Hz', 'PM_deg', 'PMmin_deg', 'Smax_dB', ...
    'nyquist_net', 'maxRe', 'zeta_min', 'fn_zeta_min_Hz'}), fullfile(out_dir, 'kazanc_taramasi.csv'));
Tdv = [0 1 2 5 10 20 30 40 45 50 60 75 100 150]*1e-6;
drows = {};
for a = 1:numel(Tdv)
    for k = 1:3
        Cw = squeeze(freqresp(CA{k}, w));
        Lw = Cw.*p.Kpwm.*Gw.*Hmw.*exp(-1j*w*Tdv(a)); R = KO.marjlar(f, Lw, 0);
        if Tdv(a) > 0, Dla = pade(tf(1, 1, 'InputDelay', Tdv(a)), 6); else, Dla = tf(1); end
        pl = pole(feedback(CA{k}*p.Kpwm*G(1, 1)*Hm*Dla, 1)); pl = pl(abs(pl) < 2*pi*3e4);
        drows(end+1, :) = {1e6*Tdv(a), cn{k}, jn('%.0f', R.fc), jn('%.1f', R.PM), ...
            R.PMmin, R.Smax_dB, R.nyquist_net, max(real(pl))}; %#ok<SAGROW>
    end
end
writetable(cell2table(drows, 'VariableNames', {'Td_us', 'denetleyici', 'fc_Hz', 'PM_deg', 'PMmin_deg', 'Smax_dB', ...
    'nyquist_net', 'maxRe_pade6'}), fullfile(out_dir, 'gecikme_taramasi.csv'));

% ---- 6) Bode verisi ve şekiller ---------------------------------------------------------------
BT = table(f, 'VariableNames', {'f_Hz'});
for k = 1:3
    BT.(['L_dB_' cn{k}]) = 20*log10(abs(LwA{k})); BT.(['L_deg_' cn{k}]) = angle(LwA{k})*180/pi;
    BT.(['S_dB_' cn{k}]) = 20*log10(abs(SwA{k})); BT.(['T_dB_' cn{k}]) = 20*log10(abs(TwA{k}));
    BT.(['Tref_dB_' cn{k}]) = 20*log10(abs(TrefA{k}));
end
BT.G_dB = 20*log10(abs(Gw)); BT.G_deg = angle(Gw)*180/pi;
writetable(BT(1:10:end, :), fullfile(out_dir, 'bode_L_S_T_A.csv'));
save(fullfile(out_dir, 'frekans_verisi.mat'), 'f', 'LwA', 'SwA', 'TwA', 'TrefA', 'Gw', 'p', 'MT', 'ST');

renk = lines(3);
% Şekil 1: L Bode, K34 açık (düz) / kapalı (kesikli işaretçi)
fh = figure('Visible', 'off', 'Position', [100 100 820 640]);
tl = tiledlayout(fh, 2, 1, 'TileSpacing', 'compact');
ax1 = nexttile(tl); hold(ax1, 'on'); grid(ax1, 'on'); set(ax1, 'XScale', 'log');
ax2 = nexttile(tl); hold(ax2, 'on'); grid(ax2, 'on'); set(ax2, 'XScale', 'log');
for k = 1:3
    L0w = squeeze(freqresp(getLoopTransfer(ara{k, 2}, 'u_fb', -1), w));
    semilogx(ax1, f, 20*log10(abs(LwA{k})), '-', 'Color', renk(k, :), 'LineWidth', 1.3, 'DisplayName', [cn{k} ', K_{34} açık']);
    ii = 301:600:numel(f);
    semilogx(ax1, f(ii), 20*log10(abs(L0w(ii))), 'o', 'Color', renk(k, :), 'MarkerSize', 4, 'DisplayName', [cn{k} ', K_{34} = 0']);
    semilogx(ax2, f, unwrap(angle(LwA{k}))*180/pi, '-', 'Color', renk(k, :), 'LineWidth', 1.3, 'HandleVisibility', 'off');
    ph0 = unwrap(angle(L0w))*180/pi; semilogx(ax2, f(ii), ph0(ii), 'o', 'Color', renk(k, :), 'MarkerSize', 4, 'HandleVisibility', 'off');
end
yline(ax1, 0, 'k:', 'HandleVisibility', 'off'); yline(ax2, -180, 'k:', 'HandleVisibility', 'off'); yline(ax2, 180, 'k:', 'HandleVisibility', 'off');
xlim(ax1, [1 5e4]); xlim(ax2, [1 5e4]); ylim(ax1, [-60 80]);
ylabel(ax1, '|L| (dB)'); ylabel(ax2, 'Faz (°)'); xlabel(ax2, 'Frekans (Hz)');
legend(ax1, 'Location', 'southwest', 'NumColumns', 2, 'FontSize', 8);

kaydet(fh, out_dir, 'kararlilik_L_bode_K34');
% Şekil 2: S ve T
fh = figure('Visible', 'off', 'Position', [100 100 820 520]);
ax = axes(fh); hold(ax, 'on'); grid(ax, 'on'); set(ax, 'XScale', 'log');
for k = 1:3
    semilogx(ax, f, 20*log10(abs(SwA{k})), '-', 'Color', renk(k, :), 'LineWidth', 1.3, 'DisplayName', ['|S|, ' cn{k}]);
    semilogx(ax, f, 20*log10(abs(TwA{k})), '--', 'Color', renk(k, :), 'LineWidth', 1.1, 'DisplayName', ['|T|, ' cn{k}]);
    L0w = squeeze(freqresp(getLoopTransfer(ara{k, 2}, 'u_fb', -1), w)); ii = 301:600:numel(f);
    semilogx(ax, f(ii), 20*log10(abs(1./(1 + L0w(ii)))), 'o', 'Color', renk(k, :), 'MarkerSize', 4, 'HandleVisibility', 'off');
    semilogx(ax, f(ii), 20*log10(abs(L0w(ii)./(1 + L0w(ii)))), 'o', 'Color', renk(k, :), 'MarkerSize', 4, 'HandleVisibility', 'off');
end
plot(ax, NaN, NaN, 'ko', 'MarkerSize', 4, 'DisplayName', 'K_{34} = 0'); xline(ax, 50, 'k:', '50 Hz', 'HandleVisibility', 'off'); xline(ax, 150, 'k:', '150 Hz', 'HandleVisibility', 'off');
xlim(ax, [1 5e4]); ylim(ax, [-60 15]); xlabel(ax, 'Frekans (Hz)'); ylabel(ax, 'Büyüklük (dB)');
legend(ax, 'Location', 'southeast', 'NumColumns', 3, 'FontSize', 8);

kaydet(fh, out_dir, 'kararlilik_S_T');
% Şekil 3: Nyquist (A ve B, PI) -1 çevresi
fh = figure('Visible', 'off', 'Position', [100 100 900 420]);
tl = tiledlayout(fh, 1, 2, 'TileSpacing', 'compact');
ax = nexttile(tl); hold(ax, 'on'); grid(ax, 'on'); axis(ax, 'equal');
for k = 1:3, plot(ax, real(LwA{k}), imag(LwA{k}), 'Color', renk(k, :), 'DisplayName', cn{k}); plot(ax, real(LwA{k}), -imag(LwA{k}), ':', 'Color', renk(k, :), 'HandleVisibility', 'off'); end
plot(ax, -1, 0, 'k+', 'MarkerSize', 10, 'LineWidth', 1.5, 'HandleVisibility', 'off');
th = linspace(0, 2*pi, 200); plot(ax, cos(th), sin(th), 'k:', 'HandleVisibility', 'off');
xlim(ax, [-3 2]); ylim(ax, [-3 3]); title(ax, {'(A) analog eşdeğer', 'T_d = 2 µs'}); xlabel(ax, 'Re L'); ylabel(ax, 'Im L'); legend(ax, 'Location', 'southeast');
ax = nexttile(tl); hold(ax, 'on'); grid(ax, 'on'); axis(ax, 'equal');
fB = f(f < 0.5/TsB);
for k = 1:3
    LB = squeeze(freqresp(CB{k}*PB, 2*pi*fB));
    plot(ax, real(LB), imag(LB), 'Color', renk(k, :), 'DisplayName', cn{k}); plot(ax, real(LB), -imag(LB), ':', 'Color', renk(k, :), 'HandleVisibility', 'off');
end
plot(ax, -1, 0, 'k+', 'MarkerSize', 10, 'LineWidth', 1.5, 'HandleVisibility', 'off'); plot(ax, cos(th), sin(th), 'k:', 'HandleVisibility', 'off');
xlim(ax, [-3 2]); ylim(ax, [-3 3]); title(ax, {'(B) sayısal, T_s = 100 µs', '1T_s hesaplama gecikmesi (toplam \approx 2T_s)'}); xlabel(ax, 'Re L'); legend(ax, 'Location', 'southeast');
kaydet(fh, out_dir, 'kararlilik_nyquist_A_B');
% Şekil 4: kutup haritası
fh = figure('Visible', 'off', 'Position', [100 100 900 420]);
tl = tiledlayout(fh, 1, 2, 'TileSpacing', 'compact');
ax = nexttile(tl); hold(ax, 'on'); grid(ax, 'on');
for k = 1:3
    pl = pole(feedback(Lon{k}, 1)); pl = pl(abs(pl) < 2*pi*2e4);
    plot(ax, real(pl), imag(pl)/2/pi, 'x', 'Color', renk(k, :), 'MarkerSize', 8, 'LineWidth', 1.3, 'DisplayName', cn{k});
end
xline(ax, 0, 'k-', 'HandleVisibility', 'off'); xlabel(ax, 'Re s [1/s]'); ylabel(ax, 'Im s / 2\pi [Hz]');
title(ax, '(A) kapalı çevrim kutupları (|s| < 2\pi·20 kHz)'); legend(ax, 'Location', 'northwest');
ax = nexttile(tl); hold(ax, 'on'); grid(ax, 'on'); axis(ax, 'equal');
plot(ax, cos(th), sin(th), 'k-', 'HandleVisibility', 'off');
for k = 1:3
    pl = pole(feedback(CB{k}*PB, 1));
    plot(ax, real(pl), imag(pl), 'x', 'Color', renk(k, :), 'MarkerSize', 8, 'LineWidth', 1.3, 'DisplayName', cn{k});
end
xlabel(ax, 'Re z'); ylabel(ax, 'Im z'); title(ax, '(B) T_s = 100 µs: |z|_{max} = 1,18'); legend(ax, 'Location', 'southwest');
kaydet(fh, out_dir, 'kararlilik_kutuplar_A_B');
% Şekil 5: L_g taraması (PI, A)
fh = figure('Visible', 'off', 'Position', [100 100 820 600]);
tl = tiledlayout(fh, 2, 1, 'TileSpacing', 'compact');
ax1 = nexttile(tl); hold(ax1, 'on'); grid(ax1, 'on'); set(ax1, 'XScale', 'log');
ax2 = nexttile(tl); hold(ax2, 'on'); grid(ax2, 'on'); set(ax2, 'XScale', 'log');
rr = parula(numel(Lgv) + 1);
for a = 1:numel(Lgv)
    Ga = KO.bitki(p, Lgv(a), 'tam'); Lw = squeeze(freqresp(CA{2}, w)).*p.Kpwm.*squeeze(freqresp(Ga(1, 1), w)).*Hmw.*Dw;
    semilogx(ax1, f, 20*log10(abs(Lw)), 'Color', rr(a, :), 'LineWidth', 1.2, 'DisplayName', ['L_g = ' strrep(sprintf('%g', 1e3*Lgv(a)), '.', ',') ' mH']);
    semilogx(ax2, f, unwrap(angle(Lw))*180/pi, 'Color', rr(a, :), 'LineWidth', 1.2, 'HandleVisibility', 'off');
end
yline(ax1, 0, 'k:', 'HandleVisibility', 'off'); yline(ax2, -180, 'k:', 'HandleVisibility', 'off');
xlim(ax1, [10 3e4]); xlim(ax2, [10 3e4]); ylim(ax1, [-50 50]);
ylabel(ax1, '|L| (dB)'); ylabel(ax2, 'Faz (°)'); xlabel(ax2, 'Frekans (Hz)'); legend(ax1, 'Location', 'southwest');

kaydet(fh, out_dir, 'kararlilik_Lg_taramasi');

fclose(fid_log);
type(fullfile(out_dir, 'analiz_gunlugu.txt'));
disp(MT(:, {'gerceklesme', 'denetleyici', 'K34', 'fc_Hz', 'PM_deg', 'PMmin_deg', 'gecikme_marji_us', 'f180_Hz', 'GM_dB', 'Smax_dB', 'nyquist_net', 'kutup_olcutu', 'kararli'}));
disp(ST); disp(LGT);

function kaydet(fh, d, ad)
b5_olcek(fh, 450, 8); b5_son(fh, ad); b5_virgul(fh);
exportgraphics(fh, fullfile(d, [ad '.pdf']), 'ContentType', 'vector');
exportgraphics(fh, fullfile(d, [ad '.png']), 'Resolution', 300);
close(fh);
end

function o = jn(fmt, x)
if isempty(x), o = ''; else, o = strjoin(compose(fmt, x), ' / '); end
end

function o = ternary(c, a, b)
if c, o = a; else, o = b; end
end
