% 2026-08-22 tarihinde Umit'ten gelen aday deney parametreleri.
%
% UYARI:
% - Bu dosya mevcut deney betikleri tarafindan calistirilmaz.
% - Kaynaklar arasindaki celiskiler giderilmeden etkin parametre dosyalarina
%   kopyalanmamalidir.
% - Bildirilen verim/THD degerleri ayar hedefi degil, yeniden uretilmesi ve
%   bagimsiz hesapla dogrulanmasi gereken kaynak iddialaridir.

received_20260822 = struct();
received_20260822.status = "PARTIALLY_VALIDATED_L2_SELECTED_NOT_ACTIVE";
received_20260822.source_note = fullfile('incoming_real_data','parameters', ...
    '2026-08-22_umit_senaryo_parametreleri.md');
received_20260822.schematic_file = fullfile('incoming_real_data','schematics', ...
    'tam_topoloji_2026-08-22.pdf');
received_20260822.schematic_render_file = fullfile('incoming_real_data', ...
    'schematics','tam_topoloji_2026-08-22_rendered.png');
received_20260822.schematic_original_pdf_pending = false;
received_20260822.schematic_original_pdf_sha256 = ...
    "133f1e967ff1e49aa8b349b75eca0b75964f449ab43158836d8f75a927b39b3d";
received_20260822.scenario1_model_file = fullfile('incoming_real_data', ...
    'models','Inverter2_senaryo1_2026-08-16.slx');
received_20260822.results_workbook_file = fullfile('incoming_real_data', ...
    'measurements','degerler_senaryo_ozeti_2026-08-17.xlsx');
received_20260822.modeling_note_file = fullfile('incoming_real_data', ...
    'parameters','simulasyon_duzeltmeleri_2026-08-16.docx');
received_20260822.relationship_review_file = fullfile('review', ...
    '2026-08-22_SENARYO_KAYNAK_ILISKI_MATRISI.md');

% Ortak LCL parametreleri - e-posta metnindeki SI karsiliklari.
received_20260822.common.L1_H = 600e-6;
received_20260822.common.L1_R_ohm = 0.02;
received_20260822.common.L2_H = 200e-6; % 2026-08-26 kaynak ayrıştırmasıyla seçildi.
received_20260822.common.L2_R_ohm = 0.02;
received_20260822.common.C_F = 8e-6;
received_20260822.common.C_R_ohm = 0.01;

% S12 ve S34 icin ayni bildirilen anahtarlama zamanlari.
switch_timing = struct( ...
    'turn_on_delay_s',165e-9, ...
    'turn_off_delay_s',400e-9, ...
    'rise_time_s',600e-9, ...
    'fall_time_s',600e-9);
received_20260822.semiconductor.S12 = switch_timing;
received_20260822.semiconductor.S34 = switch_timing;

% DS12, DS34 ve D12 icin ayni bildirilen diyot parametreleri.
diode_parameters = struct( ...
    'Vf_V',1.35, ...
    'Ron_ohm',8.5e-3, ...
    'Cj_F',31e-12, ...
    'iRM_A',-13, ...
    'Iif_A',60, ...
    'Iroffcrg_A_per_us',-300, ...
    'Iroffcrg_A_per_s',-300e6, ...
    'trr_s',380e-9);
received_20260822.semiconductor.DS12 = diode_parameters;
received_20260822.semiconductor.DS34 = diode_parameters;
received_20260822.semiconductor.D12 = diode_parameters;

% Senaryo 1: komplement anahtarlamali T-tipi mevcut model.
received_20260822.scenario(1).name = "Complementary T-type";
received_20260822.scenario(1).Vdc_V = 431;
received_20260822.scenario(1).Vrms_V = 169;
received_20260822.scenario(1).reported_efficiency_pct = 92.5;
received_20260822.scenario(1).reported_THD_pct = NaN;

% Senaryo 2: notr IGBT'leri alternans boyunca sabit 1/0.
received_20260822.scenario(2).name = "Neutral IGBT half-cycle suppression";
received_20260822.scenario(2).Vdc_V = 431;
received_20260822.scenario(2).Vrms_V = 169;
received_20260822.scenario(2).reported_efficiency_pct = 94.2;
received_20260822.scenario(2).reported_THD_pct = 47;

% Senaryo 3: K1*sin(x) + K3*sin(x)^3 ileri beslemesi.
received_20260822.scenario(3).name = "Neutral suppression plus sin-cubed feedforward";
received_20260822.scenario(3).Vdc_V = 431;
received_20260822.scenario(3).Vrms_V = 169;
received_20260822.scenario(3).reported_efficiency_pct = 94.5;
received_20260822.scenario(3).reported_THD_pct = 14;

% Senaryo 4: ileri besleme + PI, L1 akim geri beslemesi.
received_20260822.scenario(4).name = "Sin-cubed feedforward plus PI current loop";
received_20260822.scenario(4).Vdc_V = NaN;
received_20260822.scenario(4).Vrms_V = NaN;
received_20260822.scenario(4).reported_efficiency_pct = NaN;
received_20260822.scenario(4).reported_THD_pct = NaN;
received_20260822.scenario(4).reported_current_approx_A = 30;

% Excel'deki "Gercek uygulama sonuclari" ozeti. Ham zaman serisi degildir.
received_20260822.results.real_application(1) = struct( ...
    'Vdc_V',431.5,'Idc_A',0.624,'Vac_rms_V',119.8,'Iphase_A',2.26, ...
    'Pout_W',249.6,'cos_phi',1.000,'THD_pct',15,'efficiency_pct',92.5, ...
    'Pdc_from_VI_W',431.5*0.624, ...
    'efficiency_recomputed_pct',100*249.6/(431.5*0.624));
received_20260822.results.real_application(2) = struct( ...
    'Vdc_V',395.0,'Idc_A',0.684,'Vac_rms_V',121.0,'Iphase_A',2.33, ...
    'Pout_W',253.2,'cos_phi',-0.995,'THD_pct',47,'efficiency_pct',94.2, ...
    'Pdc_from_VI_W',395.0*0.684, ...
    'efficiency_recomputed_pct',100*253.2/(395.0*0.684));
received_20260822.results.real_application(3) = struct( ...
    'Vdc_V',427.5,'Idc_A',0.697,'Vac_rms_V',124.3,'Iphase_A',2.31, ...
    'Pout_W',281.2,'cos_phi',-0.997,'THD_pct',14,'efficiency_pct',94.5, ...
    'Pdc_from_VI_W',427.5*0.697, ...
    'efficiency_recomputed_pct',100*281.2/(427.5*0.697));

% Excel'in simulasyon bolumu ayni temel sayilari sabit olarak tekrarliyor.
received_20260822.results.simulation_duplicates_real_summary = true;

% Gelen Inverter2.slx dosyasinin salt-okunur inceleme ozeti.
received_20260822.model_snapshot.model_release = "R2023b";
received_20260822.model_snapshot.Vdc_V = 431.5;
received_20260822.model_snapshot.Vgrid_peak_V = 169.4;
received_20260822.model_snapshot.f_grid_Hz = 50;
received_20260822.model_snapshot.f_pwm_Hz = 10000;
received_20260822.model_snapshot.solver = "ode15s";
received_20260822.model_snapshot.max_step_s = 1e-7;
received_20260822.model_snapshot.stop_time_s = 0.1;
received_20260822.model_snapshot.L1_H = 600e-6;
received_20260822.model_snapshot.L1_R_ohm = 0.1;
received_20260822.model_snapshot.CL1_H = 400e-6;
received_20260822.model_snapshot.CL1_R_ohm = 0.2;
received_20260822.model_snapshot.Cfilter_F = 8e-6;
received_20260822.model_snapshot.Cfilter_R_ohm = 1e-6;
received_20260822.model_snapshot.final_device_blocks_all_connected = false;

% 2026-08-26 kararı: şemadaki L1/L2/L3, LCL sırasını değil A/B/C faz
% bobinlerini gösterir ve her biri 600 uH'dir. E-posta ile Excel gerçek
% uygulama S1-S2 satırlarında tekrarlanan 200 uH, LCL'nin nihai L2 değeridir.
% Kaynak modeldeki CL1=400 uH eski model ayarı olarak korunur.
received_20260822.filter_decision.date = "2026-08-26";
received_20260822.filter_decision.L1_H = 600e-6;
received_20260822.filter_decision.Cf_F = 8e-6;
received_20260822.filter_decision.L2_H = 200e-6;
received_20260822.filter_decision.legacy_model_CL1_H = 400e-6;
received_20260822.filter_decision.status = "SELECTED_FROM_AVAILABLE_SOURCES";

clear switch_timing diode_parameters;
