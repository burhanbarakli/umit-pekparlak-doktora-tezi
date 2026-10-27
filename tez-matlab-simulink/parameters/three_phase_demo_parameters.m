% Üç fazlı dört telli ortalama değer denemesi
run(fullfile(fileparts(mfilename('fullpath')),'closed_loop_demo_parameters.m'));

phase_shift_3ph = [0 -2*pi/3 2*pi/3];
I_ref_rms_3ph = 2.3;
I_ref_pk_3ph = sqrt(2)*I_ref_rms_3ph;
V_grid_rms_3ph = 120;
V_grid_pk_3ph = sqrt(2)*V_grid_rms_3ph;

Kp_3ph = Kp_cl;
Kr_3ph = Kr_cl;
wc_3ph = wc_cl;
Kdist_3ph = 6.0;                 % V, nötr susturma kaynaklı kavramsal sin^3 bozucu
Ksin3_3ph = -6.0;                % V, ideal karşı kompanzasyon denemesi
suppression_effect_enable_3ph = 0;
sin3_enable_3ph = 0;
t_stop_3ph = 0.20;
analysis_start_3ph = 0.10;

% Seri sönümlü faz başına LCL durum uzayı, x=[i1 vc i2].
A_lcl_3ph = [-(R1_sw+Rd_sw)/L1_sw, -1/L1_sw, Rd_sw/L1_sw; ...
    1/Cf_sw, 0, -1/Cf_sw; ...
    Rd_sw/L2_sw, 1/L2_sw, -(R2_sw+Rd_sw)/L2_sw];
B_lcl_3ph = [1/L1_sw, 0; 0, 0; 0, -1/L2_sw];
C_lcl_3ph = [0 0 1];
D_lcl_3ph = [0 0];
