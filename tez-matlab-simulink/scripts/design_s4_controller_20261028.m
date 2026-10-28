% S4 akım denetleyicisinin ön tasarımı (İP-5): ortalama (anahtarlamasız) model
% üzerinde çevrim kazancı, geçiş frekansı, kazanç/faz marjı ve 50/150 Hz izleme
% hatası tahmini. Simulink koşturmaz; ~10 s. İP-6'nın doğrusallaştırmasının yerini
% tutmaz; kazanç ve ölçüm zinciri seçiminin gerekçesidir.
%
% Model (frekans alanı):
%   L(jw) = C(jw) * K_pwm * G(jw) * H_m(jw) * e^{-jw Td}
%   K_pwm : Vdc4/2 (yarım periyot ayrımlı tek kutuplu modülasyon, Vdc normalizasyonu yok)
%   G     : i_L1 / v_inv — L1 (L1r) ∥ Rp4, Cf (Cr) ∥ EMC X (Cx_eq, Rx_eq),
%           L2 (L2r) + 2 CMC diferansiyel endüktansı; şebeke gerilimi bozucu (kısa devre)
%   İki gerçekleme karşılaştırılır:
%   (A) modeldeki: denetim 1 µs'de, H_m = 5 kHz tek kutuplu süzgeç, Td = 2 µs
%       (1 µs denetim tutucusu + 1 µs görev oranı örneklemesi, üst sınır)
%   (B) sayısal (yalnız denetim): PWM periyodu başında örnekleme, 1 periyot ortalama,
%       görev oranı bir sonraki periyotta; H_m = H_avg, Td = Ts + Ts/2 (ZOH)
%   C     : P, PI (Kp + Ki/s), PIR (PI + 2 Kr wb s/(s^2 + 2 wb s + w0^2))
% Çağrı (proje kökünden): matlab -batch "run('scripts/design_s4_controller_20261028.m')"

root_dir = fileparts(fileparts(mfilename('fullpath')));
par_dir = fullfile(root_dir, 'runs', '2026-10-27_diyot_esleme', 'model');
out_dir = fullfile(root_dir, 'runs', '2026-10-28_s4_kapali_cevrim', 'tasarim');
if ~exist(out_dir, 'dir'), mkdir(out_dir); end
run(fullfile(par_dir, 'inverter_common_parameters.m'));
run(fullfile(root_dir, 'scripts', 's4_denetleyici_parametreleri_20261028.m'));

Kpwm = Vdc4/2; Tsw = 1/fsw; w0 = 2*pi*f_grid;
f = logspace(0, log10(5e4), 40000).'; w = 2*pi*f; s = 1j*w;
Z1 = 1 ./ (1 ./ (s*L1 + L1r) + 1/L1_core_Rp4);          % L1 ∥ Rp4
Zc = 1 ./ (1 ./ (1 ./ (s*C) + Cr) + 1 ./ (1 ./ (s*EMC_Cx_eq) + EMC_Rx_eq));
Z2 = s*(L2 + 2*EMC_Ldm_stage) + L2r + 2*EMC_Rdm_stage;
G = 1 ./ (Z1 + Zc.*Z2./(Zc + Z2));
% Rasyonel modeller (kapalı çevrim kutupları için)
st = tf('s');
Z1t = (st*L1 + L1r)*L1_core_Rp4/(st*L1 + L1r + L1_core_Rp4);
Zct = 1/(1/(1/(st*C) + Cr) + 1/(1/(st*EMC_Cx_eq) + EMC_Rx_eq));
Z2t = st*(L2 + 2*EMC_Ldm_stage) + L2r + 2*EMC_Rdm_stage;
Gt = minreal(1/(Z1t + Zct*Z2t/(Zct + Z2t)), 1e-9);
Ct = {Kp, Kp + Kp*2*pi*S4_PI_fz/st, ...
    Kp + Kp*2*pi*S4_PI_fz/st + 2*S4_PIR_Kr*S4_R_wb*st/(st^2 + 2*S4_R_wb*st + (2*pi*f_grid)^2)};
Pa = Kpwm*Gt/(st/(2*pi*S4_f_lp) + 1)*pade(exp(-2e-6*st), 2);           % (A)
Pint = c2d(Kpwm*Gt/st, Tsw, 'zoh'); zt = tf('z', Tsw);
Pb = minreal((1 - 1/zt)/Tsw*Pint/zt, 1e-9);                                % (B)
Cb = {Kp + 0/zt, Kp + Kp*2*pi*S4_PI_fz*Tsw/(zt - 1), ...
    Kp + Kp*2*pi*S4_PI_fz*Tsw/(zt - 1) + c2d(2*S4_PIR_Kr*S4_R_wb*st/(st^2 + 2*S4_R_wb*st + (2*pi*f_grid)^2), Tsw, 'tustin')};
impl = struct('ad', {'A: model (1 us, 5 kHz suzgec)', 'B: sayisal (Ts = 100 us)'}, ...
    'Hm', {1 ./ (1 + s/(2*pi*S4_f_lp)), (1 - exp(-s*Tsw)) ./ (s*Tsw)}, ...
    'Td', {2e-6, 1.5*Tsw}, 'fmax', {5e4, 0.5/Tsw});
Kpi = Kp; Ki = Kp*2*pi*S4_PI_fz; Kr = S4_PIR_Kr; wb = S4_R_wb;
ctrl = {
    'P (Kp = 0.03)',            Kpi + 0*s
    'PI (fz = 60 Hz)',          Kpi + Ki ./ s
    'PIR (PI + Kr = 0.3 @50 Hz)', Kpi + Ki ./ s + 2*Kr*wb*s ./ (s.^2 + 2*wb*s + w0^2)
};
Ipk = sqrt(2)*Ifaz_rms_target(4);
G50 = interp1(f, G, 50); G150 = interp1(f, G, 150);
u_need = (Vac4_peak + Ipk/G50) / Kpwm;                    % gereken temel modülasyon fazörü
u_ff1 = K14 + 3*K34/4; u_ff3 = -K34/4;                     % ileri beslemenin temel ve 3. harmoniği
i_res50 = abs(u_need - u_ff1) * Kpwm * abs(G50);           % çevrimsiz temel akım hatası [A tepe]
i_res150 = abs(u_ff3) * Kpwm * abs(G150);                  % çevrimsiz 150 Hz akımı [A tepe]

rows = {};
fh = figure('Visible', 'off', 'Position', [100 100 1000 700]);
tl = tiledlayout(fh, 2, 2);
for m = 1:numel(impl)
    ax1 = nexttile(tl, m); hold(ax1, 'on'); grid(ax1, 'on'); set(ax1, 'XScale', 'log');
    ax2 = nexttile(tl, m + 2); hold(ax2, 'on'); grid(ax2, 'on'); set(ax2, 'XScale', 'log');
    sel = f <= impl(m).fmax;
    for k = 1:size(ctrl, 1)
        L = ctrl{k, 2} .* Kpwm .* G .* impl(m).Hm .* exp(-s*impl(m).Td);
        [fc, pm, gm, f180, ncross] = margins(f(sel), L(sel));
        S50 = 1/(1 + interp1(f, L, 50)); S150 = 1/(1 + interp1(f, L, 150));
        T50 = 1 - S50;
        % kapalı çevrim kutup ölçütü: (A) en büyük gerçel kısım [1/s], (B) en büyük |z|
        if m == 1
            pcl = pole(feedback(Ct{k}*Pa, 1)); N = max(real(pcl));        % < 0: kararlı
        else
            pcl = pole(feedback(Cb{k}*Pb, 1)); N = max(abs(pcl));         % < 1: kararlı
        end
        rows(end+1, :) = {impl(m).ad, ctrl{k, 1}, fc, pm, gm, f180, ncross, N, abs(S50), ...
            angle(T50)*180/pi, abs(T50), abs(S150), abs(S50)*i_res50, 100*abs(S50)*i_res50/Ipk, ...
            abs(S150)*i_res150, 100*abs(S150)*i_res150/Ipk}; %#ok<SAGROW>
        semilogx(ax1, f(sel), 20*log10(abs(L(sel))), 'DisplayName', ctrl{k, 1});
        semilogx(ax2, f(sel), unwrap(angle(L(sel)))*180/pi, 'DisplayName', ctrl{k, 1});
    end
    yline(ax1, 0, 'k:', 'HandleVisibility', 'off'); yline(ax2, -180, 'k:', 'HandleVisibility', 'off');
    title(ax1, impl(m).ad); ylabel(ax1, '|L| [dB]'); ylabel(ax2, '\angle L [°]'); xlabel(ax2, 'f [Hz]');
    legend(ax1, 'Location', 'southwest');
end
title(tl, 'S4 çevrim kazancı, ortalama model (V_{dc} = 427,5 V, L1 = 600 µH, C_f = 8 µF, L2 = 1 mH)');
T = cell2table(rows, 'VariableNames', {'gerceklesme', 'denetleyici', 'fc_Hz', 'PM_deg', 'GM_dB', ...
    'f180_Hz', 'n_kazanc_gecisi', 'kc_kutup_olcutu', 'absS_50Hz', 'angT_50Hz_deg', 'absT_50Hz', ...
    'absS_150Hz', 'e50_tahmin_Apk', 'e50_tahmin_pct', 'i150_tahmin_Apk', 'i150_tahmin_pct'});
writetable(T, fullfile(out_dir, 's4_tasarim_marjlari.csv'));
exportgraphics(fh, fullfile(out_dir, 's4_tasarim_bode.png'), 'Resolution', 200);
savefig(fh, fullfile(out_dir, 's4_tasarim_bode.fig'));
% allmargin ile bütün kazanç/faz geçişleri (rasyonel modeller)
am_rows = {};
for m = 1:2
    for k = 1:numel(Ct)
        if m == 1, Lk = Ct{k}*Pa; else, Lk = Cb{k}*Pb; end
        am = allmargin(Lk);
        for q = 1:numel(am.PMFrequency)
            am_rows(end+1, :) = {impl(m).ad, ctrl{k, 1}, 'faz', am.PMFrequency(q)/2/pi, am.PhaseMargin(q), am.Stable}; %#ok<SAGROW>
        end
        for q = 1:numel(am.GMFrequency)
            am_rows(end+1, :) = {impl(m).ad, ctrl{k, 1}, 'kazanc', am.GMFrequency(q)/2/pi, 20*log10(am.GainMargin(q)), am.Stable}; %#ok<SAGROW>
        end
    end
end
writetable(cell2table(am_rows, 'VariableNames', {'gerceklesme', 'denetleyici', 'marj_turu', 'f_Hz', ...
    'marj_deg_ya_da_dB', 'kapali_cevrim_kararli'}), fullfile(out_dir, 's4_tasarim_allmargin.csv'));
f_z = 1/(2*pi*sqrt((L2 + 2*EMC_Ldm_stage)*(C + EMC_Cx_eq)));
f_r = 1/(2*pi*sqrt(L1*(L2 + 2*EMC_Ldm_stage)*(C + EMC_Cx_eq)/(L1 + L2 + 2*EMC_Ldm_stage)));
fid = fopen(fullfile(out_dir, 's4_tasarim_ozet.txt'), 'w', 'n', 'UTF-8');
fprintf(fid, 'Kpwm = %.3f V; f_antirezonans = %.0f Hz; f_rezonans = %.0f Hz; fs/6 = %.0f Hz\n', ...
    Kpwm, f_z, f_r, fsw/6);
fprintf(fid, '|G(50 Hz)| = %.4f A/V; Vac4_peak = %.2f V; Ipk(25 A) = %.2f A\n', abs(G50), Vac4_peak, Ipk);
fprintf(fid, 'gereken temel modulasyon (25 A, faz 0): %.4f %+.4fj (|.| = %.4f); ileri besleme temel = %.4f, 3. h. = %.4f\n', ...
    real(u_need), imag(u_need), abs(u_need), u_ff1, u_ff3);
fprintf(fid, 'cevrimsiz temel akim hatasi = %.2f A tepe; cevrimsiz 150 Hz akimi = %.2f A tepe\n', i_res50, i_res150);
fprintf(fid, 'Ki = %.4f 1/(A s); Kr = %.3f 1/A; wb = %.3f rad/s; Kaw = Ki/Kp = %.2f 1/s\n', Ki, Kr, wb, Ki/Kpi);
fprintf(fid, 'egim kosulu (suzgecsiz): Kp*Kpwm/L1 = %.0f 1/s, tasiyici egimi fsw = %.0f 1/s\n', Kpi*Kpwm/L1, fsw);
fprintf(fid, 'egim kosulu (5 kHz suzgec, 10 kHz temel bileseni zayiflatmasi %.3f): %.0f 1/s\n', ...
    1/sqrt(1 + (fsw/S4_f_lp)^2), Kpi*Kpwm/L1/sqrt(1 + (fsw/S4_f_lp)^2));
fclose(fid);
disp(T); type(fullfile(out_dir, 's4_tasarim_ozet.txt'));

function [fc, pm, gm, f180, nc] = margins(f, L)
mag = abs(L); ph = unwrap(angle(L))*180/pi;
ic = find((mag(1:end-1) - 1) .* (mag(2:end) - 1) <= 0); nc = numel(ic);
fc = NaN; pm = inf;
for q = ic.'   % en küçük faz marjı
    fq = interp1(log(mag(q:q+1)), f(q:q+1), 0);
    p = interp1(f(q:q+1), ph(q:q+1), fq);
    pmq = mod(p + 180 + 180, 360) - 180;   % (-180, 180]
    if abs(pmq) < abs(pm), pm = pmq; fc = fq; end
end
ip = find((mod(ph(1:end-1) + 180 + 180, 360) - 180) .* (mod(ph(2:end) + 180 + 180, 360) - 180) <= 0 & ...
    abs(diff(ph)) < 90);
gm = inf; f180 = NaN;
for q = ip.'
    g = mean(mag(q:q+1));
    if abs(-20*log10(g)) < abs(gm), gm = -20*log10(g); f180 = mean(f(q:q+1)); end
end
end

