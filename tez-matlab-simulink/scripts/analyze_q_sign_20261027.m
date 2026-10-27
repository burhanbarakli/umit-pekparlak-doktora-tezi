% İP-3 / D-06 / K-02: reaktif güç ve cosφ işaretinin dalga biçiminden belirlenmesi.
%
% Girdiler
%   1) runs/2026-10-27_dort_senaryo_ilk_kosu/results/<model>/logsout.mat
%      (değiştirilmemiş koşu; yalnız Display kaynakları kayıtlı: Power3 P1/Q1,
%      Power Measurement 0–50. harmonik P/Q, RMS, THD)
%   2) runs/2026-10-27_q_isaret_dalga/results/<model>/dalga_0p05_0p1.mat
%      (run_q_isaret_dalga_20261027.m: aynı paket, yalnız kayıt açık;
%      v_ac, i_ac, v_inv, i_L1 ham dalga biçimleri)
% Ölçüm noktaları (load_system + PortConnectivity ile okundu, 27.10.2026):
%   A : L1 giriş düğümü (Current Sensor1 çıkışı)       v_inv = V(A) − V(N), i_L1: faz → A
%   B : L1 çıkışı, Cf (Capacitor2 = C) ve EMC S1 girişi
%   M : iki CMC kademesi arası, Capacitor6 (C_emc_aux)
%   C : EMC S3 çıkışı, CL1 (L2) girişi                 v_ac  = V(C) − V(G−)
%   G : şebeke kaynağı (Grid1) uçları; i_ac dönüş iletkeninde, G− → EMC yönünde
% Pencere: 0,06–0,10 s (iki tam 50 Hz periyodu), trapez integrali, ham örnekler.
% Sayılar tez bulgusu değildir (DENEME parametreleri, kalibrasyonsuz model).
%
% Çağrı (proje kökünden):
%   matlab -batch "run('scripts/analyze_q_sign_20261027.m')"
% Çıktı: runs/2026-10-27_q_isaret_dalga/q_isaret_*.csv, q_isaret_<model>.png

root_dir = fileparts(fileparts(mfilename('fullpath')));
first_dir = fullfile(root_dir, 'runs', '2026-10-27_dort_senaryo_ilk_kosu');
wave_dir = fullfile(root_dir, 'runs', '2026-10-27_q_isaret_dalga');
if ~exist(wave_dir, 'dir'), mkdir(wave_dir); end
run(fullfile(first_dir, 'model', 'inverter_common_parameters.m'));  % L1, C, L2, ...

f0 = f_grid; w0 = 2*pi*f0; Tw = [0.06, 0.10];
Z1 = par(L1r + 1j*w0*L1, L1_core_Rp);        % L1 ‖ çekirdek kaybı Rp
Zcf = Cr + 1/(1j*w0*C);                      % Cf + ESR
Zcm = 2*(EMC_Rw + 1j*w0*(EMC_Lw - EMC_M));   % CMC kademesi, diferansiyel
Zcx = R_emc_aux + 1/(1j*w0*C_emc_aux);       % Capacitor6
Z2 = L2r + 1j*w0*L2;                          % şebeke + varyak

cases = {
    % model, senaryo, Vac_rms, deney: P, cosφ (xlsx), THD_I %
    'inverter_scenario1_parametric5_etiquetli', 'S1', Vac1_rms, Pout_target(1), cosphi_target(1), THD_target_pct(1)
    'inverter_senaryo3',                        'S3', Vac3_rms, Pout_target(3), cosphi_target(3), THD_target_pct(3)
    };

summary = {}; points = {}; sens = {};
for c = 1:size(cases, 1)
    mdl = cases{c, 1}; sc = cases{c, 2}; Eexp = cases{c, 3};
    fprintf('\n===== %s (%s) =====\n', sc, mdl);

    % ---------- 1) değiştirilmemiş koşu: Display kaynakları ----------
    S = load(fullfile(first_dir, 'results', mdl, 'logsout.mat'), 'logs');
    L = S.logs; clear S
    g = @(blk, port) last_period(L, [mdl '/' blk], port, Tw);
    d.P1 = g('Power3', 1); d.Q1 = g('Power3', 2);
    d.Pm = g('Mean9', 1);  d.Qm = g('Mean10', 1);
    d.Irms = g('RMS1', 1); d.THDi = g('THD', 1); d.THDv = g('THD2', 1);
    d.Pdc = g('Mean1', 1);
    clear L
    d.I1 = d.Irms/sqrt(1 + d.THDi^2);
    d.V1 = hypot(d.P1, d.Q1)/d.I1;
    d.Vrms = d.V1*sqrt(1 + d.THDv^2);
    d.cos1 = d.P1/hypot(d.P1, d.Q1);
    d.PF = d.Pm/(d.Vrms*d.Irms);
    d.phi1 = atan2d(d.Q1, d.P1);
    fprintf('Display kaynakları (son periyot ort.): P1=%.2f W Q1=%+.2f var | P(0-50)=%.2f Q(0-50)=%+.2f | Irms=%.4f THDi=%.4f THDv=%.4f\n', ...
        d.P1, d.Q1, d.Pm, d.Qm, d.Irms, d.THDi, d.THDv);

    % Fazörlerin C noktasından geri yayılması (doğrusal pasif ağ, temel bileşen)
    VC = d.V1; IC = d.I1*exp(-1j*deg2rad(d.phi1));
    nw = propagate(VC, IC, Z1, Zcf, Zcm, Zcx, Z2);
    fprintf('Geri yayılım: |E|=%.2f V (parametre Vac_rms=%.2f V) |V_A|=%.2f V\n', abs(nw.VG), Eexp, abs(nw.VA));

    % ---------- 2) ham dalga biçimleri (varsa) ----------
    wf = fullfile(wave_dir, 'results', mdl, 'dalga_0p05_0p1.mat');
    have_wave = isfile(wf);
    if have_wave
        Wl = load(wf); W = Wl.W;
        [Vc_, Vc_rms] = fund(W.v_ac.t, W.v_ac.v, w0, Tw);
        [Ic_, Ic_rms] = fund(W.i_ac.t, W.i_ac.v, w0, Tw);
        [Va_, Va_rms] = fund(W.v_inv.t, W.v_inv.v, w0, Tw);
        [Il_, Il_rms] = fund(W.i_L1.t, W.i_L1.v, w0, Tw);
        ref = angle(Vc_);                       % v_ac temel bileşeni = 0°
        rot = exp(-1j*ref);
        Vc_ = Vc_*rot; Ic_ = Ic_*rot; Va_ = Va_*rot; Il_ = Il_*rot;
        Ptrue_C = mean_prod(W.v_ac, W.i_ac, Tw);
        thd50 = @(sg) thd_h(sg.t, sg.v, w0, Tw, 50);
        fprintf('THD (tüm bant / 2–50. harmonik): i_ac %.4f / %.4f, i_L1 %.4f / %.4f, v_ac %.4f / %.4f
', ...
            sqrt(Ic_rms^2 - abs(Ic_)^2)/abs(Ic_), thd50(W.i_ac), sqrt(Il_rms^2 - abs(Il_)^2)/abs(Il_), thd50(W.i_L1), ...
            sqrt(Vc_rms^2 - abs(Vc_)^2)/abs(Vc_), thd50(W.v_ac));
        Ptrue_A = mean_prod(W.v_inv, W.i_L1, Tw);
        % model Display'leriyle karşılaştırma (bu koşunun kendi kaydı)
        chk = {};
        for nm = {'P1_Power3', 'Q1_Power3', 'Q_Mean10', 'P_Mean9'}
            if isfield(W, nm{1}), chk{end+1} = sprintf('%s=%.3f', nm{1}, win_mean(W.(nm{1}), Tw)); end %#ok<SAGROW>
        end
        fprintf('Dalga koşusu Display kaynakları: %s\n', strjoin(chk, ' '));
        % B noktası dalga biçiminden: V_B = V_A − Z1·I_L1
        VB_w = Va_ - Z1*Il_;
        Icf_w = VB_w/Zcf;
        Ishunt_w = Il_ - Ic_;                    % Cf + EMC Cx + kayıplar (ölçülen fark)
        nw_w = propagate(Vc_, Ic_, Z1, Zcf, Zcm, Zcx, Z2);  % ağ modeliyle tahmin
        fprintf('Doğrulama: |I_L1| dalga=%.4f ağ=%.4f A, ∠ dalga=%.2f° ağ=%.2f°; |V_A| dalga=%.2f ağ=%.2f V\n', ...
            abs(Il_), abs(nw_w.IL1), rad2deg(angle(Il_)), rad2deg(angle(nw_w.IL1)), abs(Va_), abs(nw_w.VA));
        fprintf('           |E| (V_C − Z2·I_C) = %.3f V, parametre %.3f V\n', abs(Vc_ - Z2*Ic_), Eexp);

        % Noktalara göre güç (üretici kuralı: evirici → şebeke pozitif)
        pts = {
            'A evirici çıkışı (v_inv, i_L1)',          Va_, Il_, Va_rms, Il_rms, Ptrue_A
            'B L1 sonrası, Cf öncesi (hesap)',          VB_w, Il_, NaN, NaN, NaN
            'B+ Cf sonrası, EMC girişi (hesap)',        VB_w, Il_ - Icf_w, NaN, NaN, NaN
            'C model ölçüm noktası (v_ac, i_ac)',       Vc_, Ic_, Vc_rms, Ic_rms, Ptrue_C
            'G şebeke kaynağı uçları (hesap)',          Vc_ - Z2*Ic_, Ic_, NaN, NaN, NaN
            };
        src = 'dalga';
    else
        pts = {
            'A evirici çıkışı (ağ hesabı)',             nw.VA, nw.IL1, NaN, NaN, NaN
            'B L1 sonrası, Cf öncesi (ağ hesabı)',      nw.VB, nw.IL1, NaN, NaN, NaN
            'B+ Cf sonrası, EMC girişi (ağ hesabı)',    nw.VB, nw.IL1 - nw.VB/Zcf, NaN, NaN, NaN
            'C model ölçüm noktası (Display)',          VC, IC, d.Vrms, d.Irms, d.Pm
            'G şebeke kaynağı uçları (ağ hesabı)',      nw.VG, IC, NaN, NaN, NaN
            };
        src = 'display+ag';
    end
    for k = 1:size(pts, 1)
        V = pts{k, 2}; I = pts{k, 3};
        Sg = V*conj(I);                    % üretici
        Sl = -Sg;                          % yük kuralı (akım ters yönde)
        phi = rad2deg(angle(V) - angle(I));
        phi = mod(phi + 180, 360) - 180;
        PF = pts{k, 6}/(pts{k, 4}*pts{k, 5});
        lead = ternary(phi < 0, 'akım önde (kapasitif yük görünümü)', 'akım geride');
        points(end+1, :) = {sc, src, pts{k, 1}, abs(V), rad2deg(angle(V)), abs(I), rad2deg(angle(I)), ...
            phi, real(Sg), imag(Sg), cosd(phi), real(Sl), imag(Sl), pts{k, 4}, pts{k, 5}, pts{k, 6}, PF, lead}; %#ok<SAGROW>
        fprintf('%-38s |V|=%7.2f V ∠%6.2f° |I|=%6.4f A ∠%7.2f°  φ=%+6.2f°  Pgen=%7.2f W Qgen=%+7.2f var cosφ1=%.4f  PF=%.4f\n', ...
            pts{k, 1}, abs(V), rad2deg(angle(V)), abs(I), rad2deg(angle(I)), phi, real(Sg), imag(Sg), cosd(phi), PF);
    end
    % Cf ve EMC'nin reaktif katkısı
    if have_wave
        Qcf = imag(VB_w*conj(Icf_w)); Qsh = imag(VB_w*conj(Ishunt_w));
        QL1 = imag(Va_*conj(Il_)) - imag(VB_w*conj(Il_));
    else
        Qcf = imag(nw.VB*conj(nw.VB/Zcf)); Qsh = NaN; QL1 = imag(nw.VA*conj(nw.IL1)) - imag(nw.VB*conj(nw.IL1));
    end
    fprintf('Katkılar: Q_L1 (tüketilen)=%.2f var, Q_Cf (yük kuralı)=%.2f var ⇒ Cf sağladığı=%.2f var; şönt toplam (i_L1−i_ac)=%.2f var\n', ...
        QL1, Qcf, -Qcf, -Qsh);

    % ---------- 3) duyarlılık: V_A genliği / fazı ----------
    % E sabit, V_A değişir; ağ doğrusal. Temel nokta: geri yayılan V_A.
    E = nw.VG; VA0 = nw.VA;
    for dm = [-0.02 -0.01 -0.005 0 0.005 0.01 0.02]
        r = forward(VA0*(1 + dm), E, Z1, Zcf, Zcm, Zcx, Z2);
        sens(end+1, :) = {sc, 'genlik', 100*dm, abs(VA0)*(1 + dm), real(r.SC), imag(r.SC), ...
            real(r.SC)/abs(r.SC), imag(r.SA)}; %#ok<SAGROW>
    end
    for dth = [-0.2 -0.1 0 0.1 0.2]
        r = forward(VA0*exp(1j*deg2rad(dth)), E, Z1, Zcf, Zcm, Zcx, Z2);
        sens(end+1, :) = {sc, 'faz_derece', dth, abs(VA0), real(r.SC), imag(r.SC), ...
            real(r.SC)/abs(r.SC), imag(r.SA)}; %#ok<SAGROW>
    end
    % Ölçüm çözünürlüğü: şebeke gerilimi okuması ±0,05 V (0,1 V basamak), Vdc ±0,05 V
    for dE = [-0.05 0.05]
        r = forward(VA0, E*(1 + dE/abs(E)), Z1, Zcf, Zcm, Zcx, Z2);
        sens(end+1, :) = {sc, 'E_V', dE, abs(VA0), real(r.SC), imag(r.SC), ...
            real(r.SC)/abs(r.SC), imag(r.SA)}; %#ok<SAGROW>
    end
    % Deneydeki |Q| büyüklüğüne (iki işaretiyle) C ya da A noktasında ulaşmak için
    % gereken V_A genlik/faz değişimi (P_C benzetimdeki değerinde tutulur)
    Pexp = cases{c, 4}; ce = cases{c, 5};
    Qexp_abs = Pexp*tan(acos(abs(ce)));
    for pt = {'C', 'A'}
        for sgn = [+1 -1]
            Qt = sgn*Qexp_abs;
            if Qexp_abs == 0 && sgn < 0, continue, end
            x = fminsearch(@(x) cost_pq(x, VA0, E, Z1, Zcf, Zcm, Zcx, Z2, d.P1, Qt, pt{1}), [0 0], ...
                optimset('TolX', 1e-10, 'TolFun', 1e-10, 'MaxFunEvals', 4000));
            r = forward(VA0*(1 + x(1))*exp(1j*deg2rad(x(2))), E, Z1, Zcf, Zcm, Zcx, Z2);
            sens(end+1, :) = {sc, sprintf('hedef_Q_%s=%+.2f', pt{1}, Qt), 100*x(1), abs(VA0)*(1 + x(1)), ...
                real(r.SC), imag(r.SC), real(r.SC)/abs(r.SC), imag(r.SA)}; %#ok<SAGROW>
            fprintf('Q_%s=%+.2f var için |V_A| %+.3f %% (%.2f V), faz %+.4f°; Q_A=%+.2f, Q_C=%+.2f var\n', ...
                pt{1}, Qt, 100*x(1), abs(VA0)*(1 + x(1)), x(2), imag(r.SA), imag(r.SC));
        end
    end

    % ---------- 4) deney ile karşılaştırma ----------
    PFmax = 1/sqrt(1 + (cases{c, 6}/100)^2);
    summary(end+1, :) = {sc, d.P1, d.Q1, d.Pm, d.Qm, d.cos1, d.PF, d.phi1, d.V1, d.Vrms, d.I1, d.Irms, ...
        d.THDi, Pexp, ce, Qexp_abs, rad2deg(acos(abs(ce))), PFmax}; %#ok<SAGROW>

    % ---------- 5) şekil ----------
    if have_wave
        fig = figure('Visible', 'off', 'Position', [100 100 900 420]);
        sel = @(s) s.t >= Tw(1) & s.t <= Tw(2);
        yyaxis left
        plot(W.v_ac.t(sel(W.v_ac))*1e3, W.v_ac.v(sel(W.v_ac)), 'LineWidth', 0.8); ylabel('v_{ac} [V]');
        yyaxis right
        plot(W.i_ac.t(sel(W.i_ac))*1e3, W.i_ac.v(sel(W.i_ac)), '-', W.i_L1.t(sel(W.i_L1))*1e3, ...
            W.i_L1.v(sel(W.i_L1)), ':', 'LineWidth', 0.8); ylabel('akım [A]');
        xlabel('t [ms]'); grid on
        legend({'v_{ac} (C)', 'i_{ac} (C, evirici→şebeke +)', 'i_{L1} (A)'}, 'Location', 'southoutside', 'Orientation', 'horizontal');
        title(sprintf('%s: φ_1(C) = %+.2f°, Q_1(C) = %+.1f var (üretici kuralı)', sc, ...
            points{end - 1, 8}, points{end - 1, 10}));
        exportgraphics(fig, fullfile(wave_dir, sprintf('q_isaret_%s.png', sc)), 'Resolution', 200);
        close(fig);
    end
end

T1 = cell2table(summary, 'VariableNames', {'senaryo', 'P1_W', 'Q1_var', 'P_0_50_W', 'Q_0_50_var', ...
    'cosphi1', 'PF', 'phi1_deg', 'V1_rms', 'V_rms', 'I1_rms', 'I_rms', 'THD_I', ...
    'P_deney_W', 'cosphi_deney_xlsx', 'Q_deney_abs_var', 'phi_deney_deg', 'PF_ust_sinir_THD'});
T2 = cell2table(points, 'VariableNames', {'senaryo', 'kaynak', 'nokta', 'V_rms1', 'V_aci_deg', 'I_rms1', ...
    'I_aci_deg', 'phi_deg', 'P_uretici_W', 'Q_uretici_var', 'cosphi1', 'P_yuk_W', 'Q_yuk_var', ...
    'V_rms', 'I_rms', 'P_gercek_W', 'PF', 'yorum'});
T3 = cell2table(sens, 'VariableNames', {'senaryo', 'degisken', 'deger', 'VA_rms1', 'P_C_W', 'Q_C_var', ...
    'cosphi1_C', 'Q_A_var'});
writetable(T1, fullfile(wave_dir, 'q_isaret_ozet.csv'), 'Encoding', 'UTF-8');
writetable(T2, fullfile(wave_dir, 'q_isaret_noktalar.csv'), 'Encoding', 'UTF-8');
writetable(T3, fullfile(wave_dir, 'q_isaret_duyarlilik.csv'), 'Encoding', 'UTF-8');
disp(T1); disp(T2(:, [1 3 4 6 8 9 10 11 16 17])); disp(T3);

% ======================================================================
function z = par(a, b)
z = a*b/(a + b);
end

function v = last_period(L, blk, port, Tw)
v = NaN;
for e = 1:L.numElements
    el = L.getElement(e);
    if strcmp(el.BlockPath.getBlock(1), blk) && el.PortIndex == port
        t = el.Values.Time; x = squeeze(el.Values.Data);
        sel = t >= Tw(2) - 0.02 & t <= Tw(2);
        v = trapz(t(sel), x(sel))/(t(find(sel, 1, 'last')) - t(find(sel, 1)));
        return
    end
end
warning('kayıt yok: %s:%d', blk, port);
end

function [X, xrms] = fund(t, x, w0, Tw)
% RMS fazör (cos referanslı) ve toplam RMS, ham örneklerle trapez
sel = t >= Tw(1) & t <= Tw(2);
t = t(sel); x = x(sel); T = t(end) - t(1);
X = sqrt(2)/T*trapz(t, x.*exp(-1j*w0*t));
xrms = sqrt(trapz(t, x.^2)/T);
end

function r = thd_h(t, x, w0, Tw, H)
% 2..H. harmonik THD (analizör tipi), trapez Fourier
sel = t >= Tw(1) & t <= Tw(2); t = t(sel); x = x(sel); T = t(end) - t(1);
X = zeros(H, 1);
for h = 1:H, X(h) = sqrt(2)/T*trapz(t, x.*exp(-1j*h*w0*t)); end
r = sqrt(sum(abs(X(2:end)).^2))/abs(X(1));
end

function p = mean_prod(a, b, Tw)
sel = a.t >= Tw(1) & a.t <= Tw(2);
t = a.t(sel);
bv = b.v(sel);
if numel(b.t) ~= numel(a.t) || any(b.t ~= a.t), bv = interp1(b.t, b.v, t); end
p = trapz(t, a.v(sel).*bv)/(t(end) - t(1));
end

function m = win_mean(s, Tw)
sel = s.t >= Tw(2) - 0.02 & s.t <= Tw(2);
m = trapz(s.t(sel), s.v(sel))/(s.t(find(sel, 1, 'last')) - s.t(find(sel, 1)));
end

function nw = propagate(VC, IC, Z1, Zcf, Zcm, Zcx, Z2)
% C noktasından geriye: C → (Zcm) → M [Cx] → (Zcm) → B [Cf] → (Z1) → A; ileri: G
VM = VC + Zcm*IC;  IM = IC + VM/Zcx;
VB = VM + Zcm*IM;  IL1 = IM + VB/Zcf;
nw.VA = VB + Z1*IL1; nw.VB = VB; nw.VM = VM; nw.IL1 = IL1; nw.VG = VC - Z2*IC;
end

function r = forward(VA, E, Z1, Zcf, Zcm, Zcx, Z2)
% Düğüm gerilimi çözümü (B, M, C); kaynaklar V_A ve E
Y = [1/Z1 + 1/Zcf + 1/Zcm, -1/Zcm, 0
    -1/Zcm, 2/Zcm + 1/Zcx, -1/Zcm
    0, -1/Zcm, 1/Zcm + 1/Z2];
b = [VA/Z1; 0; E/Z2];
v = Y\b; VB = v(1); VC = v(3);
IC = (VC - E)/Z2; IL1 = (VA - VB)/Z1;
r.SC = VC*conj(IC); r.SA = VA*conj(IL1);
end

function J = cost_pq(x, VA0, E, Z1, Zcf, Zcm, Zcx, Z2, Pt, Qt, pt)
r = forward(VA0*(1 + x(1))*exp(1j*deg2rad(x(2))), E, Z1, Zcf, Zcm, Zcx, Z2);
if strcmp(pt, 'A'), Qp = imag(r.SA); else, Qp = imag(r.SC); end
J = (real(r.SC) - Pt)^2 + (Qp - Qt)^2;
end

function s = ternary(c, a, b)
if c, s = a; else, s = b; end
end
