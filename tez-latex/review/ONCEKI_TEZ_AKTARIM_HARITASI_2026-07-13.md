# Önceki tezden yeni LaTeX tezine aktarım haritası

Temel kural: Önceki tezdeki bilimsel bilgi korunacak; tekrarlar birleştirilecek, kaynağı veya hesabı doğrulanamayan öğeler kanıt olarak kullanılmayacak ve jüri talepleri doğrultusunda yeniden üretilecek.

Tam tekil envanter: `ONCEKI_TEZ_SEKIL_TABLO_TAKIP_LISTESI_2026-07-13.html`. Dosya, eski tezdeki 107 şekil ve 16 tablonun her biri için yeni hedef bölümü, aktarım durumunu ve kabul ölçütünü ayrı satırda gösterir. Mevcut belge ise birleştirilmiş karar özetidir.

## Eski Bölüm 1

| Eski öğe | Yeni konum/durum | Karar |
|---|---|---|
| Şekil 1.1 EDS bileşenleri | Bölüm 2, `fig:eds-mimarisi` | Aktarıldı; sarı etiket |
| Tablo 1.1 EDS maliyet dağılımı | Bölüm 2, `tab:eds-maliyet-dagilimi` | Aktarıldı; dış kaynak ve aralıkların toplanmaması notu eklendi |
| Şekil 1.2 DoD--çevrim ömrü | Bölüm 2, `fig:batarya-omur-guvenlik` | Şekil 1.3 ile birleştirildi; temsilî eğri sınırı yazıldı |
| Şekil 1.3 güvenli çalışma bölgesi | Bölüm 2, `fig:batarya-omur-guvenlik` | Aktarıldı; belirli hücre veri sayfası olmadığı belirtildi |
| Şekil 1.4 maliyet payı grafiği | Ana metne ayrıca alınmadı | Tablo 1.1 ile aynı bilgiyi tekrarladığı için tabloyla temsil edildi |
| Şekil 1.5 BYS mimarisi | Bölüm 2, `fig:bys-mimarisi` | Aktarıldı |
| Şekil 1.6--1.9 dengeleme yapıları | Bölüm 2, `fig:dengeleme-yontemleri` | Tek karşılaştırmalı şekilde birleştirildi |
| Tablo 1.2 dengeleme karşılaştırması | Bölüm 2, `tab:dengeleme-karsilastirma` | Bağlamsız "verim/güç" sınıfları bilimsel olarak daha izlenebilir başlıklarla düzeltildi |
| Tablo 1.3 BYS karşılaştırması | Bölüm 2, `tab:bys-islev-karsilastirma` | Aktarıldı ve "doğrudan ömür optimizasyonu" sınırlandırıldı |
| Şekil 1.10 göreli ömür senaryosu | Beklemede | Hesap denklemi ve yaşlanma modeli bulunmadan ana metne alınmayacak; model bulunursa MATLAB'da yeniden üretilecek |

## Eski Bölüm 2

| Eski öğe | Yeni konum/durum | Karar |
|---|---|---|
| Şekil 2.1--2.2 ve 2.4--2.5 FV/güç profilleri | Bölüm 2, `fig:fv-calisma-profilleri` | MATLAB'da vektörel olarak yeniden üretildi; PVGIS sorgu metadatası olmadığı için temsilî olarak adlandırıldı |
| Şekil 2.3 yıl--saat üretim/ışınım yüzeyi | Bölüm 2, `fig:fv-yil-saat-yuzeyi` | Önceki tez görseli sarı etiketle doğrudan aktarıldı; günlük ve aylık dizilerin çarpım bağı metinde yeniden kuruldu. Ham diziler doğrulandığında vektörel üretilecek |
| Tablo 2.1 güç dağılımı | Bölüm 2, `tab:fv-guc-dagilimi` | Eski tablo eski Şekil 2.4 ile uyuşmadı; 144 nokta sayımından yeniden hesaplandı |
| Tablo 2.2 ve 2.3 EU/CEC katsayıları | Bölüm 2, `tab:agirlikli-verim-katsayilari` | Denklemlerle birlikte tek tabloda birleştirildi |
| Şekil 2.6--2.7 verim profili | Bölüm 2, `fig:fv-verim-thd-profilleri` | MATLAB'da yeniden üretildi; yeni deney sonucu olmadığı açıklandı |
| Şekil 2.8 Chicco güç--THD kaydı | Bölüm 2, `fig:chicco-guc-thd` | Dış kaynak olarak kırmızı etiketle aktarıldı |
| Şekil 2.9--2.10 THD profili | Bölüm 2, `fig:fv-verim-thd-profilleri` | Tek bileşik şekilde korundu; ikincil hesap olduğu belirtildi |
| Tablo 2.4 ticari evirici kaydı | Bölüm 2, `tab:ticari-evirici-thd` ve `fig:ticari-evirici-thd` | Sayılar korundu; cihaz/ölçüm protokolü ve ham dosya beklediği yazıldı |

Bölüm 2 şekillerinin tamamı metin içi açık referans bakımından denetlenmiştir. Her görsel için bölümde kullanılma amacı, gösterdiği temel sonuç ve kanıt sınırlılığı çevre metinde belirtilmiştir.

## Eski Bölüm 3

| Eski öğe | Yeni konum/durum | Karar |
|---|---|---|
| Şekil 3.1 T-tipi faz kolu | Bölüm 2, `fig:t-tipi-faz-kolu`; Bölüm 3'te açık çapraz başvuru | Aktarıldı; aynı şema Bölüm 3'te tekrar basılmadı |
| Şekil 3.2--3.4 pozitif, sıfır ve negatif gerilim durumları | Bölüm 3, `fig:t-tipi-uc-seviye` | Üç eski görsel aynı devre tabanı üzerinde yeşil etkin anahtar ve mavi gerilim yolu lejandıyla vektörel yeniden çizildi |
| Şekil 3.5--3.8 pozitif/negatif alternans akım yolları | Bölüm 3, `fig:t-tipi-akim-yollari` | Üst alt çizime $C_A$--$C_B$ bara, antiparalel diyotlu IGBT'ler ve $L_1$--$C_f$--$L_2$ filtresini içeren tam faz topolojisi eklendi; dört eski akım yolu aynı sadeleştirilmiş devre tabanında kırmızı akım yönüyle korundu. Gerçek kart/uygulama şeması, donanım dosyasıyla doğrulandıktan sonra Ek A'ya alınacak |
| Şekil 3.9--3.10 senkron-buck eşdeğerleri | Bölüm 3, `fig:senkron-buck-esdeger` | İki yarım periyot aynı şekilde birleştirilip vektörel yeniden çizildi; ters akım eşiğiyle ilişkilendirildi |
| Şekil 3.11--3.12 CCM/DCM akımları | Bölüm 2, `fig:de-ccm-akim`, `fig:onceki-tez-ccm-ters-akim` ve `fig:onceki-tez-dcm-akim`; Bölüm 3'te çapraz başvuru | Genel senkron-buck kuramına ait üç görsel aynı yerde toplandı. Eski iki şema sarı etiketli çalışma kopyalarıdır; gerçek model çıktıları geldiğinde nihai tutma/eke taşıma kararı verilecek |
| Şekil 3.13--3.16 harmonik oluşumu ve denetleyici/anahtarlama açıklamaları | İşlevsel ilişki Bölüm 3, `fig:denetim-modulasyon-blok`; dalga biçimleri hedef Bölüm 4--5 | Eski kavramsal anlatım vektörel kontrol blok diyagramına dönüştürüldü; gerçek akım, hata, kontrol çıkışı ve kapı sinyalleri kesin MATLAB/Simulink modelinden üretilmeden eski raster dalga biçimleri nihai kanıt olarak kullanılmayacak |
| Eski Bölüm 3.5--3.6 ve alt dallarındaki yazılı anlatım | Bölüm 2'de genel DE/CCM temeli; Bölüm 3'te senkron-buck eşdeğeri ve ters akım eşiği; Bölüm 4'te düşük güç işletme gerekçesi, nötr kol, kayıp dağılımı ve denetleyici etkisi | Gün doğumu/gün batımı ile düşük akımlı şarj--deşarj örnekleri, pozitif/negatif yarım periyot eşdeğerleri, modülasyon indeksi--nötr durum ilişkisi, sabit iletim gerilimi düşümü, kaybın nötr kola dağılması, sıfır geçiş denetleyici düzeltmeleri ve ters akım/ZCD zinciri eksiksiz biçimde yeniden yazıldı. Eski sayısal sonuçlar ham kod/model bulunmadan kesinleştirilmedi; Mohan, Erickson, Chicco ve Chen kaynaklarıyla kuramsal dayanak güçlendirildi |
| Eski Bölüm 3 tabloları | Yok | Önceki Bölüm 3'te tablo bulunmadığı doğrulandı; yeni tezde anahtarlama, parametre ve doğrulama tabloları yöntem açıklığını artırmak için eklendi |

Mevcut Bölüm 3'teki bütün şekil ve tablolar metin içi açık başvuru bakımından denetlenmiştir. Her öğenin kullanılma amacı ve teknik kapsamı açıklanmış; `tab:dogrulama-matrisi` için eksik olan açık başvuru da eklenmiştir.

## Eski Bölüm 4

| Eski öğe | Yeni konum/durum | Karar |
|---|---|---|
| Şekil 4.1 klasik tam periyot kapı darbeleri | Bölüm 4, `fig:klasik-kapi-darbeleri-tam`, yeni Şekil 4.1 | Ayrı sarı etiketli tarihsel kayıt olarak aktarıldı |
| Şekil 4.2 klasik büyütülmüş kapı darbesi kesiti | Bölüm 4, `fig:klasik-kapi-darbeleri-yakin`, yeni Şekil 4.2 | Tam periyot kaydından farklı görsel olduğu korunarak ayrı aktarıldı |
| Şekil 4.3--4.4 faz modeli ve tam Simulink model ekranları | Bölüm 4, `fig:onceki-faz-modeli` ve `fig:onceki-simulasyon-modeli`, yeni Şekil 4.3--4.4 | İki farklı model ekranı ayrı sarı etiketli tarihsel kanıt olarak aktarıldı; kesin `.slx` gelince okunur model çıktılarıyla değiştirilecek |
| Şekil 4.5--4.9 klasik anahtarlama dalga ve FFT sonuçları | Bölüm 4, yeni Şekil 4.5--4.9 | Sonradan gelen Senaryo 1 ekranlarıyla dalga biçimi ve \%8,29/\%2,14 FFT sonuçları doğrulandı; beş şekil ayrı ayrı sarı etiketle aktarıldı, ham zaman serisi bulunmadığı için ikincil kanıt statüsü korundu |
| Şekil 4.10--4.16 nötr susturma kapı, akım, dört kanal ve FFT kayıtları | Bölüm 4, yeni Şekil 4.10--4.16 | Yedi farklı görsel bire bir ve ayrı sarı etiketlerle aktarıldı; ham model/zaman serisi gelirse aynı analiz penceresiyle yeniden üretilecek |
| Tablo 4.4 üç yöntem karşılaştırması | Bölüm 4, `tab:onceki-benzetim-ozeti` | Aktarıldı; verim hesabının ham model beklediği belirtildi |
| Şekil 4.17--4.24 kontrol blokları ve iki buck açıklaması | Bölüm 3--5 | Eski Şekil 4.18--4.22 yeni Şekil 5.5--5.9 olarak ayrı ve sarı etiketli biçimde Bölüm 5'e aktarıldı. Eski Şekil 4.17 ve 4.23 güncel işlevsel denetim bloğunda, eski Şekil 4.24 ise vektörel iki-buck eşdeğerinde temsil ediliyor; gerçek kod/model doğrulaması bekliyor. |
| Şekil 4.25--4.32 ve Tablo 4.1--4.3 Sin³ taramaları | Bölüm 5, yeni Şekil 5.1--5.4 ve 5.11--5.14; yeni Tablo 5.1 | Eski Şekil 4.25--4.32 tarihsel kanıt olarak sarı etiketle aktarıldı. Eski Tablo 4.1--4.2 eksiksiz biçimde yeni Tablo 5.1'de birleştirildi; eski Tablo 4.3, metin ile şekil arasındaki optimum katsayı çelişkisi açıkça belirtilerek özetlendi. Gerçek kod/model geldiğinde tarihsel kopyalar MATLAB çıktılarıyla değiştirilecek. |

Eski Bölüm 4'teki yazı içeriği de yalnızca şekiller üzerinden değil, kavram düzeyinde yeniden denetlenmiştir:

| Eski metin/kavram | Yeni tezdeki konum | Aktarım kararı |
|---|---|---|
| IGBT nötr kol ile MOSFET tabanlı senkron buck arasındaki iletim kaybı farkı | Bölüm 4, ters akım mekanizması | Eklendi; kesin kayıp iddiası gerçek parça kodu ve kayıp modeliyle sınırlandırıldı |
| Üç fazlı dört telli yapının faz başına tek fazlı kol olarak incelenmesi ve SPWM kullanımı | Bölüm 4, klasik anahtarlama | Eklendi; başka PWM tekniklerine genellemenin ayrı doğrulama gerektirdiği belirtildi |
| Pozitif alternansta $Q_4$, negatif alternansta $Q_3$ susturma kuralı | Bölüm 4, yeni Şekil 4.2 sonrası | Eski tezde bildirilen kapı eşlemesi açıklandı; gerçek PWM kodu gelene kadar işlevsel/geçici kabul edildi |
| Eski modelin 25 kW, yaklaşık 2,6 A RMS, denetleyicisiz ve ileri besleme katsayısıyla ayarlanan koşulu; EMC filtre/varyak ekleri | Bölüm 4, verim--THD kanıt sınırı | Eklendi; 20 kW/25 kW/20 kVA çelişkisi ve ham model eksikliği açık tutuldu |
| Nötr susturma sonrası iki buck yorumu, DCM akım zarfının alternans ortasında çökmesi ve üçüncü harmonik kökeni | Bölüm 4'te fiziksel özet; Bölüm 5'te matematiksel türetim | Fiziksel mekanizma ve düzeltilmiş DCM modeli eklendi; faza bağlı kritik görev oranı türetildi. Gerçek parametrelerle sayısal doğrulama yapılacak. |
| Klasik kontrol bloğu, şebeke gerilimi ileri beslemesi, denetleyici katkısı ve LCL empedansı | Bölüm 3 kontrol modeli ve Bölüm 5 kapalı çevrim analizi | İşlevsel blok Bölüm 3'e aktarıldı; Bölüm 5'e $L$, $S$ ve $T$ üzerinden geçici kapalı çevrim modeli, Bode diyagramı ve kararlılık kabul tablosu eklendi. Nihai sonuçlar gerçek denetleyici ve devre parametreleriyle yenilenecek. |
| Harmonik transfer/LTP kara kutu yaklaşımı ve Sin³--$\sin(3\omega t)$ katsayı ilişkisi | Bölüm 5 | Sin³ özdeşliği ve katsayı dönüşümü açıkça türetildi; HTF'nin matris yapısı ve sonlu mertebeye indirgeme gereği literatürle sınırlandırıldı. Gerçek koddaki katsayı tanımı ayrıca doğrulanacak. |
| Eski Tablo 4.1--4.3 katsayı taraması, kritik $d$ sınırı ve Şekil 4.25--4.32 sonuçları | Bölüm 5 | Tarihsel tablo ve şekiller aktarıldı; çelişkili optimum değer görünür kılındı. Kilitli parametreler ve aynı analiz penceresiyle tekrarlanabilir MATLAB üretimi bekliyor. |
| Eski literatüre katkı ve bölüm sonucu ifadeleri | Giriş, Bölüm 5 ve Sonuç | PLL/PR yapılarına karşı üstünlük ve anahtarlama azalması gibi iddialar gerçek kod/model kanıtı olmadan korunmayacak; son bulgularla yeniden yazılacak |

## Eski Bölüm 6 — GT-Tipi Mimari

| Eski öğe | Yeni konum/durum | Karar |
|---|---|---|
| Şekil 6.1 standart T-tipi faz kolu | Bölüm 3, `fig:t-tipi-uc-seviye`; Bölüm 7'den çapraz başvuru | Aynı devre ikinci kez basılmadı; GT-tipi yapının başlangıç topolojisi metinde açık atıfla korundu |
| Şekil 6.2 Viyana PFC ve Şekil 6.3 çok sekonderli aktif BYS | Bölüm 7, yeni Şekil 7.1--7.2 | İki kaynak alt topoloji ayrı sarı tarihsel şekiller olarak korundu; GT-tipi birleşime hangi işlevleri taşıdıkları metin içinde açıklandı |
| Şekil 6.4 GT-tipi ana topoloji | Bölüm 7, yeni Şekil 7.3 | Önceki tez görseli; RL1, transformatör, ara bara ve RL2 ilişkileriyle birlikte ayrı sarı tarihsel şekil olarak korundu |
| Şekil 6.5--6.7 evirici/LCL, iki seviyeli evirici--transformatör ve PFC çalışma yolları | Bölüm 7, yeni Şekil 7.4--7.6 | Üç çalışma modu birleştirilmeden ayrı ayrı aktarıldı; her şeklin etkin güç yolu ve bölüme konulma amacı anlatıldı |
| Şekil 6.8 GT-tipi Simulink modeli | Bölüm 7, yeni Şekil 7.10 | Eski model ekranı tarihsel benzetim kaydı olarak korundu; kesin `.slx/.mdl` geldiğinde hiyerarşik ve okunur model çıktısıyla doğrulanacak |
| Şekil 6.9--6.15 PFC/şebeke akımları, DA bara, primer--sekonder ve batarya/SoC grafikleri | Bölüm 7, yeni Şekil 7.11--7.17 | Yedi grafik ayrı sarı tarihsel şekil olarak korundu; gösterdikleri fiziksel büyüklük ve kanıt sınırı şekil çevresinde açıklandı. Ham zaman serisi bulunmadan yeni 100 kW tasarımının sonucu sayılmayacak |
| Sonradan gelen 100 kW GT-tipi şemalar ve yeni vektörel çizimler | Bölüm 7, yeni Şekil 7.7--7.9 ve 7.18 sonrası | Önceki tez görsellerinin yerine geçirilmedi; ayrı bir proje/tasarım katmanı olarak korundu ve kaynak/kanıt düzeyi belirtildi |

Eski Bölüm 6'daki grafiklerin hiçbiri yeni bileşik bir grafik içinde eritilmedi. Tarihsel görseller eski tezin ne gösterdiğini korurken, yeni şemalar 100 kW hedefli mimarinin geliştirilmiş anlatımını sağlar. `D7-1` ve `D7-2` yorumları, sırasıyla eski devrelerin donanım doğrulamasını ve eski benzetimin ham model/zaman serileriyle yeniden üretimini takip eder.

## Öncelikli kalan işler

1. Eski Şekil 3.13--3.16'yı aday değil, tezde kullanılacak kesin Simulink modelinden yeniden üretmek.
2. Tarihsel karşılıkları ayrı aktarılan eski Şekil 4.3--4.16'yı, kesin `.slx` ve ham zaman serileri geldiğinde aynı koşu ve analiz penceresinde yeniden üretmek.
3. Bölüm 5'e tarihsel kanıt olarak yerleştirilen eski Tablo 4.1--4.3 ve Şekil 4.25--4.32'yi doğru Sin³ tanımı, kilitli gerçek parametreler ve ortak analiz penceresiyle yeniden hesaplayıp MATLAB çıktılarıyla değiştirmek.
4. Gerçek konum/yönelim bilgisi kesinleşirse saatlik PVGIS verisi indirip 144 noktalı temsilî profili gerçek yıllık dağılımla değiştirmek.
5. Ticari evirici kaydının cihaz, analizör, örnekleme ve ham dosya bilgilerini bulmak; bulunamazsa kaydı destekleyici gözlem olarak sınırlı tutmak.
6. Eski Şekil 6.2--6.7'nin kesin devre/model dosyalarını bulup eleman değerleri ve anahtar durumlarıyla vektörel doğrulamasını yapmak.
7. Eski Şekil 6.8--6.15'i kesin GT-tipi Simulink modeli ve ham zaman serileriyle aynı çalışma koşulunda yeniden üretmek; mevcut sarı kopyaları ancak eşleşme doğrulandıktan sonra değiştirmek.
