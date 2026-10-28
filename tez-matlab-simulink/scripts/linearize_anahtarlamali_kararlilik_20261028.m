% İP-6: anahtarlamalı S4 Simscape/SPS modelinin doğrudan linearize denemesi (gerekçe kaydı).
% Aynı G/Ç noktaları (d girişi; u_fb ve u_x çıkışları) ortalama modeldekiyle aynıdır.
% Beklenen: PWM karşılaştırıcısı (görev oranı ≥ taşıyıcı) ve anahtar kip mantığı
% süreksizdir; yerel türevleri hemen her yerde 0'dır. Doğrusallaştırma bu yüzden
% bitki yolunu keser ve L ≡ 0 verir: sonuç anlamsızdır, kararlılık ortalama model ve
% enjeksiyon ölçümüyle değerlendirilir.
% Çağrı (proje kökünden): matlab -batch "addpath('scripts'); linearize_anahtarlamali_kararlilik_20261028"
root_dir = fileparts(fileparts(mfilename('fullpath')));
run_dir = fullfile(root_dir, 'runs', '2026-10-28_kararlilik');
md = fullfile(run_dir, 'model_c'); od = fullfile(run_dir, 'ortalama');
mdl = 'inverter_senaryo4_enj';
cd(md);
evalin('base', sprintf('run(''%s''); run(''%s'');', fullfile(md, 'inverter_common_parameters.m'), fullfile(md, 's4_denetleyici_parametreleri.m')));
load_system(mdl);
ek = ' K14 = 0.44343; K34 = 0.384306; phase_deg4 = 0.6575; Cdc_pos = 0.0056; Cdc_neg = 0.0056;';
set_param(mdl, 'InitFcn', [get_param(mdl, 'InitFcn') newline ek]);
evalin('base', ['S4_Kp_c = Kp; S4_Ki_c = Kp*2*pi*S4_PI_fz; S4_Kaw = 2*pi*S4_PI_fz; S4_Kr = 0; S4_Iref = 25; S4_Iref_step = 25; ' ...
    'S6_inj_A = [0 0 0]; S6_inj_f = [212.5 525 1037.5]; S6_inj_ph = [0 0 0];' ek]);
set_param(mdl, 'SimscapeLogType', 'none');
io(1) = linio([mdl '/S6 Ton Toplami'], 1, 'input');
io(2) = linio([mdl '/S4 Akim Denetleyicisi'], 1, 'output');
io(3) = linio([mdl '/S6 Enjeksiyon Toplami'], 1, 'output');
opt = linearizeOptions('SampleTime', 1e-6, 'RateConversionMethod', 'zoh', 'StoreAdvisor', true);
fid = fopen(fullfile(od, 'anahtarlamali_linearize.txt'), 'w', 'n', 'UTF-8');
fprintf(fid, 'linearize_anahtarlamali_kararlilik_20261028 — %s — %s\n', char(datetime('now')), version);
try
    tic; [sys, ~, info] = linearize(mdl, io, opt); el = toc;
    w = 2*pi*[212.5 525 1037.5 3362.5];
    H = freqresp(sys, w);
    fprintf(fid, 'sure: %.0f s; durum sayisi: %d\n', el, numel(sys.StateName));
    fprintf(fid, '|H_d->u_fb| (212.5/525/1037.5/3362.5 Hz): %s\n', mat2str(abs(squeeze(H(1, 1, :))).', 4));
    fprintf(fid, '|H_d->u_x|  (212.5/525/1037.5/3362.5 Hz): %s\n', mat2str(abs(squeeze(H(2, 1, :))).', 4));
    fprintf(fid, 'L = -H_ufb/H_ux: %s\n', mat2str(abs(-squeeze(H(1, 1, :))./squeeze(H(2, 1, :))).', 4));
    try
        adv = info.Advisor; tb = advise(adv);
        fprintf(fid, 'danisman (advise) bloklari: %d\n', numel(tb.BlockInfo));
        for k = 1:min(40, numel(tb.BlockInfo))
            bi = tb.BlockInfo(k);
            fprintf(fid, '  %s | %s\n', strrep(bi.BlockPath, newline, ' '), strrep(evalc('disp(bi.Diagnostics)'), newline, ' '));
        end
    catch err2
        fprintf(fid, 'advise hata: %s\n', err2.message);
    end
catch err
    fprintf(fid, 'linearize HATA: %s\n', getReport(err, 'basic', 'hyperlinks', 'off'));
end
fclose(fid);
type(fullfile(od, 'anahtarlamali_linearize.txt'));
close_system(mdl, 0);
