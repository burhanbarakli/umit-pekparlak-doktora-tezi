%% duzelt_bolum5_sekiller_20261117.m
% Bolum 5 sekillerinde yazim duzeltmesi (K-39). Benzetim YENIDEN KOSTURULMAZ, mevcut
% kanit dosyalarinin uzerine yazilmaz. Ciktilar: yeni_tez/sekiller/b5/*.pdf
%  - Sekil 5.1  harmonik mekanizma : uret_harmonik_mekanizma.m kayitli S2 verisiyle,
%                                    "kalibre" kaldirilmis etiketlerle yeniden calisir
%  - Sekil 5.2  katsayi taramasi   : kayitli .fig, Turkce etiketler, %0,15 ve %39,96
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
fg = openfig(fullfile(b5_root, 'results', 'sin3_rescan_20260901', 'sin3_katsayi_taramasi_20260901.fig'), 'invisible');
for ax = findall(fg, 'Type', 'axes')'
    t = strjoin(cellstr(ax.Title.String), ' ');
    if contains(t, 'harmonik')                       % sol panel: baslik kalkar
        ax.Title.String = '';
        ax.XLabel.String = 'k_1 (temel katsayı)';
        ax.YLabel.String = 'k_3 (Sin^3 katsayısı)';
    else
        ax.Title.String = 'Pozitif alternans ortalama akım zarfı';
        ax.YLabel.String = 'Ortalama L_1 akımı (A)';
    end
end
for cb = findall(fg, 'Type', 'colorbar')', cb.Label.String = 'I_3/I_1 (%)'; end
for lg = findall(fg, 'Type', 'legend')'
    lg.String = {'k_1 = 0,34, k_3 = 0,40 (I_3/I_1 = %0,15)', ...
                 'Saf sinüs, d_m = 0,60 (I_3/I_1 = %39,96)', 'Temel bileşen'};
end
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
    sprintf('b5_olcek(f, 430, 8); b5_virgul(f); exportgraphics(f, ''%s'', ''ContentType'', ''vector'');', ...
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
    "function kaydet(fh, d, ad)" + newline + "b5_olcek(fh, 450, 8); b5_virgul(fh);");
b5_src = b5_yama(b5_src, "ylabel(ax1, '|L| [dB]'); ylabel(ax2, '\angle L [°]'); xlabel(ax2, 'f [Hz]');", ...
    "ylabel(ax1, '|L| (dB)'); ylabel(ax2, '\angle L (°)'); xlabel(ax2, 'f (Hz)');");
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
% sayisal denetim: gecici kopyanin CSV'leri ozgunle ayni olmali
for b5_c = {'lg_taramasi.csv', 'marjlar_ozet.csv'}
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
b5_src = b5_yama(b5_src, "function kaydet(fh, d, ad)", ...
    "function kaydet(fh, d, ad)" + newline + "b5_olcek(fh, 450, 8); b5_virgul(fh);");
b5_yaz(fullfile(b5_kk, 'karsilastir_kararlilik_b5.m'), b5_src);
run(fullfile(b5_kk, 'karsilastir_kararlilik_b5.m'));
close all force
b5_root = fileparts(fileparts(mfilename('fullpath')));
b5_out  = fullfile(fileparts(b5_root), 'yeni_tez', 'sekiller', 'b5');
b5_kk   = fullfile(b5_root, 'results', 'bolum5_sekiller_20261117', 'karsilastirma');
copyfile(fullfile(b5_kk, 'kararlilik_basamak_K34.pdf'), fullfile(b5_out, 'kararlilik_basamak_K34.pdf'));

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
    sprintf('b5_virgul(f); exportgraphics(f, ''%s'', ''ContentType'', ''vector'');', ...
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
    b5_olcek(fg, 450, 8);
    b5_virgul(fg);
    exportgraphics(fg, yol, 'ContentType', 'vector');
    [d, n] = fileparts(yol);
    exportgraphics(fg, fullfile(d, [n '.png']), 'Resolution', 150);
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
