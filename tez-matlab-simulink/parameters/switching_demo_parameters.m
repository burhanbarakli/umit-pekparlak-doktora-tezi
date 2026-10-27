% Q1-Q4 anahtarlamalı tek faz T-tipi Simscape Electrical denemesi

f_grid_sw = 50;                    % Hz
w_grid_sw = 2*pi*f_grid_sw;
V_grid_rms_sw = 120;               % V
V_grid_pk_sw = sqrt(2)*V_grid_rms_sw;
Vdc_sw = 400;                      % V toplam bölünmüş bara

f_switch = 10000;                  % Hz, LCL rezonansının yeterince üzerinde deneme
T_switch = 1/f_switch;
m_index = 0.86;                    % geçici açık çevrim modülasyon indeksi

L1_sw = 2e-3;                      % H, DENEME
R1_sw = 0.20;                      % ohm, DENEME
Cf_sw = 10e-6;                     % F, DENEME
Rd_sw = 3.0;                       % ohm, seri pasif sönüm
L2_sw = 1e-3;                      % H, DENEME
R2_sw = 0.15;                      % ohm, DENEME

Ron_sw = 0.01;                     % ohm, ideal IGBT iletim direnci
Goff_sw = 1e-6;                    % 1/ohm
Vf_sw = 0.8;                       % V
Vth_sw = 0.5;                      % V, 0/1 kapı sinyali için

t_stop_sw = 0.08;                  % s
max_step_sw = 1e-6;                % s
analysis_start_sw = 0.04;          % s
