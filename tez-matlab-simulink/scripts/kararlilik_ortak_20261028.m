function K = kararlilik_ortak_20261028()
% İP-6 ortak yardımcılar: parametreler, ortalama bitki modeli, denetleyiciler,
% marj/Nyquist hesabı, ton analizi. Diğer *_kararlilik_20261028.m betikleri
% K = kararlilik_ortak_20261028(); ile çağırır.
K.parametreler = @parametreler;
K.bitki = @bitki;
K.denetleyiciler = @denetleyiciler;
K.marjlar = @marjlar;
K.kutup_tablosu = @kutup_tablosu;
K.ton_analizi = @ton_analizi;
K.empedans_G = @empedans_G;
end

% -------------------------------------------------------------------------------------
function p = parametreler(root_dir)
% İP-5 S4 model klasöründeki iki m-dosyası + KC_* (K-20, D-11) değerleri
par_dir = fullfile(root_dir, 'runs', '2026-10-28_s4_kapali_cevrim', 'model');
run(fullfile(par_dir, 'inverter_common_parameters.m'));
run(fullfile(par_dir, 's4_denetleyici_parametreleri.m'));
p.L1 = L1; p.L1r = L1r; p.Rp = L1_core_Rp4; p.C = C; p.Cr = Cr;
p.Cx = EMC_Cx_eq; p.Rx = EMC_Rx_eq; p.Ldm = EMC_Ldm_stage; p.Rdm = EMC_Rdm_stage;
p.L2 = L2; p.L2r = L2r; p.Vdc4 = Vdc4; p.Kpwm = Vdc4/2; p.Vg = Vac4_peak;
p.fsw = fsw; p.Ts_c = S4_Ts_c; p.f_lp = S4_f_lp; p.lp_a = S4_lp_a; p.f_grid = f_grid; p.w0 = 2*pi*f_grid;
p.Kp = Kp; p.fz = S4_PI_fz; p.Ki = Kp*2*pi*S4_PI_fz; p.Kr = S4_PIR_Kr; p.wb = S4_R_wb;
p.R_num1 = S4_R_num1; p.R_den = S4_R_den;
p.Iref = Ifaz_rms_target(4);
p.K14 = 0.44343; p.K34 = 0.384306; p.phase_deg4 = 0.6575;    % K-20 (KC_*)
p.K14_m = K14; p.K34_m = K34;                                   % m-dosyası ilk değerleri
p.Td_A = 2e-6;                                                  % (A) toplam gecikme üst sınırı
p.Cdc = 5.6e-3;                                                 % D-11
end

% -------------------------------------------------------------------------------------
function G = bitki(p, Lg, varyant)
% Ortalama (anahtarlamasız) LCL + EMC ağı, durum uzayı. Girişler [v_inv; v_g],
% çıkışlar [i_L1 (Current Sensor1: L1 ∥ Rp toplam akımı); i_2 (şebeke); v_b (Cf)].
% varyant 'toplu': Cf ∥ Cx aynı düğümde, seri 2 Ldm + L2 (İP-5 tasarımı)
% varyant 'tam'  : Cf -> Ldm -> Cx -> Ldm -> L2 (modeldeki sıra: CMC S1, X, CMC S3)
if nargin < 2, Lg = 0; end
if nargin < 3, varyant = 'tam'; end
L1 = p.L1; R1 = p.L1r; Rp = p.Rp; Cf = p.C; Rc = p.Cr; Cx = p.Cx; Rx = p.Rx;
switch varyant
    case 'toplu'
        % x = [iL vC vX i2]
        den = 1/Rp + 1/Rc + 1/Rx;
        vb_x = [1, 1/Rc, 1/Rx, -1]/den; vb_u = [1/Rp, 0]/den;
        L2e = 2*p.Ldm + p.L2 + Lg; R2e = 2*p.Rdm + p.L2r;
        A = zeros(4); B = zeros(4, 2);
        A(1, :) = (-vb_x - [R1 0 0 0])/L1;           B(1, :) = ([1 0] - vb_u)/L1;
        A(2, :) = (vb_x - [0 1 0 0])/(Rc*Cf);         B(2, :) = vb_u/(Rc*Cf);
        A(3, :) = (vb_x - [0 0 1 0])/(Rx*Cx);         B(3, :) = vb_u/(Rx*Cx);
        A(4, :) = (vb_x - [0 0 0 R2e])/L2e;           B(4, :) = (vb_u - [0 1])/L2e;
        Cy = [[1 0 0 0] - vb_x/Rp; 0 0 0 1; vb_x];
        Dy = [([1 0] - vb_u)/Rp; 0 0; vb_u];
        sn = {'iL', 'vC', 'vX', 'i2'};
    case 'tam'
        % x = [iL vC i1 vX i2]
        den = 1/Rp + 1/Rc;
        vb_x = [1, 1/Rc, -1, 0, 0]/den; vb_u = [1/Rp, 0]/den;
        vc_x = [0, 0, Rx, 1, -Rx];
        L2e = p.Ldm + p.L2 + Lg; R2e = p.Rdm + p.L2r;
        A = zeros(5); B = zeros(5, 2);
        A(1, :) = (-vb_x - [R1 0 0 0 0])/L1;          B(1, :) = ([1 0] - vb_u)/L1;
        A(2, :) = (vb_x - [0 1 0 0 0])/(Rc*Cf);        B(2, :) = vb_u/(Rc*Cf);
        A(3, :) = (vb_x - vc_x - [0 0 p.Rdm 0 0])/p.Ldm; B(3, :) = vb_u/p.Ldm;
        A(4, :) = [0 0 1 0 -1]/Cx;                     B(4, :) = [0 0];
        A(5, :) = (vc_x - [0 0 0 0 R2e])/L2e;          B(5, :) = [0 -1]/L2e;
        Cy = [[1 0 0 0 0] - vb_x/Rp; 0 0 0 0 1; vb_x];
        Dy = [([1 0] - vb_u)/Rp; 0 0; vb_u];
        sn = {'iL', 'vC', 'i1', 'vX', 'i2'};
    otherwise
        error('varyant: %s', varyant);
end
G = ss(A, B, Cy, Dy, 'StateName', sn, 'InputName', {'v', 'vg'}, 'OutputName', {'iL1', 'i2', 'vb'});
end

% -------------------------------------------------------------------------------------
function Gw = empedans_G(p, f, Lg)
% İP-5 tasarım betiğindeki empedans formülü (toplu varyant), çapraz denetim için
s = 1j*2*pi*f(:);
Z1 = 1 ./ (1 ./ (s*p.L1 + p.L1r) + 1/p.Rp);
Zc = 1 ./ (1 ./ (1 ./ (s*p.C) + p.Cr) + 1 ./ (1 ./ (s*p.Cx) + p.Rx));
Z2 = s*(p.L2 + Lg + 2*p.Ldm) + p.L2r + 2*p.Rdm;
Gw = 1 ./ (Z1 + Zc.*Z2./(Zc + Z2));
end

% -------------------------------------------------------------------------------------
function D = denetleyiciler(p, Ts)
% Ts = 0: sürekli (A); Ts > 0: ayrık (ileri Euler integratör, ön bükmeli Tustin rezonans)
if Ts == 0
    s = tf('s');
    R = 2*p.Kr*p.wb*s/(s^2 + 2*p.wb*s + p.w0^2);
    D = {tf(p.Kp), p.Kp + p.Ki/s, p.Kp + p.Ki/s + R};
else
    z = tf('z', Ts);
    I = p.Ki*Ts/(z - 1);                          % Discrete-Time Integrator, Forward Euler
    if abs(Ts - p.Ts_c) < 1e-12
        R = p.Kr*tf(p.R_num1, p.R_den, Ts);       % modeldeki blok (Tustin + ön bükme, 1 µs)
    else
        s = tf('s');
        R = c2d(2*p.Kr*p.wb*s/(s^2 + 2*p.wb*s + p.w0^2), Ts, ...
            c2dOptions('Method', 'tustin', 'PrewarpFrequency', p.w0));
    end
    D = {tf(p.Kp, 1, Ts), p.Kp + I, p.Kp + I + R};
end
end

% -------------------------------------------------------------------------------------
function R = marjlar(f, Lw, Ts)
% Çok geçişli çevrim kazancı için marj tanımı (İP-6):
%  - Kazanç geçişleri |L| = 1: her biri için faz marjı PM_i = 180° − |∠L| (−1 noktasına
%    açısal uzaklık) ve saat yönünde gereken dönüş φ_i = mod(∠L + 180°, 360°);
%    gecikme marjı DM_i = φ_i/(360° f_i).
%  - Faz geçişleri Im L = 0, Re L < 0 (L negatif gerçel eksende): kazanç marjı
%    GM_i = −20 log10 |L|. |L| < 1 -> kazanç artışı marjı (+), |L| > 1 -> kazanç
%    azalışı marjı (−).
%  - Nyquist: (−∞, −1) ışınının ω > 0 yarısında net kesişim sayısı (yukarı +1, aşağı −1);
%    açık çevrimde kararsız kutup yokken (P = 0) kararlılık koşulu net = 0.
%  - Modül marjı: min |1 + L| = 1/‖S‖∞.
if nargin < 3, Ts = 0; end
f = f(:); Lw = Lw(:);
mag = abs(Lw);
R.gecis = zeros(0, 6);   % [tur(1 kazanc, 2 faz), f, deger, yon, PM/GM, DM]
ic = find(sign(mag(1:end-1) - 1) ~= sign(mag(2:end) - 1));
for q = ic.'
    a = log(mag(q)); b = log(mag(q + 1)); r = -a/(b - a);
    fq = exp(log(f(q)) + r*(log(f(q + 1)) - log(f(q))));
    Lq = Lw(q) + r*(Lw(q + 1) - Lw(q)); Lq = Lq/abs(Lq);
    ph = angle(Lq)*180/pi;
    pm = 180 - abs(ph);
    phi_cw = mod(ph + 180, 360);
    R.gecis(end+1, :) = [1, fq, ph, sign(b - a), pm, phi_cw/360/fq];
end
ip = find(sign(imag(Lw(1:end-1))) ~= sign(imag(Lw(2:end))) & real(Lw(1:end-1)) < 0 & real(Lw(2:end)) < 0);
net = 0;
for q = ip.'
    a = imag(Lw(q)); b = imag(Lw(q + 1)); r = -a/(b - a);
    fq = f(q) + r*(f(q + 1) - f(q));
    Lq = real(Lw(q)) + r*(real(Lw(q + 1)) - real(Lw(q)));
    yon = sign(b - a);                      % +1: yukarı (−'den +'ya)
    R.gecis(end+1, :) = [2, fq, Lq, yon, -20*log10(abs(Lq)), NaN];
    if Lq < -1, net = net + yon; end
end
R.nyquist_net = net;
k1 = R.gecis(:, 1) == 1; k2 = R.gecis(:, 1) == 2;
R.fc = R.gecis(k1, 2).'; R.PM = R.gecis(k1, 5).'; R.DM = R.gecis(k1, 6).';
R.f180 = R.gecis(k2, 2).'; R.GM = R.gecis(k2, 5).';
if any(k1), [R.PMmin, i] = min(R.PM); R.fPMmin = R.fc(i); R.DMmin = min(R.DM); else, R.PMmin = inf; R.fPMmin = NaN; R.DMmin = inf; end
gp = R.GM(R.GM > 0); gn = R.GM(R.GM < 0);
if isempty(gp), R.GMup = inf; else, R.GMup = min(gp); end
if isempty(gn), R.GMdown = -inf; else, R.GMdown = max(gn); end
[mm, im] = min(abs(1 + Lw)); R.modul = mm; R.Smax_dB = -20*log10(mm); R.fSmax = f(im);
Tw = Lw./(1 + Lw); [tm, it] = max(abs(Tw)); R.Tmax_dB = 20*log10(tm); R.fTmax = f(it);
R.Ts = Ts;
end

% -------------------------------------------------------------------------------------
function T = kutup_tablosu(pl, Ts, etiket, fmax)
% Kapalı çevrim kutupları: s-düzlemi karşılıkları (ayrıkta s = ln z / Ts)
if nargin < 4, fmax = inf; end
pl = pl(:);
if Ts > 0, z = pl; s = log(pl)/Ts; else, z = NaN(size(pl)); s = pl; end
fn = abs(s)/2/pi; zeta = -real(s)./abs(s);
keep = fn <= fmax & imag(s) >= -1e-9;     % eşlenik çiftten birini tut
T = table(repmat(string(etiket), nnz(keep), 1), real(s(keep)), imag(s(keep)), fn(keep), zeta(keep), ...
    abs(z(keep)), 'VariableNames', {'durum', 're_s', 'im_s', 'fn_Hz', 'zeta', 'abs_z'});
T = sortrows(T, 'zeta');
end

% -------------------------------------------------------------------------------------
function T = ton_analizi(o, tonlar, Kpwm)
% Ölçüm penceresindeki sinyallerden (o.t, o.d_inj, o.u_x, o.u_fb, o.iL1_olcum, o.iL1,
% o.i_ref, o.v_inv) ton frekanslarında karmaşık genlik ve oranlar.
ph1 = @(s, f) 2*mean(s(:).*exp(-1j*2*pi*f*o.t(:)));
rows = zeros(numel(tonlar), 0);
for q = 1:numel(tonlar)
    f = tonlar(q);
    D = ph1(o.d_inj, f); UX = ph1(o.u_x, f); UFB = ph1(o.u_fb, f); YM = ph1(o.iL1_olcum, f);
    IL = ph1(o.iL1, f); IR = ph1(o.i_ref, f);
    if isfield(o, 'v_inv'), VI = ph1(o.v_inv, f); else, VI = NaN; end
    Lm = -UFB/UX; Sm = UX/D; Tm = -UFB/D; Pm = YM/UX; Cm = UFB/(IR - YM); Gm = IL/(Kpwm*UX);
    rows(q, 1:16) = [f, abs(D), abs(UX), abs(YM), real(Lm), imag(Lm), real(Sm), imag(Sm), real(Tm), imag(Tm), ...
        real(Pm), imag(Pm), real(Cm), imag(Cm), real(Gm), imag(Gm)];
    rows(q, 17:18) = [real(VI/UX), imag(VI/UX)];
end
T = array2table(rows, 'VariableNames', {'f_Hz', 'D', 'UX', 'YM_A', 'L_re', 'L_im', 'S_re', 'S_im', 'T_re', 'T_im', ...
    'P_re', 'P_im', 'C_re', 'C_im', 'G_re', 'G_im', 'Kef_re', 'Kef_im'});
end
