% S4 kapali cevrim sekillerini (KC_*) tez icin vektor PDF'e aktarir (IP-8).
% Kaynak: runs/2026-10-28_s4_kapali_cevrim/sekiller/*_KC.fig
% Hedef : tez-latex-v2/figures/s4/
% .fig dosyalarinda Turkce karakterler kayip (U+FFFD) kaydedilmis; metinler
% burada yeniden yazilir. Basamak basligindaki "asim 7.3 %" K-21 ile gecersiz
% (son kararli zarfa gore asim %0,2), baslik sadelestirilir.
root_dir = fileparts(fileparts(mfilename('fullpath')));
src = fullfile(root_dir, 'runs', '2026-10-28_s4_kapali_cevrim', 'sekiller');
dst = fullfile(fileparts(root_dir), 'tez-latex-v2', 'figures', 's4');
if ~exist(dst, 'dir'), mkdir(dst); end
bozuk = char(65533);
duzelt = { ['ak' bozuk 'm'], 'akım'; ['hatas' bozuk], 'hatası'; ['anl' bozuk 'k'], 'anlık'; ...
           ['ortalamas' bozuk], 'ortalaması'; ['noktas' bozuk], 'noktası'; ...
           ['mod' bozuk 'lasyon'], 'modülasyon'; ['faz +0.24' bozuk], 'faz +0.24°'; ...
           ['faz -4.04' bozuk], 'faz -4.04°'; ['faz -2.60' bozuk], 'faz -2.60°'; ...
           ' (Display)', '\eta (Display)'};
names = {'s4_akim_izleme_25A_KC', 's4_basamak_PI_10_25A_KC', 's4_tarama_ozet_KC'};
for k = 1:numel(names)
    f = openfig(fullfile(src, [names{k} '.fig']), 'invisible');
    nesne = [findall(f, 'Type', 'text'); findall(f, 'Type', 'legend')];
    for j = 1:numel(nesne)
        s = nesne(j).String;
        tek = ~iscell(s); if tek, s = {s}; end
        for m = 1:numel(s)
            if startsWith(s{m}, 'PI, 10 \rightarrow 25 A basamak')
                s{m} = 'PI, 10 \rightarrow 25 A basamak (t = 55 ms)';
            end
            for r = 1:size(duzelt, 1), s{m} = strrep(s{m}, duzelt{r, 1}, duzelt{r, 2}); end
            if contains(s{m}, bozuk), warning('kalan bozuk karakter: %s', s{m}); end
        end
        if tek, s = s{1}; end
        nesne(j).String = s;
    end
    set(findall(f, '-property', 'FontName'), 'FontName', 'Arial');
    exportgraphics(f, fullfile(dst, [names{k} '.pdf']), 'ContentType', 'vector');
    fprintf('%s ok, size %s\n', names{k}, mat2str(f.Position));
    close(f);
end
