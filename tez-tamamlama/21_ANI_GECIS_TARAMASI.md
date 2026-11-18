# Ani konu geçişi taraması (18.11.2026)

Ümit'in 18.11.2026 notu: "Sayfa 21'de bir anda ters akım problemine damdan düşer gibi bir giriş var."
Bu not üzerine bütün bölümler aynı türden geçişler için tarandı. Sayfa numaraları 18.11.2026
derlemesinin (209 sayfa) basılı numaralarıdır, satırlar `yeni_tez/bolumler/` dosyalarındandır.
Metne henüz dokunulmadı.

Tür: **T** = paragraf/blok yanlış bölümde, taşınmalı; **K** = yerinde kalabilir, köprü cümlesi yeter;
**Ö** = kavram/simge tanımından önce kullanılıyor.

## Öncelik 1: yapısal (paragraf ya da blok başka yere ait)

| # | Sayfa | Yer | Başlangıç | Sorun | Öneri |
|---|---|---|---|---|---|
| 1 | 21 | 02:259–303 | "Ters akım problemi, senkron alçaltıcı…" | 2.3 FV profili, verim ve THD anlatırken ters akım köprüsüz giriyor; 2.3 zaten 255'te kapanıyor; 2.giriş (satır 4) bu konuyu saymıyor | Blok + Şekil 2.7, 2.2 sonuna (155'ten sonra; 155 "nötr kolun ters akım oluşturma mekanizması" diye bitiyor) ya da 2.2–2.3 arasında ayrı bölüm ("Hafif Yükte Ters Akım ve Süreksiz İletim") **T** |
| 2 | 31 | 03:45–65 | "Sistemin üç fazlı güç devresi…" | 3.2 tek faz kolunu anlatırken üç fazlı Proteus şeması, BYS, röleler giriyor; metin 67'de faz koluna dönüyor | 45–47 + Şekil 3.2–3.3'ü 3.1'e, 20'deki inceleme sınırı paragrafının ardına **T** |
| 3 | 60 | 04:132–168 | "Kapalı çevrim akım denetiminde denetleyici…" | Açık çevrim kapı mantığı bölümünde kapalı çevrim denetleyici; $K_{1x},K_{3x}$ ve S4 henüz tanımsız; alt bölüm kendisi "deney sonuçlarının açıklaması değildir" diyor | Bölüm 5 "Senaryo 4" altına taşı ya da başa köprü **T** |
| 4 | 115–116 | 06:353–393 | "Deney düzeneğindeki güç, ölçüm ve veri…" | 6.9 sonuç cümlesinden sonra ölçüm zinciri şeması, cihaz tablosu, belirsizlik geliyor | Şema + cihaz tablosu + belirsizlik 6.4 sonuna; 6.9'da yalnız sonuç **T** |
| 5 | 115 | 06:331 | "Üç yöntemin deneyde ve kalibre edilmiş benzetimde…" | Kalibre benzetim 6.9'da kullanılıyor, kalibrasyon 6.10'da anlatılıyor | 6.10'u 6.9'un önüne al ya da 331'e geri/ileri köprü **T/Ö** |
| 6 | 131 | 07:136–220 | 7.3 "Şarj Yönündeki Benzetim Kayıtları" | 7.2 "durum makinesiyle yönetilmelidir" diye bitiyor, araya benzetim giriyor, 7.4 yine 7.2'ye dönüyor | 7.3'ü 7.5'ten sonra / 7.7'nin önüne **T** |
| 7 | 147 | 08:82–86 | "Üç katkı birlikte…" / "…üç ulusal patent…" | Sentez paragrafı GT-tipi alt başlığında; patent bölümü köprüsüz, patentler gövdede ilk kez | 82'yi 8.2 sonuna; 107'nin ilk cümlesini 86'nın başına **T/K** |
| 8 | 40 | 03:336 | "Laboratuvar deneyleri (S1–S3) açık çevrim…" | 3.5 senaryo ayrıntısıyla açılıyor; S1–S4'ün Bölüm 3'teki tanımı 547'de | 547'deki senaryo tanımını 3.5 başına + yön cümlesi **T/Ö** |
| 9 | 47 | 03:540 | "LCL filtrenin şebeke tarafı endüktansı ayrı bir filtre bobini değildir." | 3.4'te $L_2$ gerçek bobin gibi okunuyor, gerçeği 3.6.1'de sürpriz olarak geliyor | 3.6.1'i 3.4 sonuna ya da 3.4'e tek cümlelik ileri atıf **T/K** |

## Öncelik 2: köprü cümlesi ya da kısa taşıma yeter

| # | Sayfa | Yer | Başlangıç | Sorun | Öneri |
|---|---|---|---|---|---|
| 10 | 25 | 02:323 | "Literatürdeki doktora tezleri, tezin yapısı için de…" | 2.5 ne yaptığını söylemeden açılıyor | 325'i ilk paragraf yap, 323'ü tablodan sonraya **T** |
| 11 | 23 | 02:313–317 | "Tezin Sin3 katkısına en yakın literatür…" | Sin³ kıyaslanıyor, tanımı iki paragraf sonra | 317'yi 313'ün önüne al **T** |
| 12 | 23 | 02:311 | "Anahtar ölü zamanı, snubber…" | Kararlılık/faz marjı paragrafından sonra ölü zaman; konu 2.3'te (257) açılmıştı | 257'nin arkasına taşı ya da köprü **T/K** |
| 13 | 13 | 02:136 | "Yeniden yapılandırılabilir sistemlerin esneklik kazancı…" | Konu iki paragraf ve bir tablo önce bırakılmıştı (113) | 113'teki yeniden yapılandırma cümlelerini 136'nın başına **T** |
| 14 | 11 | 02:52, 76 | "Ortak eleman kullanımının…" / "Batarya paketinin kullanılabilir ömrünü…" | Maliyet anlatısı bölünüyor; BYS'ye köprüsüz geçiş | Sıra 50 → maliyet tablosu → 74 → 52; 76'ya köprü **T/K** |
| 15 | 4, 11 | 01:21, 02:52 | "Vienna PFC", "GT-tipi" | İlk iki bölümde açıklamasız; açıklama Bölüm 7'de | Giriş 21 ve 2.2 sonuna birer tanım cümlesi **Ö** |
| 16 | 6 | 01:50 | "Üç katkıyı ortak bir doğrulama altyapısı…" | Katkılar başlığında doğrulama yöntemi; 1.4'te aynı konu yeniden | 1.4'e, 57'nin sonuna **T** |
| 17 | 37 | 03:191, 234 | "Pozitif ve negatif yarım periyotlar ayrı…" | 3.3 neden kurulduğunu söylemiyor; "susturmalı" açıklamasız | 191'e köprü, 234'ten önce tek cümlelik susturma tanımı **K/Ö** |
| 18 | 39 | 03:240 | "Benzetim modelinde güç, RMS ve THD ölçümleri…" | LCL modelinde ölçüm noktası, C noktası, EMC süzgeci, S4 | İki cümleyi 3.7'ye (570) **T** |
| 19 | 35 | 03:79 | "Benzetim modelinde ölü zaman $t_d$…" | İdeal görev oranından benzetim gerçeklemesine sıçrama | 3.5.1'e (428) taşı, 79'da atıf **T** |
| 20 | 49 | 03:592 | "Verim hesabında DA giriş gücü…" | THD'den sonra verime geri dönüş; 594 tek başına cümle | 583'ün ardına **T** |
| 21 | 53 | 03:648 | "Benzetimde $L_1$ doğrusal endüktans…" | "Dört etki" listesi bittikten sonra köprüsüz yeni konu | Köprü cümlesi **K** |
| 22 | 56 | 04:28 | "Benzetim ve deney, prototipin tek faz kolunu…" | Klasik yöntem anlatımını kapsam paragrafı bölüyor | Bölüm girişine ya da 172'ye **T** |
| 23 | 58 | 04:73, 75 | "…akım eşiği ve histerezisle…" / "Alternans ortasında … çökmenin nedeni" | Genişletme sabit maske anlatımına karışmış; çökme gösterilmeden anılıyor | Genişletmeyi 168'e; çökmeye ileri atıf **T/Ö** |
| 24 | 63 | 04:172, 80 | "Deney senaryoları aynı düşük güç…" | S1–S3 bölümde 80'den beri kullanılıyor, tanımı 172'de | Senaryo eşlemesini bölüm girişine **Ö** |
| 25 | 63 | 04:183 | "Üçüncü bulgu, susturmanın köprü davranışını…" | "Ara seviye" açıklaması sonraki paragrafta; şekil sırası metinle ters | Tanımı öne al, iki şekli yer değiştir **Ö** |
| 26 | 66 | 05:8 | 5.1 Sin³ matematiksel tanımı | Çare, sorunun mekanizmasından önce geliyor | Mekanizma bölümünü öne al ya da 8'e köprü **T/K** |
| 27 | 69 | 05:57–64 | "Mekanizma, S2 çalışma noktasında…" | Şekil, henüz kurulmamış parçalı modele ve %39,96'ya dayanıyor | Paragraf + şekli 108'den sonraya **T** |
| 28 | 72 | 05:137 | "İkincisi, uygun $(k_1,k_3)$ çifti…" | Karşılaştırma çiftlerinin kaynağı söylenmiyor | Kaynağı bir cümleyle belirt (tez sahibinin bilgisi gerekir) **Ö** |
| 29 | 73 | 05:160–200 | "İleri besleme yolunun fiziksel işlevi…" | Katsayı taramasından genel ileri besleme fiziğine sıçrama; "Önerilen yapı" analizden sonra | Bölümü 5.1'in arkasına, 162'ye bağlayıcı **T/K** |
| 30 | 82 | 05:357 | "Gerçekleme (A), S4 modelindeki…" | (A) etiketi, gerçeklemeler sayılmadan | Alt bölümü (A)/(B)/(B2) sayan cümleyle aç **K** |
| 31 | 109 | 06:229 | "Osiloskop kanal adlarında…" | Haberleşme yazılımı paragrafının ortasında osiloskop ve S1–S3/S4 | 6.6'ya (253) **T** |
| 32 | 109 | 06:238 | "Ortak hedef çalışma koşulu olarak…" | Deney koşulları yazılım başlığı altında | 6.6 başına ya da "Deney Koşulları" ara başlığı **T** |
| 33 | 119 | 06:517 | "Analizörün güç faktörü göstergesi…" | Güç faktörü tartışılmadan savunur gibi giriyor | Sil ya da sorunu öne koyan cümle **K** |
| 34 | 128 | 07:60 | "Şekil 7.3, $Q_1$–$Q_2$ ile…" | GT-tipi'nin kendi topolojisi, iki genel şemadan sonra | Şekil 7.3'ü Tablo 7.1'in ardına **T** |
| 35 | 129 | 07:69 | "…RL1 ve RL2'nin evirici konumunda…" | RL2'nin görevi hiçbir yerde söylenmiyor | 60'a yan cümle **Ö** |
| 36 | 139 | 07:402 | "Şarj ve deşarj yönündeki dönüştürme verimleri ayrı ölçülürse…" | Doğrulama matrisinden sonra yeni büyüklük tanımı | 7.6'ya (376'dan sonra) **T** |

## Hafif notlar

- 02:159 PVGIS cümlesi: dizilerin PVGIS'ten mi türetildiği söylenmiyor.
- 03:22 model katmanları tablosu (4 katman) ile 20'deki üç katman arasında bağ yok.
- 03:633 ve 03:642 aynı açıklamayı tekrarlıyor.
- 04:15 tamamlayıcı sürme, klasik yöntem anlatılmadan mekanizma bölümünde.
- 04:22 son cümle (kayıp farkı yöntem notu) 177'ye ait.
- 05:475 "Köprünün etkin küçük işaret kazancı…" başlıksız yeni konu.
- 05:512 "Sin³'ün üçüncü harmonik bulgusu." kararlılık altında; S4 taramasına (293) ait.
- 06:47–58 donanım tablolarındaki şarj rölesi/diyotu/lambası için GT-tipi yan cümlesi.
