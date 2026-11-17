function b5_virgul(fg)
% Dogrusal eksenlerde ve renk cubuklarinda ondalik ayiraci virgul yapar (K-39).
% Tik degerleri sabitlenir, etiketler '%g' bicimiyle yazilip nokta virgule cevrilir.
% Eksi isareti tire yerine U+2212 (metindeki gibi) yazilir (K-40).
for ax = findall(fg, 'Type', 'axes')'
    cetveller = [ax.XAxis(:); ax.YAxis(:)];
    for r = cetveller'
        if isprop(r, 'Scale') && strcmp(r.Scale, 'linear')
            t = r.TickValues;
            r.TickValues = t;
            r.TickLabels = strrep(strrep(compose('%g', t(:)), '.', ','), '-', char(8722));
        end
    end
end
for cb = findall(fg, 'Type', 'colorbar')'
    t = cb.Ticks;
    cb.Ticks = t;
    cb.TickLabels = strrep(strrep(compose('%g', t(:)), '.', ','), '-', char(8722));
end
end
