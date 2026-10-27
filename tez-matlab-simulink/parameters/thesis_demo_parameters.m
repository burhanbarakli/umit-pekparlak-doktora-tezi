% Tez Simulink denemesi - geçici ve açıkça izlenebilir parametreler

f_grid = 50;                 % Hz
w_grid = 2*pi*f_grid;        % rad/s
V_grid_rms = 120;            % V, eski tezdeki düşük güç deney aralığı
V_grid_pk = sqrt(2)*V_grid_rms;
I_ref_rms = 2.3;             % A, eski tez düşük güç çalışma noktası
I_ref_pk = sqrt(2)*I_ref_rms;

Vdc = 400;                   % V, toplam/yarım bara tanımı tezde doğrulanacak
L1 = 2e-3;                   % H, DENEME DEĞERİ - gerçek bobin değeri doğrulanacak
R1 = 0.20;                   % ohm, DENEME DEĞERİ
Cf = 10e-6;                  % F, DENEME DEĞERİ - gerçek değer doğrulanacak
Rd = 3.0;                    % ohm, LCL kapasitörüne seri pasif sönüm (DENEME)
L2 = 1e-3;                   % H, DENEME DEĞERİ - gerçek bobin değeri doğrulanacak
Lg = 0.25e-3;                % H, DENEME şebeke endüktansı
R2 = 0.15;                   % ohm, DENEME DEĞERİ

Kp = 8;                      % V/A, basit P akım denetimi; gerçek denetleyici değil
Kdist = 8;                   % V, düşük güç sin^3 bozucu eşdeğeri
Ksin3 = -8;                  % V, ideal karşı kompanzasyon
sin3_enable = 0;             % 0: kapalı, 1: açık

t_stop = 0.20;               % s
max_step = 1e-5;             % s
analysis_start = 0.10;       % s, ilk geçici rejim analiz dışı
analysis_fs = 50000;         % Hz, metrik hesabı için yeniden örnekleme
