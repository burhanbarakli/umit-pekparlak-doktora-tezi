# Tez çalışma listesi

## Giriş bölümü

- [x] Ters üçgen akışla giriş metnini hazırlama
- [x] Amaç, araştırma soruları, özgün katkılar, kapsam ve tez organizasyonunu yazma
- [x] Giriş kaynaklarını BibTeX kaynakçasına bağlama
- [x] Cümle başlangıçlarında “Bu” kullanımını temizleme
- [ ] **Problem–yöntem–katkı akış şeklini hazırlayıp Giriş bölümüne ekleme**
  - Akış: EDS → T-tipi dönüştürücü → düşük güçte ters akım → yeni anahtarlama yöntemi → Sin³ ileri besleme kompanzasyonu → GT-tipi mimari
  - Şekil, teknik sistem blok diyagramından farklı ve tezin araştırma mantığını özetleyen kavramsal bir görsel olmalı.

## Tez tamamlandıktan sonra yapılacak kapanış kontrolü

- [ ] **Giriş bölümündeki araştırma sorularını, özgün katkıları ve tez organizasyonunu tamamlanan bölümler ve sonuçlarla karşılaştırma**
- [ ] Her araştırma sorusunun Sonuçlar bölümünde açık ve kanıta dayalı bir yanıtı bulunduğunu doğrulama
- [ ] Katkı ifadelerini gerçek benzetim ve deney kanıtının kapsamıyla uyumlu hâle getirme
- [ ] Bölüm numaraları ve içerik değişmişse “Tezin Organizasyonu” kısmını son yapıya göre güncelleme

## Bölüm 2 — Literatür, Kuramsal Temel ve Araştırma Boşluğu

Durum: **ŞİMDİLİK KAPATILDI.** Mevcut kaynaklar ve eldeki eski tez kayıtlarıyla akademik yazım tamamlandı; temsilî profilin kanıt sınırı literatürle gerekçelendirildi. Yalnızca tez sonuçları tamamlandıktan sonraki eşleştirme ve son teslim denetimi açık tutuldu.

- [x] Mevcut 45 kaynağı tez katkı eksenlerine göre tarama
- [x] T-tipi dönüştürücü ve yeniden yapılandırılabilir EDS alanlarında ek birincil kaynakları ekleme
- [x] EDS güç dönüşümü, T-tipi topoloji, düşük güç/ters akım ve ileri besleme kuramsal çerçevesini yazma
- [x] Literatür karşılaştırma tablosunu oluşturma
- [x] Tezin üç katkısını birleştiren açık araştırma boşluğunu yazma
- [x] Eski tezdeki EDS/BYS/dengeleme görsellerini kalite ve tekrar bakımından ayıklayıp Bölüm 2'ye yalnızca gerekli olanları geçici olarak aktarma
- [x] Eski Bölüm 1--4 şekil ve tabloları için aktarım/yeniden üretim haritası hazırlama
- [x] EDS maliyeti, batarya ömrü/güvenliği, BYS mimarisi ve BYS/dengeleme karşılaştırmalarını Bölüm 2'ye aktarma
- [x] Eski Bölüm 2'deki FV güç, verim ve THD profillerini MATLAB ile vektörel yeniden üretme
- [x] Eski Şekil 2.3'ü yıl--saat yüzeyinin türetim bağını korumak amacıyla sarı etiketli geçici raster olarak ekleme; ölçülmüş yıllık veri olmadığını belirtme
- [x] Eski Tablo 2.1 ile Şekil 2.4 arasındaki uyuşmazlığı 144 noktayı yeniden gruplayarak düzeltme
- [x] Avrupa/CEC ağırlıklı verim denklemlerini ve katsayılarını Bölüm 2'ye ekleme
- [x] Chicco güç--THD şeklini dış kaynak etiketiyle ve eski ticari evirici kaydını kanıt sınırıyla aktarma
- [x] Bölüm 2'deki bütün şekiller için metin içi amaç--bulgu--sınırlılık anlatımını ve açık şekil referanslarını denetleme
- [x] Temsilî \%23,6 oranını yıllık saha sonucu olmaktan çıkarıp düşük güç bölgesinin önemini Mondol ve Ab. Rahman çalışmalarına dayalı kısmi yük gerekçesiyle sınırlandırma
- [ ] Bölüm 4--6 sonuçları tamamlandığında literatür karşılaştırma tablosunu, araştırma boşluğunu ve katkı sınırlarını gerçek bulgularla yeniden eşleştirme
- [ ] Şekil 2.7 ana metinde kalacaksa son teslim öncesinde vektör veya en az 300 dpi olarak yeniden üretme; çıkarılacaksa metindeki türetim bağını Şekil 2.6 üzerinden kurma
- [ ] Son teslim öncesinde Bölüm 2 kaynak--iddia eşleşmesini, şekil kullanım izinlerini ve şekil/tablo numaralarını son kez denetleme

## Bölüm 3 — Sistem Mimarisi, Model ve Metodoloji

Durum: Kuramsal iskelet, eski tez aktarımı ve jüriye yönelik yöntem görselleri tamamlandı. Gerçek kod, kesin Simulink modeli, devre değerleri ve deney kayıtları geldikten sonra aşağıdaki mühendislik ayrıntıları kilitlenerek bölüm nihai hâle getirilecek.

- [x] Genel enerji, ölçüm ve denetim blok diyagramını ekleme
- [x] T-tipi üç gerilim seviyesi ile dört temel akım yolunu eski tezden çalışma kopyası olarak aktarma
- [x] Anahtarlama durumlarını tek karşılaştırma tablosunda toplama
- [x] Senkron-buck eşdeğeri, ters akım eşiği ve LCL filtre modelini yazma
- [x] Elektriksel ve denetim parametrelerini tek çalışma tablosunda birleştirme
- [x] Düşük, orta ve anma gücü doğrulama matrisini oluşturma
- [x] Önceki Bölüm 3'teki 16 şekli ve tablo bulunmadığını tek tek denetleme
- [x] Önceki tezin tamamındaki 107 şekil ve 16 tabloyu eski numaralarıyla tek tek envanterleyip yeni hedef bölüm, aktarım durumu ve kabul ölçütlerini `review/ONCEKI_TEZ_SEKIL_TABLO_TAKIP_LISTESI_2026-07-13.html` dosyasında izlenebilir hâle getirme
- [x] Eski Şekil 3.1--3.12'nin yeni konumlarını belirleme; tekrar edilenleri açık bölüm içi referanslarla gösterme
- [x] Eski Şekil 3.11 ve Şekil 3.12'yi sarı etiketli iki ayrı çalışma kopyası olarak Bölüm 2'de birincil kaynaklı DE--CCM karşılaştırmasının arkasına ekleme
- [x] Mevcut Bölüm 3 şekil ve tablolarının tamamına metin içinde amaç, teknik sonuç ve kapsam açıklaması verme
- [x] T-tipi çalışma modu şekillerini aynı devre tabanı ve renk lejandıyla vektörel yeniden çizme
- [x] Şekil 3.3'e $C_A$--$C_B$ bölünmüş DA bara, antiparalel diyotlu $Q_1$--$Q_4$ IGBT'leri ve $L_1$--$C_f$--$L_2$ filtresini içeren faz başına tam güç topolojisini ekleme
- [x] Eski Şekil 3.9--3.10 senkron-buck eşdeğerlerini ortak vektör çizim diliyle yeniden üretme
- [ ] Eski Şekil 3.13--3.16'nın kavramsal raster kopyalarını doğrudan kullanmak yerine gerçek MATLAB/Simulink modelinden akım, hata, denetleyici çıkışı ve kapı işaretlerini yeniden üretme; sonuçları Bölüm 4--5'e yerleştirme
- [x] LCL filtre elemanlarını, ölçülen akımları ve gerilimleri durum modeliyle eşleştiren vektörel faz başına devre şemasını ekleme
- [x] PR/akım denetimi, klasik ileri besleme, Sin³ yolu, sınırlayıcı, PWM ve nötr susturma mantığını ayıran işlevsel denetim blok diyagramını ekleme
- [ ] İşlevsel denetim blok diyagramındaki denetleyici türü, işaretler, sınırlayıcı sırası, PWM güncelleme anı ve nötr susturma koşulunu gerçek kontrol koduyla kesinleştirme
- [x] Anahtarlama fonksiyonu, ideal görev oranları, verim, THD, RMSE, ters akım alanı ve anahtarlama geçiş sayısı denklemlerini yöntem bölümüne ekleme
- [x] İdeal durum, ortalama model, anahtarlamalı benzetim ve deney katmanlarının kanıt sınırlarını tek tabloda ayırma
- [ ] `DOĞRULANACAK` parametreleri kontrol kodu, benzetim dosyası, devre şeması ve donanım etiketlerinden kilitleme
- [ ] Gerçek güç kartı şeması geldiğinde IGBT/diyot parça kodları, kapı sürücüleri, sensörler, koruma elemanları, konektörler ve $C_A$--$C_B$--$L_1$--$C_f$--$L_2$ değerlerini doğrulayıp ayrıntılı uygulama devresini Ek A'ya yerleştirme; kavramsal Şekil 3.3'ü uygulama/imalat şeması olarak sunmama
- [ ] İdeal anahtarlama tablosunu gerçek PWM kapı komutları, ölü zaman ve akım yönüne bağlı diyot yollarıyla doğrulama
- [ ] Gerçek MATLAB/Simulink kapı işaretleri ve endüktör akımı üretildiğinde eski Şekil 3.11--3.12 ile Bölüm 2'deki birincil kaynaklı karşılaştırmayı yan yana değerlendirme; eski şemaların ana metinde kalması, eke taşınması veya çıkarılması kararını verme
- [ ] Toplam/yarım DA bara tanımını ve prototip anma gücünü ham tasarım kaydıyla kesinleştirme
- [ ] Ham deney kaydı → işleme yöntemi → şekil/tablo → tez iddiası izlenebilirlik çizelgesini hazırlama
- [x] Sin³ kapalı çevrim yapısını Bölüm 5'te $L$, $S$, $T$ ve geçici MATLAB Bode çıktısıyla kurma; sonuçları geçici parametre sınırıyla işaretleme
- [ ] Gerçek LCL/PR/gecikme değerleri geldiğinde $L$, $S$, $T$, kazanç/faz marjı ve çalışma noktası taramasını aynı MATLAB betiğiyle nihai olarak yeniden üretme

## Bölüm 4 — Düşük Güç Analizi ve Yeni Anahtarlama Yöntemi

- [x] Ters akım dolaşım mekanizmasını senkron-buck eşdeğeri üzerinden açıklama
- [x] Sürekli, sınır ve zorlanmış sürekli iletim bölgelerini tanımlama
- [x] Klasik anahtarlama ile nötr anahtar susturma yöntemini işlevsel tabloda karşılaştırma
- [x] Nötr anahtar susturma kuralını eşik ve histerezis içeren matematiksel tanımla verme
- [x] Senaryo 1/2/3 temel akım ve THD değerlerini karşılaştırmalı tabloya aktarma
- [x] Kurtarılan üç dalga biçimini sarı `ÖNCEKİ TEZ` etiketiyle Bölüm 4'e yerleştirme
- [x] Jürinin çalışma modları ve düşük/orta/anma gücü taleplerini yeşil etiketlerle görünür kılma
- [x] Ham model bulunmadığı için senaryo eşlemesi ve verim iddiasının kanıt sınırını açıkça yazma
- [x] Eski Şekil 4.1--4.16'nın birbirinden farklı görseller olduğunu doğrulayıp yeni Şekil 4.1--4.16 olarak bire bir ve ayrı sarı etiketlerle aktarma; hatalı birleşik 4.1--4.3 eşlemesini kaldırma
- [x] Eski Şekil 4.2 ve 4.11'deki büyütülmüş kapı darbesi kesitlerini tam periyot Şekil 4.1 ve 4.10'dan ayrı tutma; $Q_1$--$Q_4$ ilişkisini metin içinde açıklama
- [x] Eski Bölüm 4'teki IGBT--MOSFET kayıp gerekçesi, faz başına SPWM kurgusu, denetleyicisiz/ileri besleme katsayılı benzetim koşulu ve DCM akım zarfı mekanizmasını kanıt sınırlarıyla yeni Bölüm 4'e aktarma
- [x] Eski simülasyon verimi/THD özet tablosunu ham model sınırıyla aktarma
- [x] Eski Şekil 4.5--4.9'u Senaryo 1 kaynak ekranlarıyla doğrulayıp yeni Şekil 4.5--4.9 olarak ayrı ayrı aktarma; eski Şekil 4.7'deki ikinci kanal adını özgün ekran başlığına göre filtrelenmiş gerilim olarak düzeltme
- [x] Eski Bölüm 3.5--3.6 ve alt dallarındaki senkron-buck eşdeğeri, düşük güç işletme gerekçesi, modülasyon indeksi, nötr anahtar rolü, kayıp dağılımı, kontrolör düzeltmeleri ve ters akım kavramlarını yeni Bölüm 2--4'e eksiksiz ve kanıt sınırlarıyla yerleştirme; Mohan/Chicco/Chen atıflarını hedefli biçimde düzeltme
- [ ] Gerçek kapı kodu gelirse işlevsel susturma kuralını kesin $Q_1$--$Q_4$ kapı tablosuyla değiştirme
- [ ] Ham DA/AA güç kayıtları bulunursa ters akım alanı ile verim kazanımını sayısal olarak doğrulama
- [ ] Belirli bir saha için yıllık düşük güç oranı raporlanacaksa konum, yönelim ve kayıp bilgileriyle saatlik PVGIS profilini ayrı bir yöntem ve sonuç çalışması olarak üretme
- [ ] Eski ticari evirici kaydı deney kanıtı olarak kullanılacaksa cihaz, analizör, ölçüm penceresi ve ham veri bilgilerini doğrulama; doğrulanamazsa kaydı yalnızca tarihsel örnek olarak bırakma
- [ ] Eski Şekil 3.13--3.16'nın eksik mekanizma kanıtlarını kesin Simulink modelinden yeniden üretme
- [ ] Tarihsel karşılıkları aktarılan Şekil 4.3--4.16'yı kesin `.slx` ve ham zaman serileri geldiğinde aynı analiz penceresinden alınmış okunur vektör/model çıktılarıyla değiştirme
- [x] Eski Tablo 4.1--4.2 ile Şekil 4.25--4.32'yi sarı tarihsel kanıt etiketiyle Bölüm 5'e aktarma; Şekil 4.28 ile eski Tablo 4.3 optimum çelişkisini görünür kılma
- [x] Eski Tablo 4.3'ün 24 aday çiftini ana metinde tarihsel tarama olarak özetleme ve nihai katsayı sayılmadığını belirtme
- [ ] Eski Tablo 4.1--4.3 ve Şekil 4.25--4.32'yi gerçek kod/model eşleşmesiyle yeniden üretip tarihsel kopyaların ana metin/ek/çıkarma kararını verme
- [x] Eski Bölüm 4.4--4.7'deki şebeke gerilimi ileri beslemesi, LCL empedans etkisi, denetleyici/ileri besleme katkı ayrımı, iki buck eşdeğeri, parçalı DCM--CCM modeli, kritik görev oranı ve katsayı taramasını Bölüm 5'te düzeltilmiş matematiksel akışla yeniden kurma
- [x] Eski Şekil 4.18--4.22'yi yeni Şekil 5.5--5.9 olarak ayrı, sarı etiketli ve metin içi açıklamalı biçimde Bölüm 5'e aktarma; görsel--metin sayısal uyuşmazlıklarını açıkça belirtme
- [ ] Eski Bölüm 4.4--4.7 sayısal sonuçlarını gerçek yarım bara tanımı, filtre değerleri, kip sınırları ve kaynak betikle yeniden doğrulama
- [ ] Eski Bölüm 4.8'deki literatüre katkı iddialarını; PLL/PR ile karşılaştırma, gecikme/hesaplama yükü ve anahtarlama azalması bakımından gerçek kod, kapalı çevrim ve geçiş sayısı kanıtlarıyla sınayıp ancak desteklenen kısmı Sonuç'a taşıma

## Bölüm 6 — Deneysel Doğrulama

Durum: Önceki tezin Bölüm 5 deney düzeneği ve üç düşük güç yöntemi, özgün Word paketindeki görsellerden doğrulanarak yeni Bölüm 6'ya aktarıldı. Deneyler yeniden yapılmış gibi sunulmadı; eski metin özetleri, PC ekran değerleri ve eksik ham veri sınırları ayrı gösterildi.

- [x] Eski Şekil 5.1--5.24 ile Tablo 5.1--5.4'ün metin, tablo ve gömülü medya bağlantılarını özgün DOCX paketinden çıkarıp eşleme
- [x] Deney düzeneği, güç donanımı, kontrol/buffer/sürücü kartları ve koruma zincirini metin içinde açıklama
- [x] Eski Tablo 5.1--5.3'ü birleştirmeden, özgün satırları ve Şekil 5.3--5.6 üzerindeki numara ilişkilerini aynen koruyarak yeni Tablo 6.1--6.3'e aktarma
- [x] AA/DA analizörleri, osiloskop, problar, HLSR akım sensörü ve AMC1200 ölçüm yolunu kaynak sınırlarıyla tabloya aktarma
- [x] Güç, ölçüm ve RS485/Modbus veri toplama akışını jüri talebine uygun tek vektörel blok diyagramında gösterme
- [x] Eski Şekil 5.1--5.24'ün tamamını ayrı görseller olarak ve yeni Şekil 6.1--6.24 sırasıyla yerleştirme; her görselin metin içi kanıt rolünü açıklama
- [x] Eski tez metnindeki verim/THD özetleriyle PC ekranlarında görünen anlık değerleri yan yana denetleyip uyuşmazlıkları görünür kılma
- [x] Eski Tablo 5.4'te simülasyon hücrelerinin boş kaldığını ve çevre metinde yalnız %90,45/%93 verim değerlerinin bildirildiğini belgeleyerek tahminle doldurmama
- [x] Yaklaşık 2,3 A kayıtların düşük güç kanıtı olduğunu; orta/nominal güç ve geçici rejim jüri talebini karşılamadığını açıkça yazma
- [x] Eski Şekil 5.1--5.24 ve Tablo 5.1--5.4 için birebir yeni numara, PDF sayfası ve aktarım kararını HTML takip listesine işleme
- [x] Bölüm 6 sayfalarını PDF olarak görsel inceleyip tablo taşmalarını ve hatalı SI aralık gösterimini düzeltme
- [ ] Ham PC/Modbus ve osiloskop dosyaları bulunursa ortak zaman penceresiyle verim, THD, RMS, ters akım ve belirsizlikleri yeniden hesaplama
- [ ] Gerçek deney koşusu tekrarlanacaksa üç yöntemi aynı DA bara, faz gerilimi, güç noktası ve denetleyiciyle düşük--orta--erişilebilir en yüksek güçte en az üç tekrar çalıştırma
- [ ] Cihaz veri sayfaları, kalibrasyon belgeleri, kontrol/PWM kodu ve devre BOM'u gelirse ölçüm belirsizliği ile donanım parametrelerini kesinleştirme

## Bölüm 7 — GT-Tipi Yeniden Yapılandırılabilir Enerji Depolama Mimarisi

Durum: Proje başvuru formundaki üç özgün şema, 100 kW/690 V/1000 V hedefleri, AB--BC--CA konteynerleri, izole şarj kolları ve seçilebilir seri deşarj yolu kaynak sınırlarıyla yazıldı. Bölüm mimari tanım ve doğrulama yöntemi düzeyinde tamamlandı; gerçek model, donanım ve deney kayıtları gelmeden performans sonucu kurulmadı.

- [x] Eski Şekil 6.2--6.7'deki Viyana PFC, çok sekonderli BYS, GT-tipi ana topoloji ve üç çalışma yolunu yeni Şekil 7.1--7.6 olarak ayrı sarı tarihsel şekiller halinde koruma
- [x] Eski Şekil 6.8--6.15'teki Simulink ekranı ile PFC, DA bara, primer, sekonder ve batarya/SoC grafiklerini yeni Şekil 7.10--7.17 olarak ayrı sarı tarihsel kanıt halinde koruma
- [x] Eski GT-tipi görselleri yeni 100 kW proje şemalarıyla birleştirmeme; iki içerik katmanının kaynak ve kanıt düzeyini metinde ayırma
- [x] Önceki 30 kW T-tipi evirici altyapısı ile yeni 100 kW GT-tipi proje hedefini ayrı kanıt katmanları olarak tanımlama
- [x] Başvuru formundaki değiştirilmiş T-tipi güç katı, AB--BC--CA şarj/deşarj mimarisi ve IGBT--SiC tetikleme şemalarını kırmızı dış kaynak etiketiyle koruma
- [x] GT-tipi adının proje içi geliştirilmiş/değiştirilmiş T-tipi mimariyi ifade ettiğini ve standartlaşmış ayrı bir topoloji adı olmadığını açıklama
- [x] 400/700/1000 V ile 10/30/140 kHz değerlerini eski prototip, harici Vienna referansı ve 100 kW proje hedefi olarak ayırma
- [x] Güç paylaşımı, seçilebilir dizi gerilimi, CC--CV şarj, SoC güncellemesi, güvenli mod geçişi ve gidiş--dönüş verimi denklemlerini parametre tanımlarıyla yazma
- [x] Güvenli kapalı, ön şarj, şebekeden şarj, CC--CV, kademeli yüke deşarj, bypass/yedekleme ve kimyaya bağlı bakım modlarını ayırma
- [x] Üst seviye enerji/denetim mimarisi ile güvenli durum makinesini vektörel çizme
- [x] IEC 62619, IEC 62477-1 ve IEC 62933-5-2 kapsamlarını güvenlik gereksinimlerine bağlama
- [x] Başvuru formundaki “şebekeye deşarj prototip test kapsamı dışındadır” sınırını Bölüm 7 doğrulama matrisi ve verim tanımında koruma
- [x] Geleneksel, literatürdeki yeniden yapılandırılabilir ve GT-tipi mimarileri kanıt düzeyiyle karşılaştırma
- [ ] Kesin GT-tipi `.slx/.mdl` paketi ve kontrol kodu geldiğinde bağlantı, kapı tablosu, IGBT--SiC sırası ve durum makinesini doğrulama
- [ ] Güç kartı/BOM/transformatör/batarya veri sayfaları geldiğinde 100 kW parametre tablosunu, kayıp hesabını ve koruma eşiklerini kilitleme
- [ ] Şarj yönünde PF, THD, verim, akım paylaşımı ve termal sonuçları; deşarj yönünde kademeli yük, bypass/yedekleme ve verim sonuçlarını ham veriden üretme
- [ ] Kaynak metindeki desülfasyon için 3 kHz referans darbesi ile 30 kHz SiC anahtarlaması ayrımını gerçek kodla çözme; kimya ve üretici sınırlarını doğrulama
- [ ] Eski Şekil 6.2--6.7'nin ham devre/model dosyaları geldiğinde anahtar durumlarını ve eleman değerlerini doğrulayıp gerekiyorsa vektörel yeniden çizme
- [ ] Eski Şekil 6.8--6.15'i kesin `.slx/.mdl` ve ham zaman serileriyle aynı çalışma koşulunda yeniden üretip tarihsel grafiklerle sayısal eşleştirme

## Bölüm 8 — Sonuçlar ve Gelecek Çalışmalar

Durum: Mevcut kanıt düzeyine göre ilk tam sonuç metni yazıldı. Eski tezin üç katkı ekseni, THD/verim kayıtları, GT-tipi sonuç çizgisi, fikrî mülkiyet numaraları ve gelecek çalışma kavramları korunmuş; doğrulanamayan iddialar yeni deney sonucu gibi sunulmadan sınırlandırılmıştır.

- [x] AS1--AS4 için yanıt, dayanak, sonuç düzeyi ve geçerlilik sınırını içeren jüri etiketli kanıt matrisi hazırlama
- [x] Düşük güç anahtarlama, Sin³ ileri besleme ve GT-tipi mimari katkılarını T-tipi ana ekseni korunacak biçimde değerlendirme
- [x] Eski tezde bildirilen yaklaşık %46--%7,8 THD zincirini tarihsel ekranlarla eşleştirme; klasik yöntemin %2,14 düzeyine ulaşılamadığını açıkça yazma
- [x] Eski tezde bildirilen altı fikrî mülkiyet numarasını sarı tarihsel tabloyla koruma ve bilimsel performans kanıtından ayırma
- [x] Model/kod, ortak çalışma koşulu, güç aralığı, ölçüm izlenebilirliği, kararlılık, GT-tipi prototip ve genellenebilirlik sınırlılıklarını toplama
- [x] MATLAB/Simulink yeniden üretimi, ortak güç taraması, HTF, deney, GT-tipi prototip, güvenlik ve batarya çalışmalarını gelecek işlere ayırma
- [ ] Ham model ve ortak koşullu deney sonuçları geldiğinde AS2--AS3 yanıtlarını ve katkı yüzdelerini yeniden değerlendirme
- [ ] GT-tipi prototip ve güvenlik deneyleri geldiğinde AS4'ü mimari düzeyden performans düzeyine güncelleme
- [ ] TR/PCT numaralarının güncel sicil durumu, tarih, hak sahibi ve teknik istem eşleşmesini resmî kayıtlardan doğrulama
- [ ] Nihai sonuçlar kilitlendiğinde Girişteki ana sav, araştırma soruları, katkılar ve tez organizasyonunu Bölüm 8 ile son kez eşleştirme

## 13 Temmuz 2026 — Sonradan gelen teknik dosyalar

- [x] Senaryo RAR arşivlerini aynı adlı klasörlere çıkarma ve içeriklerini doğrulama
- [x] Senaryo 1/2/3 için IL1 ve Iout THD değerlerini kaydetme
- [x] Anahtarlama akışını klasik / nötr anahtar susturma / susturma+Sin³ olarak eşleme
- [ ] Eşlemeyi ham Simulink modeli veya gerçek kapı koduyla kesinleştirme
- [x] Senaryo sonuçlarını Bölüm 4'e "kurtarılmış benzetim ekranı; ham veri bekleniyor" kanıt sınırıyla yerleştirme
- [x] Sin³ özdeşliğini doğru katsayılarla yazma: $\sin^3x=[3\sin x-\sin(3x)]/4$
- [ ] Kaynak metindeki `sin³` ve `sin(3x)` anlatım çelişkisini gerçek kod/model ile çözme
- [x] Eski 30 kW/faz-nötr mimari ile yeni 100 kW/faz-arası AB-BC-CA mimarisinin tezdeki rollerini ayırma
- [x] 400/700/1000 V ile 10/30/140 kHz değerlerini kaynak ve alt sistem etiketleriyle parametre tablosunda ayırma
- [ ] Microchip Vienna verilerini yalnızca harici referans tasarım olarak kullanma; tez prototip sonucu gibi sunmama
- [ ] Ek-A'daki topoloji görsellerinden yalnız gerekli karşılaştırma setini Bölüm 2'ye alma
- [ ] Ek-D'deki BYS yöntemlerini tek sentez tabloya indirme; on üç şekli ana metne yığmama
- [x] Fotovoltaik kusur tespiti konulu `Rev6_2_Goksin...docx` dosyasını kapsam dışı olarak işaretleme
- [x] Başvuru formundaki "şebekeye deşarj prototipi test edilmeyecek" sınırını deney iddialarıyla uyumlu hâle getirme
- [x] Ham deney kaydı yoksa verim ve grid-tied deşarj iddialarını benzetim/tasarım kapsamıyla sınırlama

## 26 Ağustos 2026 — R2025b Senaryo 1 cihaz ve filtre doğrulaması

- [x] $L_1=600\,\mu\mathrm{H}$, $C_f=8\,\mu\mathrm{F}$, $L_2=200\,\mu\mathrm{H}$ setini ayrı çalışma kopyasına uygulama
- [x] S1--S2'yi SKM100GB12T4, S3--S4'ü IXYN100N65C3H1, D1--D2'yi DSEI2x61-12B ile eşleme; DSEI parametrelerini IGBT diyotlarına yaymama
- [x] Tam cihaz dinamikli 1 ms R2025b sağlık kontrolünü tamamlama
- [x] Tam cihaz dinamikli 5 ms koşunun 1200 s hesap süresi içinde tamamlanmadığını kaydetme
- [x] Sade sistem katmanındaki 25 ms koşunun 21,3324 ms'de diyot yakınsamasıyla durduğunu kaydetme
- [x] Başlangıçtaki 43,1 kA ideal kaynak/kondansatör darbesi nedeniyle 1 ms güç, THD ve verim göstergelerini geçersiz sayma
- [ ] Fiziksel ön şarj veya kaynak empedansı, diyot komütasyon parasitikleri ve çözücü ayarlarıyla en az iki kararlı 50 Hz periyodu tamamlama
- [ ] Senaryo 1'de %92,5 verim ve yaklaşık %15 THD'yi ham DA/AA güç ile ortak FFT penceresinden yeniden hesaplama

## 14 Temmuz 2026 — Denklem, parametre ve kaynak denetimi

- [x] Bölüm 1--5'teki bütün numaralı denklemleri envanterleme; Bölüm 1'de numaralı denklem bulunmadığını doğrulama
- [x] Bölüm 2--5'teki 41 denklem etiketinin tamamının metin içinde çağrıldığını ve etiketsiz gösterim kalmadığını doğrulama
- [x] Denklem parametrelerini ilk geçtikleri yerde tanımlama; DA bara orta noktası $N$ ile örnek sayısı çakışmasını örnek sayısını $N_s$ yaparak giderme
- [x] Eski tezdeki Avrupa/CEC, Sin³, DCM, CCM ve Fourier formüllerini kaynak, boyut ve işaret tutarlılığı bakımından denetleyip gerekli olanları düzeltme
- [x] Eski skaler “toplam transfer fonksiyonu” türetimini doğrulanmış model olarak taşımayıp harmonik transfer matrisi çerçevesiyle değiştirme
- [x] Eski 4.2--4.26 denklem zincirini Bölüm 5.1.1'e eksiksiz yerleştirip 26 tarihsel formülün her birini kırmızı `HATALI--Eski` etiketiyle ayırma
- [x] Eski 4.14 numarasının yinelenmesini 4.14a/4.14b olarak gösterme; 4.21'deki akım--gerilim çıkış simgesi değişimini ve 4.20/4.22 Laplace katsayısı tutarsızlığını metinde belgeleme
- [ ] Nihai teslim öncesinde kırmızı etiketli tarihsel 4.2--4.26 zincirinin ana metinde mi kalacağına yoksa eke mi taşınacağına danışmanla karar verme
- [ ] Gerçek denetim kodunda kullanılan ifadenin `K1*sin(theta)+K3*sin(theta)^3` veya `K1*sin(theta)+K3*sin(3*theta)` seçeneklerinden hangisi olduğunu; işaret, ölçek, doyum ve etkinleştirme koşullarıyla kilitleme
- [ ] Belirlenmiş düşük/orta/anma gücü çalışma noktalarında temel--üçüncü harmonik HTF matrisini model doğrusallaştırması veya küçük işaret enjeksiyonuyla elde etme
- [ ] `K1,K3` değerlerini temel akımı koruma, üçüncü harmonik/THD, RMS akım, modülasyon payı ve kararlılık kısıtlarıyla seçip çalışma noktasına bağlı çizelgeleme gereksinimini sınama
- [ ] Aday katsayıları gerçek MATLAB/Simulink modeli ve deney verisinde `I3/I1`, THD, ters akım, RMS akım, verim ve modülasyon payı bakımından karşılaştırma
- [x] Güç integrali sınırlarını, referansa göre ters akım ölçütünü, mutlak ortalama akımlı iletim kaybını ve histerezis bandını düzeltme
- [x] Denklem aktarım kararlarını `review/DENKLEM_PARAMETRE_DENETIMI_2026-07-14.html` dosyasında görünür hâle getirme
- [ ] Gerçek model/kod geldiğinde $K_1$, $K_3$, $D_1$, $D_3$, $N_h$, $T_d$, Padé mertebesi, LCL/PR değerleri ve DCM--CCM sınırını yeniden doğrulama
- [ ] Kesin deney kayıtlarında her sonuç için kullanılan örnekleme frekansı, pencere, harmonik üst sınırı, güç işaret yönü ve anahtarlama geçiş sayma kuralını raporlama

## 14 Temmuz 2026 — Önceki tez içeriğini ezmeme ve doğrulama yorumları

- [x] Girişe `D1-1--D1-2`: problem--yöntem--katkı şekli ile araştırma sorusu/katkı kapanış denetimini ekleme
- [x] Bölüm 2'ye `D2-1--D2-4`: birleştirilen EDS/BYS görselleri, çıkarılan ömür senaryosu, eski CCM/DCM şekilleri, FV--THD kayıtları ve kaynak/izin denetimini ekleme
- [x] Bölüm 3'e `D3-1--D3-4`: birleştirilen topoloji şekilleri, eski Şekil 3.13--3.16, parametre kilitleme ve modelden iddiaya izlenebilirlik denetimini ekleme
- [x] Bölüm 4'e `D4-1--D4-3`: kapı mantığı, eski Şekil 4.3--4.16'nın yeniden üretimi ve güç/verim/THD çelişkilerinin doğrulanmasını ekleme
- [x] Bölüm 5'e `D5-1--D5-5`: hatalı tarihsel denklemler, gerçek Sin³ kodu, katsayı taraması, eski kontrol blokları, Bode/HTF ve üstünlük iddialarının doğrulanmasını ekleme
- [x] Bölüm 6'daki `D6-1--D6-9` deney protokolü, ham veri, cihaz, belirsizlik, tekrarlanabilirlik ve güç/geçici rejim denetimlerinin yeterli kapsamda kaldığını yeniden kontrol etme
- [x] Bölüm 7'deki `D7-1--D7-8` eski devre/benzetim, kod, frekans/kimya, güvenlik, model, donanım ve deney kanıtı denetimlerinin yeterli kapsamda kaldığını yeniden kontrol etme
- [x] Bölüm 8'e `D8-1--D8-4`: araştırma sorusu--kanıt matrisi, eski sonuç/patent ifadeleri, açık notların kapanışı ve gelecek çalışma ayrımını ekleme
- [ ] Nihai teslimden önce bütün `D1--D8` yorumlarını tamamlandı / sınırlılık olarak kaldı / kapsamdan çıkarıldı biçiminde kapatma
