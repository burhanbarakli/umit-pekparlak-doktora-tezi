# Tez LaTeX çalışma alanı

## Nerede yazılacak?

Her bölüm `chapters` klasöründeki ayrı `.tex` dosyasına yazılacak. İlk çalışma dosyamız:

`chapters/01-giris.tex`

Codex'in verdiği metni ilgili başlığın altına yapıştırabilirsiniz. `main.tex` yalnızca bölümleri birleştirir; normal yazım sırasında bu dosyayı sık değiştirmeyeceğiz.

Tez başlığı, öğrenci numarası, anabilim dalı, program/bilim dalı, danışman ve tarihler yalnızca aşağıdaki dosyada tutulur:

`config/tez-metadata.tex`

## Derleme

Proje klasöründe `build.cmd` dosyasını çalıştırın. PDF şurada oluşur:

`build/main.pdf`

## Çalışma kuralı

- Eski Word tezi kaynak ve kanıt deposudur; yeni ana metin LaTeX'te tutulur.
- Bir bölüm tamamlanmadan şekil ve tablo numaraları elle yazılmaz; `\label` ve `\ref` kullanılır.
- Kaynaklar elle numaralandırılmaz; atıf standardı kesinleştirildikten sonra `references/references.bib` kullanılır.
- Biçim; 04.08.2022 tarih ve 621-9 sayılı Senato kararı eki SAÜ FBE tez yazım kılavuzu, Word tez şablonu ve teslim kontrol formuna göre ayarlanmıştır.
- Tez A4, çift taraflı, iç kenarı 4 cm; dış, üst ve alt kenarları 2,5 cm'dir.
- Metin Times New Roman 12 punto, 1,5 satır; paragraflar önce/sonra 6 nk ve iki yana yaslıdır.
- Bölümler tek numaralı sağ sayfada başlar ve bölümün ilk sayfasında sayfa numarası gösterilmez.
- Resmî şablon ile kontrol formunda sayfa numarası alt mesafesi 1,25 cm olduğu için bu değer kullanılmıştır.
- Kaynakça sistemi APA 7 veya Chicago 17 olarak danışmanla kesinleştirilecektir.
