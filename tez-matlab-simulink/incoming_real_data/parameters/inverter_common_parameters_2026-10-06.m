clc

% Model ile ayni klasordeki ozel dort-uclu CMC kutuphanesini MATLAB yoluna ekle.
parameter_file_path = mfilename('fullpath');
if ~isempty(parameter_file_path)
    addpath(fileparts(parameter_file_path));
end
clear parameter_file_path

%% ORTAK DEVRE PARAMETRELERI
% Bu dosya tum senaryo modellerinin ortak fiziksel parametre kaynagidir.
% SI birimleri kullanilmistir; Simscape bloklarindaki birim alanlari da SI'a
% ayarlanmistir. Senaryolar arasinda ortak kalmasi gereken degerleri burada
% degistirmek, bu dosyayi kullanan tum modelleri ayni anda gunceller.

L1  = 600e-6;             % [H] inverter tarafi LCL enduktansi
L1r = 0.03; %0.10;               % [Ohm] L1 seri direnci (mevcut modeldeki deger)
%L1_core_Rp = 470; %1.5e3;       % [Ohm] L1 aktif cekirdek kaybi esdeger direnci
%L2  = 950e-6;             % [H] sebeke + varyak ortak esdeger enduktansi (400 uH deneme)
%L2  = 500e-6;
L2r = 0.10;               % [Ohm] sebeke + varyak ortak seri direnci
C   = 8e-6;               % [F] LCL kondansatoru
Cr  = 0.01;               % [Ohm] kondansator ESR / sonumleme direnci
Rdc = 1e-3;               % [Ohm] DC kaynak baglanti direnci (mevcut modeldeki deger)

% Mevcut devredeki enerji depolama/EMI yardimci elemanlari.
Cdc_pos = 470e-6;         % [F] pozitif DC bara kapasitörü
Cdc_neg = 470e-6;         % [F] negatif DC bara kapasitörü
Cdc_esr = 0.10;           % [Ohm] DC bara kapasitörü ESR
C_emc_aux = 1e-6;         % [F] EMI yardimci kapasitörü
R_emc_aux = 0.01;         % [Ohm] EMI yardimci kapasitörü ESR
R_bleed_1 = 220e3;        % [Ohm] EMI/ag referans direnci 1
R_bleed_2 = 220e3;        % [Ohm] EMI/ag referans direnci 2

% DC kaynaga geri akimi engelleyen sembolik seri diyot.
DCB_Vf       = 0.05;      % [V]
DCB_Ron      = 1.0;       % [Ohm]
DCB_Goff     = 1e-8;      % [S]
DCB_Cj       = 1e-12;     % [F]
DCB_iRM      = -7.15;     % [A]
DCB_If       = 4.0;       % [A]
DCB_didt     = -750e6;    % [A/s]
DCB_trr      = 115e-9;    % [s]
DCB_Qrr      = 150e-9;    % [C]
DCB_Vr       = -600;      % [V]
DCB_Ls       = 150e-9;    % [H]
DCB_Tdevice  = 25;        % [degC]

% SimPower deney modelinden aktarilan iki kademeli EMC filtresi.
% Her ortak-mod bobininde iki esit sargi vardir. Iki adet 1 uF/0.1 Ohm
% seri RC kolu hat ve donus arasinda yüzer orta noktali X2 agini olusturur.
EMC_Lw = 400e-6;          % [H] her sarginin oz enduktansi
EMC_Rw = 5e-3;            % [Ohm] her sarginin seri direnci
EMC_M  = 398e-6;          % [H] karsilikli enduktans
EMC_k  = EMC_M/EMC_Lw;    % [-] = 0.995
EMC_Rcore = 1e5;          % [Ohm] her CMC sargisina paralel 100 kOhm cekirdek kaybi direnci
EMC_Cx_each = 1e-6;       % [F] iki seri X2 kolunun her biri
EMC_Rx_each = 0.1;        % [Ohm] her X2 kolunun seri direnci
% Y/PE yolu bulunmayan tek-faz diferansiyel model icin tam esdegerler:
EMC_Ldm_stage = 2*(EMC_Lw-EMC_M); % [H] = 4 uH, her CMC kademesi
EMC_Rdm_stage = 2*EMC_Rw;         % [Ohm] = 10 mOhm, iki sargi toplami
EMC_Cx_eq = EMC_Cx_each/2;        % [F] = 0.5 uF, iki esit C seri
EMC_Rx_eq = 2*EMC_Rx_each;        % [Ohm] = 0.2 Ohm
EMC_Rref = 1e9;                   % [Ohm] floating AC network numerical reference only

Tj_operating = 25;        % [degC] ortak calisma/jonksiyon sicakligi
Tj_operating_K = Tj_operating + 273.15; % [K] IGBT bloklarinin kullandigi birim
RG_total     = 15;        % [Ohm] harici+dahili toplam etkin gate direnci
Vgate_on     = 15;        % [V] gate surucu yuksek seviyesi
Vgate_off    = -5;        % [V] gate surucu dusuk seviyesi
gate_logic_high = 0.7;    % [1] gate driver mantiksal 1 esigi
gate_logic_low  = 0.3;    % [1] gate driver mantiksal 0 esigi
gate_driver_rise = 20e-9; % [s] gate driver cikis rise time
gate_driver_fall = 20e-9; % [s] gate driver cikis fall time
gate_driver_cload = 10e-9;% [F] gate driver esdeger yuk kapasitansi
gate_driver_ton = 0;      % [s] gate driver ilave on delay
gate_driver_toff = 0;     % [s] gate driver ilave off delay
fsw          = 10e3;      % [Hz] PWM anahtarlama frekansi
deadtime     = 1e-6;      % [s] PIC32: DTR=ALTDTR=120, PTPER=12000 @ 10 kHz
f_grid       = 50;        % [Hz] AC kaynak/PWM referans frekansi
pwm_ref_amp  = 1;         % [1] PWM sinüs referans genligi
pwm_ref_Ts   = 1e-6;      % [s] PWM sinüs referans örnekleme zamani

% Ortak sayisal cozum ayarlari (fiziksel kalibrasyon parametresi degildir).
sim_max_step = 1e-7;                 % [s]
sim_min_step = 1e-8;                 % [s] low-step convergence test
sim_rel_tol  = 1e-4;
sim_abs_tol  = 1e-6;
simscape_residual_tolerance = 1e-6;

%% S1-S2 IGBT PARAMETRELERI
% Simscape: Simplified I-V characteristics and event-based timing |
% Show thermal port. S1 ve S2 ayni parametre grubunu kullanir.
% S1-S2 için aktif iletim tablosu SKM100GB12T4'e aittir. 25 degC,
% VGE=15 V satırı SKM100 datasheet'indeki maksimum VCE0=0.9 V ve
% rCE=11.5 mOhm doğrusu ile oluşturulmuştur: VCE=0.9+0.0115*Ic.
% Simscape requires at least two strictly monotonic temperature samples even
% for a fixed-temperature model; the 0.0001 K separation is negligible.
S12_Tj_cond       = [298.15, 298.1501];                      % [K] 25 degC; epsilon second grid point
S12_Ic_cond       = [0, 1, 2, 5, 8, 10, 20, 30, 40, 50];     % [A]
S12_Vce_cond_25C  = [0, 0.9115, 0.9230, 0.9575, 0.9920, 1.0150, 1.1300, 1.2450, 1.3600, 1.4750]; % [V]
S12_Vce_cond      = [S12_Vce_cond_25C; S12_Vce_cond_25C];
S12_Rmiller       = 0.1;                                  % [Ohm]
S12_Goff          = 1e-5;                                 % [S]
S12_Vge_threshold = 6;                                    % [V]

% SKM100 datasheet switching-energy curves are specified at VCC=600 V,
% IC=100 A, Tj=150 degC and RG=1 Ohm (Eon=15 mJ, Eoff=10.2 mJ).
% Figure 3/4 supplies the technology trend, but does not resolve 1/2/5/8 A
% points. Therefore the values below are a transparent low-current
% engineering interpolation tied to the existing 10 A SKM-family anchors;
% they are not direct 1--8 A measurements. Eon is scaled modestly for the
% model's RG_total=10 Ohm; Eoff is left essentially RG-independent.
S12_Tj_loss = [298.15, 298.1501];                        % [K] monotonic 25 degC grid
S12_Ic_loss = S12_Ic_cond;                              % [A] [0 1 2 5 8 10 20 30 40 50]
S12_Eon_25C   = [0, .020, .040, .100, .160, .200, .400, .600, .800, 1.000]*1e-3; % [J]
S12_Eoff_25C  = [0, .030, .060, .150, .240, .300, .600, .900, 1.200, 1.500]*1e-3; % [J]
S12_Eon       = [S12_Eon_25C; S12_Eon_25C];
S12_Eoff      = [S12_Eoff_25C; S12_Eoff_25C];

% Initial physical estimate for the 25 degC, 2-3 A operating region.
% These are engineering starting values, not direct SKM100 2-3 A
% datasheet points (the datasheet timing table is at 100 A, 150 degC).
S12_tondly   = 200e-9;    % [s]
S12_toffdly  = 600e-9;    % [s]
S12_risetime = 60e-9;     % [s]
S12_falltime = 110e-9;     % [s]
S12_Voff_ref = 600;      % [V] SKM datasheet Eon/Eoff test gerilimi
S12_thermal_network = ee.enum.thermalNetworkTopology.junctionCase;
S12_Rth = [0, 10];                         % [K/W]
S12_thermal_mass_parameterization = ee.enum.thermalNetwork.timeconstant;
S12_thermal_mass = [0, 1];                 % [J/K]
S12_thermal_time_constant = [0, 10];       % [s]
S12_thermal_initial_temperature = [25, 25];% [degC]

%% S3-S4 IGBT PARAMETRELERI
% Mevcut %93.61 referans modelinde S3-S4 de hazir IGBT ile ayni degerdedir.
% Ayri isimlendirme, sonraki iterasyonlarda notr IGBT'lerin birlikte ve
% senaryolar arasinda ortak olarak degistirilmesini saglar.
S34_Tj_cond       = [298.15, 298.1501];
% Nötr IGBT: IXYN100N65C3H1, 25 degC / VGE=15 V.
% Dusuk-akim noktaları datasheet cikis eg risinden okunup yuvarlanmistir;
% 0 A disinda VCE(sat) icin 0.8 V alt siniri korunur.
S34_Ic_cond       = [0, 1, 2, 5, 8, 10, 20, 30, 40, 50];
S34_Vce_cond_25C  = [0, 0.800, 0.820, 0.880, 0.940, 1.000, 1.180, 1.360, 1.540, 1.680]; % [V]
S34_Vce_cond      = [S34_Vce_cond_25C; S34_Vce_cond_25C];
S34_Rmiller       = S12_Rmiller;
S34_Goff          = S12_Goff;
S34_Vge_threshold = S12_Vge_threshold;
S34_Tj_loss       = [298.15, 298.1501];
S34_Ic_loss       = S34_Ic_cond;
% IXYN device-specific switching-energy envelope. The 0--10 A points
% retain the existing low-current technology-matched surrogate. The
% 10--50 A segment is linearly resampled to the new current grid and the
% 50 A IXYS datasheet anchor is retained; these are not direct 1--10 A IXYS
% measurements. Energies are in joules after the 1e-3 conversion.
S34_Eon_25C       = [0, .05, .08, .17, .24, .26, .52, .78, 1.04, 1.30]*1e-3;
S34_Eon           = [S34_Eon_25C; S34_Eon_25C];
S34_Eoff_25C      = [0, .07, .12, .25, .34, .38, .4925, .605, .7175, .83]*1e-3;
S34_Eoff          = [S34_Eoff_25C; S34_Eoff_25C];
% IXYN100N65C3H1 datasheet timing anchor: TJ=25 degC,
% IC=50 A, VCE=400 V, VGE=15 V, RG=3 Ohm.
S34_tondly        = 200e-9;  %24e-9;  % [s] td(on)
S34_toffdly       = 50e-9;  %134e-9; % [s] td(off)
S34_risetime      = 100e-9;  %38e-9;  % [s] tri
S34_falltime      = 1000e-9;  %66e-9;  % [s] tfi
S34_Voff_ref      = 400; % [V] IXYS datasheet Eon/Eoff test gerilimi
S34_thermal_network = S12_thermal_network;
S34_Rth = S12_Rth;
S34_thermal_mass_parameterization = S12_thermal_mass_parameterization;
S34_thermal_mass = S12_thermal_mass;
S34_thermal_time_constant = S12_thermal_time_constant;
S34_thermal_initial_temperature = S12_thermal_initial_temperature;

%% S1-S2 PARALEL DIYOTLARI (DS1-DS2)
DS12_Vf       = 1.50;       % [V] SKM100GB12T4 diode VF0 max/konservatif
DS12_Ron      = 10.2e-3;    % [Ohm] SKM datasheet rF max
DS12_Goff     = 1e-8;       % [S]
DS12_Cj       = 0;          % [F]
DS12_iRM      = -54;        % [A]
DS12_Iif      = 100;        % [A] SKM datasheet reverse-recovery test ileri akimi
DS12_Iroffcrg = -1600e6;    % [A/s]
% SKM datasheet trr'yi ayri bir tablo degeri olarak vermiyor; peakcharge
% modeli Qrr/iRM ile tanimlandigi icin bu alan onceki sayisal placeholder'dir.
DS12_trr      = 115e-9;     % [s] engineering placeholder (not tabulated)
DS12_Qrr      = 15.7e-6;    % [C]
DS12_Vr_test  = -600;       % [V]
DS12_Ls       = 150e-9;     % [H]
DS12_Tdevice  = 25;         % [degC]
DS12_junction_thermal_mass = 0.01; % [J/K]
DS12_diode_model = ee.enum.diode.modelType.pwl;
DS12_cap_model   = ee.enum.diode.capParam.fixed;
DS12_recovery_model = ee.enum.diode.recoveryParam.peakcharge;
DS12_fidelity = ee.enum.diode.fidelity.includeChargeDyn;
DS12_temperature_model = ee.enum.diode.temperatureParam.off;
DS12_thermal_network = ee.enum.thermalNetworkTopology.external;

%% S3-S4 PARALEL DIYOTLARI (DS3-DS4)
% IXYN100N65C3H1 ic FRD: VF=1.7 V min / 2.3 V max at IF=100 A, TJ=25 C.
% 1.7 V + 6 mOhm*IF, 100 A datasheet ust sinirina oturan muhendislik PWL fitidir.
DS34_Vf       = 1.70;       % [V]
DS34_Ron      = 6e-3;       % [Ohm] derived PWL slope to 2.3 V at 100 A
DS34_Goff     = 1e-8;       % [S]
% IXYN FRD datasheetinde Cj verilmedigi icin DSEI Cj degeri kopyalanmiyor.
DS34_Cj       = 0;          % [F] not specified for the IXYN FRD
% IXYN reverse-recovery anchor: IF=100 A, TJ=150 C, VR=400 V,
% -diF/dt=1500 A/us. Qrr is read approximately from datasheet Fig. 24.
DS34_iRM      = -95;        % [A] typ.
DS34_Iif      = 100;        % [A]
DS34_Iroffcrg = -1500e6;    % [A/s]
DS34_trr      = 100e-9;     % [s] typ.
DS34_Qrr      = 9.5e-6;     % [C] approx. Fig. 24 value at IF=100 A
DS34_Vr_test  = -400;       % [V]
DS34_Ls       = 150e-9;     % [H]
DS34_Tdevice  = 25;         % [degC]
DS34_junction_thermal_mass = 0.01; % [J/K]
DS34_diode_model = ee.enum.diode.modelType.pwl;
DS34_cap_model   = ee.enum.diode.capParam.fixed;
DS34_recovery_model = ee.enum.diode.recoveryParam.peaktime;
DS34_fidelity = ee.enum.diode.fidelity.includeChargeDyn;
DS34_temperature_model = ee.enum.diode.temperatureParam.off;
DS34_thermal_network = ee.enum.thermalNetworkTopology.external;

%% HARICI D1-D2 DIYOTLARI
% D1 ve D2 ayni DSEI cihazidir ve tek ortak parametre grubunu kullanir.
D12_Vf       = 1.58;        % [V] DSEI equivalent VF0 at TJ=150 C
D12_Ron      = 8.5e-3;      % [Ohm] DSEI rF (power-loss fit; TJ=150 C)
D12_Goff     = 1e-8;        % [S]
D12_Cj       = 31e-12;      % [F]
D12_iRM      = -13;         % [A]
D12_Iif      = 60;          % [A]
D12_Iroffcrg = -300e6;      % [A/s]
% DSEI datasheet: trr=190 ns typ at TJ=25 C and 380 ns typ at TJ=100 C,
% IF=60 A, VR=540 V, -diF/dt=300 A/us. Use the 25 C anchor here.
D12_trr      = 190e-9;      % [s]
% Qrr is plotted in microcoulombs, not given as 150 nC; approx. 3 uC
% is read from Fig. 2 near IF=60 A and -diF/dt=300 A/us.
D12_Qrr      = 3.0e-6;      % [C] approximate datasheet-curve value
D12_Vr_test  = -540;        % [V] DSEI reverse-recovery test voltage
D12_Ls       = 150e-9;      % [H]
D12_Tdevice  = 25;          % [degC]
D12_junction_thermal_mass = 0.01; % [J/K]
D12_diode_model = ee.enum.diode.modelType.pwl;
D12_cap_model   = ee.enum.diode.capParam.fixed;
D12_recovery_model = ee.enum.diode.recoveryParam.peaktime;
D12_fidelity = ee.enum.diode.fidelity.includeChargeDyn;
D12_temperature_model = ee.enum.diode.temperatureParam.off;
D12_thermal_network = ee.enum.thermalNetworkTopology.external;

%% SENARYO HEDEFLERI VE SENARYOYA OZGU AYARLAR
% Gain ve faz her senaryoda ayri ayarlanabilir. Fiziksel eleman parametreleri
% yukaridaki ortak degiskenlerden alinmaya devam eder.
scenario_name = {
    'Komplement anahtarlama'
    'Notr IGBTler off anahtarlama'
    'Notr IGBTler off ve sinkuplu anahtarlama'
    'Notr IGBTler off, sinkuplu ve PI kontrollu anahtarlama'
};

% Deneysel hedefler. NaN, ilgili buyuklugun deney tablosunda verilmedigini
% ve optimizasyon hata fonksiyonuna katilmayacagini belirtir.
Vdc_target       = [431.50, 395.00, 427.50, 427.50]; % [V]
Idc_target       = [0.624,  0.684,  0.697,  NaN];    % [A]
Vac_rms_target   = [119.80, 121.00, 124.30, 124.30]; % [V]
Ifaz_rms_target  = [2.26,   2.33,   2.31,   25.00];  % [A]
Pout_target      = [249.60, 253.20, 281.20, NaN];    % [W]
cosphi_target    = [1.000, -0.995, -0.997, 1.000];   % [1]
THD_target_pct   = [15.00,  47.00,  14.00,  NaN];    % [%]
Qout_target      = [0.00,  -25.42, -21.83,  NaN];    % [var]
Vout_target      = [119.950,121.170, NaN,    NaN];   % [V]
eff_target       = [0.9250, 0.9420, 0.9450, NaN];    % [1]

% Senaryoya ozgu kontrol ayarlari. Bu baslik altindaki degiskenler iki
% sema arasinda farkli olabilir; bunun disindaki tum fiziksel parametreler
% yukaridaki ortak degiskenlerden gelir.
Vdc1 = Vdc_target(1);             % [V] Senaryo 1 DC kaynak gerilimi
Vdc2 = Vdc_target(2);             % [V] Senaryo 2 DC kaynak gerilimi
Vac1_rms = Vac_rms_target(1);     % [V] Senaryo 1 sebeke/Varyak RMS gerilimi
Vac2_rms = Vac_rms_target(2);     % [V] Senaryo 2 sebeke/Varyak RMS gerilimi
Vac1_peak = sqrt(2)*Vac1_rms;     % [V] Simscape AC kaynak tepe genligi
Vac2_peak = sqrt(2)*Vac2_rms;     % [V] Simscape AC kaynak tepe genligi

% Adlandirmada ilk rakam kontrol gain'ini, son rakam senaryoyu belirtir:
% K11 = Senaryo 1'in K1'i, K12 = Senaryo 2'nin K1'i.
%K11 = 0.7865;             % Senaryo 1: 400 uH / -0.007 rad / dusuk akim deneme
K11 = 0.7865;
K12 = 0.79400;
K13 = NaN;
K14 = NaN;
K_pwm = [K11, K12, K13, K14];

% Senaryo 3'te kullanilacak ek K3 gain'i daha sonra K33 olarak baglanacak.
K33 = NaN;
K3_pwm = [NaN, NaN, K33, NaN];
phase_deg1 = -0.44;       % [deg] Senaryo 1 PWM sinüs referans fazi
phase_deg2 = 2.8000;      % [deg] Senaryo 2 PWM sinüs referans fazi
phase_deg = [phase_deg1, phase_deg2, NaN, NaN]; % sonraki senaryolar icin saklanir
measurement_gain = 20;    % [-] iki semadaki ortak olcum ölçekleme kazanci
L2  = 500e-6;
L1_core_Rp = 600;

















































