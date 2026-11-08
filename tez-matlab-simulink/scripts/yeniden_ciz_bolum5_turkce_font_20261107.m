% Bolum 5 MATLAB sekillerinin Turkce glifli yazi tipiyle (Arial) yeniden uretimi.
% Sorun: sekiller varsayilan Helvetica ile vektor PDF'e aktarilmis; Helvetica
% gomulmedigi icin WinAnsi disi harfler (s-cedilla, noktasiz i, yumusak g) PDF'te
% "#" olarak cikiyor (tez PDF'inde Sekil 5.5 ve 5.8-5.13).
% Benzetim YENIDEN KOSTURULMAZ:
%  - kararlilik_* sekilleri: analiz_kararlilik_20261028 (analitik, ortalama model,
%    Simulink yok) ve karsilastir_kararlilik_20261028 (kayitli olcum.mat/dalga.mat)
%    betikleri groot varsayilan yazi tipi Arial iken yeniden calistirilir. Bu
%    betiklerin yazdigi CSV/MAT/TXT dosyalari koşu sonrasi yedekle karsilastirilip
%    yedekten geri yuklenir (kanit dosyalari degismez; yalniz PDF/PNG yenilenir).
%  - s4_akim_izleme_25A_KC: kayitli .fig acilir, butun metin nesneleri ve
%    tiledlayout ekseni etiketi Arial yapilir, vektor PDF'e aktarilir. Metinler
%    degistirilmez (onceki aktarimdaki "eta eta" yinelemesi bu yolla ortadan kalkar).
% Yedek: runs/2026-10-28_kararlilik/_yedek_2026-11-07/ ve
%        runs/2026-10-28_s4_kapali_cevrim/sekiller/_yedek_2026-11-07/
% Cagri (proje kokunden):
%   matlab -batch "run('scripts/yeniden_ciz_bolum5_turkce_font_20261107.m')"

yc_root = fileparts(fileparts(mfilename('fullpath')));
yc_font = 'Arial';
yc_ozellik = {'defaultAxesFontName', 'defaultTextFontName', 'defaultLegendFontName', ...
    'defaultColorbarFontName', 'defaultTextarrowshapeFontName', 'defaultTextboxshapeFontName', ...
    'defaultConstantLineFontName'};
for yc_i = 1:numel(yc_ozellik)
    try, set(groot, yc_ozellik{yc_i}, yc_font); catch yc_e, fprintf('atlandi: %s (%s)\n', yc_ozellik{yc_i}, yc_e.message); end
end

% ---- 1) kararlilik sekilleri (Sekil 5.8-5.13) -----------------------------------
addpath(fullfile(yc_root, 'scripts'));
run(fullfile(yc_root, 'scripts', 'analiz_kararlilik_20261028.m'));
close all force
run(fullfile(yc_root, 'scripts', 'karsilastir_kararlilik_20261028.m'));
close all force
% Analiz betiklerinin yeniden yazdigi sayisal dosyalar: yedekle ayni olmali.
% CSV'ler bayt duzeyinde ayni cikar (07.11.2026 denetimi); gunluk TXT'de yalniz
% zaman damgasi, MAT'ta yalniz ust bilgi degisir. Ozgun kanit korunsun diye
% yedekteki TXT/MAT geri yuklenir.
yc_root = fileparts(fileparts(mfilename('fullpath')));
yc_yedek = fullfile(yc_root, 'runs', '2026-10-28_kararlilik', '_yedek_2026-11-07');
if isfolder(yc_yedek)
    for yc_d = {'frekans', 'karsilastirma'}
        yc_l = dir(fullfile(yc_yedek, yc_d{1}, '*.*'));
        yc_l = yc_l(~[yc_l.isdir] & ~endsWith({yc_l.name}, {'.pdf', '.png'}));
        for yc_i = 1:numel(yc_l)
            copyfile(fullfile(yc_l(yc_i).folder, yc_l(yc_i).name), ...
                fullfile(yc_root, 'runs', '2026-10-28_kararlilik', yc_d{1}, yc_l(yc_i).name));
        end
    end
end

% ---- 2) S4 akim izleme (Sekil 5.5) ------------------------------------------------
yc_root = fileparts(fileparts(mfilename('fullpath')));   % betikler calisma alanini paylasir
yc_font = 'Arial';
yc_src = fullfile(yc_root, 'runs', '2026-10-28_s4_kapali_cevrim', 'sekiller', 's4_akim_izleme_25A_KC.fig');
yc_dst = fullfile(fileparts(yc_root), 'tez-latex-v2', 'figures', 's4');
yc_fg = openfig(yc_src, 'invisible');
set(findall(yc_fg, '-property', 'FontName'), 'FontName', yc_font);
yc_tl = findall(yc_fg, 'Type', 'tiledlayout');
for yc_i = 1:numel(yc_tl)
    yc_tl(yc_i).XLabel.FontName = yc_font; yc_tl(yc_i).YLabel.FontName = yc_font; yc_tl(yc_i).Title.FontName = yc_font;
end
exportgraphics(yc_fg, fullfile(yc_dst, 's4_akim_izleme_25A_KC.pdf'), 'ContentType', 'vector');
% Bilgi icin (tex'te kullanilmaz): sol ve sag y ekseninin sifirlari hizali varyant.
yc_ax = findall(yc_fg, 'Type', 'axes');
for yc_i = 1:numel(yc_ax)
    yyaxis(yc_ax(yc_i), 'left'); yc_yl = yc_ax(yc_i).YLim; yc_m = max(abs(yc_yl));
    yc_ax(yc_i).YLim = [-yc_m yc_m];
    yyaxis(yc_ax(yc_i), 'right'); yc_yl = yc_ax(yc_i).YLim; yc_m = max(abs(yc_yl));
    yc_ax(yc_i).YLim = [-yc_m yc_m];
end
exportgraphics(yc_fg, fullfile(yc_root, 'runs', '2026-10-28_s4_kapali_cevrim', 'sekiller', ...
    's4_akim_izleme_25A_KC_sifir_hizali.pdf'), 'ContentType', 'vector');
exportgraphics(yc_fg, fullfile(yc_root, 'runs', '2026-10-28_s4_kapali_cevrim', 'sekiller', ...
    's4_akim_izleme_25A_KC_sifir_hizali.png'), 'Resolution', 300);
close(yc_fg);
fprintf('yeniden_ciz_bolum5_turkce_font_20261107: tamam\n');
