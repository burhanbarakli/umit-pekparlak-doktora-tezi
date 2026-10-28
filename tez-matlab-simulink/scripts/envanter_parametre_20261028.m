% İP-7 / K-09: tek parametre tablosu için parametre envanteri (salt okuma).
%
% Çağrı (proje kökünden):
%   matlab -batch "run('scripts/envanter_parametre_20261028.m')"
%
% Ne yapar:
%   1. 12.10 paketinin üç modelini (ham) ve tez sonuçlarının dayandığı dört taban
%      modeli (S1/S2 kalibre ayrık kopyalar, S3 kalibre, S4 kapalı çevrim) kendi
%      parametre/kalibrasyon dosyalarıyla birlikte runs/2026-10-28_parametre_tablosu/
%      model/{ham,tez}/ altına kopyalar. Ham paket değiştirilmez.
%   2. inverter_common_parameters.m (ve S4 denetleyici / kalibrasyon dosyaları)
%      atamalarını satır satır ayrıştırır: değişken, ifade, değer, birim, yorum.
%   3. Her modelde yorum satırına alınmamış bütün blokların diyalog parametrelerini,
%      model geri çağrılarını ve yapılandırma ayarlarını tarar; hangi değişkenin
%      hangi blokta doğrudan, hangisinin dolaylı kullanıldığını çıkarır.
%   4. Tez modellerinde senaryoya özgü etkin değerleri (kalibrasyon dosyası,
%      S4 parametre dosyası, KC_* koşu eki) yazar.
%   Benzetim koşturulmaz; model kaydedilmez. D-03: parametre dosyası load_system'dan
%   önce taban çalışma alanında çalıştırılır. D-13: model kapanınca C ve L
%   silindiği için her yüklemeden önce parametreler yeniden yüklenir.
%
% Çıktılar (runs/2026-10-28_parametre_tablosu/):
%   parametre_envanteri.csv       değişken → değer, birim, satır, model başına kullanım
%   parametre_kullanim_uzun.csv   model, değişken, blok, parametre, ifade
%   model_yapilandirma.csv        çözücü, adım, geri çağrılar, powergui, çözücü blokları
%   etkin_degerler.csv            tez modellerinde senaryoya özgü etkin değerler
%   blok_parametreleri_tez.csv    tez modellerinde denetim/ölçüm/PWM blok parametreleri
%   sabit_sayi_parametreleri.csv  fiziksel bloklarda değişken yerine sayı yazılmış alanlar
%   envanter_gunlugu.txt
% Review: review/2026-10-28_PARAMETRE_TABLOSU.md

envanter_ana(fileparts(fileparts(mfilename('fullpath'))));

%% ========================================================================
function envanter_ana(root_dir)
warning('off', 'all');
run_dir = fullfile(root_dir, 'runs', '2026-10-28_parametre_tablosu');
pkg_dir = fullfile(root_dir, 'incoming_real_data', 'models', '2026-10-12_dort_senaryo_paketi');
ham_dir = fullfile(run_dir, 'model', 'ham');
tez_dir = fullfile(run_dir, 'model', 'tez');
if ~exist(ham_dir, 'dir'), mkdir(ham_dir); end
if ~exist(tez_dir, 'dir'), mkdir(tez_dir); end
gun = {};
gun{end+1} = sprintf('envanter_parametre_20261028  %s  MATLAB %s', char(datetime('now')), version);

% ---- 1) Kopyalar --------------------------------------------------------
ham_dosyalar = {'inverter_common_parameters.m', 'inverter_scenario1_parametric5_etiquetli.slx', ...
    'inverter_senaryo3.slx', 'inverter_senaryo4.slx'};
for k = 1:numel(ham_dosyalar)
    src = fullfile(pkg_dir, ham_dosyalar{k}); dst = fullfile(ham_dir, ham_dosyalar{k});
    if ~isfile(dst), copyfile(src, dst); end
    gun{end+1} = sprintf('ham kopya %-48s ayni=%d', ham_dosyalar{k}, ayni_mi(src, dst)); %#ok<AGROW>
end
kal = fullfile(root_dir, 'runs', '2026-10-28_kalibrasyon');
s4d = fullfile(root_dir, 'runs', '2026-10-28_s4_kapali_cevrim', 'model');
tez_kaynak = {
    fullfile(pkg_dir, 'inverter_common_parameters.m')
    fullfile(kal, 'model_s1', 'inverter_s1_kal.slx')
    fullfile(kal, 'model_s1', 'inverter_s1_kal_kalibrasyon.m')
    fullfile(kal, 'model_s2', 'inverter_s2_kal.slx')
    fullfile(kal, 'model_s2', 'inverter_s2_kal_kalibrasyon.m')
    fullfile(kal, 'model_s3', 'inverter_senaryo3_kal.slx')
    fullfile(kal, 'model_s3', 'inverter_senaryo3_kal_kalibrasyon.m')
    fullfile(s4d, 'inverter_senaryo4_kc.slx')
    fullfile(s4d, 's4_denetleyici_parametreleri.m')};
for k = 1:numel(tez_kaynak)
    [~, n, e] = fileparts(tez_kaynak{k}); dst = fullfile(tez_dir, [n e]);
    if ~isfile(dst), copyfile(tez_kaynak{k}, dst); end
    gun{end+1} = sprintf('tez kopya %-48s ayni=%d', [n e], ayni_mi(tez_kaynak{k}, dst)); %#ok<AGROW>
end

% ---- 2) Parametre dosyalarının ayrıştırılması ----------------------------
P = ayristir(fullfile(ham_dir, 'inverter_common_parameters.m'), 'parametre dosyası');
P = [P, ayristir(fullfile(tez_dir, 's4_denetleyici_parametreleri.m'), 'S4 denetleyici dosyası')];
kal_dosyalari = {'inverter_s1_kal_kalibrasyon.m', 'inverter_s2_kal_kalibrasyon.m', ...
    'inverter_senaryo3_kal_kalibrasyon.m'};
Pk = [];
for k = 1:numel(kal_dosyalari)
    Pk = [Pk, ayristir(fullfile(tez_dir, kal_dosyalari{k}), ['kalibrasyon: ' kal_dosyalari{k}])]; %#ok<AGROW>
end

% m-dosyası değerleri (taban çalışma alanı)
taban(ham_dir, false);
evalin('base', sprintf('run(''%s'');', fullfile(tez_dir, 's4_denetleyici_parametreleri.m')));
for k = 1:numel(P)
    P(k).deger = degerle(P(k).ad);
end
for k = 1:numel(Pk)
    Pk(k).deger = '';
    try, Pk(k).deger = bicim(eval(Pk(k).ifade)); catch, end
end
adlar = unique({P.ad}, 'stable');

% ---- 3) Model taraması ---------------------------------------------------
modeller = {
    'ham_S1S2', ham_dir, 'inverter_scenario1_parametric5_etiquetli', {}
    'ham_S3',   ham_dir, 'inverter_senaryo3', {}
    'ham_S4',   ham_dir, 'inverter_senaryo4', {}
    'tez_S1',   tez_dir, 'inverter_s1_kal',       {'inverter_s1_kal_kalibrasyon.m'}
    'tez_S2',   tez_dir, 'inverter_s2_kal',       {'inverter_s2_kal_kalibrasyon.m'}
    'tez_S3',   tez_dir, 'inverter_senaryo3_kal', {'inverter_senaryo3_kal_kalibrasyon.m'}
    'tez_S4',   tez_dir, 'inverter_senaryo4_kc',  {'s4_denetleyici_parametreleri.m'}};
nm = size(modeller, 1);
uzun = {};          % model, değişken, blok, parametre, ifade
yap = {};           % model, ayar, değer
blokpar = {};       % model, blok, tip, referans, parametre, ifade, tür
sabit = {};         % model, blok, tip, parametre, ifade
kullanim = zeros(numel(adlar), nm);
for m = 1:nm
    etiket = modeller{m, 1}; mdir = modeller{m, 2}; mdl = modeller{m, 3};
    taban(mdir, true);
    for q = 1:numel(modeller{m, 4})
        evalin('base', sprintf('run(''%s'');', fullfile(mdir, modeller{m, 4}{q})));
    end
    cd(mdir);
    load_system(fullfile(mdir, [mdl '.slx']));
    gun{end+1} = sprintf('yüklendi: %s (%s)', mdl, etiket); %#ok<AGROW>

    % yapılandırma
    ayarlar = {'Solver', 'SolverType', 'StopTime', 'MaxStep', 'MinStep', 'RelTol', 'AbsTol', ...
        'FixedStep', 'SimulationMode', 'ZeroCrossControl', 'InitFcn', 'PreLoadFcn', 'CloseFcn', ...
        'StartFcn', 'PostLoadFcn'};
    for a = 1:numel(ayarlar)
        v = '';
        try, v = get_param(mdl, ayarlar{a}); catch, end
        if ~ischar(v), v = bicim(v); end
        yap(end+1, :) = {etiket, ayarlar{a}, v}; %#ok<AGROW>
        kullanim = isaretle(kullanim, adlar, m, v);
        tok = ayir(v, adlar);
        for t = 1:numel(tok)
            uzun(end+1, :) = {etiket, tok{t}, '<model yapılandırması>', ayarlar{a}, v}; %#ok<AGROW>
        end
    end

    bloklar = find_system(mdl, 'LookUnderMasks', 'all', 'FollowLinks', 'on', ...
        'IncludeCommented', 'off', 'Type', 'Block');
    yap(end+1, :) = {etiket, 'etkin_blok_sayisi', sprintf('%d', numel(bloklar))}; %#ok<AGROW>
    for b = 1:numel(bloklar)
        blk = bloklar{b};
        if yorumlu_mu(blk), continue, end
        try
            dp = get_param(blk, 'DialogParameters');
        catch
            continue
        end
        if isempty(dp), continue, end
        bt = get_param(blk, 'BlockType');
        ref = '';
        try, ref = get_param(blk, 'ReferenceBlock'); catch, end
        ssc = '';
        try, ssc = get_param(blk, 'SourceFile'); catch, end
        bad = strrep(blk, newline, ' ');
        ust = get_param(blk, 'Parent');
        ic_blok = false;   % kitaplığa bağlı (maskeli) bir bloğun iç yapısı mı?
        if ~strcmp(ust, mdl)
            try, ic_blok = ~isempty(get_param(ust, 'ReferenceBlock')) || strcmp(get_param(ust, 'Mask'), 'on'); catch, end
        end
        alanlar = fieldnames(dp);
        for q = 1:numel(alanlar)
            try
                v = get_param(blk, alanlar{q});
            catch
                continue
            end
            if ~ischar(v), continue, end
            tok = ayir(v, adlar);
            for t = 1:numel(tok)
                uzun(end+1, :) = {etiket, tok{t}, bad, alanlar{q}, v}; %#ok<AGROW>
                i = find(strcmp(adlar, tok{t}), 1);
                kullanim(i, m) = kullanim(i, m) + 1;
            end
            % tez modellerinde denetim/ölçüm/PWM bloklarının parametreleri
            % (kitaplık bloklarının iç yapısı ve veri türü alanları dışarıda bırakılır)
            if startsWith(etiket, 'tez_') && ~ic_blok && ilgili_blok(bt, ref, bad) && ...
                    (~isempty(tok) || (strcmp(ifade_turu(v), 'sabit sayı') && ~strcmp(v, '[]'))) && ...
                    ~any(strcmp(alanlar{q}, {'gainval', 'InitialCondition', 'InitialStates', 'SampleTime', 'OutMin', 'OutMax'}) & strcmp(v, {'-1'}))
                blokpar(end+1, :) = {etiket, bad, bt, ref, alanlar{q}, v, ifade_turu(v)}; %#ok<AGROW>
            end
            % fiziksel blokta değişken yerine sayı yazılmış etkin alanlar (D-10)
            if strcmp(bt, 'SimscapeBlock') && strcmp(ifade_turu(v), 'sabit sayı') && ...
                    any(strcmp(alanlar{q}, {'Vth', 'Rth', 'thermal_mass', 'thermal_time_constant', ...
                    'thermal_mass_initial_temperatures', 'Tdevice', 'uHigh', 'uLow'}))
                sabit(end+1, :) = {etiket, bad, ssc, alanlar{q}, v}; %#ok<AGROW>
            end
        end
    end
    % powergui ve Solver Configuration özetleri
    pg = find_system(mdl, 'SearchDepth', 1, 'MaskType', 'PSB option menu block');
    for k = 1:numel(pg)
        for a = {'SimulationMode', 'SampleTime', 'frequencyindice'}
            try, yap(end+1, :) = {etiket, ['powergui.' a{1}], get_param(pg{k}, a{1})}; catch, end %#ok<AGROW>
        end
    end
    sc = find_system(mdl, 'LookUnderMasks', 'all', 'IncludeCommented', 'off', ...
        'Regexp', 'on', 'Type', 'Block', 'Name', 'Solver Configuration');
    for k = 1:numel(sc)
        if true
            for a = {'DoDC', 'UseLocalSolver', 'LocalSolverChoice', 'LocalSolverSampleTime', ...
                    'ResidualTolerance', 'DoFixedCost', 'MaxNonlinIter'}
                try
                    yap(end+1, :) = {etiket, [strrep(get_param(sc{k}, 'Name'), newline, ' ') '.' a{1}], ...
                        get_param(sc{k}, a{1})}; %#ok<AGROW>
                catch
                end
            end
        end
    end
    close_system(mdl, 0);
end

% ---- 4) Dolaylı kullanım (bir kullanılan değişkenin tanımına giren) ------
durum = repmat({''}, numel(adlar), nm);
for m = 1:nm
    kul = kullanim(:, m) > 0;
    dol = false(numel(adlar), 1);
    degisti = true;
    while degisti
        degisti = false;
        for i = 1:numel(adlar)
            if kul(i) || dol(i), continue, end
            for j = find(kul | dol)'
                ifj = P(find(strcmp({P.ad}, adlar{j}), 1, 'last')).ifade;
                if any(strcmp(ayir(ifj, adlar), adlar{i}))
                    dol(i) = true; degisti = true; break
                end
            end
        end
    end
    for i = 1:numel(adlar)
        if kul(i)
            durum{i, m} = sprintf('%d', kullanim(i, m));
        elseif dol(i)
            durum{i, m} = 'dolaylı';
        else
            durum{i, m} = '-';
        end
    end
end

% ---- 5) Etkin değerler (tez modelleri) -----------------------------------
etkin = {};
izle = {'Vdc1', 'Vdc2', 'Vdc3', 'Vdc4', 'Vac1_peak', 'Vac2_peak', 'Vac3_peak', 'Vac4_peak', ...
    'K11', 'K12', 'K13', 'K14', 'K33', 'K34', 'phase_deg1', 'phase_deg2', 'phase_deg3', ...
    'phase_deg4', 'Cdc_pos', 'Cdc_neg', 'L1_core_Rp', 'L1_core_Rp4', 'EMC_Cx_eq', 'EMC_Rx_eq', ...
    'C_emc_aux', 'R_emc_aux'};
for m = 4:7
    taban(ham_dir, false);
    kaynak = 'parametre dosyası';
    for q = 1:numel(modeller{m, 4})
        evalin('base', sprintf('run(''%s'');', fullfile(tez_dir, modeller{m, 4}{q})));
        kaynak = modeller{m, 4}{q};
    end
    ek_kaynak = '';
    if m == 7
        kb = fullfile(root_dir, 'runs', '2026-10-28_s4_kapali_cevrim', 'results', 'KC_PI_25A', 'kosu_bilgisi.txt');
        satir = regexp(fileread(kb), 'InitFcn eki:([^\n]*)', 'tokens', 'once');
        evalin('base', satir{1});
        ek_kaynak = 'KC_* koşu eki (D-11, K-20)';
        gun{end+1} = sprintf('S4 KC eki: %s', strtrim(satir{1})); %#ok<AGROW>
    end
    for i = 1:numel(izle)
        etkin(end+1, :) = {modeller{m, 1}, izle{i}, degerle(izle{i}), kaynak, ek_kaynak}; %#ok<AGROW>
    end
    if m == 7
        g = evalin('base', '[Kp, Kp*2*pi*S4_PI_fz, 2*pi*S4_PI_fz, S4_PIR_Kr, S4_R_wb, S4_f_lp, S4_Ts_c, S4_u_lim, S4_int_lim]');
        adg = {'S4_Kp (P/PI/PIR)', 'S4_Ki (PI/PIR)', 'S4_Kaw (PI/PIR)', 'S4_Kr (PIR)', 'S4_R_wb', ...
            'S4_f_lp', 'S4_Ts_c', 'S4_u_lim', 'S4_int_lim'};
        for i = 1:numel(adg)
            etkin(end+1, :) = {'tez_S4', adg{i}, bicim(g(i)), 's4_denetleyici_parametreleri.m + run_s4_closed_loop_20261028.m kip tablosu', ''}; %#ok<AGROW>
        end
    end
end
taban(ham_dir, false);

% ---- 6) Yazım ------------------------------------------------------------
bas = [{'kaynak_dosya', 'satir', 'degisken', 'ifade', 'deger', 'birim', 'yorum'}, modeller(:, 1)', {'ornek_blok_tez'}];
rows = {};
for i = 1:numel(adlar)
    k = find(strcmp({P.ad}, adlar{i}), 1, 'last');
    ornek = '';
    sel = uzun(startsWith(uzun(:, 1), 'tez_') & strcmp(uzun(:, 2), adlar{i}), :);
    if isempty(sel), sel = uzun(strcmp(uzun(:, 2), adlar{i}), :); end
    if ~isempty(sel)
        ub = unique(strcat(sel(:, 3), '.', sel(:, 4)), 'stable');
        ornek = strjoin(ub(1:min(3, numel(ub))), ' | ');
        if numel(ub) > 3, ornek = sprintf('%s | (+%d)', ornek, numel(ub) - 3); end
    end
    rows(end+1, :) = [{P(k).kaynak, sprintf('%d', P(k).satir), P(k).ad, P(k).ifade, P(k).deger, ...
        P(k).birim, P(k).yorum}, durum(i, :), {ornek}]; %#ok<AGROW>
end
for k = 1:numel(Pk)
    rows(end+1, :) = [{Pk(k).kaynak, sprintf('%d', Pk(k).satir), Pk(k).ad, Pk(k).ifade, Pk(k).deger, ...
        Pk(k).birim, Pk(k).yorum}, repmat({''}, 1, nm), {''}]; %#ok<AGROW>
end
csv_yaz(fullfile(run_dir, 'parametre_envanteri.csv'), bas, rows);
csv_yaz(fullfile(run_dir, 'parametre_kullanim_uzun.csv'), {'model', 'degisken', 'blok', 'parametre', 'ifade'}, uzun);
csv_yaz(fullfile(run_dir, 'model_yapilandirma.csv'), {'model', 'ayar', 'deger'}, yap);
csv_yaz(fullfile(run_dir, 'etkin_degerler.csv'), {'model', 'degisken', 'deger', 'kaynak', 'ek'}, etkin);
csv_yaz(fullfile(run_dir, 'blok_parametreleri_tez.csv'), {'model', 'blok', 'tip', 'referans', 'parametre', 'ifade', 'tur'}, blokpar);
csv_yaz(fullfile(run_dir, 'sabit_sayi_parametreleri.csv'), {'model', 'blok', 'kaynak', 'parametre', 'ifade'}, sabit);

% özet
for m = 1:nm
    n_dog = sum(kullanim(:, m) > 0); n_dol = sum(strcmp(durum(:, m), 'dolaylı'));
    gun{end+1} = sprintf('%-9s doğrudan %3d  dolaylı %3d  kullanılmayan %3d  (toplam %d)', ...
        modeller{m, 1}, n_dog, n_dol, numel(adlar) - n_dog - n_dol, numel(adlar)); %#ok<AGROW>
end
hic = adlar(all(strcmp(durum(:, 4:7), '-'), 2));
gun{end+1} = ['tez modellerinin hiçbirinde kullanılmayan: ' strjoin(hic, ', ')];
fid = fopen(fullfile(run_dir, 'envanter_gunlugu.txt'), 'w', 'n', 'UTF-8');
fprintf(fid, '%s\n', gun{:});
fclose(fid);
fprintf('%s\n', gun{:});
cd(root_dir);
end

%% ========================================================================
function taban(mdir, yeniden)
% Parametre dosyasını taban çalışma alanında çalıştırır (D-03, D-13).
if yeniden, evalin('base', 'clear'); end
evalin('base', sprintf('run(''%s'');', fullfile(mdir, 'inverter_common_parameters.m')));
end

function e = ayni_mi(a, b)
fa = fopen(a, 'r'); xa = fread(fa, inf, '*uint8'); fclose(fa);
fb = fopen(b, 'r'); xb = fread(fb, inf, '*uint8'); fclose(fb);
e = isequal(xa, xb);
end

function P = ayristir(dosya, kaynak)
% Basit atama satırlarını ayrıştırır: ad = ifade; % [birim] yorum
satirlar = splitlines(fileread(dosya));
P = struct('kaynak', {}, 'satir', {}, 'ad', {}, 'ifade', {}, 'birim', {}, 'yorum', {}, 'deger', {});
for k = 1:numel(satirlar)
    s = satirlar{k};
    t = regexp(s, '^\s*([A-Za-z]\w*)\s*=\s*(.*)$', 'tokens', 'once');
    if isempty(t), continue, end
    govde = t{2};
    yorum = '';
    ip = strfind(govde, '%');
    % % işaretinin tırnak içinde olmadığını varsay (dosyalarda öyle)
    if ~isempty(ip)
        yorum = strtrim(govde(ip(1)+1:end));
        govde = govde(1:ip(1)-1);
    end
    govde = strtrim(regexprep(govde, ';\s*$', ''));
    if contains(govde, '{') && ~contains(govde, '}'), continue, end   % çok satırlı hücre
    birim = '';
    [b, son] = regexp(yorum, '\[([^\]]*)\]', 'tokens', 'end', 'once');
    if ~isempty(b), birim = b{1}; yorum = strtrim(yorum(son+1:end)); end
    P(end+1) = struct('kaynak', kaynak, 'satir', k, 'ad', t{1}, 'ifade', govde, ... %#ok<AGROW>
        'birim', birim, 'yorum', yorum, 'deger', '');
end
end

function s = degerle(ad)
s = '';
try
    if evalin('base', sprintf('exist(''%s'', ''var'')', ad))
        s = bicim(evalin('base', ad));
    else
        s = '<tanımsız>';
    end
catch
end
end

function s = bicim(v)
if ischar(v)
    s = v;
elseif isstring(v)
    s = char(strjoin(v, ', '));
elseif iscell(v)
    s = strjoin(cellfun(@bicim, v(:)', 'UniformOutput', false), '; ');
elseif isnumeric(v) || islogical(v)
    if isscalar(v)
        s = sprintf('%.10g', v);
    else
        s = mat2str(double(v), 6);
    end
else
    try
        s = char(string(v));
    catch
        s = class(v);
    end
end
if numel(s) > 400, s = [s(1:400) ' …']; end
end

function tok = ayir(v, adlar)
if isempty(v) || ~ischar(v), tok = {}; return, end
tok = unique(regexp(v, '(?<![\w.])[A-Za-z]\w*', 'match'));
tok = tok(ismember(tok, adlar));
end

function kullanim = isaretle(kullanim, adlar, m, v)
tok = ayir(v, adlar);
for t = 1:numel(tok)
    i = find(strcmp(adlar, tok{t}), 1);
    kullanim(i, m) = kullanim(i, m) + 1;
end
end

function y = yorumlu_mu(blk)
% Üst alt sistemlerden biri yorumluysa blok etkin değildir.
y = false;
p = blk;
while contains(p, '/')
    try
        if ~strcmp(get_param(p, 'Commented'), 'off'), y = true; return, end
    catch
    end
    p = get_param(p, 'Parent');
end
end

function t = ifade_turu(v)
if isempty(strtrim(v))
    t = 'boş';
elseif ~isnan(str2double(v)) || ~isempty(regexp(v, '^\s*\[[\d\s.,;eE+\-]*\]\s*$', 'once'))
    t = 'sabit sayı';
elseif ~isempty(regexp(v, '[A-Za-z_]\w*', 'once')) && isnan(str2double(v))
    t = 'ifade/değişken';
else
    t = 'metin';
end
end

function y = ilgili_blok(bt, ref, ad)
anahtar = {'PWM Generator', 'On Delay', 'THD', 'RMS', 'Mean', 'Fourier', 'Power', 'powergui', ...
    'Gate Driver', 'Solver'};
y = any(strcmp(bt, {'Sin', 'Gain', 'Saturate', 'DeadZone', 'DiscreteTransferFcn', 'DiscreteIntegrator', ...
    'Constant', 'Step', 'ZeroOrderHold', 'Product', 'Switch'})) || contains(ref, anahtar) || ...
    contains(ad, {'S4 ', 'Subsystem', 'PWM'});
end

function csv_yaz(dosya, bas, satirlar)
fid = fopen(dosya, 'w', 'n', 'UTF-8');
fprintf(fid, '%s\n', strjoin(cellfun(@tirnak, bas, 'UniformOutput', false), ','));
for r = 1:size(satirlar, 1)
    fprintf(fid, '%s\n', strjoin(cellfun(@tirnak, satirlar(r, :), 'UniformOutput', false), ','));
end
fclose(fid);
end

function s = tirnak(x)
if ~ischar(x), x = bicim(x); end
x = strrep(strrep(x, newline, ' ⏎ '), char(13), '');
if any(x == ',') || any(x == '"') || any(x == ';')
    s = ['"' strrep(x, '"', '""') '"'];
else
    s = x;
end
end
