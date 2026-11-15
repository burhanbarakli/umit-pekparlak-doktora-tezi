# yeni_tez: SAÜ FBE şablonuyla tez

Kuruluş: 15 Kasım 2026. Tezin güncel metni (`tez-latex-v2`, 586ae82) SAÜ FBE LaTeX
şablonuna taşındı:
[burhanbarakli/sau-fbe-doktora-latex-sablonu](https://github.com/burhanbarakli/sau-fbe-doktora-latex-sablonu)
(kullanılan sürüm `SABLON_SURUMU.txt`). Ana metin artık burada ilerler; `tez-latex-v2`
15.11.2026 hâlinde kalır.

## Derleme

Şablon yalnız **LuaLaTeX** ile derlenir (Tectonic/XeLaTeX kullanılamaz). MiKTeX
`%LOCALAPPDATA%\Programs\MiKTeX` altında kuruludur; betik yolu kendisi ekler.

```bat
cd yeni_tez
.\derle.cmd          :: tez.pdf       (teslim sürümü)
.\derle.cmd notlu    :: tez_notlu.pdf (ÜMİT ABİ İÇİN NOT kutuları açık)
```

Süre yaklaşık 1 dakika, yaklaşık 231 sayfa. Betik sonunda `Output written` satırını,
`!` hatalarını ve `undefined` uyarılarını basar; son ikisi boş dönmelidir.

## Dosyalar

| Dosya | İçerik |
|---|---|
| `tez.tex` | Tez bilgileri (başlıklar, yazar, öğrenci no, danışman, jüri, tarihler) ve bölüm sırası |
| `sauthesis.cls`, `sauwordline.lua` | Şablondan **aynen** alındı; değiştirilmez. Şablon güncellenirse yalnız bu ikisi değişir. |
| `tezpaketleri.sty` | Tezin ek paketleri (siunitx, booktabs, tabularx, subcaption, TikZ, natbib), `\umitnot`, `\eksikistek` ve şablonun notsuz çıktıdaki küçük aksaklıklarının düzeltmeleri (kapaklarda "(Varsa)", onay sayfası jüri yuvaları, beyanname, kaynakça biçimi) |
| `onkisim/` | Teşekkür, kısaltmalar, simgeler, özet, summary |
| `bolumler/` | Bölüm 1–8, kaynaklar, ekler, özgeçmiş |
| `sekiller/t_tipi_vektor_cizimler.tex` | T-tipi TikZ çizim tabanı (Bölüm 3) |
| `references.bib` | Kaynakça veritabanı (unsrtnat, numaralı) |

Şekiller çoğaltılmaz: `\graphicspath` önce `../tez-latex-v2/figures/`, sonra
`../tez-latex/figures/` deposunu okur; MATLAB sonuçları `../tez-matlab-simulink/...`
göreli yoluyla gelir. Klasör proje köküyle birlikte taşınmalıdır.

## tez-latex-v2'den farklar (K-33)

- Biçim şablondan gelir: Word satır modeli (heceleme yok), başlık aralıkları, sayfa
  numarası alttan 1,5 cm, kapaklar, onay sayfası yuvaları, İçindekiler/listeler.
- Şekil ve tablolar şablondaki gibi metin içinde (`[H]`). Tam sayfa döndürülmüş üç şekil
  (3.2, 3.3, 4.4) şablonun yatay sayfasında; sayfa numarası okuma yönünde.
- Ekler şablon biçiminde: "EK A. …", Şekil A.1; metinde "EK-A" yerine "EK A".
- Beyanname şablonun resmî metniyle; etik kurul onayı gerektirmeyen çalışma olduğu
  için "etik kurul onay belgesi aldığımı" cümlesi çıkarıldı.
- Onay sayfası: danışman yuvası dolu, öteki yuvalar gri yer tutucu (K-31). Jüri belli
  olunca `tez.tex` içinde `\juribaskani{…}{…}`, `\juriuyesiA/B/C{…}{…}` doldurulur.
- Özgeçmiş şablon başlıklarıyla: patentler "Tezden türetilen yayınlar", makaleler
  "Diğer eserler". Mezuniyet yılları ve mesleki deneyim belgelenmediği için yok.

## Açık noktalar

- Tez başlığı kapakta 4 satıra yayılıyor; şablon notu "üç satıra sığdırınız" diyor.
  Başlık değiştirilmedi.
- `\kapaktarihi{EKİM 2026}` ve `\savunmatarihi` güncellenecek; jüri başkanı ve
  üniversiteler bekleniyor.
