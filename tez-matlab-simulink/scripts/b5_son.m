function b5_son(fg, ad)
% Bolum 5 sekillerinde disa aktarimdan once son bicim duzeltmesi (K-40).
% b5_olcek'ten SONRA, b5_virgul'den ONCE cagrilir (eksen sinirlari burada degisirse
% b5_virgul yeni tikleri dondurur). ad: ciktinin uzantisiz dosya adi.
% Ortak: baslik normal yazi, eksen cercevesi, eksen adlari buyuk harfle, dik mikro (µ),
% cizgi kalinligi en fazla 1,0 pt. Sekile ozgu: veriyi ortten gostergeler disari alinir.
% Kaynak: Mac denetimi, 17.11.2026 (bagimsiz denetci ajan raporu).

eksenler = findall(fg, 'Type', 'axes')';

%% ortak
for ax = eksenler
    ax.Title.FontWeight = 'normal';
    ax.Box = 'on';
    for r = [ax.XAxis(:); ax.YAxis(:)]'
        r.Label.String = buyuk_harf(r.Label.String);
    end
end
for t = findall(fg, 'Type', 'text')'
    t.String = mikro(t.String);
end
for lg = findall(fg, 'Type', 'legend')'
    lg.String = mikro(lg.String);
end
for ln = findall(fg, 'Type', 'line')'
    if ~strcmp(ln.LineStyle, 'none')
        ln.LineWidth = min(ln.LineWidth, 1.0);       % yogun anahtarlama izleri kalinlasmasin
    end
end

%% sekile ozgu
switch ad
    case 'harmonik_olusum_mekanizmasi'                 % Sekil 5.1 (c): gosterge egrinin tepesinde
        for ax = eksenler
            if contains(etiket(ax.YLabel.String), 'I_{pk}'), ax.YLim = [0 12.5]; end
        end
        for lg = findall(fg, 'Type', 'legend')'
            if any(contains(lg.String, 'aynı tepeli sinüs')), lg.Orientation = 'horizontal'; end
        end

    case 'sin3_katsayi_taramasi'                       % Sekil 5.2 sag: gosterge egri kollarini ortuyor
        for lg = findall(fg, 'Type', 'legend')', disari(lg, 2, 'south'); end

    case 's4_tarama_ozet'                              % Sekil 5.7: gosterge ve kesilen isaretciler
        for lg = findall(fg, 'Type', 'legend')', disari(lg, 3, 'north'); end
        for ax = eksenler, pay_birak(ax); end

    case 's4_basamak_PI_10_25A'                        % Sekil 5.8: iki gosterge ilk tepeleri ortuyor
        for lg = findall(fg, 'Type', 'legend')', disari(lg, 2, ''); end

    case 'kararlilik_S_T'                              % Sekil 5.10: gosterge |T| centigini kesiyor
        for lg = findall(fg, 'Type', 'legend')', disari(lg, 3, ''); end

    case 'kararlilik_nyquist_A_B'                      % Sekil 5.11: (B) basligi "3" tikine biniyor
        for ax = eksenler, ax.YTick = -2:2; end

    case 'kararlilik_Lg_taramasi'                      % Sekil 5.12: gosterge, dB araligi 5.9 ile ayni
        for lg = findall(fg, 'Type', 'legend')', disari(lg, 5, 'north'); end
        for ax = eksenler
            if contains(etiket(ax.YLabel.String), '|L|'), ax.YLim = [-60 80]; ax.YTick = -60:20:80; end
        end

    case 'kararlilik_L_olcum_karsilastirma'            % Sekil 5.13: gosterge 2,3 A noktalarini gizliyor
        for lg = findall(fg, 'Type', 'legend')'
            lg.String = strrep(lg.String, 'ortalama Simulink modeli', 'ortalama model');
            disari(lg, 2, 'north');
        end

    case 'kararlilik_basamak_K34'                      % Sekil 5.14: gosterge egrileri ortuyor
        for lg = findall(fg, 'Type', 'legend')', disari(lg, 2, 'north'); end
end
drawnow;
end

%% yerel islevler
function disari(lg, ncol, kutu)
% Gostergeyi cizim alaninin disina, yatay dizilimle alir. kutu = 'north'/'south' ve
% gosterge bir tiledlayout icindeyse butun yerlesimin ustune/altina; aksi hâlde kendi
% ekseninin ustune (northoutside).
lg.NumColumns = ncol;
if ~isempty(kutu) && isa(lg.Parent, 'matlab.graphics.layout.TiledChartLayout')
    try
        lg.Layout.Tile = kutu;
        return
    catch
    end
end
if strcmp(kutu, 'south'), lg.Location = 'southoutside'; else, lg.Location = 'northoutside'; end
end

function pay_birak(ax)
% Eksen sinirlarini verinin %12 (y) ve %5 (x) disina acar; isaretciler cerceveye kesilmez.
x = []; y = [];
for ln = findall(ax, 'Type', 'line')'
    x = [x; ln.XData(:)]; y = [y; ln.YData(:)]; %#ok<AGROW>
end
x = x(isfinite(x)); y = y(isfinite(y));
if isempty(y), return, end
ry = max(y) - min(y); if ry == 0, ry = max(abs(y(1)), 1); end
rx = max(x) - min(x); if rx == 0, rx = max(abs(x(1)), 1); end
ax.YTickMode = 'auto';
ax.YLim = [min(y) - 0.12*ry, max(y) + 0.12*ry];
ax.XLim = [min(x) - 0.05*rx, max(x) + 0.05*rx];
end

function s = buyuk_harf(s)
% Eksen adi kucuk harfli bir sozcukle basliyorsa ilk harfi buyutur ("görev oranı" ->
% "Görev oranı"). Simgeyle baslayan adlara (t, i_{L1}, k_1, \eta) dokunmaz.
if ~ischar(s) || numel(s) < 2, return, end
if isletter(s(1)) && isletter(s(2)) && s(1) ~= upper(s(1))
    if s(1) == 'i', s(1) = char(304);              % i -> İ
    elseif s(1) == char(305), s(1) = 'I';          % ı -> I
    else, s(1) = upper(s(1));
    end
end
end

function s = mikro(s)
% TeX yorumlayicisinda \mu italik basilir; dik mikro isareti (U+00B5) kullanilir.
s = strrep(s, '\mu', char(181));
end

function s = etiket(s)
if iscell(s), s = strjoin(s, ' '); end
s = char(s);
end
