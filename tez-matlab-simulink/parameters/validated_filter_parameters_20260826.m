% 2026-08-26 kaynak ayrıştırmasıyla seçilen faz-başına LCL parametreleri.
%
% 600 uH tam topolojide A/B/C faz bobinlerinin ortak değeridir.
% 200 uH en yeni parametre notu ve Excel gerçek uygulama S1-S2 satırlarında
% bağımsız olarak bulunur. Kaynak .slx içindeki CL1=400 uH eski model ayarıdır.

validated_filter_20260826 = struct();
validated_filter_20260826.status = "SELECTED_FROM_AVAILABLE_SOURCES";
validated_filter_20260826.date = "2026-08-26";
validated_filter_20260826.L1_H = 600e-6;
validated_filter_20260826.L1_R_ohm = 0.02;
validated_filter_20260826.Cf_F = 8e-6;
validated_filter_20260826.Cf_R_ohm = 0.01;
validated_filter_20260826.L2_H = 200e-6;
validated_filter_20260826.L2_R_ohm = 0.02;
validated_filter_20260826.f_switch_reference_Hz = 10000;
validated_filter_20260826.f_grid_Hz = 50;
validated_filter_20260826.f_res_ideal_Hz = ...
    (1/(2*pi))*sqrt((validated_filter_20260826.L1_H + ...
    validated_filter_20260826.L2_H)/(validated_filter_20260826.L1_H * ...
    validated_filter_20260826.L2_H * validated_filter_20260826.Cf_F));
validated_filter_20260826.source_note = ...
    "incoming_real_data/parameters/2026-08-22_umit_senaryo_parametreleri.md";
validated_filter_20260826.source_workbook = ...
    "incoming_real_data/measurements/degerler_senaryo_ozeti_2026-08-17.xlsx";
validated_filter_20260826.source_topology = ...
    "incoming_real_data/schematics/tam_topoloji_2026-08-22.pdf";
validated_filter_20260826.legacy_model_L2_H = 400e-6;
validated_filter_20260826.note = ...
    "400 uH remains only in the archived source model until R2025b conversion is repaired.";
