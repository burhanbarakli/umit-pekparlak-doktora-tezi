% Şekil 2.2 (fig:batarya-omur-guvenlik) temsilî batarya eğrilerinin vektörel çizimi (İP-11).
% Veri noktaları ilk tezdeki raster şekillerden okunmuştur (onceki_tez_dod_cevrim.jpg,
% onceki_tez_guvenli_calisma.png); eğriler Smith2017, Chen2021 ve Feng2018'e göre
% uyarlanmış temsilî değerlerdir, belirli bir hücrenin veri sayfası değildir.
% Çağrı: matlab -batch "run('<bu dosya>')"
here = fileparts(mfilename('fullpath'));
mavi = [0.12 0.47 0.71];

dod = [20 40 60 80 100];
cevrim = [12000 5500 3000 1500 750];
f = figure('Units', 'centimeters', 'Position', [2 2 8 6], 'Color', 'w', 'Visible', 'off');
ax = axes(f); hold(ax, 'on');
plot(ax, dod, cevrim, '-o', 'Color', mavi, 'LineWidth', 1.2, 'MarkerFaceColor', mavi, 'MarkerSize', 4);
grid(ax, 'on'); box(ax, 'on'); xlim(ax, [15 105]); ylim(ax, [0 13000]);
xlabel(ax, 'Deşarj derinliği (%)'); ylabel(ax, 'Çevrim ömrü (çevrim sayısı)');
ax.YAxis.Exponent = 0; ax.FontName = 'Arial'; ax.FontSize = 8;
exportgraphics(f, fullfile(here, 'batarya_dod_cevrim.pdf'), 'ContentType', 'vector');
close(f);

soc = [0 10 20 40 60 80 90 100];
vh = [2.50 3.00 3.20 3.45 3.65 3.90 4.03 4.19];
f = figure('Units', 'centimeters', 'Position', [2 2 8 6], 'Color', 'w', 'Visible', 'off');
ax = axes(f); hold(ax, 'on');
koyu = [0.85 0.90 0.95]; acik = [0.95 0.97 0.99];
patch(ax, [0 10 10 0], [2.4 2.4 4.3 4.3], koyu, 'EdgeColor', 'none');
patch(ax, [10 90 90 10], [2.4 2.4 4.3 4.3], acik, 'EdgeColor', 'none');
patch(ax, [90 100 100 90], [2.4 2.4 4.3 4.3], koyu, 'EdgeColor', 'none');
plot(ax, soc, vh, '-', 'Color', mavi, 'LineWidth', 1.4);
text(ax, 5, 4.12, {'Aşırı', 'deşarj'}, 'HorizontalAlignment', 'center', 'FontName', 'Arial', 'FontSize', 7);
text(ax, 50, 4.12, 'Güvenli çalışma bölgesi', 'HorizontalAlignment', 'center', 'FontName', 'Arial', 'FontSize', 7);
text(ax, 95, 3.70, {'Aşırı', 'şarj'}, 'HorizontalAlignment', 'center', 'FontName', 'Arial', 'FontSize', 7);
grid(ax, 'on'); box(ax, 'on'); ax.Layer = 'top';
xlim(ax, [0 100]); ylim(ax, [2.4 4.3]);
xlabel(ax, 'Doluluk oranı, SoC (%)'); ylabel(ax, 'Hücre gerilimi (V)');
ax.FontName = 'Arial'; ax.FontSize = 8;
exportgraphics(f, fullfile(here, 'batarya_guvenli_calisma.pdf'), 'ContentType', 'vector');
close(f);
fprintf('batarya eğrileri yazıldı: %s\n', here);
