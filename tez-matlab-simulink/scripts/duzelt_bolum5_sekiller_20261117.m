%% duzelt_bolum5_sekiller_20261117.m
% Bolum 5 sekillerinde yazim duzeltmesi (K-39). Benzetim YENIDEN KOSTURULMAZ, mevcut
% kanit dosyalarinin uzerine yazilmaz. Ciktilar: yeni_tez/sekiller/b5/*.pdf
%  - Sekil 5.1  harmonik mekanizma : uret_harmonik_mekanizma.m kayitli S2 verisiyle,
%                                    "kalibre" kaldirilmis etiketlerle yeniden calisir
%  - Sekil 5.2  katsayi taramasi   : 20.11 taramasi, Irms > 2.2 A, %0,315 ve %39,96
%  - Sekil 5.6  S4 25 A izleme     : kayitli .fig, basliklar (a) P, (b) PI, (c) PIR
%  - Sekil 5.7  S4 tarama ozeti    : kayitli .fig, eksen etiketleri
%  - Sekil 5.8  PI basamagi        : kayitli .fig, gosterge "doyum oncesi"
%  - Sekil 5.11 Nyquist, 5.12 L_g  : analiz_kararlilik_20261028.m gecici kopyasi
%                                    (yalniz etiketler degisir, cikti gecici klasore)
%  - Sekil 5.14 K34 basamak       : karsilastir_kararlilik_20261028.m gecici kopyasi
%  - Sekil 5.4  S3 L1 akimi        : uret_l1_kapi_sekilleri.m gecici kopyasi
% Tum eksenlerde ondalik virgul, yazi tipi Arial (Turkce glifler gomulsun). Sekiller
% basili genislikte (~450 pt) ve 8 pt yaziyla aktarilir (b5_olcek), tezde 1:1 basilir.
% Denetci ajan bulgulari: i_ac -> i_g, esit eksen olcegi, toplam gecikme notu, L_g ekseni 30 kHz.
% K-40 (Mac denetimi, 17.11.2026): disa aktarimdan once b5_son(fg, ad) cagrilir: veriyi orten
% gostergeler disari, basliklar normal yazi, cerceve, mikro dik, eksen adlari tik boyutunda,
% eksi isareti U+2212, 5.2 sag baslik kalkar, 5.7 eksen payi, 5.11 tikleri, 5.12 dB araligi.
% K-40 ucuncu tur: 5.4 da b5_olcek'ten gecer (eksen adlari 8,8 pt kaliyordu).
% Cagri (proje kokunden): matlab -batch "run('scripts/duzelt_bolum5_sekiller_20261117.m')"

b5_root = fileparts(fileparts(mfilename('fullpath')));
b5_out  = fullfile(fileparts(b5_root), 'yeni_tez', 'sekiller', 'b5');
b5_tmp  = fullfile(b5_root, 'results', 'bolum5_sekiller_20261117');
if ~isfolder(b5_out), mkdir(b5_out); end
if ~isfolder(b5_tmp), mkdir(b5_tmp); end
b5_font = 'Arial';
for b5_p = {'defaultAxesFontName', 'defaultTextFontName', 'defaultLegendFontName', 'defaultColorbarFontName'}
    set(groot, b5_p{1}, b5_font);
end
addpath(fullfile(b5_root, 'scripts'));
b5_s4 = fullfile(b5_root, 'runs', '2026-10-28_s4_kapali_cevrim', 'sekiller');

%% Sekil 5.2: (k1,k3) katsayi taramasi
fg = openfig(fullfile(b5_root, 'results', 'sin3_rescan_20261120', 'sin3_katsayi_taramasi_20261120.fig'), 'invisible');
for ax = findall(fg, 'Type', 'axes')'
    t = strjoin(cellstr(ax.Title.String), ' ');
    if contains(t, 'harmonik')                       % sol panel: baslik kalkar
        ax.Title.String = '';
        ax.XLabel.String = 'k_1 (temel katsayı)';
        ax.YLabel.String = 'k_3 (Sin^3 katsayısı)';
    else
        ax.Title.String = '';                        % K-40: sag panel basligi da kalkar
        ax.YLabel.String = 'Ortalama L_1 akımı (A)';
    end
end
for cb = findall(fg, 'Type', 'colorbar')', cb.Label.String = 'I_3/I_1 (%)'; end
b5_bitir(fg, b5_font, fullfile(b5_out, 'sin3_katsayi_taramasi.pdf'));

%% Sekil 5.6: S4 25 A akim izleme
fg = openfig(fullfile(b5_s4, 's4_akim_izleme_25A_KC.fig'), 'invisible');
for ax = findall(fg, 'Type', 'axes')'
    t = strjoin(cellstr(ax.Title.String), ' ');
    if contains(t, 'KC PIR'),      ax.Title.String = '(c) PIR';
    elseif contains(t, 'KC PI '),  ax.Title.String = '(b) PI';
    elseif contains(t, 'KC P '),   ax.Title.String = '(a) P';
    end
    yyaxis(ax, 'left');  ax.YLabel.String = 'Akım (A)';
    yyaxis(ax, 'right'); ax.YLabel.String = 'v_{ac} (V)';
end
for tl = findall(fg, 'Type', 'tiledlayout')', tl.XLabel.String = 't (ms), son iki şebeke periyodu'; end
for lg = findall(fg, 'Type', 'legend')', lg.String = strrep(lg.String, 'i_{ac} (C noktası)', 'i_g (C noktası)'); end
for ax = findall(fg, 'Type', 'axes')'                     % uc panelde esit olcek
    yyaxis(ax, 'left'); ax.YLim = [-60 60]; yyaxis(ax, 'right'); ax.YLim = [-200 200];
end
b5_bitir(fg, b5_font, fullfile(b5_out, 's4_akim_izleme_25A.pdf'));

%% Sekil 5.7: S4 tarama ozeti
fg = openfig(fullfile(b5_s4, 's4_tarama_ozet_KC.fig'), 'invisible');
for ax = findall(fg, 'Type', 'axes')'
    yl = strjoin(cellstr(ax.YLabel.String), ' ');
    if contains(yl, 'genlik'),   ax.YLabel.String = 'Genlik hatası (%)';
    elseif contains(yl, 'THD'),  ax.YLabel.String = 'Şebeke akımı THD''si, h \leq 50 (%)';
    else,                        ax.YLabel.String = '\eta (%)';
    end
    ax.XLabel.String = 'I_{ref} (A, RMS)';
end
b5_bitir(fg, b5_font, fullfile(b5_out, 's4_tarama_ozet.pdf'));

%% Sekil 5.8: PI basamagi 10 -> 25 A
fg = openfig(fullfile(b5_s4, 's4_basamak_PI_10_25A_KC.fig'), 'invisible');
for ax = findall(fg, 'Type', 'axes')'
    ax.Title.String = '';
    yl = strjoin(cellstr(ax.YLabel.String), ' ');
    if contains(yl, 'lasyon'), ax.YLabel.String = 'Modülasyon (–)'; else, ax.YLabel.String = 'Akım (A)'; end
    if ~isempty(ax.XLabel.String), ax.XLabel.String = 't (ms)'; end
end
for lg = findall(fg, 'Type', 'legend')'
    s = lg.String;
    s = strrep(s, 'u = u_{ff} + u_{fb}', 'u_{ff} + u_{fb} (doyum öncesi)');
    lg.String = s;
end
b5_bitir(fg, b5_font, fullfile(b5_out, 's4_basamak_PI_10_25A.pdf'));

%% Sekil 5.1: harmonik olusum mekanizmasi (kayitli S2 verisiyle yeniden cizim)
b5_kaynak = fullfile(fileparts(b5_root), 'tez-latex-v2', 'figures', 'sin3', 'uret_harmonik_mekanizma.m');
b5_src = fileread(b5_kaynak);
b5_veri = strrep(fullfile(b5_root, 'runs', '2026-10-29_tez_sekilleri', 'results'), '\', '/');
b5_src = b5_yama(b5_src, "kok = fullfile(here, '..', '..', '..', 'tez-matlab-simulink', 'runs', '2026-10-29_tez_sekilleri', 'results');", ...
    sprintf('kok = ''%s'';', b5_veri));
b5_src = b5_yama(b5_src, "here = fileparts(mfilename('fullpath'));", sprintf('here = ''%s'';', strrep(b5_tmp, '\', '/')));
b5_src = strrep(b5_src, '''kalibre S2 benzetimi''', '''S2 benzetimi''');
b5_src = strrep(b5_src, ' [V]''', ' (V)''');
b5_src = strrep(b5_src, ' [A]''', ' (A)''');
b5_src = strrep(b5_src, 't [ms]', 't (ms)');
b5_src = b5_yama(b5_src, "title(ax, '(b) Endüktör akımını yükselten gerilim payı', 'FontWeight', 'normal');", ...
    "title(ax, '(b) İletimde endüktör gerilimi', 'FontWeight', 'normal');");
b5_src = b5_yama(b5_src, "exportgraphics(f, fullfile(here, 'harmonik_olusum_mekanizmasi.pdf'), 'ContentType', 'vector');", ...
    sprintf('b5_olcek(f, 430, 8); b5_son(f, ''harmonik_olusum_mekanizmasi''); b5_virgul(f); exportgraphics(f, ''%s'', ''ContentType'', ''vector'');', ...
    strrep(fullfile(b5_out, 'harmonik_olusum_mekanizmasi.pdf'), '\', '/')));
b5_yaz(fullfile(b5_tmp, 'uret_harmonik_mekanizma_b5.m'), b5_src);
run(fullfile(b5_tmp, 'uret_harmonik_mekanizma_b5.m'));
close all force

%% Sekil 5.11 ve 5.12: kararlilik betiginin gecici kopyasi (yalniz etiketler)
b5_root = fileparts(fileparts(mfilename('fullpath')));      % betikler calisma alanini paylasir
b5_out  = fullfile(fileparts(b5_root), 'yeni_tez', 'sekiller', 'b5');
b5_tmp  = fullfile(b5_root, 'results', 'bolum5_sekiller_20261117');
b5_kd   = fullfile(b5_tmp, 'kararlilik');
if ~isfolder(b5_kd), mkdir(b5_kd); end
b5_src = fileread(fullfile(b5_root, 'scripts', 'analiz_kararlilik_20261028.m'));
b5_src = b5_yama(b5_src, "root_dir = fileparts(fileparts(mfilename('fullpath')));", ...
    sprintf('root_dir = ''%s'';', strrep(b5_root, '\', '/')));
b5_src = b5_yama(b5_src, "out_dir = fullfile(root_dir, 'runs', '2026-10-28_kararlilik', 'frekans');", ...
    sprintf('out_dir = ''%s'';', strrep(b5_kd, '\', '/')));
b5_src = b5_yama(b5_src, "title(ax, '(A) analog eşdeğeri');", ...
    "title(ax, {'(A) analog eşdeğer', 'T_d = 2 µs'});");
b5_src = b5_yama(b5_src, "title(ax, '(B) sayısal, T_s = 100 µs, 1 T_s gecikme');", ...
    "title(ax, {'(B) sayısal, T_s = 100 µs', '1T_s hesaplama gecikmesi (toplam \approx 2T_s)'});");
b5_src = b5_yama(b5_src, "xlim(ax1, [10 2e4]); xlim(ax2, [10 2e4]);", "xlim(ax1, [10 3e4]); xlim(ax2, [10 3e4]);");
b5_src = b5_yama(b5_src, "function kaydet(fh, d, ad)", ...
    "function kaydet(fh, d, ad)" + newline + "b5_olcek(fh, 450, 8); b5_son(fh, ad); b5_virgul(fh);");
b5_src = b5_yama(b5_src, "ylabel(ax1, '|L| [dB]'); ylabel(ax2, '\angle L [°]'); xlabel(ax2, 'f [Hz]');", ...
    "ylabel(ax1, '|L| (dB)'); ylabel(ax2, 'Faz (°)'); xlabel(ax2, 'Frekans (Hz)');");
% Sekil 5.9 (L Bode) ve 5.10 (S, T)
b5_src = b5_yama(b5_src, "ylabel(ax1, '|L(j\omega)| [dB]'); ylabel(ax2, '\angle L(j\omega) [°]'); xlabel(ax2, 'f [Hz]');", ...
    "ylabel(ax1, '|L| (dB)'); ylabel(ax2, 'Faz (°)'); xlabel(ax2, 'Frekans (Hz)');");
b5_src = b5_yama(b5_src, "title(ax1, 'Çevrim kazancı L = C K_{pwm} G H_m e^{-sT_d} (ortalama model, gerçekleme A)');", "");
b5_src = b5_yama(b5_src, "xlabel(ax, 'f [Hz]'); ylabel(ax, '[dB]');", "xlabel(ax, 'Frekans (Hz)'); ylabel(ax, 'Büyüklük (dB)');");
b5_src = b5_yama(b5_src, "title(ax, 'Duyarlılık S = 1/(1+L) ve tümleyen T = L/(1+L) (K_{34} açık ve kapalı aynı)');", "");
% K-40 dorduncu tur: 5.9 isaretcileri 1 Hz eksen kenarindan iceri; 5.10'a K34 = 0 isaretcileri
% (5.9'daki K34 = 0 isaretcileriyle ayni L: getLoopTransfer(ara{k,2}, 'u_fb', -1); SwA/TwA gibi
% S = 1/(1+L), T = L/(1+L))
b5_src = b5_yama(b5_src, "ii = 1:600:numel(f);", "ii = 301:600:numel(f);");
b5_src = b5_yama(b5_src, "    semilogx(ax, f, 20*log10(abs(TwA{k})), '--', 'Color', renk(k, :), 'LineWidth', 1.1, 'DisplayName', ['|T|, ' cn{k}]);", ...
    "    semilogx(ax, f, 20*log10(abs(TwA{k})), '--', 'Color', renk(k, :), 'LineWidth', 1.1, 'DisplayName', ['|T|, ' cn{k}]);" + newline + ...
    "    L0w = squeeze(freqresp(getLoopTransfer(ara{k, 2}, 'u_fb', -1), w)); ii = 301:600:numel(f);" + newline + ...
    "    semilogx(ax, f(ii), 20*log10(abs(1./(1 + L0w(ii)))), 'o', 'Color', renk(k, :), 'MarkerSize', 4, 'HandleVisibility', 'off');" + newline + ...
    "    semilogx(ax, f(ii), 20*log10(abs(L0w(ii)./(1 + L0w(ii)))), 'o', 'Color', renk(k, :), 'MarkerSize', 4, 'HandleVisibility', 'off');");
b5_src = b5_yama(b5_src, "xline(ax, 50, 'k:', '50 Hz', 'HandleVisibility', 'off');", ...
    "plot(ax, NaN, NaN, 'ko', 'MarkerSize', 4, 'DisplayName', 'K_{34} = 0'); xline(ax, 50, 'k:', '50 Hz', 'HandleVisibility', 'off');");
b5_src = b5_yama(b5_src, "'DisplayName', sprintf('L_g = %.1f mH', 1e3*Lgv(a))", ...
    "'DisplayName', ['L_g = ' strrep(sprintf('%g', 1e3*Lgv(a)), '.', ',') ' mH']");
b5_src = b5_yama(b5_src, "title(ax1, 'Şebeke endüktansı duyarlılığı, PI, gerçekleme A (L_2 + L_g)');", "");
b5_yaz(fullfile(b5_kd, 'analiz_kararlilik_b5.m'), b5_src);
run(fullfile(b5_kd, 'analiz_kararlilik_b5.m'));
close all force
b5_root = fileparts(fileparts(mfilename('fullpath')));
b5_out  = fullfile(fileparts(b5_root), 'yeni_tez', 'sekiller', 'b5');
b5_kd   = fullfile(b5_root, 'results', 'bolum5_sekiller_20261117', 'kararlilik');
copyfile(fullfile(b5_kd, 'kararlilik_nyquist_A_B.pdf'), fullfile(b5_out, 'kararlilik_nyquist_A_B.pdf'));
copyfile(fullfile(b5_kd, 'kararlilik_Lg_taramasi.pdf'), fullfile(b5_out, 'kararlilik_Lg_taramasi.pdf'));
copyfile(fullfile(b5_kd, 'kararlilik_L_bode_K34.pdf'), fullfile(b5_out, 'kararlilik_L_bode_K34.pdf'));
copyfile(fullfile(b5_kd, 'kararlilik_S_T.pdf'), fullfile(b5_out, 'kararlilik_S_T.pdf'));
% sayisal denetim: gecici kopyanin CSV'leri ozgunle ayni olmali
for b5_c = {'lg_taramasi.csv', 'kararlilik_marjlar.csv'}
    b5_a = fullfile(b5_root, 'runs', '2026-10-28_kararlilik', 'frekans', b5_c{1});
    b5_b = fullfile(b5_kd, b5_c{1});
    if isfile(b5_a) && isfile(b5_b)
        fprintf('%s ozgunle ayni: %d\n', b5_c{1}, isequal(fileread(b5_a), fileread(b5_b)));
    end
end

%% Sekil 5.14: PI basamagi, K34 acik/kapali (karsilastirma betiginin gecici kopyasi)
b5_root = fileparts(fileparts(mfilename('fullpath')));
b5_out  = fullfile(fileparts(b5_root), 'yeni_tez', 'sekiller', 'b5');
b5_kk   = fullfile(b5_root, 'results', 'bolum5_sekiller_20261117', 'karsilastirma');
if ~isfolder(b5_kk), mkdir(b5_kk); end
b5_src = fileread(fullfile(b5_root, 'scripts', 'karsilastir_kararlilik_20261028.m'));
b5_src = b5_yama(b5_src, "root_dir = fileparts(fileparts(mfilename('fullpath')));", ...
    sprintf('root_dir = ''%s'';', strrep(b5_root, '\', '/')));
b5_src = b5_yama(b5_src, "out_dir = fullfile(run_dir, 'karsilastirma'); if ~exist(out_dir, 'dir'), mkdir(out_dir); end", ...
    sprintf('out_dir = ''%s'';', strrep(b5_kk, '\', '/')));
b5_src = b5_yama(b5_src, "ylabel(ax, 'i_{L1} (periyot ortalaması) [A]');", "ylabel(ax, 'i_{L1}, periyot ortalaması (A)');");
b5_src = b5_yama(b5_src, "title(ax, 'PI, 10 \rightarrow 25 A basamağı (t = 55 ms)');", "xlim(ax, [-10 15]);");
b5_src = b5_yama(b5_src, "xlim(ax, [-10 30]); xlabel(ax, 't - t_{basamak} [ms]'); ylabel(ax, 'geçici bileşen [A]');", ...
    "xlim(ax, [-10 15]); xlabel(ax, 't − t_{basamak} (ms)'); ylabel(ax, 'i_{L1}(t) − i_{L1}(t + 20 ms) (A)');");
b5_src = b5_yama(b5_src, "title(ax, 'Geçici bileşen i_{L1}(t) - i_{L1}(t + 20 ms)');", "");
% Sekil 5.13: olculen ve analitik cevrim kazanci
b5_src = b5_yama(b5_src, "ylabel(ax1, '|L| [dB]'); ylabel(ax2, '\angle L [°]'); xlabel(ax2, 'f [Hz]');", ...
    "ylabel(ax1, '|L| (dB)'); ylabel(ax2, 'Faz (°)'); xlabel(ax2, 'Frekans (Hz)');");
b5_src = b5_yama(b5_src, "title(ax1, 'L(j\omega): ortalama model ve anahtarlamalı modelde enjeksiyon ölçümü (PI)');", "");
b5_src = b5_yama(b5_src, "'analitik (ortalama model), PI'", "'analitik L, gerçekleme (A), PI'");
b5_src = b5_yama(b5_src, "function kaydet(fh, d, ad)", ...
    "function kaydet(fh, d, ad)" + newline + "b5_olcek(fh, 450, 8); b5_son(fh, ad); b5_virgul(fh);");
b5_yaz(fullfile(b5_kk, 'karsilastir_kararlilik_b5.m'), b5_src);
run(fullfile(b5_kk, 'karsilastir_kararlilik_b5.m'));
close all force
b5_root = fileparts(fileparts(mfilename('fullpath')));
b5_out  = fullfile(fileparts(b5_root), 'yeni_tez', 'sekiller', 'b5');
b5_kk   = fullfile(b5_root, 'results', 'bolum5_sekiller_20261117', 'karsilastirma');
copyfile(fullfile(b5_kk, 'kararlilik_basamak_K34.pdf'), fullfile(b5_out, 'kararlilik_basamak_K34.pdf'));
copyfile(fullfile(b5_kk, 'kararlilik_L_olcum_karsilastirma.pdf'), fullfile(b5_out, 'kararlilik_L_olcum_karsilastirma.pdf'));

%% Sekil 5.4: S3 L1 akimi (model dogrulama betiginin gecici kopyasi)
b5_tmp = fullfile(b5_root, 'results', 'bolum5_sekiller_20261117');
b5_src = fileread(fullfile(fileparts(b5_root), 'tez-latex-v2', 'figures', 'model_dogrulama', 'uret_l1_kapi_sekilleri.m'));
b5_src = b5_yama(b5_src, "kok = fullfile(here, '..', '..', '..', 'tez-matlab-simulink', 'runs', '2026-10-29_tez_sekilleri', 'results');", ...
    sprintf('kok = ''%s'';', strrep(fullfile(b5_root, 'runs', '2026-10-29_tez_sekilleri', 'results'), '\', '/')));
b5_src = b5_yama(b5_src, "here = fileparts(mfilename('fullpath'));", sprintf('here = ''%s'';', strrep(b5_tmp, '\', '/')));
b5_src = b5_yama(b5_src, "ylabel(ax, 'akım [A]'); xlabel(ax, 't - 80 ms [ms]');", "ylabel(ax, 'Akım (A)'); xlabel(ax, 't − 80 ms (ms)');");
b5_src = strrep(b5_src, "ylabel(ax, 'i_{L1} [A]');", "ylabel(ax, 'i_{L1} (A)');");
b5_src = strrep(b5_src, "xlabel(ax, ['t - ' strrep(num2str(za*1e3, '%.1f'), '.', ',') ' ms [\mus]']);", ...
    "xlabel(ax, ['t − ' strrep(num2str(za*1e3, '%.1f'), '.', ',') ' ms (\mus)']);");
b5_src = b5_yama(b5_src, "exportgraphics(f, fullfile(here, 's3_kalibre_l1.pdf'), 'ContentType', 'vector');", ...
    sprintf('b5_olcek(f, 450, 8); b5_son(f, ''s3_l1_akimi''); b5_virgul(f); exportgraphics(f, ''%s'', ''ContentType'', ''vector'');', ...
    strrep(fullfile(b5_out, 's3_l1_akimi.pdf'), '\', '/')));
b5_yaz(fullfile(b5_tmp, 'uret_l1_kapi_sekilleri_b5.m'), b5_src);
run(fullfile(b5_tmp, 'uret_l1_kapi_sekilleri_b5.m'));
close all force
fprintf('duzelt_bolum5_sekiller_20261117: tamam\n');

%% yerel islevler
function b5_bitir(fg, font, yol)
    set(findall(fg, '-property', 'FontName'), 'FontName', font);
    for tl = findall(fg, 'Type', 'tiledlayout')'
        tl.XLabel.FontName = font; tl.YLabel.FontName = font; tl.Title.FontName = font;
    end
    [~, ad] = fileparts(yol);
    yazi = 8;
    if strcmp(ad, 'sin3_katsayi_taramasi'), yazi = 10; end
    b5_olcek(fg, 450, yazi);
    b5_son(fg, ad);
    b5_virgul(fg);
    exportgraphics(fg, yol, 'ContentType', 'vector');
    close(fg);
end
function s = b5_yama(s, eski, yeni)
    eski = char(eski); yeni = char(yeni);
    n = numel(strfind(s, eski));
    assert(n == 1, 'yama bulunamadi (%d): %s', n, eski);
    s = strrep(s, eski, yeni);
end
function b5_yaz(yol, s)
    fid = fopen(yol, 'w', 'n', 'UTF-8'); fwrite(fid, s, 'char'); fclose(fid);
end
