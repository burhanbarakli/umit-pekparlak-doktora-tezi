% Senaryo 4 (S4) kapalı çevrim denetleyici parametreleri — İP-5, D-02, K-05, K-14
% 28.10.2026. Bu dosya inverter_common_parameters.m'den SONRA taban çalışma
% alanında çalıştırılır (modelin PreLoadFcn'i ve koşu betiği). Ortak parametre
% dosyası değiştirilmez; burada yalnız S4'e özgü ve m-dosyasında karşılığı
% olmayan denetim/ölçüm değişkenleri tanımlanır. Değerler varsayılandır: koşu
% betiği (run_s4_closed_loop_20261028.m) denetleyici kipine göre üzerine yazar.
%
% Kaynaklar:
%   Kp (= 0.03)                 12.10 m-dosyası ve 12.10 e-postası (oransal L1 akım denetimi)
%   Ifaz_rms_target(4) (= 25 A) 12.10 m-dosyası, K-05
%   fsw, pwm_ref_Ts, L1, C, L2  12.10 m-dosyası
%   PI sıfırı, gecikme, ölçüm   İP-5 tasarımı (design_s4_controller_20261028.m, review notu)

% --- Örnekleme ve ölçüm zinciri ------------------------------------------------
% 12.10 tarifine uygun olarak denetim, modelin mevcut denetim hızında (pwm_ref_Ts
% = 1 µs; PWM görev oranı da 1 µs ile örneklenir) yürür; hesaplama gecikmesi
% yoktur (sürekli/analog eşdeğeri). i_L1 ölçümüne tek kutuplu kenar yumuşatma
% (anti-aliasing) süzgeci konur: köşe fsw/2 = 5 kHz. Gerekçe: (1) anahtarlama
% dalgalılığının (~9 A tepe-tepe, d = 0,5) modülasyona geri beslenmesini ve
% testere dişi karşılaştırıcıda çoklu kesişimi önlemek (eğim koşulu); (2) LCL
% rezonansında (~2,8 kHz) ek faz gecikmesini 90°'nin altında tutmak. PWM periyodu
% başında tek örnek alan ve görev oranını bir sonraki periyotta yükleyen sayısal
% gerçekleme (≥ 1 Ts gecikme) bu LCL'de (f_res > fs/6) L1 akım geri beslemesini
% etkin sönümleme olmadan kararsız yapar (design_s4_controller_20261028.m).
S4_Ts_c   = pwm_ref_Ts;                     % [s] denetleyici örnekleme periyodu (1 µs)
S4_f_lp   = fsw/2;                          % [Hz] ölçüm süzgeci köşe frekansı
S4_lp_a   = exp(-2*pi*S4_f_lp*S4_Ts_c);     % [-] ayrık tek kutup: y = a*y + (1-a)*x
S4_lp_num = 1 - S4_lp_a;
S4_lp_den = [1, -S4_lp_a];
S4_iL1_sign = 1;                            % [-] Current Sensor1 yönü: +1 = faz -> L1 (evirici -> şebeke)

% --- Akım referansı --------------------------------------------------------------
% i_ref = sqrt(2)*I_ref(t)*sin(2*pi*f_grid*t + 0): şebeke fazına kilitli (Grid1
% faz kayması 0; ideal PLL). I_ref(t) basamak bloğundan gelir.
S4_Iref      = Ifaz_rms_target(4);          % [A RMS] basamak öncesi referans
S4_Iref_step = S4_Iref;                     % [A RMS] basamak sonrası referans
S4_t_step    = 1e3;                         % [s] basamak anı (1e3: basamak yok)

% --- Denetleyici kazançları (birim: görev oranı / A) ----------------------------
% Kip P (12.10 tarifi): u_fb = Kp*e.
% Kip PI: u_fb = Kp*e + Ki*sum(e)*Ts  (ileri Euler), geri hesaplamalı anti-windup.
% Kip PIR (isteğe bağlı): PI + 50 Hz rezonans terimi (S4_Kr > 0).
S4_Kp_c = Kp;                               % [1/A]
S4_PI_fz = 60;                              % [Hz] PI sıfırı (geçiş frekansının ~1/10'u)
S4_Ki_c = 0;                                % [1/(A s)] P kipinde 0
S4_Kaw  = 0;                                % [1/s] geri hesaplama kazancı (PI: 1/Ti)
S4_Kr   = 0;                                % [1/A] rezonans kazancı (0: rezonans kapalı)
S4_PIR_Kr = 10*Kp;                          % [1/A] PIR kipinde kullanılan tasarım değeri
S4_R_wb = 2*pi*2;                           % [rad/s] rezonans bant genişliği (ωb)
S4_int_lim = 1;                             % [-] integratör durum sınırı (görev oranı)
S4_u_lim   = 1;                             % [-] modülasyon sınırı |u| <= 1

% Rezonans teriminin ayrık eşdeğeri: R(s) = 2*Kr*wb*s/(s^2 + 2*wb*s + w0^2),
% Tustin + w0 ön bükmesi. Blok payı S4_Kr*S4_R_num1'dir; Kr = 0 iken pay sıfırdır,
% blok yapısı değişmez.
s4_w0 = 2*pi*f_grid;
s4_K  = s4_w0/tan(s4_w0*S4_Ts_c/2);         % ön bükmeli Tustin sabiti
s4_a0 = s4_K^2 + 2*S4_R_wb*s4_K + s4_w0^2;
S4_R_num1 = 2*S4_R_wb*s4_K*[1 0 -1]/s4_a0;   % Kr = 1 için pay
S4_R_den = [1, (2*s4_w0^2 - 2*s4_K^2)/s4_a0, (s4_K^2 - 2*S4_R_wb*s4_K + s4_w0^2)/s4_a0];
clear s4_w0 s4_K s4_a0
