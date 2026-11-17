function b5_olcek(fg, genislik_pt, yazi_pt)
% Sekli basili genislige (punto) getirir ve yazi boyutlarini sabitler (K-39).
% Tezde \includegraphics[width=\textwidth] ile yaklasik 1:1 basilir, boylece
% yazilar basili sayfada yazi_pt boyutunda kalir. En-boy orani korunur.
fg.Units = 'points';
p = fg.Position;
fg.Position = [p(1) p(2) genislik_pt genislik_pt*p(4)/p(3)];
set(findall(fg, 'Type', 'axes'), 'FontSize', yazi_pt);
set(findall(fg, 'Type', 'legend'), 'FontSize', yazi_pt - 0.5);
set(findall(fg, 'Type', 'colorbar'), 'FontSize', yazi_pt);
set(findall(fg, 'Type', 'text'), 'FontSize', yazi_pt - 0.5);
% eksen adlari ve basliklar da 'text' nesnesidir; tik yazisindan kucuk kalmasinlar (K-40)
for ax = findall(fg, 'Type', 'axes')'
    for r = [ax.XAxis(:); ax.YAxis(:)]', r.Label.FontSize = yazi_pt; end
    ax.Title.FontSize = yazi_pt;
end
set(findall(fg, 'Type', 'constantline'), 'FontSize', yazi_pt - 0.5);   % xline/yline etiketleri
for tl = findall(fg, 'Type', 'tiledlayout')'
    tl.XLabel.FontSize = yazi_pt; tl.YLabel.FontSize = yazi_pt; tl.Title.FontSize = yazi_pt;
end
drawnow;
end
