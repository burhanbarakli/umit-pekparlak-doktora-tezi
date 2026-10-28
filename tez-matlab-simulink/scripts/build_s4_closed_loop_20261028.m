function build_s4_closed_loop_20261028()
% D-02 / K-05 / K-14 (İP-5): Senaryo 4 kapalı çevrim modelini S3 tabanından kurar.
%
% Taban: runs/2026-10-27_diyot_esleme/model/inverter_senaryo3_d08.slx (D-03 + D-08)
% Çıktı: runs/2026-10-28_s4_kapali_cevrim/model/inverter_senaryo4_kc.slx
%
% Yapılanlar (programatik; ham paket ve taban modele dokunulmaz):
%  1. Taban model ve inverter_common_parameters.m yeni klasöre kopyalanır;
%     scripts/s4_denetleyici_parametreleri_20261028.m -> model/s4_denetleyici_parametreleri.m
%  2. S3 değişkenleri S4 karşılıklarıyla değiştirilir (yalnız blok diyaloglarında,
%     kütüphane bağlı bloklara girilmez): Vdc3->Vdc4, Vac3_peak->Vac4_peak,
%     Vac3_rms->Vac4_rms, K13->K14, K33->K34, phase_deg3->phase_deg4,
%     L1_core_Rp->L1_core_Rp4 (K-14: S4 yüksek akım çekirdek kaybı Rp'si).
%  3. D-09 / K-17: Capacitor6/Capacitor7 c = EMC_Cx_eq, r = EMC_Rx_eq.
%  4. 12.10 tarifi: L1 akımı (Current Sensor1 -> PS-Simulink Converter3) ölçülür,
%     i_ref = sqrt(2)*I_ref*sin(theta_sebeke) ile karşılaştırılır; denetleyici çıkışı
%     u_fb, ileri besleme toplamına (K14 sin + K34 sin^3, Sum bloğu, dokunulmaz)
%     ayrı bir toplama bloğunda eklenir. Sin^3 terimi geri besleme yolunun
%     dışında kalan dış girdidir (K-07).
%  5. Denetleyici tek alt sistemde: 'S4 Akim Denetleyicisi' (giriş i_ref, iL1_olcum,
%     aw_asim; çıkış u_fb). P / PI / PIR aynı yapıdır; kip yalnız kazançlarla seçilir.
%  6. Doyum: |u| <= S4_u_lim (Saturation) ve geri hesaplamalı anti-windup (Dead Zone ->
%     Kaw), integratör durumu ±S4_int_lim ile sınırlı.
%  7. Kayıt: denetim sinyalleri ve 1 µs ZOH üzerinden i_L1, i_ac, v_ac, v_dc, i_dc.
%  8. PreLoadFcn (D-03): iki parametre dosyası model klasöründen yüklenir.
% Denetim çıktısı: runs/2026-10-28_s4_kapali_cevrim/inspection/build_s4_denetim.txt
% Çağrı (proje kökünden):
%   matlab -batch "addpath('scripts'); build_s4_closed_loop_20261028"

root_dir = fileparts(fileparts(mfilename('fullpath')));
src_dir = fullfile(root_dir, 'runs', '2026-10-27_diyot_esleme', 'model');
run_dir = fullfile(root_dir, 'runs', '2026-10-28_s4_kapali_cevrim');
model_dir = fullfile(run_dir, 'model');
ins_dir = fullfile(run_dir, 'inspection');
for d = {model_dir, ins_dir}, if ~exist(d{1}, 'dir'), mkdir(d{1}); end, end
src_mdl = 'inverter_senaryo3_d08'; mdl = 'inverter_senaryo4_kc';
copyfile(fullfile(src_dir, [src_mdl '.slx']), fullfile(model_dir, [src_mdl '.slx']), 'f');
copyfile(fullfile(src_dir, 'inverter_common_parameters.m'), fullfile(model_dir, 'inverter_common_parameters.m'), 'f');
copyfile(fullfile(root_dir, 'scripts', 's4_denetleyici_parametreleri_20261028.m'), ...
    fullfile(model_dir, 's4_denetleyici_parametreleri.m'), 'f');
log = {};
log{end+1} = sprintf('build_s4_closed_loop_20261028 — %s — %s', char(datetime('now')), version);
log{end+1} = sprintf('kaynak: %s (SHA-256 %s)', fullfile(src_dir, [src_mdl '.slx']), file_hash(fullfile(src_dir, [src_mdl '.slx'])));
log{end+1} = sprintf('parametre dosyasi SHA-256: %s', file_hash(fullfile(model_dir, 'inverter_common_parameters.m')));

cd(model_dir);
for m = {mdl, src_mdl}, if bdIsLoaded(m{1}), close_system(m{1}, 0); end, end
evalin('base', sprintf('run(''%s''); run(''%s'');', fullfile(model_dir, 'inverter_common_parameters.m'), ...
    fullfile(model_dir, 's4_denetleyici_parametreleri.m')));
load_system(fullfile(model_dir, [src_mdl '.slx']));
new_file = fullfile(model_dir, [mdl '.slx']);
if isfile(new_file), delete(new_file); end
save_system(src_mdl, new_file);    % bellekteki model artık 'inverter_senaryo4_kc'
assert(bdIsLoaded(mdl));

% ---- 2) S3 -> S4 değişken eşlemesi ---------------------------------------------
map = {'Vdc3', 'Vdc4'; 'Vac3_peak', 'Vac4_peak'; 'Vac3_rms', 'Vac4_rms'; 'K13', 'K14'; ...
    'K33', 'K34'; 'phase_deg3', 'phase_deg4'; 'L1_core_Rp', 'L1_core_Rp4'};
blks = find_system(mdl, 'LookUnderMasks', 'all', 'FollowLinks', 'off', 'IncludeCommented', 'on', 'Type', 'Block');
log{end+1} = '--- S3 -> S4 degisken eslemesi ---';
n_rep = 0;
for k = 1:numel(blks)
    try, dp = get_param(blks{k}, 'DialogParameters'); catch, continue, end
    if isempty(dp), continue, end
    fn = fieldnames(dp);
    for q = 1:numel(fn)
        try, v = get_param(blks{k}, fn{q}); catch, continue, end
        if ~ischar(v) || isempty(v), continue, end
        nv = v;
        for r = 1:size(map, 1)
            nv = regexprep(nv, ['(?<![A-Za-z0-9_])' map{r, 1} '(?![A-Za-z0-9_])'], map{r, 2});
        end
        if ~strcmp(nv, v)
            try
                set_param(blks{k}, fn{q}, nv);
                n_rep = n_rep + 1;
                log{end+1} = sprintf('%s :: %s : %s -> %s', clean(blks{k}), fn{q}, v, nv); %#ok<AGROW>
            catch err
                log{end+1} = sprintf('ATLANDI %s :: %s : %s (%s)', clean(blks{k}), fn{q}, v, err.message); %#ok<AGROW>
            end
        end
    end
end
log{end+1} = sprintf('toplam degisiklik: %d', n_rep);

% ---- 3) D-09 -------------------------------------------------------------------
log{end+1} = '--- D-09 (K-17) ---';
for nm = {'Capacitor6', 'Capacitor7'}
    b = [mdl '/' nm{1}];
    if getSimulinkBlockHandle(b) < 0, log{end+1} = sprintf('%s yok', nm{1}); continue, end %#ok<AGROW>
    old = sprintf('c=%s, r=%s, Commented=%s', get_param(b, 'c'), get_param(b, 'r'), get_param(b, 'Commented'));
    set_param(b, 'c', 'EMC_Cx_eq', 'r', 'EMC_Rx_eq');
    log{end+1} = sprintf('%s: %s -> c=EMC_Cx_eq, r=EMC_Rx_eq', nm{1}, old); %#ok<AGROW>
end

% ---- 4-7) Denetim zinciri ----------------------------------------------------------
X = -760; Y = 330;   % yeni blok bölgesi (mevcut çizimin altı)
% ileri besleme toplamı: mevcut 'Sum' (|++) çıkışı -> Subsystem2 ve Scope21
sum_ff = [mdl '/Sum'];
ph = get_param(sum_ff, 'PortHandles');
delete_line(get_param(ph.Outport(1), 'Line'));
% referans
add_block('simulink/Sources/Sine Wave', [mdl '/S4 Sebeke Faz Referansi'], 'Amplitude', '1', ...
    'Frequency', '2*pi*f_grid', 'Phase', '0', 'SampleTime', 'pwm_ref_Ts', 'Position', pos(X, Y, 30, 30));
add_block('simulink/Sources/Step', [mdl '/S4 Iref Basamak'], 'Time', 'S4_t_step', 'Before', 'S4_Iref', ...
    'After', 'S4_Iref_step', 'SampleTime', 'pwm_ref_Ts', 'Position', pos(X, Y + 70, 30, 30));
add_block('simulink/Math Operations/Gain', [mdl '/S4 sqrt2'], 'Gain', 'sqrt(2)', 'Position', pos(X + 70, Y + 70, 40, 30));
add_block('simulink/Math Operations/Product', [mdl '/S4 iref Carpim'], 'Inputs', '2', 'Position', pos(X + 150, Y + 20, 30, 50));
add_line(mdl, 'S4 Sebeke Faz Referansi/1', 'S4 iref Carpim/1', 'autorouting', 'on');
add_line(mdl, 'S4 Iref Basamak/1', 'S4 sqrt2/1', 'autorouting', 'on');
add_line(mdl, 'S4 sqrt2/1', 'S4 iref Carpim/2', 'autorouting', 'on');
% ölçüm: i_L1 (PS-Simulink Converter3 çıkışı, Scope8'e giden hat) -> işaret -> 5 kHz süzgeç
psconv = find_system(mdl, 'SearchDepth', 1, 'Regexp', 'on', 'Name', '^PS-Simulink\sConverter3$');
assert(numel(psconv) == 1, 'PS-Simulink Converter3 bulunamadı');
add_block('simulink/Math Operations/Gain', [mdl '/S4 iL1 Isaret'], 'Gain', 'S4_iL1_sign', 'Position', pos(X, Y + 160, 40, 30));
add_block('simulink/Discrete/Discrete Transfer Fcn', [mdl '/S4 iL1 Olcum Suzgeci'], 'Numerator', 'S4_lp_num', ...
    'Denominator', 'S4_lp_den', 'SampleTime', 'S4_Ts_c', 'Position', pos(X + 80, Y + 155, 70, 40));
pc = get_param(psconv{1}, 'PortHandles');
pg = get_param([mdl '/S4 iL1 Isaret'], 'PortHandles');
add_line(mdl, pc.Outport(1), pg.Inport(1), 'autorouting', 'on');
add_line(mdl, 'S4 iL1 Isaret/1', 'S4 iL1 Olcum Suzgeci/1', 'autorouting', 'on');
% denetleyici alt sistemi
ctl = [mdl '/S4 Akim Denetleyicisi'];
build_controller(ctl, pos(X + 260, Y + 40, 120, 150));
add_line(mdl, 'S4 iref Carpim/1', 'S4 Akim Denetleyicisi/1', 'autorouting', 'on');
add_line(mdl, 'S4 iL1 Olcum Suzgeci/1', 'S4 Akim Denetleyicisi/2', 'autorouting', 'on');
% modülasyon toplamı, sınırlayıcı, anti-windup aşımı
add_block('simulink/Math Operations/Sum', [mdl '/S4 Modulasyon Toplami'], 'Inputs', '++', ...
    'IconShape', 'rectangular', 'Position', pos(X + 460, Y + 60, 40, 60));
add_block('simulink/Discontinuities/Saturation', [mdl '/S4 Modulasyon Siniri'], 'UpperLimit', 'S4_u_lim', ...
    'LowerLimit', '-S4_u_lim', 'Position', pos(X + 540, Y + 70, 40, 40));
add_block('simulink/Discontinuities/Dead Zone', [mdl '/S4 AW Asim'], 'LowerValue', '-S4_u_lim', ...
    'UpperValue', 'S4_u_lim', 'Position', pos(X + 540, Y + 160, 40, 40));
add_line(mdl, 'Sum/1', 'S4 Modulasyon Toplami/1', 'autorouting', 'on');
add_line(mdl, 'Sum/1', 'Scope21/1', 'autorouting', 'on');
add_line(mdl, 'S4 Akim Denetleyicisi/1', 'S4 Modulasyon Toplami/2', 'autorouting', 'on');
add_line(mdl, 'S4 Modulasyon Toplami/1', 'S4 Modulasyon Siniri/1', 'autorouting', 'on');
add_line(mdl, 'S4 Modulasyon Toplami/1', 'S4 AW Asim/1', 'autorouting', 'on');
add_line(mdl, 'S4 Modulasyon Siniri/1', 'Subsystem2/1', 'autorouting', 'on');
add_line(mdl, 'S4 AW Asim/1', 'S4 Akim Denetleyicisi/3', 'autorouting', 'on');
% sinyal adları ve kayıt
name_log(mdl, 'Sum', 1, 'u_ff');
name_log(mdl, 'S4 iref Carpim', 1, 'i_ref');
name_log(mdl, 'S4 iL1 Olcum Suzgeci', 1, 'iL1_olcum');
name_log(mdl, 'S4 Akim Denetleyicisi', 1, 'u_fb');
name_log(mdl, 'S4 Modulasyon Toplami', 1, 'u_top');
name_log(mdl, 'S4 Modulasyon Siniri', 1, 'u_mod');
name_log(mdl, 'S4 AW Asim', 1, 'aw_asim');
% ham dalga biçimleri: 1 µs ZOH ile (değişken adımlı kayıt dosyayı şişirmesin)
yy = Y + 260;
kay = {'iL1', ''; 'i_ac', 'i_ac1'; 'v_ac', 'v_ac1'; 'v_dc', 'v_dc1'; 'i_dc', 'i_dc1'; 'v_inv', 'v_inv1'};
for k = 1:size(kay, 1)
    z = [mdl '/S4 Kayit ' kay{k, 1}];
    add_block('simulink/Discrete/Zero-Order Hold', z, 'SampleTime', 'pwm_ref_Ts', 'Position', pos(X + 80, yy, 30, 30));
    add_block('simulink/Sinks/Terminator', [z ' T'], 'Position', pos(X + 140, yy, 20, 20));
    add_line(mdl, ['S4 Kayit ' kay{k, 1} '/1'], ['S4 Kayit ' kay{k, 1} ' T/1']);
    if isempty(kay{k, 2})
        pz = get_param(z, 'PortHandles');
        add_line(mdl, pc.Outport(1), pz.Inport(1), 'autorouting', 'on');
    else
        fr = [mdl '/S4 From ' kay{k, 1}];
        add_block('simulink/Signal Routing/From', fr, 'GotoTag', kay{k, 2}, 'Position', pos(X, yy, 50, 20));
        add_line(mdl, ['S4 From ' kay{k, 1} '/1'], ['S4 Kayit ' kay{k, 1} '/1']);
    end
    name_log(mdl, ['S4 Kayit ' kay{k, 1}], 1, [kay{k, 1} '_1us']);
    yy = yy + 45;
end
ann = Simulink.Annotation([mdl '/S4 Not']);
ann.Position = [X, Y - 60, X + 700, Y - 20];
ann.Text = sprintf(['Senaryo 4 (D-02, K-05): L1 akim geri beslemesi. u = u_ff (K14 sin + K34 sin^3, ileri besleme, ' ...
    'cevrim disi) + u_fb (S4 Akim Denetleyicisi). build_s4_closed_loop_20261028.m ile kuruldu, %s.'], char(datetime('today')));
set_param(mdl, 'SignalLogging', 'on', 'SignalLoggingName', 'logsout', 'ReturnWorkspaceOutputs', 'on');

% ---- 8) PreLoadFcn (D-03) --------------------------------------------------------
set_param(mdl, 'PreLoadFcn', ['s4_pre_dir = fileparts(which(''' mdl ''')); if isempty(s4_pre_dir), s4_pre_dir = pwd; end; ' ...
    'run(fullfile(s4_pre_dir, ''inverter_common_parameters.m'')); run(fullfile(s4_pre_dir, ''s4_denetleyici_parametreleri.m'')); clear s4_pre_dir']);
log{end+1} = ['PreLoadFcn: ' get_param(mdl, 'PreLoadFcn')];
log{end+1} = ['InitFcn (degismedi): ' get_param(mdl, 'InitFcn')];
save_system(mdl);
close_system(mdl, 0);
close_system(src_mdl, 0);

% ---- Doğrulama: temiz çalışma alanında yükle ve derle --------------------------------
evalin('base', 'clear all');
load_system(new_file);
log{end+1} = '--- dogrulama (temiz calisma alani, PreLoadFcn) ---';
try
    set_param(mdl, 'SimulationCommand', 'update');
    log{end+1} = 'derleme (update): basarili';
catch err
    log{end+1} = ['derleme (update) HATA: ' err.message];
end
% S3 değişkeni kalmış mı?
left = {};
blks = find_system(mdl, 'LookUnderMasks', 'all', 'FollowLinks', 'off', 'Type', 'Block');
for k = 1:numel(blks)
    try, dp = get_param(blks{k}, 'DialogParameters'); catch, continue, end
    if isempty(dp), continue, end
    fn = fieldnames(dp);
    for q = 1:numel(fn)
        try, v = get_param(blks{k}, fn{q}); catch, continue, end
        if ischar(v) && ~isempty(regexp(v, '(?<![A-Za-z0-9_])(Vdc3|Vac3_peak|Vac3_rms|K13|K33|phase_deg3|L1_core_Rp)(?![A-Za-z0-9_])', 'once'))
            left{end+1} = sprintf('%s :: %s = %s', clean(blks{k}), fn{q}, v); %#ok<AGROW>
        end
    end
end
log{end+1} = sprintf('kalan S3 degiskeni: %d', numel(left));
log = [log, left];
% yeni blok listesi
nb = find_system(mdl, 'SearchDepth', 1, 'Regexp', 'on', 'Name', '^S4 ');
log{end+1} = sprintf('--- eklenen ust duzey bloklar (%d) ---', numel(nb));
log = [log, cellfun(@clean, nb.', 'UniformOutput', false)];
cb = find_system(ctl, 'SearchDepth', 1, 'Type', 'Block');
log{end+1} = '--- S4 Akim Denetleyicisi icerigi ---';
for k = 2:numel(cb)
    log{end+1} = sprintf('%s [%s]', clean(cb{k}), get_param(cb{k}, 'BlockType')); %#ok<AGROW>
end
log{end+1} = sprintf('model SHA-256: %s', file_hash(new_file));
close_system(mdl, 0);
fid = fopen(fullfile(ins_dir, 'build_s4_denetim.txt'), 'w', 'n', 'UTF-8');
fprintf(fid, '%s\n', log{:});
fclose(fid);
fprintf('%s\n', log{:});
end

% =====================================================================================
function build_controller(ctl, position)
add_block('simulink/Ports & Subsystems/Subsystem', ctl, 'Position', position);
lns = find_system(ctl, 'FindAll', 'on', 'Type', 'line');
delete_line(lns);
set_param([ctl '/In1'], 'Name', 'i_ref', 'Position', pos(20, 40, 30, 14));
set_param([ctl '/Out1'], 'Name', 'u_fb', 'Position', pos(620, 100, 30, 14));
add_block('simulink/Sources/In1', [ctl '/iL1_olcum'], 'Position', pos(20, 90, 30, 14));
add_block('simulink/Sources/In1', [ctl '/aw_asim'], 'Position', pos(20, 220, 30, 14));
add_block('simulink/Math Operations/Sum', [ctl '/e_hesap'], 'Inputs', '+-', 'IconShape', 'rectangular', ...
    'Position', pos(90, 50, 30, 50));
add_block('simulink/Math Operations/Gain', [ctl '/Kp'], 'Gain', 'S4_Kp_c', 'Position', pos(200, 20, 50, 30));
add_block('simulink/Math Operations/Gain', [ctl '/Ki'], 'Gain', 'S4_Ki_c', 'Position', pos(200, 100, 50, 30));
add_block('simulink/Math Operations/Gain', [ctl '/Kaw'], 'Gain', 'S4_Kaw', 'Position', pos(200, 210, 50, 30));
add_block('simulink/Math Operations/Sum', [ctl '/I_giris'], 'Inputs', '+-', 'IconShape', 'rectangular', ...
    'Position', pos(290, 105, 30, 50));
add_block('simulink/Discrete/Discrete-Time Integrator', [ctl '/Integrator'], ...
    'IntegratorMethod', 'Integration: Forward Euler', 'gainval', '1', 'SampleTime', 'S4_Ts_c', ...
    'LimitOutput', 'on', 'UpperSaturationLimit', 'S4_int_lim', 'LowerSaturationLimit', '-S4_int_lim', ...
    'InitialCondition', '0', 'Position', pos(360, 110, 50, 40));
add_block('simulink/Discrete/Discrete Transfer Fcn', [ctl '/Rezonans'], 'Numerator', 'S4_Kr*S4_R_num1', ...
    'Denominator', 'S4_R_den', 'SampleTime', 'S4_Ts_c', 'Position', pos(330, 170, 90, 40));
add_block('simulink/Math Operations/Sum', [ctl '/u_fb_toplam'], 'Inputs', '+++', 'IconShape', 'rectangular', ...
    'Position', pos(520, 80, 30, 60));
add_line(ctl, 'i_ref/1', 'e_hesap/1');
add_line(ctl, 'iL1_olcum/1', 'e_hesap/2');
add_line(ctl, 'e_hesap/1', 'Kp/1', 'autorouting', 'on');
add_line(ctl, 'e_hesap/1', 'Ki/1', 'autorouting', 'on');
add_line(ctl, 'e_hesap/1', 'Rezonans/1', 'autorouting', 'on');
add_line(ctl, 'aw_asim/1', 'Kaw/1', 'autorouting', 'on');
add_line(ctl, 'Ki/1', 'I_giris/1', 'autorouting', 'on');
add_line(ctl, 'Kaw/1', 'I_giris/2', 'autorouting', 'on');
add_line(ctl, 'I_giris/1', 'Integrator/1', 'autorouting', 'on');
add_line(ctl, 'Kp/1', 'u_fb_toplam/1', 'autorouting', 'on');
add_line(ctl, 'Integrator/1', 'u_fb_toplam/2', 'autorouting', 'on');
add_line(ctl, 'Rezonans/1', 'u_fb_toplam/3', 'autorouting', 'on');
add_line(ctl, 'u_fb_toplam/1', 'u_fb/1', 'autorouting', 'on');
ph = get_param([ctl '/e_hesap'], 'PortHandles');
set_param(ph.Outport(1), 'Name', 'e_akim');
set_param(ctl, 'Description', ['S4 akim denetleyicisi: u_fb = Kp*e + Integrator(Ki*e - Kaw*aw) + R(z)*e. ' ...
    'P: Ki = Kaw = Kr = 0. Dogrusallastirma (IP-6): giris i_ref / iL1_olcum, cikis u_fb.']);
end

function name_log(mdl, blk, port, nm)
ph = get_param([mdl '/' blk], 'PortHandles');
set_param(ph.Outport(port), 'Name', nm, 'DataLogging', 'on', 'DataLoggingNameMode', 'SignalName');
end

function p = pos(x, y, w, h)
p = [x, y, x + w, y + h];
end

function s = clean(s)
s = strrep(s, newline, ' ');
end

function h = file_hash(f)
md = java.security.MessageDigest.getInstance('SHA-256');
fid = fopen(f, 'r'); b = fread(fid, inf, '*uint8'); fclose(fid);
md.update(b);
h = lower(reshape(dec2hex(typecast(md.digest(), 'uint8')).', 1, []));
end
