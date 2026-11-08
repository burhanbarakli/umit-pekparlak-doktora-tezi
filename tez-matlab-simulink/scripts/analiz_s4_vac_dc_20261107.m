% Okuma notu madde 20 (Sekil 5.5, yesil egri v_ac): kayitli S4 25 A dalga
% kayitlarindan v_ac'nin periyot ortalamasi, tepe degerleri ve eksen hizalamasi.
% Benzetim kosturulmaz; yalniz results/<durum>/dalga.mat okunur.
% v_ac: 'AC Voltage Sensor1' (Goto v_ac1), L2'nin evirici ucu (C noktasi) ile
% Grid- arasi; Grid- (sebeke notru) EMC ortak kip bobini donus sargisi uzerinden
% DA bara orta noktasina baglidir (review/2026-10-27_TOPOLOJI_DENETIMI.md, s.3).
% v_inv: faz dugumu - DA orta noktasi. DA kapasitor gerilimleri ayri kaydedilmedi
% (dalga.mat'te yalniz toplam v_dc, 'tum' alt yapisinda, 10 us adimla).
% Cikti: runs/2026-10-28_s4_kapali_cevrim/inceleme_vac_dc_20261107.csv
% Cagri (proje kokunden): matlab -batch "run('scripts/analiz_s4_vac_dc_20261107.m')"
va_root = fileparts(fileparts(mfilename('fullpath')));
va_res = fullfile(va_root, 'runs', '2026-10-28_s4_kapali_cevrim', 'results');
va_cases = {'KC_P_25A', 'KC_PI_25A', 'KC_PIR_25A_02s'};
va_fig = fullfile(va_root, 'runs', '2026-10-28_s4_kapali_cevrim', 'sekiller', 's4_akim_izleme_25A_KC.fig');
fg = openfig(va_fig, 'invisible'); axs = flipud(findall(fg, 'Type', 'axes'));   % ust panel ilk
rows = {};
for k = 1:numel(va_cases)
    d = load(fullfile(va_res, va_cases{k}, 'dalga.mat')); w = d.dalga; u = d.tum;
    t = w.t(:); Tg = 0.02; dt = median(diff(t));
    for q = 1:2   % iki tam sebeke periyodu
        s = t >= t(1) + (q - 1)*Tg - dt/2 & t < t(1) + q*Tg - dt/2;
        su = u.t >= t(1) + (q - 1)*Tg - 5e-6 & u.t < t(1) + q*Tg - 5e-6;
        v = w.v_ac(s); tt = t(s);
        V1 = 2*mean(v.*exp(-1j*2*pi*50*tt));       % temel bilesen fazoru (tepe)
        v1 = real(V1*exp(1j*2*pi*50*tt)) ;          % (isaret kuralina gerek yok, yalniz genlik)
        vlf = movmean(v, round(1e-4/dt));           % 100 us kayan ortalama (anahtarlama dalgaciksiz)
        rows(end+1, :) = {va_cases{k}, q, mean(v), max(v), min(v), max(v) + min(v), ...
            max(vlf), min(vlf), abs(V1), rms(v), mean(w.v_inv(s)), mean(w.i_ac(s)), mean(w.iL1(s)), ...
            mean(u.v_dc(su)), NaN, NaN, NaN}; %#ok<SAGROW>
    end
    % sekildeki eksen sinirlari (sol = akim, sag = v_ac) ve sol sifirin sag eksendeki karsiligi
    ax = axs(k); yyaxis(ax, 'left'); yl = ax.YLim; yyaxis(ax, 'right'); yr = ax.YLim;
    v0 = yr(1) + (0 - yl(1))/(yl(2) - yl(1))*(yr(2) - yr(1));
    for r = size(rows, 1) - 1:size(rows, 1), rows(r, 15:17) = {mat2str(yl), mat2str(yr), v0}; end
end
close(fg);
VT = cell2table(rows, 'VariableNames', {'durum', 'periyot', 'vac_ort_V', 'vac_max_V', 'vac_min_V', ...
    'vac_max_arti_min_V', 'vac_100us_max_V', 'vac_100us_min_V', 'vac_1_tepe_V', 'vac_rms_V', ...
    'vinv_ort_V', 'iac_ort_A', 'iL1_ort_A', 'vdc_ort_V', 'sol_eksen_A', 'sag_eksen_V', 'sol_sifir_sag_eksende_V'});
disp(VT);
writetable(VT, fullfile(va_root, 'runs', '2026-10-28_s4_kapali_cevrim', 'inceleme_vac_dc_20261107.csv'), 'Encoding', 'UTF-8');
