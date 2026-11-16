# Bölüm 1 kip incelemesi (kural 9: geniş zaman → "-mektedir/-maktadır")

- Dosya: `yeni_tez/bolumler/01-giris.tex` (158 satır), görev kipi: **incele** (dosya değiştirilmedi)
- Tarih: 16.11.2026
- Kapsam: düz metin, tablo hücreleri (Tablo 1.1), `\caption` düz metni, TikZ düğüm metinleri (ayrı başlık). `%` yorumları ve `\umitnot{...}` dışarıda (bölümde `\umitnot` yok).
- Sayım birimi: **yüklem**. Bağlaçla birleşen "-makta/-mekte" ve "-mış" yüklemleri ayrı sayılmıştır ("çalışmakta ve ... geçirmektedir" = 2). "-ebilmektedir" biçimleri hedef kipte sayılmıştır.

## 1. Özet

### Kalan geniş zaman yüklemleri (çevrilecek)

| Katman | Yüklem | Öneri |
|---|---:|---:|
| Düz metin | 23 | 22 (K-01–K-22, K-18 iki yüklem içerir) |
| Tablo 1.1 hücreleri | 0 | 0 (önceki turda çevrilmiş) |
| `\caption` düz metni | 2 | 2 (K-23, K-24; Şekil 1.1) |
| TikZ düğüm metinleri | 0 | 0 (düğümlerin hepsi fiilsiz ad öbeği) |
| **Toplam** | **25** | **24** |

### Zaten "-mektedir" kipinde olan yüklemler

| Katman | Yüklem |
|---|---:|
| Düz metin | 58 |
| Tablo 1.1 | 7 |
| Caption / TikZ | 0 / 0 |
| **Toplam** | **65** (`grep` sayımıyla doğrulandı) |

### Geniş zamanın yoğunlaştığı paragraflar

1. Satır 11 (FV kısmi yük paragrafı): 4 yüklem (K-02–K-05). Tez sahibinin düzelttiği paragraf. Çevrilince 7 cümle art arda "-mektedir" ile bitmektedir (bkz. hafifletme seçenekleri).
2. Satır 19 (Sin³ ileri besleme paragrafı): 4 yüklem (K-10–K-13).
3. Satır 59 (başlık–katkı eşleştirme): 3 yüklem, 2 cümlede (K-17, K-18).
4. Satır 13, 21 ve Şekil 1.1 başlığı: ikişer yüklem.

### Kural 9 kapsamında değişmeyecek türler

| Tür | Metin | Tablo | Caption | Not |
|---|---:|---:|---:|---|
| Ad cümlesi ("-dır/-dir") | 24 | 5 | 1 | Değişmez |
| Geçmiş zaman ("-mıştır", eksiltili "-mış" dahil) | 28 | 1 | 0 | Değişmez |
| Olasılık "-ebilir" (soru "-ebilir mi" dahil) | 9 | 1 | 0 | Değişmez, bkz. Bölüm 3 |
| Gereklilik "-malıdır/-meli" | 3 | 0 | 0 | Değişmez (satır 11, 17) |

### Öteki kurallar

- Yasak gösterme sözcüğü: metinde 0. Önerilerin hiçbirinde yasak sözcük ya da yeni noktalı virgül yoktur.
- LaTeX: önerilerde `\citep`, `\ref`, `~`, `$...$`, `\textsuperscript` aynen korunmuştur. TikZ koduna öneri yoktur.

## 2. Öneri listesi

Her öneride **Sonra** metni yalnız ilgili cümledir ve doğrudan .tex'e yapıştırılabilir. "Hafif" seçenek, art arda dörtten fazla "-mektedir" oluştuğunda cümleyi ad cümlesiyle kuran alternatiftir (kural 9, son madde). Hafif seçenek seçilirse ana Sonra yerine o kullanılır.

### Satır 9 (EDS paragrafı)

**K-01** `01-giris.tex:9`
- **Önce:** Sistem başarısını yalnızca hücrenin enerji yoğunluğu belirlemez.
- **Sonra:** Sistem başarısını yalnızca hücrenin enerji yoğunluğu belirlememektedir.
- Not: Paragraftaki öteki yüklemler ad cümlesidir, ağırlık oluşmaz.

### Satır 11 (FV ve kısmi yük paragrafı)

**K-02** `01-giris.tex:11`
- **Önce:** Yalnızca anma noktasında verilen tepe verim değeri, yıllık enerji dönüşüm başarısını tek başına açıklamaz.
- **Sonra:** Yalnızca anma noktasında verilen tepe verim değeri, yıllık enerji dönüşüm başarısını tek başına açıklamamaktadır.
- **Hafif (önerilen):** Yalnızca anma noktasında verilen tepe verim değeri, yıllık enerji dönüşüm başarısını açıklamak için tek başına yeterli değildir.
- Not: Paragrafta K-02–K-05 çevrilince 2.–8. cümlelerin yedisi de "-mektedir" ile bitmektedir. K-02 ve K-05 için hafif seçenek alınırsa en uzun dizi 3 cümleye iner.

**K-03** `01-giris.tex:11`
- **Önce:** Kısmi yükte sabit sürme, anahtarlama ve manyetik eleman kayıplarının aktarılan güce oranı büyür.
- **Sonra:** Kısmi yükte sabit sürme, anahtarlama ve manyetik eleman kayıplarının aktarılan güce oranı büyümektedir.
- Not: Geçişsiz fiil, özne "oranı". "büyütmektedir" değil.

**K-04** `01-giris.tex:11`
- **Önce:** Aynı bölgede akım dalga biçimi de anahtar doğrusal olmayanlıklarına, ölü zamana ve şebeke gerilimindeki bozulmalara daha duyarlı hâle gelir.
- **Sonra:** Aynı bölgede akım dalga biçimi de anahtar doğrusal olmayanlıklarına, ölü zamana ve şebeke gerilimindeki bozulmalara daha duyarlı hâle gelmektedir.

**K-05** `01-giris.tex:11`
- **Önce:** Sonuçta düşük güç bölgesi, verim ile akım toplam harmonik bozulması (Total Harmonic Distortion, THD) arasındaki ödünleşimin belirginleştiği bir çalışma alanına dönüşür \citep{Kjaer2005,Chicco2009}.
- **Sonra:** Sonuçta düşük güç bölgesi, verim ile akım toplam harmonik bozulması (Total Harmonic Distortion, THD) arasındaki ödünleşimin belirginleştiği bir çalışma alanına dönüşmektedir \citep{Kjaer2005,Chicco2009}.
- **Hafif (önerilen):** Sonuçta düşük güç bölgesi, verim ile akım toplam harmonik bozulması (Total Harmonic Distortion, THD) arasındaki ödünleşimin belirginleştiği bir çalışma alanıdır \citep{Kjaer2005,Chicco2009}.
- Not: "Sonuçta" sözcüğü nedensellik bağını taşıdığı için "dönüşür"ün "hâline gelme" anlamı ad cümlesinde korunmaktadır.

### Satır 13 (çok seviyeli topoloji paragrafı)

**K-06** `01-giris.tex:13`
- **Önce:** Şebekeye bağlı dönüştürücülerde verim--THD ödünleşimini topoloji, modülasyon, filtre ve kontrol yapısı birlikte belirler.
- **Sonra:** Şebekeye bağlı dönüştürücülerde verim--THD ödünleşimini topoloji, modülasyon, filtre ve kontrol yapısı birlikte belirlemektedir.
- **Hafif:** Şebekeye bağlı dönüştürücülerde verim--THD ödünleşimi topoloji, modülasyon, filtre ve kontrol yapısına birlikte bağlıdır.
- Not: Ana öneriyle 1.–4. cümleler art arda "-mektedir" ile bitmektedir (4 cümle). Hafif seçenekte nesne durum eki değişir ("ödünleşimini" → "ödünleşimi"), anlam aynıdır.

**K-07** `01-giris.tex:13`
- **Önce:** Üç seviyeli T-tipi evirici, nötr noktaya bağlanan çift yönlü anahtar kolu sayesinde $+V_{\mathrm{dc}}/2$, $0$ ve $-V_{\mathrm{dc}}/2$ gerilim seviyelerini üretir.
- **Sonra:** Üç seviyeli T-tipi evirici, nötr noktaya bağlanan çift yönlü anahtar kolu sayesinde $+V_{\mathrm{dc}}/2$, $0$ ve $-V_{\mathrm{dc}}/2$ gerilim seviyelerini üretmektedir.
- Not: Tanım niteliğinde bir cümle (bkz. S-01). Sonraki cümle "sunmakta ve ... gerçekleştirilebilmektedir" ile bittiği için kip birliği açısından çevrilmesi önerilmektedir.

### Satır 15 (ters akım paragrafı)

**K-08** `01-giris.tex:15`
- **Önce:** Sıfır durumunda yapılan değişiklik akım yolunu, çıkış gerilimini, modülasyon bütünlüğünü ve harmonik içeriği birlikte etkiler.
- **Sonra:** Sıfır durumunda yapılan değişiklik akım yolunu, çıkış gerilimini, modülasyon bütünlüğünü ve harmonik içeriği birlikte etkilemektedir.
- Not: Paragraftaki dört "-ebilir" yüklemi değişmez (S-02).

### Satır 17 (önerilen yöntem paragrafı)

**K-09** `01-giris.tex:17`
- **Önce:** Yöntem, düşük güç bölgesinde dolaşımı sınırlandırmak için nötr anahtarı belirli koşullarda susturur.
- **Sonra:** Yöntem, düşük güç bölgesinde dolaşımı sınırlandırmak için nötr anahtarı belirli koşullarda susturmaktadır.
- **Hafif (önerilen):** Yöntemin ilkesi, düşük güç bölgesinde dolaşımı sınırlandırmak için nötr anahtarın belirli koşullarda susturulmasıdır.
- Not: Ana öneriyle paragrafın ilk beş cümlesi art arda "-mektedir" ile bitmektedir ("ele alınmaktadır, susturmaktadır, değiştirmektedir, çıkabilmektedir, değiştirebilmektedir"). Hafif seçenekle en uzun dizi 3 cümleye iner. Sonraki cümle "Susturma, ..." diye başladığı için bağ korunmaktadır.

### Satır 19 (Sin³ ileri besleme paragrafı)

**K-10** `01-giris.tex:19`
- **Önce:** $\sin^3(\theta)=[3\sin(\theta)-\sin(3\theta)]/4$ özdeşliği, ölçülen şebeke geriliminin faz bilgisinden temel ve üçüncü harmonikle ilişkili anlık bir şekillendirme terimi üretilebilmesini sağlar.
- **Sonra:** $\sin^3(\theta)=[3\sin(\theta)-\sin(3\theta)]/4$ özdeşliği, ölçülen şebeke geriliminin faz bilgisinden temel ve üçüncü harmonikle ilişkili anlık bir şekillendirme terimi üretilebilmesini sağlamaktadır.
- Not: Özdeşlik doğru biçimdedir, dokunulmamıştır.

**K-11** `01-giris.tex:19`
- **Önce:** Sin\textsuperscript{3} terimi ideal doğrusal modelde karakteristik paydayı değiştirmez.
- **Sonra:** Sin\textsuperscript{3} terimi ideal doğrusal modelde karakteristik paydayı değiştirmemektedir.

**K-12** `01-giris.tex:19`
- **Önce:** Ancak gecikme ve filtre etkileşimi, gerçek dönüştürücüde kararlılık incelemesini gerekli kılar.
- **Sonra:** Ancak gecikme ve filtre etkileşimi, gerçek dönüştürücüde kararlılık incelemesini gerekli kılmaktadır.

**K-13** `01-giris.tex:19`
- **Önce:** İncelemenin kapalı çevrim modelini, duyarlılık fonksiyonlarını, düşük güç ve anma akımı çalışma noktalarını birlikte kapsaması gerekir.
- **Sonra:** İncelemenin kapalı çevrim modelini, duyarlılık fonksiyonlarını, düşük güç ve anma akımı çalışma noktalarını birlikte kapsaması gerekmektedir.
- Not: K-11–K-13 paragraf sonunda 3 ardışık "-mektedir" oluşturur (sınırda, kabul edilebilir). Daha hafif istenirse gereklilik kipiyle: "İnceleme, kapalı çevrim modelini, duyarlılık fonksiyonlarını, düşük güç ve anma akımı çalışma noktalarını birlikte kapsamalıdır." (kural 9'un değişmeyen türü, anlam aynı).

### Satır 21 (GT-tipi odak paragrafı)

**K-14** `01-giris.tex:21`
- **Önce:** Her ilave kat güç yoğunluğu, sürücü, soğutma, koruma ve maliyet üzerinde yeni yük oluşturur.
- **Sonra:** Her ilave kat güç yoğunluğu, sürücü, soğutma, koruma ve maliyet üzerinde yeni yük oluşturmaktadır.
- Not: Aynı paragrafın 8. cümlesi de "oluşturmaktadır" ile bitmektedir. Yineleme istenmezse: "... üzerinde yeni yük getirmektedir."

**K-15** `01-giris.tex:21`
- **Önce:** Tezde önerilen GT-tipi mimari, T-tipi dönüştürücünün anahtarlarını çalışma kipine göre yeniden görevlendirir.
- **Sonra:** Tezde önerilen GT-tipi mimari, T-tipi dönüştürücünün anahtarlarını çalışma kipine göre yeniden görevlendirmektedir.
- Not: Paragraf sonundaki "yeniden görevlendirilmektedir" ile yineleme özgün metinde de vardır. Terim birliği için olduğu gibi bırakılması önerilmektedir.

### Satır 56 (Katkı 3 maddesi)

**K-16** `01-giris.tex:56`
- **Önce:** Mimari, üç işlevi ortak yarı iletkenlerde birleştirerek ayrı güç katlarına göre eleman sayısını azaltma olanağı sunar.
- **Sonra:** Mimari, üç işlevi ortak yarı iletkenlerde birleştirerek ayrı güç katlarına göre eleman sayısını azaltma olanağı sunmaktadır.
- Not: Tablo 1.1, 3. satırdaki "olanağı sunmaktadır" ile uyumlu hâle gelir.

### Satır 59 (başlık–katkı eşleştirme paragrafı)

**K-17** `01-giris.tex:59`
- **Önce:** Tez başlığının üç bileşeni üç katkıya karşılık gelir.
- **Sonra:** Tez başlığının üç bileşeni üç katkıya karşılık gelmektedir.
- **Hafif (önerilen):** Tez başlığının üç bileşeninin her biri bir katkının karşılığıdır.
- Not: Ana öneri 3. cümledeki "karşılık gelmektedir" ile sözcük yinelemesi yaratır ve paragrafta 5 ardışık "-mektedir" cümlesi oluşur. Hafif seçenekle dizi 4 cümleye iner. Dördün altına inmek için cümleleri birleştirmek gerekir, ama birleşik cümle 30 kelimeyi aşacağı için önerilmemektedir.

**K-18** `01-giris.tex:59` (iki yüklem)
- **Önce:** Bölümlerin sırası başlığın sırasını değil, fiziksel zinciri izler: önce faz kolu ölçeğindeki mekanizma ve iki yöntem, ardından aynı donanımın sistem ölçeğinde yeniden görevlendirilmesi ele alınır.
- **Sonra:** Bölümlerin sırası başlığın sırasını değil, fiziksel zinciri izlemektedir: önce faz kolu ölçeğindeki mekanizma ve iki yöntem, ardından aynı donanımın sistem ölçeğinde yeniden görevlendirilmesi ele alınmaktadır.

### Satır 101 (Tezin Düzeni girişi)

**K-19** `01-giris.tex:101`
- **Önce:** Tez sekiz bölümden oluşmaktadır ve genelden özele, faz kolundan sisteme doğru ilerler.
- **Sonra:** Tez sekiz bölümden oluşmakta ve genelden özele, faz kolundan sisteme doğru ilerlemektedir.
- Not: Karma kip ("-mektedir ve ... -er") kuralın bağlaç maddesine göre düzeltilmiştir: ilk yüklem "-makta" alır.

### Satır 154 (Bölüm 1–3 tanıtımı)

**K-20** `01-giris.tex:154`
- **Önce:** Üçüncü bölüm, sonraki bütün bölümlerin ortak tabanını oluşturur.
- **Sonra:** Üçüncü bölüm, sonraki bütün bölümlerin ortak tabanını oluşturmaktadır.

### Satır 156 (Bölüm 4–6 tanıtımı)

**K-21** `01-giris.tex:156`
- **Önce:** Dördüncü, beşinci ve altıncı bölümler faz kolu ölçeğindeki zinciri oluşturur.
- **Sonra:** Dördüncü, beşinci ve altıncı bölümler faz kolu ölçeğindeki zinciri oluşturmaktadır.
- **Hafif (önerilen):** Faz kolu ölçeğindeki zincir dördüncü, beşinci ve altıncı bölümlerdedir.
- Not: Paragrafın kalan dört cümlesi zaten "-mektedir" kipindedir. Ana öneriyle 5 ardışık cümle oluşur. Hafif seçenek ayrıca önceki paragraftaki K-20 "oluşturmaktadır" ile yinelemeyi de önler.

### Satır 158 (Bölüm 7–8 tanıtımı)

**K-22** `01-giris.tex:158`
- **Önce:** Yedinci bölüm sistem ölçeğine geçer ve GT-tipi yeniden yapılandırılabilir EDS mimarisini, çalışma kiplerini ve klasik mimariyle farklarını sunmaktadır (katkı~3).
- **Sonra:** Yedinci bölüm sistem ölçeğine geçmekte ve GT-tipi yeniden yapılandırılabilir EDS mimarisini, çalışma kiplerini ve klasik mimariyle farklarını sunmaktadır (katkı~3).
- Not: K-19 ile aynı karma kip düzeltmesi.

### Şekil 1.1 başlığı (`\caption`, satır 152)

**K-23** `01-giris.tex:152`
- **Önce:** Faz kolu ölçeğindeki iki katkı düşük güç ters akım problemine, sistem ölçeğindeki GT-tipi mimari aynı T-tipi donanımın yeniden görevlendirilmesine dayanır.
- **Sonra:** Faz kolu ölçeğindeki iki katkı düşük güç ters akım problemine, sistem ölçeğindeki GT-tipi mimari aynı T-tipi donanımın yeniden görevlendirilmesine dayanmaktadır.

**K-24** `01-giris.tex:152`
- **Önce:** Yeşil kutular kanıt katmanlarını gösterir.
- **Sonra:** Yeşil kutular kanıt katmanlarını göstermektedir.
- Not: Kısa başlık `[Tezin problem--yöntem--katkı akışı]` fiilsizdir. Şekiller listesine giden metin değişmez.

### Tablo 1.1 ve TikZ düğümleri

- **Tablo hücreleri (satır 71–84):** Geniş zaman yüklemi kalmamıştır. Hücrelerdeki 7 yüklem "-mektedir" kipindedir, öteki yüklemler ad cümlesi (5), eksiltili "-mış" (satır 74, "Mekanizma doğrulanmış") ya da "-ebilir" (satır 83, bkz. S-05) biçimindedir. Tablo başlığı (satır 63) ad cümlesiyle bitmektedir ("... tek faz kolu içindir"), değişiklik gerekmez.
- **TikZ düğüm metinleri (satır 118–146):** Bütün düğümler fiilsiz ad öbeğidir ("Verim--THD ödünleşimi", "Bedel: süreksiz iletim, üçüncü harmonik", "Evirici, Vienna PFC ve aktif batarya yönetimi aynı yarı iletkenlerle" vb.). Kural 9 kapsamında öneri yoktur. Kural 7 gereği TikZ koduna zaten dokunulmaz.

## 3. Sınırda olanlar

Aşağıdakiler ana listeye alınmamıştır (S-01 hariç, o ana listede K-07 olarak yer alır). Öneri: **olduğu gibi kalsın**, aksi belirtilmedikçe.

**S-01** `01-giris.tex:13`, "gerilim seviyelerini üretir" (K-07)
- Genel geçer topoloji tanımıdır. Tanım cümlelerinde geniş zaman Türkçe teknik metinde olağandır. Yine de çevrilmesi önerilmektedir, çünkü sonraki cümle "-mektedir" kipindedir ve tez sahibinin kararı bütün fiilli cümleleri kapsamaktadır. Tez sahibi tanımları geniş zamanda bırakmayı yeğlerse K-07 atlanabilir.

**S-02** `01-giris.tex:15`, "korunmayabilir", "gösterebilir", "büyüyebilir", "artırabilir"
- Ters akım mekanizması burada olasılık olarak kurulmuştur, kanıtı Bölüm 4'tedir. "büyümektedir", "artırmaktadır" gibi çeviriler iddiayı güçlendirir (kural 4). "-ebilmektedir" de gereksiz ağırlık getirir. Değişmesin.

**S-03** `01-giris.tex:19`, "ileri besleme yolları akım bozulmasını azaltabilir", "sistem dinamiğiyle de etkileşebilir"
- Literatürden aktarılan olasılıklardır (\citep{Lu2016,Wang2024}). "-mektedir" kesinlik kazandırır. Değişmesin.

**S-04** `01-giris.tex:21`, "... ayrı yarı iletken gruplarıyla gerçekleştirilebilir."
- Anlam "geleneksel sistemlerde katlar genellikle ayrı donanımla kurulur" yönündedir. "gerçekleştirilmektedir" biçimi geleneksel uygulamayı genelleyerek kesinleştirir. İsteğe bağlı, önerilmeyen seçenek: "Geleneksel bir depolama sisteminde şebeke eviricisi, şarj doğrultucusu veya güç faktörü düzeltme (Power Factor Correction, PFC) katı ve hücre dengeleme dönüştürücüleri ayrı yarı iletken gruplarıyla gerçekleştirilmektedir." Mevcut biçimin korunması önerilmektedir.

**S-05** `01-giris.tex:83` (Tablo 1.1, 3. satır), "... işlevlerinde kullanılabilir."
- "kullanılmaktadır" demek, üç işlevin hepsinin donanımda işletildiği izlenimini verir. Oysa tezde evirici kipi deneyle, şarj yönü benzetimle gösterilmiştir (satır 56). "-ebilir" olanak bildirdiği için doğrudur. Değişmesin.

**S-06** `01-giris.tex:26`, `\emph{...}` içindeki sav: "... birlikte kullanılabilir."
- Tezin ana savıdır, olanak kipi bilinçlidir. Değişmesin.

**S-07** `01-giris.tex:45`, AS4: "... birleştirilebilir mi?"
- Evet/hayır biçimli araştırma sorusudur, "-ebilir mi" doğal kalıptır. Değişmesin.

**S-08** Mevcut ağırlık (geniş zamandan bağımsız), `01-giris.tex:7`
- Paragrafın ilk dört cümlesi zaten art arda "-mektedir" ile bitmektedir ("yol açmaktadır, ilerlemektedir, kaldırmamaktadır, artırmaktadır"). Kural 9'un son maddesine göre hafifletilebilir, ama tez sahibi istemediği için öneri yazılmamıştır. İstenirse ayrı turda ele alınabilir.

## 4. Uygulanınca beklenen sayılar

### Yalnız ana Sonra metinleri uygulanırsa

| Ölçüt | Şimdi | Sonra |
|---|---:|---:|
| Geniş zaman yüklemi (metin / tablo / caption / TikZ) | 23 / 0 / 2 / 0 | 0 / 0 / 0 / 0 |
| "-mektedir" yüklemi (toplam) | 65 | 90 |
| Ad cümlesi yüklemi | 30 | 30 |
| "-mıştır" / "-ebilir" / "-malıdır" | 29 / 10 / 3 | değişmez |
| 4 ve daha uzun ardışık "-mektedir" cümle dizisi | 2 (satır 7, 156) | 6 (satır 7, 11, 13, 17, 59, 156) |
| Noktalı virgül, yasak sözcük | 0, 0 | 0, 0 |

### "Hafif (önerilen)" seçenekleri de alınırsa (K-02, K-05, K-09, K-17, K-21; K-06 isteğe bağlı)

| Ölçüt | Sonra |
|---|---:|
| Geniş zaman yüklemi | 0 |
| "-mektedir" yüklemi | 85 (K-06 hafifiyle 84) |
| Ad cümlesi yüklemi | 35 (K-06 hafifiyle 36) |
| 4 ve daha uzun ardışık "-mektedir" dizisi | 4: satır 7 (mevcut), 13 (4 cümle, K-06 hafifiyle 3'e iner), 59 (4), 156 (4, özgün metindeki durumla aynı) |

`\cite`/`\ref`/`\label` sayıları hiçbir öneride değişmez.
