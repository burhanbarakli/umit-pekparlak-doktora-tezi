% Kapalı çevrim Q1-Q4 T-tipi deneme parametreleri
run(fullfile(fileparts(mfilename('fullpath')),'switching_demo_parameters.m'));

I_ref_rms_cl = 2.3;               % A
I_ref_pk_cl = sqrt(2)*I_ref_rms_cl;
Kp_cl = 5.0;                      % V/A, geçici
Kr_cl = 35.0;                     % rezonans kazancı, geçici
wc_cl = 2*pi*5;                   % rad/s rezonans bant genişliği
Ksin3_cl = -2.0;                  % V, 2 us ölü zamanlı geçici taramada en düşük THD
sin3_enable_cl = 0;               % 0/1
neutral_suppression_enable = 0;   % 0: klasik O durumu, 1: diyot benzetimi
modulation_limit_cl = 0.95;
Ts_control_cl = T_switch;          % bir PWM periyotluk örnekleme/hesap gecikmesi
dead_time_cl = 2e-6;               % s, DENEME - gerçek sürücü/PWM kodundan doğrulanacak
neutral_suppression_3ph = 0;       % 0: klasik O durumu, 1: nötr anahtar susturma
Ksin3_3ph = -2;                    % V, fiziksel üç faz ince taramasında en düşük nötr RMS
Kzero3_cl = 22;                    % V/A, ince taramada en düşük nötr RMS (DENEME)
wc_zero3_cl = 2*pi*10;             % rad/s, üçüncü harmonik rezonans bant genişliği
Vzero_limit_cl = 30;               % V, ortak-mod kompanzasyon sınırı (DENEME)
