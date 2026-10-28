function ortalama_model_kararlilik_20261028(adim)
% İP-6 (K-07): S4'ün ortalama (anahtarlamasız) Simulink/Simscape eşdeğeri.
%  adim = 'kur'            : modeli betikle kurar (runs/2026-10-28_kararlilik/model_ort/)
%  adim = 'dogrusallastir' : Simulink Control Design linearize ile L, S, T (K34 açık/kapalı,
%                            t = 0,08 s anlık görüntüsünde), analitik (Ad) ile karşılaştırma
%  adim = 'kos'            : zaman alanı koşuları (anahtarlamalı koşularla aynı ton/basamak)
%  adim = 'hepsi'          : üçü sırayla
% Model yapısı (anahtarlamalı S4 ile aynı denetim blokları):
%   - 'S4 Akim Denetleyicisi' inverter_senaryo4_kc'den KOPYALANIR (aynı P/PI/PIR, 1 µs)
%   - ölçüm: işaret kazancı + aynı ayrık 5 kHz süzgeç (1 µs)
%   - u = sat(u_ff + u_fb + d); u_ff = K14 sin(θ+φ4) + K34 sin³(θ+φ4) (S3 bloğu ile aynı dizilim)
%   - PWM: 1 µs örnekleme (Unit Delay) + K_pwm = Vdc4/2 ortalama köprü (anahtar yok)
%   - güç ağı Simscape Foundation: L1 (L1r) ∥ Rp4 -> Cf (Cr) -> Ldm -> Cx (Rx) -> Ldm -> L2 (L2r) -> şebeke
%     (anahtarlamalı modeldeki sıra: Capacitor2, CMC S1, Capacitor6, CMC S3, CL1, Grid1)
% Çağrı (proje kökünden): matlab -batch "addpath('scripts'); ortalama_model_kararlilik_20261028('hepsi')"
if nargin < 1, adim = 'hepsi'; end
root_dir = fileparts(fileparts(mfilename('fullpath')));
run_dir = fullfile(root_dir, 'runs', '2026-10-28_kararlilik');
md = fullfile(run_dir, 'model_ort'); if ~exist(md, 'dir'), mkdir(md); end
od = fullfile(run_dir, 'ortalama'); if ~exist(od, 'dir'), mkdir(od); end
switch adim
    case 'kur', kur(root_dir, md);
    case 'dogrusallastir', dogrusallastir(root_dir, md, od);
    case 'kos', kos(root_dir, md, od);
    case 'hepsi', kur(root_dir, md); dogrusallastir(root_dir, md, od); kos(root_dir, md, od);
end
end

% =====================================================================================
function taban(root_dir)
par_dir = fullfile(root_dir, 'runs', '2026-10-28_s4_kapali_cevrim', 'model');
evalin('base', sprintf('run(''%s''); run(''%s'');', fullfile(par_dir, 'inverter_common_parameters.m'), ...
    fullfile(par_dir, 's4_denetleyici_parametreleri.m')));
% KC_* (K-20); D-11 ortalama modelde etkisiz (sabit Vdc4/2)
evalin('base', 'K14 = 0.44343; K34 = 0.384306; phase_deg4 = 0.6575; S4_Lg_ek = 0;');
evalin('base', 'S6_inj_A = [0 0 0]; S6_inj_f = [212.5 525 1037.5]; S6_inj_ph = [0 0 0];');
end

function kazanc(mode)
P = evalin('base', 'struct(''Kp'', Kp, ''fz'', S4_PI_fz, ''Kr'', S4_PIR_Kr)');
switch upper(mode)
    case 'P',   g = [P.Kp, 0, 0, 0];
    case 'PI',  g = [P.Kp, P.Kp*2*pi*P.fz, 2*pi*P.fz, 0];
    case 'PIR', g = [P.Kp, P.Kp*2*pi*P.fz, 2*pi*P.fz, P.Kr];
end
assignin('base', 'S4_Kp_c', g(1)); assignin('base', 'S4_Ki_c', g(2));
assignin('base', 'S4_Kaw', g(3));  assignin('base', 'S4_Kr', g(4));
end

% =====================================================================================
function kur(root_dir, md)
mdl = 's4_ortalama_kararlilik';
taban(root_dir);
src_dir = fullfile(root_dir, 'runs', '2026-10-28_s4_kapali_cevrim', 'model');
src = 'inverter_senaryo4_kc';
cd(md);
if bdIsLoaded(mdl), close_system(mdl, 0); end
if isfile(fullfile(md, [mdl '.slx'])), delete(fullfile(md, [mdl '.slx'])); end
load_system(fullfile(src_dir, [src '.slx']));
new_system(mdl);
set_param(mdl, 'Solver', 'ode23t', 'MaxStep', '1e-6', 'RelTol', '1e-6', 'StopTime', '0.11', ...
    'SignalLogging', 'on', 'SignalLoggingName', 'logsout', 'ReturnWorkspaceOutputs', 'on');
b = @(n) [mdl '/' n];
% --- ileri besleme (S3 dizilimi) --------------------------------------------------------
add_block('simulink/Sources/Sine Wave', b('FF Faz'), 'Amplitude', 'pwm_ref_amp', 'Frequency', '2*pi*f_grid', ...
    'Phase', 'phase_deg4*pi/180', 'SampleTime', 'pwm_ref_Ts', 'Position', [40 40 70 70]);
add_block('simulink/Math Operations/Gain', b('K1'), 'Gain', 'K14', 'Position', [140 30 180 60]);
add_block('simulink/Math Operations/Product', b('Product15'), 'Inputs', '2', 'Position', [110 90 140 120]);
add_block('simulink/Math Operations/Product', b('Product1'), 'Inputs', '2', 'Position', [170 90 200 120]);
add_block('simulink/Math Operations/Gain', b('K3'), 'Gain', 'K34', 'Position', [230 90 270 120]);
add_block('simulink/Math Operations/Sum', b('Sum'), 'Inputs', '++', 'Position', [310 40 340 100]);
add_line(mdl, 'FF Faz/1', 'K1/1'); add_line(mdl, 'FF Faz/1', 'Product15/1'); add_line(mdl, 'FF Faz/1', 'Product15/2');
add_line(mdl, 'Product15/1', 'Product1/1'); add_line(mdl, 'FF Faz/1', 'Product1/2');
add_line(mdl, 'Product1/1', 'K3/1'); add_line(mdl, 'K1/1', 'Sum/1'); add_line(mdl, 'K3/1', 'Sum/2');
% --- referans --------------------------------------------------------------------------
add_block('simulink/Sources/Sine Wave', b('S4 Sebeke Faz Referansi'), 'Amplitude', '1', 'Frequency', '2*pi*f_grid', ...
    'Phase', '0', 'SampleTime', 'pwm_ref_Ts', 'Position', [40 200 70 230]);
add_block('simulink/Sources/Step', b('S4 Iref Basamak'), 'Time', 'S4_t_step', 'Before', 'S4_Iref', ...
    'After', 'S4_Iref_step', 'SampleTime', 'pwm_ref_Ts', 'Position', [40 260 70 290]);
add_block('simulink/Math Operations/Gain', b('S4 sqrt2'), 'Gain', 'sqrt(2)', 'Position', [100 260 140 290]);
add_block('simulink/Math Operations/Product', b('S4 iref Carpim'), 'Inputs', '2', 'Position', [170 210 200 260]);
add_line(mdl, 'S4 Sebeke Faz Referansi/1', 'S4 iref Carpim/1'); add_line(mdl, 'S4 Iref Basamak/1', 'S4 sqrt2/1');
add_line(mdl, 'S4 sqrt2/1', 'S4 iref Carpim/2');
% --- denetleyici (kopya) ve enjeksiyon -------------------------------------------------------
add_block([src '/S4 Akim Denetleyicisi'], b('S4 Akim Denetleyicisi'), 'Position', [260 200 380 350]);
fprintf('kaynak CloseFcn: %s\n', get_param(src, 'CloseFcn'));
close_system(src, 0);
taban(root_dir);     % kaynak modelin geri çağrıları taban çalışma alanını değiştirebilir
add_block('simulink/Sources/Sine Wave', b('S6 Enjeksiyon Tonlari'), 'SineType', 'Time based', ...
    'Amplitude', 'S6_inj_A', 'Frequency', '2*pi*S6_inj_f', 'Phase', 'S6_inj_ph', 'Bias', '0', ...
    'SampleTime', 'pwm_ref_Ts', 'Position', [300 400 340 430]);
add_block('simulink/Math Operations/Sum', b('S6 Ton Toplami'), 'Inputs', '+', 'IconShape', 'rectangular', 'Position', [370 400 400 430]);
add_block('simulink/Math Operations/Sum', b('S6 Enjeksiyon Toplami'), 'Inputs', '++', 'IconShape', 'rectangular', 'Position', [430 250 460 310]);
add_block('simulink/Math Operations/Sum', b('S4 Modulasyon Toplami'), 'Inputs', '++', 'IconShape', 'rectangular', 'Position', [500 60 530 300]);
add_block('simulink/Discontinuities/Saturation', b('S4 Modulasyon Siniri'), 'UpperLimit', 'S4_u_lim', 'LowerLimit', '-S4_u_lim', 'Position', [560 160 600 200]);
add_block('simulink/Discontinuities/Dead Zone', b('S4 AW Asim'), 'LowerValue', '-S4_u_lim', 'UpperValue', 'S4_u_lim', 'Position', [560 330 600 370]);
add_block('simulink/Discrete/Unit Delay', b('PWM Ornekleme'), 'SampleTime', 'pwm_ref_Ts', 'Position', [630 160 670 200]);
add_block('simulink/Math Operations/Gain', b('Kpwm'), 'Gain', 'Vdc4/2', 'Position', [700 160 750 200]);
add_line(mdl, 'S4 iref Carpim/1', 'S4 Akim Denetleyicisi/1', 'autorouting', 'on');
add_line(mdl, 'S6 Enjeksiyon Tonlari/1', 'S6 Ton Toplami/1');
add_line(mdl, 'S4 Akim Denetleyicisi/1', 'S6 Enjeksiyon Toplami/1', 'autorouting', 'on');
add_line(mdl, 'S6 Ton Toplami/1', 'S6 Enjeksiyon Toplami/2', 'autorouting', 'on');
add_line(mdl, 'Sum/1', 'S4 Modulasyon Toplami/1', 'autorouting', 'on');
add_line(mdl, 'S6 Enjeksiyon Toplami/1', 'S4 Modulasyon Toplami/2', 'autorouting', 'on');
add_line(mdl, 'S4 Modulasyon Toplami/1', 'S4 Modulasyon Siniri/1', 'autorouting', 'on');
add_line(mdl, 'S4 Modulasyon Toplami/1', 'S4 AW Asim/1', 'autorouting', 'on');
add_line(mdl, 'S4 AW Asim/1', 'S4 Akim Denetleyicisi/3', 'autorouting', 'on');
add_line(mdl, 'S4 Modulasyon Siniri/1', 'PWM Ornekleme/1');
add_line(mdl, 'PWM Ornekleme/1', 'Kpwm/1');
% --- şebeke gerilimi ------------------------------------------------------------------------
add_block('simulink/Sources/Sine Wave', b('Sebeke Gerilimi'), 'Amplitude', 'Vac4_peak', 'Frequency', '2*pi*f_grid', ...
    'Phase', '0', 'SampleTime', '0', 'Position', [1300 420 1330 450]);
% --- Simscape güç ağı ---------------------------------------------------------------------------
fl = 'fl_lib/Electrical/';
add_block('nesl_utility/Simulink-PS Converter', b('SPS v_inv'), 'Position', [780 165 800 195]);
add_block('nesl_utility/Simulink-PS Converter', b('SPS v_g'), 'Position', [1360 425 1380 445]);
for nm = {'SPS v_inv', 'SPS v_g'}
    set_param(b(nm{1}), 'Unit', 'V');
    try, set_param(b(nm{1}), 'FilteringAndDerivatives', 'zero'); catch, end
end
add_block([fl 'Electrical Sources/Controlled Voltage Source'], b('Kopru Ortalama'), 'Position', [830 160 870 220]);
add_block([fl 'Electrical Sources/Controlled Voltage Source'], b('Sebeke'), 'Position', [1400 400 1440 460]);
add_block([fl 'Electrical Sensors/Current Sensor'], b('Current Sensor1'), 'Position', [900 120 940 160]);
add_block([fl 'Electrical Elements/Inductor'], b('L1'), 'l', 'L1', 'r', 'L1r', 'g', '0', 'Position', [980 120 1020 140]);
add_block([fl 'Electrical Elements/Resistor'], b('L1 Core Loss Rp'), 'R', 'L1_core_Rp4', 'Position', [980 60 1020 80]);
add_block([fl 'Electrical Elements/Capacitor'], b('Cf'), 'c', 'C', 'r', 'Cr', 'g', '0', 'Orientation', 'down', 'Position', [1060 180 1080 220]);
add_block([fl 'Electrical Elements/Inductor'], b('CMC S1 Ldm'), 'l', 'EMC_Ldm_stage', 'r', 'EMC_Rdm_stage', 'g', '0', 'Position', [1100 120 1140 140]);
add_block([fl 'Electrical Elements/Capacitor'], b('Cx'), 'c', 'EMC_Cx_eq', 'r', 'EMC_Rx_eq', 'g', '0', 'Orientation', 'down', 'Position', [1170 180 1190 220]);
add_block([fl 'Electrical Elements/Inductor'], b('CMC S3 Ldm'), 'l', 'EMC_Ldm_stage', 'r', 'EMC_Rdm_stage', 'g', '0', 'Position', [1210 120 1250 140]);
add_block([fl 'Electrical Elements/Inductor'], b('L2'), 'l', 'L2 + S4_Lg_ek', 'r', 'L2r', 'g', '0', 'Position', [1290 120 1330 140]);
add_block([fl 'Electrical Elements/Electrical Reference'], b('Ref'), 'Position', [1060 300 1080 320]);
add_block('nesl_utility/Solver Configuration', b('Solver Configuration'), 'Position', [1110 300 1150 320]);
add_block('nesl_utility/PS-Simulink Converter', b('PSS iL1'), 'Position', [960 200 980 220]);
set_param(b('PSS iL1'), 'Unit', 'A');
P = @(blk) get_param(b(blk), 'PortHandles');
% CVS: LConn1 = p (+), RConn1 = vT (PS girişi), RConn2 = n (−)   [controlled_voltage.ssc]
% Current sensor: LConn1 = p (+), RConn1 = I (PS), RConn2 = n (−) [current.ssc]
cvs = P('Kopru Ortalama'); grd = P('Sebeke'); cs = P('Current Sensor1');
l1 = P('L1'); rp = P('L1 Core Loss Rp'); cf = P('Cf'); d1 = P('CMC S1 Ldm'); cx = P('Cx'); d2 = P('CMC S3 Ldm');
l2 = P('L2'); rf = P('Ref'); sc = P('Solver Configuration'); spv = P('SPS v_inv'); spg = P('SPS v_g'); psi = P('PSS iL1');
add_line(mdl, 'Kpwm/1', 'SPS v_inv/1');
add_line(mdl, spv.RConn(1), cvs.RConn(1));
add_line(mdl, cvs.LConn(1), cs.LConn(1));             % köprü + -> akım algılayıcı + (evirici -> şebeke pozitif)
add_line(mdl, cs.RConn(2), l1.LConn(1));
add_line(mdl, cs.RConn(2), rp.LConn(1));
add_line(mdl, l1.RConn(1), rp.RConn(1));
add_line(mdl, l1.RConn(1), cf.LConn(1));
add_line(mdl, l1.RConn(1), d1.LConn(1));
add_line(mdl, d1.RConn(1), cx.LConn(1));
add_line(mdl, d1.RConn(1), d2.LConn(1));
add_line(mdl, d2.RConn(1), l2.LConn(1));
add_line(mdl, l2.RConn(1), grd.LConn(1));             % şebeke + ucu
add_line(mdl, 'Sebeke Gerilimi/1', 'SPS v_g/1');
add_line(mdl, spg.RConn(1), grd.RConn(1));
add_line(mdl, grd.RConn(2), rf.LConn(1));
add_line(mdl, cvs.RConn(2), rf.LConn(1));
add_line(mdl, cf.RConn(1), rf.LConn(1));
add_line(mdl, cx.RConn(1), rf.LConn(1));
add_line(mdl, sc.RConn(1), rf.LConn(1));
add_line(mdl, cs.RConn(1), psi.LConn(1));
% --- ölçüm zinciri (S4 ile aynı) ------------------------------------------------------------------
add_block('simulink/Math Operations/Gain', b('S4 iL1 Isaret'), 'Gain', 'S4_iL1_sign', 'Position', [1010 240 1050 270]);
add_block('simulink/Discrete/Discrete Transfer Fcn', b('S4 iL1 Olcum Suzgeci'), 'Numerator', 'S4_lp_num', ...
    'Denominator', 'S4_lp_den', 'SampleTime', 'S4_Ts_c', 'Position', [1080 240 1150 280]);
add_block('simulink/Discrete/Zero-Order Hold', b('S4 Kayit iL1'), 'SampleTime', 'pwm_ref_Ts', 'Position', [1010 330 1040 360]);
add_line(mdl, 'PSS iL1/1', 'S4 iL1 Isaret/1');
add_line(mdl, 'PSS iL1/1', 'S4 Kayit iL1/1');
add_line(mdl, 'S4 iL1 Isaret/1', 'S4 iL1 Olcum Suzgeci/1');
add_line(mdl, 'S4 iL1 Olcum Suzgeci/1', 'S4 Akim Denetleyicisi/2', 'autorouting', 'on');
add_block('simulink/Sinks/Terminator', b('T iL1'), 'Position', [1070 335 1090 355]);
add_line(mdl, 'S4 Kayit iL1/1', 'T iL1/1');
add_block('simulink/Sinks/Terminator', b('T vinv'), 'Position', [780 230 800 250]);
add_line(mdl, 'Kpwm/1', 'T vinv/1');
nl = {'Sum', 'u_ff'; 'S4 iref Carpim', 'i_ref'; 'S4 iL1 Olcum Suzgeci', 'iL1_olcum'; 'S4 Akim Denetleyicisi', 'u_fb'; ...
    'S6 Ton Toplami', 'd_inj'; 'S6 Enjeksiyon Toplami', 'u_x'; 'S4 Modulasyon Toplami', 'u_top'; ...
    'S4 Kayit iL1', 'iL1_1us'; 'Kpwm', 'v_inv_1us'};
for k = 1:size(nl, 1)
    ph = get_param(b(nl{k, 1}), 'PortHandles');
    set_param(ph.Outport(1), 'Name', nl{k, 2}, 'DataLogging', 'on', 'DataLoggingNameMode', 'SignalName');
end
ann = Simulink.Annotation([mdl '/Not']);
ann.Position = [40 480 900 520];
ann.Text = sprintf(['IP-6: S4 ortalama esdegeri (anahtar yok, K_pwm = Vdc4/2). Denetleyici inverter_senaryo4_kc''den kopya. ' ...
    'ortalama_model_kararlilik_20261028.m ile kuruldu, %s.'], char(datetime('today')));
save_system(mdl, fullfile(md, [mdl '.slx']));
set_param(mdl, 'SimulationCommand', 'update');
fprintf('kur: %s derlendi\n', mdl);
close_system(mdl, 0);
end

% =====================================================================================
function dogrusallastir(root_dir, md, od)
mdl = 's4_ortalama_kararlilik';
cd(md); taban(root_dir);
KO = kararlilik_ortak_20261028(); p = KO.parametreler(root_dir);
load_system(mdl);
f = logspace(0, log10(4.9e4), 3000).'; w = 2*pi*f;
io(1) = linio([mdl '/S6 Ton Toplami'], 1, 'input');
io(2) = linio([mdl '/S4 Akim Denetleyicisi'], 1, 'output');
io(3) = linio([mdl '/S6 Enjeksiyon Toplami'], 1, 'output');
iolt = linio([mdl '/S6 Enjeksiyon Toplami'], 1, 'looptransfer');
opt = linearizeOptions('SampleTime', p.Ts_c, 'RateConversionMethod', 'zoh');
% analitik (Ad): aynı ayrık yapı
G = KO.bitki(p, 0, 'tam');
Pd = c2d(p.Kpwm*G(1, 1), p.Ts_c, 'zoh'); Hd = tf(1 - p.lp_a, [1, -p.lp_a], p.Ts_c); zd = tf([0 1], [1 0], p.Ts_c);
CAd = KO.denetleyiciler(p, p.Ts_c);
cn = {'P', 'PI', 'PIR'}; rows = {}; LS = struct();
set_param(mdl, 'StopTime', '0.08');
for k = 1:3
    kazanc(cn{k});
    for q = 1:2
        if q == 1, assignin('base', 'K34', p.K34); else, assignin('base', 'K34', 0); end
        assignin('base', 'S4_Iref', 25); assignin('base', 'S4_Iref_step', 25); assignin('base', 'S4_t_step', 1e3);
        assignin('base', 'S6_inj_A', [0 0 0]);
        op = findop(mdl, 0.08);                                   % 25 A kararlı durum anlık görüntüsü
        % Dead Zone (anti-windup aşımı) yerel türevi: |u_top| < 1 iken 0 olmalı. SCD'nin
        % blok doğrusallaştırması ayrıca ölçülür; geri hesaplama yolu çevrime ikinci bir yol
        % ekleyeceğinden yerel türev (0) blok yerine koyma ile zorlanır ve iki sonuç da yazılır.
        iodz = [linio([mdl '/S4 Modulasyon Toplami'], 1, 'input'), linio([mdl '/S4 AW Asim'], 1, 'output')];
        dzlin = linearize(mdl, iodz, op, opt); dz_gain = dcgain(dzlin);
        sysdef = linearize(mdl, io, op, opt);
        bsub = struct('Name', [mdl '/S4 AW Asim'], 'Value', 0);
        sys = linearize(mdl, io, op, bsub, opt);
        lt = linearize(mdl, iolt, op, bsub, opt);
        sys0 = linearize(mdl, io, bsub, opt);                     % model başlangıç noktası
        Hd0 = freqresp(sysdef, w); Ldef = -squeeze(Hd0(1, 1, :))./squeeze(Hd0(2, 1, :));
        H = freqresp(sys, w); Hufb = squeeze(H(1, 1, :)); Hux = squeeze(H(2, 1, :));
        H0 = freqresp(sys0, w); L0 = -squeeze(H0(1, 1, :))./squeeze(H0(2, 1, :));
        Lscd = -Hufb./Hux; Sscd = Hux; Tscd = -Hufb;
        Llt = squeeze(freqresp(lt, w));
        Lad = squeeze(freqresp(CAd{k}*Pd*Hd*zd, w));
        LS.(sprintf('%s_%d', cn{k}, q)) = Lscd;
        R = KO.marjlar(f, Lscd, p.Ts_c);
        rows(end+1, :) = {cn{k}, q == 1, max(abs(Lscd - Lad)./abs(Lad)), max(abs(angle(Lscd./Lad)))*180/pi, ...
            max(abs(Llt + Lscd)./abs(Lscd)), max(abs(Llt - Lscd)./abs(Lscd)), max(abs(L0 - Lscd)./abs(Lscd)), ...
            max(abs(Sscd - 1./(1 + Lscd))), strjoin(compose('%.0f', R.fc), ' / '), strjoin(compose('%.1f', R.PM), ' / '), ...
            R.PMmin, strjoin(compose('%.0f', R.f180), ' / '), strjoin(compose('%.1f', R.GM), ' / '), R.nyquist_net, ...
            max(abs(pole(feedback(lt, 1, +1)))), max(abs(pole(sys))), dz_gain, max(abs(Ldef - Lad)./abs(Lad))}; %#ok<AGROW>
        fprintf('%s K34=%d: |L_scd - L_Ad|/|L_Ad| max %.3g\n', cn{k}, q == 1, rows{end, 3});
    end
end
T = cell2table(rows, 'VariableNames', {'denetleyici', 'K34_acik', 'max_rel_L_scd_vs_Ad', 'max_faz_farki_deg', ...
    'looptransfer_isaret_eksi_fark', 'looptransfer_isaret_arti_fark', 'op_t0_vs_t008_fark', 'S_tutarlilik', ...
    'fc_Hz', 'PM_deg', 'PMmin_deg', 'f180_Hz', 'GM_dB', 'nyquist_net', 'max_abs_z_lt_kapali', 'max_abs_z_kapali_cevrim', ...
    'scd_deadzone_kazanci', 'max_rel_L_scd_varsayilan_vs_Ad'});
for k = 1:3
    T.K34_fark_L(2*k - 1:2*k) = max(abs(LS.(sprintf('%s_1', cn{k})) - LS.(sprintf('%s_2', cn{k})))./abs(LS.(sprintf('%s_1', cn{k}))));
end
writetable(T, fullfile(od, 'scd_dogrusallastirma.csv'));
save(fullfile(od, 'scd_L.mat'), 'f', 'LS');
disp(T);
close_system(mdl, 0);
end

% =====================================================================================
function kos(root_dir, md, od)
mdl = 's4_ortalama_kararlilik';
cd(md); taban(root_dir);
KO = kararlilik_ortak_20261028(); p = KO.parametreler(root_dir);
load_system(mdl);
A = [212.5 525 1037.5]; B = [587.5 2025 3362.5];
kos_listesi = {   % ad, kip, Iref, stop, tonlar, genlik, K34, t_step
    'ort_PI25_K34_A', 'PI', 25, 0.11, A, 0.015, p.K34, 1e3
    'ort_PI25_K34_B', 'PI', 25, 0.11, B, 0.015, p.K34, 1e3
    'ort_PI25_K340_A', 'PI', 25, 0.11, A, 0.015, 0, 1e3
    'ort_PI10_K34_A', 'PI', 10, 0.11, A, 0.015, p.K34, 1e3
    'ort_P25_K34_A', 'P', 25, 0.11, A, 0.015, p.K34, 1e3
    'ort_PIR25_K34_0', 'PIR', 25, 0.2, A, 0, p.K34, 1e3
    'ort_PI_basamak_K34', 'PI', [10 25], 0.09, A, 0, p.K34, 0.055
    'ort_PI_basamak_K340', 'PI', [10 25], 0.09, A, 0, 0, 0.055};
for c = 1:size(kos_listesi, 1)
    [ad, mode, Ir, st, ton, Aa, K34v, tst] = kos_listesi{c, :};
    kazanc(mode); if isscalar(Ir), Ir = [Ir Ir]; end
    assignin('base', 'K34', K34v); assignin('base', 'S4_Iref', Ir(1)); assignin('base', 'S4_Iref_step', Ir(2));
    assignin('base', 'S4_t_step', tst);
    assignin('base', 'S6_inj_A', Aa*ones(1, 3)); assignin('base', 'S6_inj_f', ton);
    assignin('base', 'S6_inj_ph', pi*(0:2).^2/3);
    set_param(mdl, 'StopTime', num2str(st));
    tic; out = sim(mdl); wall = toc;
    Lg = out.logsout;
    nm = {'i_ref', 'iL1_olcum', 'u_fb', 'u_x', 'd_inj', 'u_top', 'u_ff', 'iL1_1us', 'v_inv_1us'};
    t = []; x = struct();
    for k = 1:numel(nm)
        el = Lg.getElement(nm{k}); if iscell(el) || isa(el, 'Simulink.SimulationData.Dataset'), el = el{1}; end
        v = el.Values;
        if isempty(t), t = (0:1e-6:st - 1e-6).'; end
        x.(nm{k}) = interp1(v.Time, squeeze(v.Data), t, 'previous', 'extrap');
    end
    x.iL1_avg = movmean(x.iL1_1us, 100);
    if tst < st, pen = [st - 0.02, st]; else, pen = [st - 0.08, st]; end
    w = t >= pen(1) - 5e-7 & t < pen(2) - 5e-7;
    olcum = struct('t', t(w), 'd_inj', x.d_inj(w), 'u_x', x.u_x(w), 'u_fb', x.u_fb(w), 'iL1_olcum', x.iL1_olcum(w), ...
        'iL1', x.iL1_1us(w), 'i_ref', x.i_ref(w), 'u_top', x.u_top(w), 'v_inv', x.v_inv_1us(w));
    tum = struct('t', t(1:10:end), 'i_ref', x.i_ref(1:10:end), 'iL1_avg', x.iL1_avg(1:10:end), ...
        'u_top', x.u_top(1:10:end), 'u_fb', x.u_fb(1:10:end), 'u_ff', x.u_ff(1:10:end));
    Tt = KO.ton_analizi(olcum, ton, p.Kpwm);
    % temel/3. harmonik son periyot
    w2 = t >= st - 0.02 - 5e-7 & t < st - 5e-7;
    f1 = @(s, h) 2*mean(s(w2).*exp(-1j*2*pi*50*h*t(w2)));
    M = struct('case', string(ad), 'mode', string(mode), 'I_ref_rms', Ir(2), 'K34', K34v, ...
        'IL1_1_rms_A', abs(f1(x.iL1_1us, 1))/sqrt(2), 'izleme_genlik_hatasi_pct', 100*(abs(f1(x.iL1_1us, 1))/abs(f1(x.i_ref, 1)) - 1), ...
        'izleme_faz_hatasi_deg', angle(f1(x.iL1_1us, 1)/f1(x.i_ref, 1))*180/pi, 'IL1_3_rms_A', abs(f1(x.iL1_1us, 3))/sqrt(2), ...
        'IL1_3_faz_deg', angle(f1(x.iL1_1us, 3))*180/pi, 'u_top_max', max(abs(x.u_top(w2))), 'wall_s', wall);
    save(fullfile(od, [ad '.mat']), 'olcum', 'tum', 'M', 'Tt', 'ton');
    fprintf('%s (%.0f s): I1 = %.3f A (%.2f %%, %.2f deg), I3 = %.3f A\n', ad, wall, M.IL1_1_rms_A, ...
        M.izleme_genlik_hatasi_pct, M.izleme_faz_hatasi_deg, M.IL1_3_rms_A);
    if Aa > 0
        Lm = complex(Tt.L_re, Tt.L_im); disp(table(Tt.f_Hz, 20*log10(abs(Lm)), angle(Lm)*180/pi, 'VariableNames', {'f', 'L_dB', 'L_deg'}));
    end
end
close_system(mdl, 0);
end
