%% relabel_sin3_coefficients_20261116.m
% K-35 gosterim birlestirmesi: tezde Sin^3 katsayilari D_1, D_3 yerine k_1, k_3
% ile gosterilir (D_1-D_2 faz hucresindeki harici diyotlarin adidir).
% 01.09.2026 taramasinin kayitli .fig dosyasi acilir, yalniz metin etiketlerinde
% D_1 -> k_1, D_3 -> k_3 degistirilir ve yeni adla disa aktarilir. Hesap yeniden
% yapilmaz; mevcut sonuc dosyalarinin uzerine yazilmaz.
root_dir = fileparts(fileparts(mfilename('fullpath')));
res_dir  = fullfile(root_dir, 'results', 'sin3_rescan_20260901');
fig = openfig(fullfile(res_dir, 'sin3_katsayi_taramasi_20260901.fig'), 'invisible');

degistir = @(s) strrep(strrep(s, 'D_1', 'k_1'), 'D_3', 'k_3');
n = 0;
for h = findall(fig, 'Type', 'text')'
    eski = h.String;
    h.String = degistir(eski);
    if ~isequal(eski, h.String), n = n + 1; end
end
for lg = findall(fig, 'Type', 'legend')'
    eski = lg.String;
    lg.String = cellfun(degistir, eski, 'UniformOutput', false);
    if ~isequal(eski, lg.String), n = n + 1; end
end
fprintf('Degisen etiket sayisi: %d\n', n);

exportgraphics(fig, fullfile(res_dir, 'sin3_katsayi_taramasi_20260901_k.pdf'), 'ContentType', 'vector');
exportgraphics(fig, fullfile(res_dir, 'sin3_katsayi_taramasi_20260901_k.png'), 'Resolution', 220);
close(fig);
