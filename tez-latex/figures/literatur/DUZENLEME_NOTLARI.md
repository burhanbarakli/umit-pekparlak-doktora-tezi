# Bölüm 2 görsel düzenleme notları

Klasörde `gecici_` öneki taşıyan dosyalar, tez akışını ve sayfa yerleşimini görmek için hazırlanmış çalışma görselleridir. Nihai teslimden önce aynı dosya adları korunarak vektörel veya en az 300 dpi yeni sürümlerle değiştirilmelidir.

## Geçici köken etiketleri

- Sarı zeminli `ÖNCEKİ TEZ`: Eski tez dosyasından taşınan veya eski tez şekillerinin birleştirilmesiyle oluşturulan çalışma görseli.
- Kırmızı `DIŞ KAYNAK`: Makale/PDF'den doğrudan alınan görsel veya dış kaynakların karşılaştırmalı sentezi olan tablo.
- Etiketsiz şekil/tablo: Yeni tez için yazar tarafından özgün olarak üretilecek içerik.
- Etiketler yalnızca çalışma aşaması içindir. Nihai teslimde `config/tez-preamble.tex` içindeki `\eskitezetiketi` ve `\diskaynaketiketi` tanımları boşaltılarak topluca kaldırılabilir.

## Teze yerleştirilen görseller

### `gecici_eds_mimarisi_eski_tez.png`

- Eski tezdeki Şekil 1.1 temel alınmıştır.
- Yeniden çizimde `DC Bara` yerine `DA Bara`, `AC/DC` yerine `AA/DA` yazılmalıdır.
- Güç akışı kalın ve kesintisiz; ölçüm/kontrol akışı ince ve kesikli çizilmelidir.
- `EMS/BMS` kutusu `EYS/BYS` olarak Türkçeleştirilmelidir.
- Şarj ve deşarj yönünü göstermek için güç hattında çift yönlü ok kullanılmalıdır.
- Önerilen çıktı: Inkscape, diagrams.net veya TikZ ile hazırlanmış PDF/SVG.

### `gecici_dengeleme_yontemleri_bilesik.png`

- Eski tezdeki Şekil 1.6--1.9 tek bir 2x2 görselde birleştirilmiştir.
- Dört panel aynı batarya sembolü, anahtar çizgi kalınlığı ve yazı karakteriyle yeniden çizilmelidir.
- Panel başlıkları `Pasif`, `Kapasitif`, `Endüktif` ve `Transformatörlü` olarak korunmalıdır.
- Her panelde enerji aktarım yönünü gösteren bir ok eklenmelidir.
- Şema ayrıntısı okunabilirliği bozarsa yalnızca üç veya dört hücre gösterilmelidir.
- Kaynak dayanağı: Daowd ve arkadaşları ile Khan ve arkadaşları.

### `gecici_t_tipi_faz_kolu_eski_tez.jpg`

- Eski tezin Bölüm 3 çiziminden alınmıştır.
- Yeniden çizimde anahtarlar `S_1`, `S_2`, `S_3`, `S_4`; DA bara kondansatörleri `C_A`, `C_B`; filtre elemanları `L_1`, `L_2`, `C_f` olarak etiketlenmelidir.
- `+V_dc/2`, `0` ve `-V_dc/2` gerilim seviyeleri şeklin yanında gösterilmelidir.
- Nötr kol farklı bir renk veya kesikli çerçeveyle vurgulanmalıdır.
- Literatür bölümünde yalnızca temel topoloji gösterilmeli; renkli akım yolları Bölüm 3 ve 4'e bırakılmalıdır.

### `gecici_de_ccm_akim_chen34.png`

- Chen ve arkadaşlarının kaynak PDF'indeki Şekil 2 geçici olarak kesilmiştir.
- Nihai çizimde İngilizce `DE Operation` ve `CCM Operation` ifadeleri sırasıyla `Diyot Benzetimi` ve `Sürekli İletim` olarak değiştirilmelidir.
- Yatay eksen `t`, düşey eksen `i_L` olarak açıkça yazılmalıdır.
- Sıfır akım çizgisi kalınlaştırılmalı; CCM'deki negatif akım bölgesi açık renkli taramayla gösterilmelidir.
- DE ve CCM dalga şekilleri aynı ölçek ve aynı anahtarlama periyoduyla çizilmelidir.
- Kaynak atfı korunmalı; doğrudan kopya yerine `Chen ve arkadaşlarından uyarlanmıştır` ifadesi kullanılmalıdır.

## Bölüm 2'ye alınmayan eski şekil ve tablolar

- Eski Şekil 1.2 ve 1.3: Batarya ömrü ve güvenli çalışma bölgesi yeni literatür akışının dışında kaldığı için çıkarıldı.
- Eski Şekil 1.4: Maliyet tablosunu tekrar ettiği için çıkarıldı.
- Eski Şekil 1.5: Genel BYS yapısı EDS mimarisiyle tekrar ediyor; GT-tipi işlev karşılaştırması hazırlanırken Bölüm 7'de yeniden değerlendirilecek.
- Eski Şekil 1.10: Temsili ömür eğrisinin hesaplama yöntemi izlenebilir olmadığı için çıkarıldı.
- Eski Tablo 1.1: Yüzde aralıklarının NREL ve Lazard raporlarından doğrudan izlenebilirliği yeterli olmadığı için aktarılmadı.
- Eski Tablo 1.2: `yüksek/çok yüksek` sınıfları nicel ölçüte dayanmadığından aktarılmadı; yerine kaynaklı açıklama ve birleşik dengeleme şekli kullanıldı.
- Eski Tablo 1.3: Geleneksel BYS ile hücre bazlı yönetim karşılaştırması GT-tipi mimarinin sunulduğu Bölüm 7'ye bırakıldı.

## Sonraki bölümlere ayrılan görseller

- `gecici_lcl_ileri_besleme_lu41.png`: Kaynak PDF'den kesilen LCL ve ileri besleme şemasıdır. Tez sistemiyle birebir aynı olmadığı için Bölüm 2'ye eklenmedi. Bölüm 5'te geri besleme denetleyicisi ile Sin³ ileri besleme kolunu açıkça ayıran özgün blok diyagram hazırlanırken referans olarak kullanılacaktır.
- `gecici_t_tipi_topoloji_wang31.png`: Wang ve arkadaşlarının üç fazlı T-tipi evirici şeklidir. Bölüm 2'de daha sade tek faz kolu tercih edildiği için kullanılmadı; Bölüm 3'te genel üç fazlı sistem çizilirken yardımcı referans olarak tutuldu.

## Ortak çizim standardı

- Yazı tipi: Times New Roman veya tez metniyle uyumlu eşdeğer serif yazı tipi.
- Nihai baskıdaki en küçük yazı: en az 9 punto.
- Çizgi kalınlığı: ana güç yolu 1,2--1,5 punto; kontrol yolu 0,8--1 punto.
- Renk kullanımı: siyah/gri temel çizim; yalnızca güç, kontrol ve önerilen yol ayrımı için sınırlı renk.
- Arka plan: beyaz ve saydamlık kullanılmadan.
- Terimler: DA, AA, EDS, BYS, EYS ve LCL biçiminde tutarlı Türkçe kısaltmalar.
- Çıktı tercihi: PDF veya SVG; raster zorunluysa en az 300 dpi PNG.
