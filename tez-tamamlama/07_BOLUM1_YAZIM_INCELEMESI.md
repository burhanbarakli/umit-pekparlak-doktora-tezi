# Bölüm 1 (Giriş) yazım incelemesi

- **Dosya:** `yeni_tez/bolumler/01-giris.tex` (158 satır). Dosya değiştirilmedi.
- **Görev:** "incele" (`.claude/agents/tez-yazim-editoru.md`). Yalnız rapor yazıldı.
- **Tarih:** 16.11.2026
- **Tez sahibinin bu turdaki istekleri:** noktalı virgülü belirgin biçimde azaltmak, cümleleri kısaltmak, yeniden yazmadan sadeleştirmek, gösterme sözcüğü kullanmamak, TDK ve teknik doğruluk denetimi yapmak.

## 1. Özet

| Ölçüt | Şu anki metin | Öneriler uygulanınca |
|---|---|---|
| Noktalı virgül (düz metin, tablo ve başlıklar dahil, TikZ hariç) | **46** | **1** |
| 30 kelimeyi aşan cümle | **14** | **0** |
| 25 kelimeyi aşan cümle | 29 | 5 (en uzunu 28 kelime) |
| Ortalama cümle uzunluğu | 19,9 kelime | 14,7 kelime |
| En uzun cümle | 49 kelime (satır 21) | 28 kelime |
| Yasak gösterme sözcüğü | **1** ("şudur", satır 26) | **0** |
| `\cite` / `\ref` / `\label` / `$` / `\SI` / `~` | 11 / 28 / 8 / 12 / 9 / 28 | aynı (değişmez) |

**Sayım yöntemi.** TikZ bloğu ve `%` yorumları çıkarıldı. Tablo hücreleri ve `\item` öğeleri ayrı birim sayıldı, cümleler `. ? !` işaretlerinden bölündü, LaTeX komutları temizlendi. Tüm paragrafı tek akış olarak sayan bir yöntem ortalamayı yaklaşık 23 kelime bulur (tez sahibinin verdiği değer). Fark, tablo hücrelerinin ve liste öğelerinin komşu metne eklenmesinden geliyor. "Sonra" sütunu, 55 önerinin hepsi dosyanın bir kopyasına uygulanıp aynı betikle yeniden sayılarak elde edildi. Kalan tek noktalı virgül tablonun 2. satırındaki kaynak hücresinde (satır 79). Orada iç öğelerinde virgül bulunan bir gönderme listesini ayırıyor, bu yüzden kural 2'ye göre kalabilir.

**Öneri sayısı:** 55 (A-01 – A-55). Bir öneri birden çok türü kapsayabilir: noktalı virgül 38, uzun cümle 22, terim 7, yazım-noktalama 3, yasak sözcük 1, anlam açıklığı 1. Önerilerdeki "Önce" metinleri toplam 45 noktalı virgül içeriyor, "Sonra" metinlerinde hiç yok.

**En önemli bulgular**

1. **Yasak sözcük var: "şudur" (satır 26).** "Tezin ana savı şudur:" ifadesindeki "şudur", "şu" gösterme zamirinin ek almış biçimi. Yalnız tam kelime "şu" arayan bir tarama onu kaçırıyor. A-19 hem sözcüğü hem savdaki noktalı virgülü kaldırıyor.
2. **Noktalı virgüllerin çoğu özneden ya da "-makta/-mekte"den sonra geliyor** ("Elektrik enerjisi sistemleri;", "Katkı;", "Sonuçlar;", "ele alınmakta;"). TDK'ye göre bu kullanım gereksiz. İki cümleye bölmek ya da sıralamayı yüklemin önüne almak yetiyor. Tablodaki 18 noktalı virgülün 17'si, iç virgüller ayraca alınarak ya da "ile" kullanılarak virgüle çevrildi.
3. **Teknik:** satır 15'te senkron alçaltıcı eşdeğeri yalnız "nötr anahtarlara" bağlanıyor. Bölüm 4'e göre eşdeğer devreyi dış anahtar ile nötr anahtar birlikte oluşturuyor (T-1). Ayrıca Sin³ teriminin "kararlılığı değiştirmez" iddiası, Bölüm 5'teki varsayım (şebekeye kilitli, yalnız zamana bağlı $\theta$) belirtilmeden mutlak biçimde yazılmış (T-3).
4. **Terim birliği:** Bölüm 1, tezin geri kalanının kullanmadığı "kontrolcü", "kontrol döngüsü", "nominal akım" ve "LCL filtresi" biçimlerini kullanıyor. Önerilen karşılıklar: "denetleyici", "akım çevrimi", "anma akımı", "LCL filtre". Tabloda "çevrim" sözcüğü hem akım denetim çevrimi hem şebeke periyodu anlamında geçiyor (A-31).
5. **Yazım:** "PWM'in" → "PWM'nin" (A-38). Cümle ortasında "Yedinci bölümdeki" → "yedinci bölümdeki" (A-55). "değil" karşıtlığından sonra virgül eksik (A-25).

## 2. Paragraf paragraf öneriler
Her öneride **Önce** metni dosyadaki metnin birebir kopyasıdır ve dosyada yalnız bir kez geçer (betikle denetlendi). Öneriler birbiriyle çakışmaz, aynı dosyaya sırayla `str.replace` ile uygulanabilir. **Sonra** metni doğrudan .tex'e yapıştırılabilir: `\cite`, `\ref`, `\label`, `$...$`, `\SI`, `~` bağları ve `\textsuperscript` korunmuştur.

### 1.1, paragraf 1 (satır 7): enerji sistemlerindeki dönüşüm

**A-01** · `bolumler/01-giris.tex:7` · *noktalı virgül*

Önce:

```latex
Elektrik enerjisi sistemleri; artan talep, fosil kaynakların çevresel etkileri ve enerji arzının karbonsuzlaştırılması gereksinimi nedeniyle önemli bir dönüşüm geçirmektedir.
```

Sonra:

```latex
Artan talep, fosil kaynakların çevresel etkileri ve enerji arzının karbonsuzlaştırılması gereksinimi, elektrik enerjisi sistemlerinde önemli bir dönüşüme yol açmaktadır.
```

Gerekçe: Özneden sonra gelen noktalı virgül TDK'ye göre gereksiz. Nedenler özneye alınınca cümle noktalı virgülsüz ve virgül belirsizliği olmadan kurulur.

**A-02** · `bolumler/01-giris.tex:7` · *uzun cümle*

Önce:

```latex
Işınım ve rüzgâr koşullarına bağlı üretim değişimleri, güç dengesinin korunması, gerilim ve frekansın desteklenmesi ve yenilenebilir enerjinin etkin biçimde kullanılabilmesi için esnek kaynaklara duyulan gereksinimi artırmaktadır \citep{Chen2009,Aneke2016,IEAPVPS2024}.
```

Sonra:

```latex
Işınım ve rüzgâr koşullarına bağlı üretim değişimleri, esnek kaynaklara duyulan gereksinimi artırmaktadır. Esnek kaynaklar güç dengesini korumak, gerilim ile frekansı desteklemek ve yenilenebilir enerjiyi etkin biçimde kullanmak için gereklidir \citep{Chen2009,Aneke2016,IEAPVPS2024}.
```

Gerekçe: Tek cümlede üç ayrı "ve" dizisi ve 27 kelime vardı. Ana yargı öne alındı, amaçlar ikinci cümleye taşındı. Kaynak grubu aynı sırayla paragraf sonunda kalıyor.

### 1.1, paragraf 2 (satır 9): EDS ve güç elektroniği arayüzü

**A-03** · `bolumler/01-giris.tex:9` · *uzun cümle*

Önce:

```latex
Sistem başarısı yalnızca hücrenin enerji yoğunluğuyla değil, batarya ile DA bara, yük ve şebeke arasındaki enerji akışını yöneten güç elektroniği arayüzünün verimi, güvenilirliği, hacmi ve maliyetiyle de belirlenir.
```

Sonra:

```latex
Sistem başarısını yalnızca hücrenin enerji yoğunluğu belirlemez. Batarya ile DA bara, yük ve şebeke arasındaki enerji akışını yöneten güç elektroniği arayüzünün verimi, güvenilirliği, hacmi ve maliyeti de belirleyicidir.
```

Gerekçe: 29 kelimelik "yalnızca ... değil, ... de" yapısı ikiye bölündü. Anlam aynı kalıyor.

**A-04** · `bolumler/01-giris.tex:9` · *uzun cümle*

Önce:

```latex
Güncel maliyet çalışmalarında batarya paketi en büyük kalem olarak öne çıksa da çift yönlü güç dönüştürücüleri ile yardımcı donanımları da sistem düzeyindeki maliyet ve kayıpların önemli bir parçasıdır \citep{Ramasamy2023,Lazard2024}.
```

Sonra:

```latex
Güncel maliyet çalışmalarında en büyük kalem batarya paketidir. Ancak çift yönlü güç dönüştürücüleri ve yardımcı donanımları da sistem düzeyindeki maliyet ve kayıpların önemli bir parçasıdır \citep{Ramasamy2023,Lazard2024}.
```

Gerekçe: "-sa da ... da" tekrarı giderildi, cümle ikiye bölündü.

### 1.1, paragraf 3 (satır 11): FV profili ve kısmi yük verimi

**A-05** · `bolumler/01-giris.tex:11` · *noktalı virgül*

Önce:

```latex
Fotovoltaik (FV) üretim, ışınım ve sıcaklık nedeniyle gün boyunca sürekli değişir; evirici yalnızca sınırlı sürelerle anma gücüne yakın çalışır ve çalışma ömrünün kayda değer bir bölümünü kısmi yük bölgelerinde geçirir.
```

Sonra:

```latex
Fotovoltaik (FV) üretim, ışınım ve sıcaklık nedeniyle gün boyunca sürekli değişir. Dolayısıyla FV evirici yalnızca sınırlı sürelerle anma gücüne yakın çalışır ve çalışma ömrünün kayda değer bir bölümünü kısmi yük bölgelerinde geçirir.
```

Gerekçe: Neden–sonuç bağı noktalı virgül yerine "Dolayısıyla" ile kuruldu. Evirici paragrafta ilk kez geçtiği için "FV evirici" diye belirtildi.

**A-06** · `bolumler/01-giris.tex:11` · *uzun cümle*

Önce:

```latex
Kısmi yükte sabit sürme, anahtarlama ve manyetik eleman kayıplarının aktarılan güce oranı büyürken akım dalga biçimi de anahtar doğrusal olmayanlıklarına, ölü zamana ve şebeke gerilimindeki bozulmalara daha duyarlı hâle gelir.
```

Sonra:

```latex
Kısmi yükte sabit sürme, anahtarlama ve manyetik eleman kayıplarının aktarılan güce oranı büyür. Aynı bölgede akım dalga biçimi de anahtar doğrusal olmayanlıklarına, ölü zamana ve şebeke gerilimindeki bozulmalara daha duyarlı hâle gelir.
```

Gerekçe: 29 kelime, "-ken" ile bağlanmış iki ayrı yargı vardı, ikiye bölündü. Kayıp sınıflandırmasıyla ilgili teknik not T-5'te.

### 1.1, paragraf 4 (satır 13): çok seviyeli topolojiler ve T-tipi

**A-07** · `bolumler/01-giris.tex:13` · *noktalı virgül*

Önce:

```latex
Şebekeye bağlı dönüştürücülerde verim--THD ödünleşimi; topoloji, modülasyon, filtre ve kontrol yapısının ortak sonucudur.
```

Sonra:

```latex
Şebekeye bağlı dönüştürücülerde verim--THD ödünleşimini topoloji, modülasyon, filtre ve kontrol yapısı birlikte belirler.
```

Gerekçe: Özneden sonraki noktalı virgül kaldırıldı. Sıralama yüklem öncesine alınınca virgül belirsizliği de kalmıyor.

**A-08** · `bolumler/01-giris.tex:13` · *noktalı virgül*

Önce:

```latex
T-tipi yapı; uygun eleman seçimi ve modülasyonla yüksek güç yoğunluğu ve yüksek verim potansiyeli sunmakta, aynı zamanda ticari yarı iletken modüllerle gerçekleştirilebilmektedir \citep{Wang2020}.
```

Sonra:

```latex
T-tipi yapı, uygun eleman seçimi ve modülasyonla yüksek güç yoğunluğu ile yüksek verim potansiyeli sunmakta ve ticari yarı iletken modüllerle gerçekleştirilebilmektedir \citep{Wang2020}.
```

Gerekçe: Özneden sonraki noktalı virgül virgüle çevrildi. "ve ... ve" yerine "ile ... ve" kullanıldı, "aynı zamanda" çıkarıldı.

### 1.1, paragraf 5 (satır 15): düşük güçte ters akım

**A-09** · `bolumler/01-giris.tex:15` · *noktalı virgül*

Önce:

```latex
Endüktör akımı bir anahtarlama periyodu içinde sıfıra ulaştıktan sonra nötr anahtar iletimde tutulduğunda akım ters yönde büyüyebilir; şebekeye yararlı güç taşımayan dolaşım akımı, yarı iletken ve pasif elemanların RMS akımını ve iletim kayıplarını artırabilir.
```

Sonra:

```latex
Endüktör akımı bir anahtarlama periyodu içinde sıfıra ulaştıktan sonra nötr anahtar iletimde tutulursa akım ters yönde büyüyebilir. Şebekeye yararlı güç taşımayan dolaşım akımı, yarı iletken ve pasif elemanların RMS akımı ile iletim kayıplarını artırabilir.
```

Gerekçe: 34 kelime ve bir noktalı virgül vardı, iki cümleye bölündü. "-dığında" yerine "-ırsa" kullanıldı. İkinci "ve" yerine "ile" geldi.

**A-10** · `bolumler/01-giris.tex:15` · *uzun cümle (ortaç zinciri)*

Önce:

```latex
Süreksiz iletim ve diyot benzetimi (diode emulation) yaklaşımlarının hafif yükte ters akımı engelleyerek kayıpları azaltabilmesi, senkron alçaltıcı dönüştürücüler için bilinen bir ilkedir \citep{Erickson2001,Mohan2003,Chen2010}.
```

Sonra:

```latex
Senkron alçaltıcı dönüştürücülerde süreksiz iletim ve diyot benzetimi (diode emulation) yaklaşımlarının hafif yükte ters akımı engelleyerek kayıpları azaltabildiği bilinmektedir \citep{Erickson2001,Mohan2003,Chen2010}.
```

Gerekçe: Uzun bir adlaşmış özne ("...azaltabilmesi") yerine bağlam başa alındı. Cümle daha doğrudan okunuyor.

**A-11** · `bolumler/01-giris.tex:15` · *noktalı virgül / uzun cümle*

Önce:

```latex
Ancak ters akımı engelleme ilkesinin şebekeye bağlı üç seviyeli T-tipi eviricinin sıfır durumuna uygulanması, yalnızca bir anahtarın kapatılması değildir; akım yolunu, çıkış gerilimini, modülasyon bütünlüğünü ve harmonik içeriği birlikte değiştiren topolojiye özgü bir problemdir.
```

Sonra:

```latex
Ancak ters akımı engelleme ilkesini şebekeye bağlı üç seviyeli T-tipi eviricinin sıfır durumuna uygulamak, yalnızca bir anahtarı kapatmak değildir. Sıfır durumunda yapılan değişiklik akım yolunu, çıkış gerilimini, modülasyon bütünlüğünü ve harmonik içeriği birlikte etkiler. Dolayısıyla problem, T-tipi topolojiye özgüdür.
```

Gerekçe: 34 kelime ve bir noktalı virgül vardı. Üç kısa cümleye bölündü. "Topolojiye özgü problem" iddiası korunuyor.

### 1.1, paragraf 6 (satır 17): susturma yöntemi ve THD bedeli

**A-12** · `bolumler/01-giris.tex:17` · *uzun cümle (ortaç zinciri)*

Önce:

```latex
Tezde, T-tipi sıfır durumuna özgü ters akım problemi için düşük güç bölgesinde dolaşımı sınırlandırmak amacıyla nötr anahtarın belirli koşullarda susturulmasına dayanan yeni bir anahtarlama yöntemi ele alınmaktadır. Yöntem, dolaşım akımını ve dolaşım akımından kaynaklanan kayıpları azaltmayı hedeflerken T-tipi eviricinin ürettiği gerilim darbelerini de değiştirmektedir.
```

Sonra:

```latex
Tezde, T-tipi sıfır durumuna özgü ters akım problemi için yeni bir anahtarlama yöntemi ele alınmaktadır. Yöntem, düşük güç bölgesinde dolaşımı sınırlandırmak için nötr anahtarı belirli koşullarda susturur. Susturma, dolaşım akımını ve akımın yol açtığı kayıpları azaltmayı hedeflerken T-tipi eviricinin ürettiği gerilim darbelerini de değiştirmektedir.
```

Gerekçe: 27 kelimelik ilk cümlede "amacıyla ... dayanan ... yöntemi" diye bir ortaç zinciri vardı, ikiye bölündü. "dolaşım akımı" tekrarı azaltıldı.

**A-13** · `bolumler/01-giris.tex:17` · *uzun cümle*

Önce:

```latex
Ölü zaman, anahtar geçişleri ve parazitik kapasiteler gibi gerçek devre etkileri akım harmoniklerini çalışma noktasına bağlı biçimde değiştirebildiğinden \citep{Zhang2014Deadtime}, önerilen anahtarlama yönteminin başarısı yalnızca verim kazancıyla değil, aynı çalışma noktalarında THD ve şebeke akımı kalitesi korunarak değerlendirilmelidir.
```

Sonra:

```latex
Ölü zaman, anahtar geçişleri ve parazitik kapasiteler gibi gerçek devre etkileri, akım harmoniklerini çalışma noktasına bağlı biçimde değiştirebilmektedir \citep{Zhang2014Deadtime}. Dolayısıyla önerilen anahtarlama yönteminin başarısı yalnızca verim kazancıyla ölçülmemeli, aynı çalışma noktalarında THD ve şebeke akımı kalitesinin korunup korunmadığı da değerlendirilmelidir.
```

Gerekçe: 37 kelimelik cümle neden ve sonuç olarak iki cümleye bölündü. Kaynak, iddianın hemen ardında kalıyor.

### 1.1, paragraf 7 (satır 19): Sin³ ileri besleme ve kararlılık

**A-14** · `bolumler/01-giris.tex:19` · *terim*

Önce:

```latex
Üretilen terim, akım hatasından türetilen bağımsız bir geri besleme kontrolcüsü değil, mevcut akım kontrol döngüsünün modülasyon girişine eklenen bir kompanzasyon bileşenidir.
```

Sonra:

```latex
Üretilen terim, akım hatasından türetilen bağımsız bir geri besleme denetleyicisi değil, mevcut akım çevriminin modülasyon girişine eklenen bir kompanzasyon bileşenidir.
```

Gerekçe: Bölüm 3 ve 5 "denetleyici" (Bölüm 5'te 35 kez) ve "akım çevrimi" kullanıyor. Bölüm 1'deki "kontrolcü" ve "kontrol döngüsü" tezin geri kalanıyla uyuşmuyor.

**A-15** · `bolumler/01-giris.tex:19` · *uzun cümle / terim*

Önce:

```latex
İleri besleme ile geri besleme arasındaki terminolojik ayrım önemlidir: şebeke gerilimi ileri besleme yolları akım bozulmasını azaltabilse de dijital gecikme, LCL filtresi ve şebeke empedansı nedeniyle sistem dinamiğiyle etkileşebilir \citep{Lu2016,Wang2024}.
```

Sonra:

```latex
İleri besleme ile geri besleme arasındaki terminolojik ayrım önemlidir. Şebeke gerilimi ileri besleme yolları akım bozulmasını azaltabilir. Ancak dijital gecikme, LCL filtre ve şebeke empedansı nedeniyle sistem dinamiğiyle de etkileşebilir \citep{Lu2016,Wang2024}.
```

Gerekçe: İki nokta ile bağlanmış 30 kelimelik cümle üçe bölündü. Tezin genelinde "LCL filtre" kullanılıyor ("LCL filtresi" yalnız burada geçiyor).

**A-16** · `bolumler/01-giris.tex:19` · *noktalı virgül / uzun cümle / terim*

Önce:

```latex
Sin\textsuperscript{3} terimi ideal doğrusal modelde karakteristik paydayı değiştirmese de gecikme ve filtre etkileşimi gerçek dönüştürücüde kararlılık incelemesini gerekli kılar; kapalı çevrim modelinin, duyarlılık fonksiyonlarının ve düşük güç ile nominal akım çalışma noktalarının birlikte incelenmesi gerekir.
```

Sonra:

```latex
Sin\textsuperscript{3} terimi ideal doğrusal modelde karakteristik paydayı değiştirmez. Ancak gecikme ve filtre etkileşimi, gerçek dönüştürücüde kararlılık incelemesini gerekli kılar. İncelemenin kapalı çevrim modelini, duyarlılık fonksiyonlarını, düşük güç ve anma akımı çalışma noktalarını birlikte kapsaması gerekir.
```

Gerekçe: 36 kelime ve bir noktalı virgül vardı, üç cümleye bölündü. "inceleme ... incelenmesi" tekrarı kalktı. Tezde "nominal" yerine "anma akımı" kullanılıyor (Bölüm 3'te 8, Bölüm 5'te 17 kez).

### 1.1, paragraf 8 (satır 21): GT-tipi mimari ve iki ölçekli eksen

**A-17** · `bolumler/01-giris.tex:21` · *noktalı virgül / uzun cümle*

Önce:

```latex
Tezde önerilen GT-tipi mimari, T-tipi dönüştürücünün anahtarlarını çalışma kipine göre yeniden görevlendirerek evirici, Vienna PFC ve aktif batarya yönetimi işlevlerini ortak bir donanımsal yapı üzerinde birleştirmeyi amaçlamaktadır; tezin deney düzeneği de GT-tipi olarak kurulmuştur.
```

Sonra:

```latex
Tezde önerilen GT-tipi mimari, T-tipi dönüştürücünün anahtarlarını çalışma kipine göre yeniden görevlendirir. Mimarinin amacı evirici, Vienna PFC ve aktif batarya yönetimi işlevlerini ortak bir donanım üzerinde birleştirmektir. Tezin deney düzeneği de GT-tipi olarak kurulmuştur.
```

Gerekçe: 34 kelime ve bir noktalı virgül vardı, üç cümleye bölündü. "donanımsal yapı" yerine "donanım" yazıldı.

**A-18** · `bolumler/01-giris.tex:21` · *uzun cümle*

Önce:

```latex
Düşük güçteki anahtarlama ve harmonik problemi ile şarj--deşarj mimarisinin yeniden yapılandırılması, birbirinden kopuk iki çalışma olarak değil, T-tipi dönüştürücünün yapısal olanaklarını iki ölçekte kullanan tek bir araştırma ekseni olarak ele alınmaktadır: faz kolu ölçeğinde nötr kolun düşük güçteki görevi değiştirilmekte, sistem ölçeğinde dönüştürücü anahtarları şarj--deşarj mimarisi içinde yeniden görevlendirilmektedir.
```

Sonra:

```latex
Düşük güçteki anahtarlama ve harmonik problemi ile şarj--deşarj mimarisinin yeniden yapılandırılması, birbirinden kopuk iki çalışma olarak ele alınmamaktadır. İki konu, T-tipi dönüştürücünün yapısal olanaklarını iki ölçekte kullanan tek bir araştırma ekseni oluşturmaktadır. Faz kolu ölçeğinde nötr kolun düşük güçteki görevi değiştirilmekte, sistem ölçeğinde ise dönüştürücü anahtarları şarj--deşarj mimarisi içinde yeniden görevlendirilmektedir.
```

Gerekçe: Bölümün en uzun cümlesiydi (49 kelime). Üç cümleye bölündü, içerik aynı.

### 1.2, paragraf 1 (satır 26): ana sav ve araştırma boşluğu

**A-19** · `bolumler/01-giris.tex:26` · *yasak sözcük / noktalı virgül / uzun cümle*

Önce:

```latex
Tezin ana savı şudur: \emph{T-tipi dönüştürücünün yapısal ve anahtarlama özellikleri, enerji depolama sistemlerinde şarj--deşarj işlevlerini yeniden yapılandırmak ve düşük güçte verim--harmonik ödünleşimini iyileştirmek için birlikte kullanılabilir; Sin\textsuperscript{3} terimi ise düşük güç verim--harmonik hedefini destekleyen ve akım çevriminin kararlılığını değiştirmeyen bir ileri besleme kompanzasyonudur.}
```

Sonra:

```latex
Tezin ana savı iki önermeden oluşmaktadır: \emph{T-tipi dönüştürücünün yapısal ve anahtarlama özellikleri, enerji depolama sistemlerinde şarj--deşarj işlevlerini yeniden yapılandırmak ve düşük güçte verim--harmonik ödünleşimini iyileştirmek için birlikte kullanılabilir. Sin\textsuperscript{3} terimi, düşük güç verim--harmonik hedefini destekleyen ve akım çevriminin kararlılığını değiştirmeyen bir ileri besleme kompanzasyonudur.}
```

Gerekçe: "şudur", "şu" gösterme zamirinin ek almış biçimi ve yasak listede. Basit bir "\bşu\b" taraması onu yakalamıyor, "bölümde hiç yok" sayımında görünmemesinin nedeni olabilir. Sav iki önermeye ayrılınca noktalı virgül de kalkıyor. "ise" artık gereksiz. Sav içeriğine dokunulmadı (kararlılık ifadesi için T-3'e bakın).

**A-20** · `bolumler/01-giris.tex:26` · *noktalı virgül / uzun cümle*

Önce:

```latex
Tezin odaklandığı araştırma boşluğu; T-tipi faz kolundaki düşük güç ters akım mekanizmasını, mekanizmanın verim--THD sonucunu, Sin\textsuperscript{3} tabanlı kompanzasyonu ve aynı donanımın EDS işlevleri için yeniden yapılandırılmasını ortak bir mimari ve doğrulama zinciri içinde ele almaktır.
```

Sonra:

```latex
Tezin odaklandığı araştırma boşluğu, dört konunun ortak bir mimari ve doğrulama zinciri içinde ele alınmasıdır. Dört konu T-tipi faz kolundaki düşük güç ters akım mekanizması, mekanizmanın verim--THD sonucu, Sin\textsuperscript{3} tabanlı kompanzasyon ve aynı donanımın EDS işlevleri için yeniden yapılandırılmasıdır.
```

Gerekçe: 36 kelime ve özneden sonra noktalı virgül vardı. Önce çerçeve, sonra dört öğeli sıralama veriliyor.

### 1.2, paragraf 2 (satır 28–37): temel amaç ve amaç listesi

**A-21** · `bolumler/01-giris.tex:28` · *uzun cümle / noktalı virgül*

Önce:

```latex
Tezin temel amacı, enerji depolama sistemleri için T-tipi dönüştürücü tabanlı yeniden yapılandırılabilir bir şarj--deşarj mimarisi geliştirmek ve aynı topolojinin şebekeye bağlı düşük güç çalışmasında görülen verim ile harmonik bozulma sorunlarını birlikte iyileştirecek yöntemleri ortaya koymaktır. Genel amaç doğrultusunda;
```

Sonra:

```latex
Tezin temel amacı, enerji depolama sistemleri için T-tipi dönüştürücü tabanlı yeniden yapılandırılabilir bir şarj--deşarj mimarisi geliştirmektir. Tez ayrıca aynı topolojinin şebekeye bağlı düşük güç çalışmasında görülen verim ile harmonik bozulma sorunlarını birlikte iyileştirecek yöntemleri ortaya koymayı amaçlamaktadır. Genel amaç doğrultusunda
```

Gerekçe: 35 kelimelik amaç cümlesi ikiye bölündü. "Genel amaç doğrultusunda;" sonrasındaki liste, "amaçlanmıştır." yüklemiyle biten tek bir cümlenin parçası. Bu yüzden noktalı virgüle gerek yok, işaretsiz bağlanır. Liste ve "amaçlanmıştır." satırı değişmiyor.

### 1.2, araştırma soruları (satır 42)

**A-22** · `bolumler/01-giris.tex:42` · *noktalı virgül*

Önce:

```latex
T-tipi eviricinin düşük güç çalışma bölgesinde ters akım dolaşımı hangi anahtarlama durumları ve akım yolları üzerinden oluşmakta; dolaşım akımı kayıpları ve akım harmoniklerini nasıl etkilemektedir?
```

Sonra:

```latex
T-tipi eviricinin düşük güç çalışma bölgesinde ters akım dolaşımı hangi anahtarlama durumları ve akım yolları üzerinden oluşmaktadır? Dolaşım akımı kayıpları ve akım harmoniklerini nasıl etkilemektedir?
```

Gerekçe: Noktalı virgülle bağlanmış iki soru ayrı soru cümlesi olarak yazıldı. AS1 numarası ve kapsamı değişmiyor.

### 1.3, giriş paragrafı (satır 51)

**A-23** · `bolumler/01-giris.tex:51` · *noktalı virgül*

Önce:

```latex
İlk iki katkı T-tipi faz kolu ölçeğinde, üçüncü katkı sistem ölçeğindedir; üç katkının ortak tabanı T-tipi topolojinin kendisidir.
```

Sonra:

```latex
İlk iki katkı T-tipi faz kolu ölçeğinde, üçüncü katkı sistem ölçeğindedir. Üç katkının ortak tabanı T-tipi topolojinin kendisidir.
```

Gerekçe: Bağımsız iki yargı iki cümleye ayrıldı.

### 1.3, katkı listesi (satır 54–56)

**A-24** · `bolumler/01-giris.tex:54` · *noktalı virgül*

Önce:

```latex
Katkı; çalışma kiplerinin analizi, klasik ve önerilen akım yollarının karşılaştırılması, deney özetine kalibre edilmiş benzetim ve prototip deney kayıtlarıyla değerlendirilmektedir.
```

Sonra:

```latex
Katkının değerlendirilmesinde çalışma kiplerinin analizi, klasik ve önerilen akım yollarının karşılaştırılması, deney özetine kalibre edilmiş benzetim ve prototip deney kayıtları kullanılmaktadır.
```

Gerekçe: Özneden sonraki noktalı virgül kalktı. Sıralama yüklemin önüne alındı.

**A-25** · `bolumler/01-giris.tex:55` · *terim / yazım-noktalama*

Önce:

```latex
Katkı, bağımsız bir kontrolcü olarak değil mevcut kapalı çevrime eklenen ileri besleme bileşeni olarak modellenmektedir.
```

Sonra:

```latex
Katkı, bağımsız bir denetleyici olarak değil, mevcut kapalı çevrime eklenen ileri besleme bileşeni olarak modellenmektedir.
```

Gerekçe: "denetleyici" tezin geri kalanıyla uyumlu. "değil" karşıtlığından sonra, bölümün diğer yerlerindeki gibi virgül konuldu.

**A-26** · `bolumler/01-giris.tex:55` · *uzun cümle (ve ... ve) / terim*

Önce:

```latex
Kararlılık analizi, terimin karakteristik denklemde yer almadığını ve akım çevriminin kazancını ve duyarlılık fonksiyonlarını değiştirmediğini göstermiştir.
```

Sonra:

```latex
Kararlılık analizi, terimin karakteristik denklemde yer almadığını göstermiştir. Terim, akım çevriminin açık çevrim kazancını ve duyarlılık fonksiyonlarını da değiştirmemektedir.
```

Gerekçe: Aynı cümledeki iki "ve" dizisi ayrıldı. Bölüm 5'teki tanıma uygun olarak ("açık çevrim kazancı $L$") "kazanç" yerine "açık çevrim kazancı" yazıldı.

**A-27** · `bolumler/01-giris.tex:56` · *noktalı virgül*

Önce:

```latex
Katkı; çalışma kipleri, anahtarlama durumları, enerji akış yolları ve güvenlik kısıtları üzerinden klasik ayrık mimariyle nitel olarak karşılaştırılmaktadır.
```

Sonra:

```latex
Katkı, klasik ayrık mimariyle çalışma kipleri, anahtarlama durumları, enerji akış yolları ve güvenlik kısıtları üzerinden nitel olarak karşılaştırılmaktadır.
```

Gerekçe: Özneden sonraki noktalı virgül virgüle çevrildi, öge sırası netleşti.

**A-28** · `bolumler/01-giris.tex:56` · *noktalı virgül*

Önce:

```latex
Donanımın evirici kipi düşük güç deneyleriyle, şarj yönünün işlevsel bütünlüğü benzetim kayıtlarıyla gösterilmiştir; şarj yönü donanım deneyi ve kip geçişinin sınanması yapılmadığından katkı, mimari öneri düzeyindedir.
```

Sonra:

```latex
Donanımın evirici kipi düşük güç deneyleriyle, şarj yönünün işlevsel bütünlüğü benzetim kayıtlarıyla gösterilmiştir. Şarj yönünde donanım deneyi yapılmadığından ve kip geçişi sınanmadığından katkı, mimari öneri düzeyindedir.
```

Gerekçe: İki cümleye bölündü. "şarj yönü donanım deneyi ... yapılmadığından" daha düzgün bir eylem yapısıyla yeniden kuruldu.

### 1.3, başlık–katkı eşlemesi (satır 59)

**A-29** · `bolumler/01-giris.tex:59` · *uzun cümle*

Önce:

```latex
``Enerji depolama sistemleri için geliştirilmiş T-tipi dönüştürücü mimarisi'' bileşeni GT-tipi mimariyi (katkı~3), ``düşük güç performansını iyileştiren anahtarlama'' bileşeni nötr anahtar susturma yöntemini (katkı~1), ``Sin\textsuperscript{3} tabanlı kompanzasyon'' bileşeni ise ileri besleme kompanzasyonunu (katkı~2) adlandırmaktadır.
```

Sonra:

```latex
``Enerji depolama sistemleri için geliştirilmiş T-tipi dönüştürücü mimarisi'' bileşeni GT-tipi mimariyi (katkı~3) adlandırmaktadır. ``Düşük güç performansını iyileştiren anahtarlama'' bileşeni nötr anahtar susturma yöntemine (katkı~1), ``Sin\textsuperscript{3} tabanlı kompanzasyon'' bileşeni ise ileri besleme kompanzasyonuna (katkı~2) karşılık gelmektedir.
```

Gerekçe: 37 kelimelik eşleme cümlesi ikiye bölündü. Alıntı yeni cümleyi başlattığı için ilk harfi büyük yazıldı.

### 1.3, katkı tablosu (satır 72–84) ve doğrulama altyapısı (satır 89)

**A-30** · `bolumler/01-giris.tex:72` · *noktalı virgül (tablo)*

Önce:

```latex
Kip ve akım yolu analizi, senkron-buck eşdeğeri; deneyin aktif ve reaktif gücüne kalibre edilmiş anahtarlamalı benzetim; deney özet kayıtları &
```

Sonra:

```latex
Kip ve akım yolu analizi ile senkron-buck eşdeğeri, deneyin aktif ve reaktif gücüne kalibre edilmiş anahtarlamalı benzetim, deney özet kayıtları &
```

Gerekçe: İlk öğedeki iç virgül "ile"ye dönünce öğeler virgülle ayrılabiliyor.

**A-31** · `bolumler/01-giris.tex:73` · *noktalı virgül (tablo) / terim*

Önce:

```latex
\SI{10}{\ampere}'de süreksiz iletim çevrimin büyük kısmını kaplar ve THD \%20 düzeyindedir; yöntem düşük güç yöntemidir. &
```

Sonra:

```latex
\SI{10}{\ampere}'de süreksiz iletim şebeke periyodunun büyük kısmını kaplar ve THD \%20 düzeyindedir. Dolayısıyla susturma, düşük güç bölgesine özgü bir yöntemdir. &
```

Gerekçe: Noktalı virgül yerine nokta ve bağlaç kullanıldı. Aynı tabloda "çevrim" akım denetim çevrimi anlamında da geçiyor. Burada şebeke periyodu kastedildiği için (Bölüm 5, 10 A maddesi) belirsizlik giderildi. "yöntem ... yöntemidir" tekrarı kalktı.

**A-32** · `bolumler/01-giris.tex:74` · *noktalı virgül (tablo)*

Önce:

```latex
Alt Bölüm~\ref{sec:s1-s2-kalibre}, Tablo~\ref{tab:kalibrasyon-karsilastirma}; Bölüm~\ref{chap:deney}; Tablo~\ref{tab:s4-tarama}. Mekanizma doğrulanmış; verim kazancı deney ve kalibre benzetimde aynı yönde \\
```

Sonra:

```latex
Alt Bölüm~\ref{sec:s1-s2-kalibre} ve Tablo~\ref{tab:kalibrasyon-karsilastirma}, Bölüm~\ref{chap:deney}, Tablo~\ref{tab:s4-tarama}. Mekanizma doğrulanmış, verim kazancı deney ve kalibre benzetimde aynı yönde \\
```

Gerekçe: Üç noktalı virgül vardı. İlk kaynak çifti "ve" ile bağlanınca kaynak listesi virgülle ayrılabiliyor. Telgraf üslubu korundu.

**A-33** · `bolumler/01-giris.tex:77` · *noktalı virgül (tablo)*

Önce:

```latex
Doğru özdeşlikle parçalı DCM--CCM katsayı taraması; kalibre S3 benzetimi; akım geri beslemeli S4 benzetimi; analitik, frekans alanı ve zaman alanı kararlılık analizi &
```

Sonra:

```latex
Doğru özdeşlikle parçalı DCM--CCM katsayı taraması, kalibre S3 benzetimi, akım geri beslemeli S4 benzetimi, kararlılık analizi (analitik, frekans alanı, zaman alanı) &
```

Gerekçe: Son öğenin iç virgülleri ayraç içine alındı. Böylece üç noktalı virgülün hepsi virgüle dönüyor.

**A-34** · `bolumler/01-giris.tex:78` · *noktalı virgül (tablo)*

Önce:

```latex
Susturma ile birlikte (S3) deneyde THD \%14, verim \%94,5; kalibre model THD'yi kalibre edilmeden \%14,8, verimi 0,25 puan içinde verir.
```

Sonra:

```latex
Susturma ile birlikte (S3) deneyde THD \%14, verim \%94,5'tir. Kalibre model THD'yi kalibre edilmeden \%14,8, verimi 0,25 puan içinde verir.
```

Gerekçe: İki ayrı bulgu iki cümleye ayrıldı.

**A-35** · `bolumler/01-giris.tex:78` · *noktalı virgül (tablo)*

Önce:

```latex
Sin\textsuperscript{3} terimi akım çevriminin dışında kaldığı için çevrimin kararlılığını değiştirmez; analog eşdeğer çevrimin kararlılık marjları yeterlidir
```

Sonra:

```latex
Sin\textsuperscript{3} terimi akım çevriminin dışında kaldığı için çevrimin kararlılığını değiştirmez. Analog eşdeğer çevrimin kararlılık marjları yeterlidir
```

Gerekçe: İki bağımsız yargı iki cümleye ayrıldı. Ardındaki ayraç içindeki marj değerleri değişmiyor.

**A-36** · `bolumler/01-giris.tex:79` · *noktalı virgül (tablo)*

Önce:

```latex
Düşük güçte deney ve benzetim; anma akımı ve kararlılık yalnız benzetim \\
```

Sonra:

```latex
Düşük güçte deney ve benzetim, anma akımı ve kararlılıkta yalnız benzetim \\
```

Gerekçe: Hücredeki ilk noktalı virgül (iç öğelerinde virgül bulunan kaynak listesi) kural 2'ye göre kalabilir. İkincisi virgüle çevrildi.

**A-37** · `bolumler/01-giris.tex:82` · *noktalı virgül (tablo)*

Önce:

```latex
İşlev paylaşım topolojisi, çalışma kipleri ve geçiş kısıtlarının tanımı; şarj zinciri benzetim kayıtları; evirici kipinde düşük güç deneyleri; klasik ayrık mimariyle nitel karşılaştırma &
```

Sonra:

```latex
Tanımlar (işlev paylaşım topolojisi, çalışma kipleri, geçiş kısıtları), şarj zinciri benzetim kayıtları, evirici kipinde düşük güç deneyleri, klasik ayrık mimariyle nitel karşılaştırma &
```

Gerekçe: İlk öğenin iç virgülleri ayraca alınınca üç noktalı virgül de virgüle dönüyor (2. satırla aynı düzen).

**A-38** · `bolumler/01-giris.tex:83` · *noktalı virgül (tablo) / yazım*

Önce:

```latex
Aynı T-tipi yarı iletken tabanı evirici, Vienna PFC ve aktif batarya yönetimi işlevlerinde kullanılabilir; güvenli kip geçişi PWM'in durdurulması, sıfıra yakın faz akımı, DA bara dengesi ve röle geri bildirimi koşuluna bağlıdır.
```

Sonra:

```latex
Aynı T-tipi yarı iletken tabanı evirici, Vienna PFC ve aktif batarya yönetimi işlevlerinde kullanılabilir. Güvenli kip geçişi PWM'nin durdurulması, sıfıra yakın faz akımı, DA bara dengesi ve röle geri bildirimi koşuluna bağlıdır.
```

Gerekçe: İki cümleye bölündü. TDK'ye göre kısaltmaya gelen ek okunuşa uyar: PWM "pe-ve-me" diye okunur, ek "PWM'nin" olur (Bölüm 4'te de "PWM'nin" var).

**A-39** · `bolumler/01-giris.tex:84` · *noktalı virgül (tablo)*

Önce:

```latex
Mimari öneri; evirici kipinde deney, şarj yönünde nitel benzetim kaydı \\
```

Sonra:

```latex
Mimari öneri düzeyi: evirici kipinde deney, şarj yönünde nitel benzetim kaydı \\
```

Gerekçe: Açıklama işlevli noktalı virgül iki noktaya çevrildi.

**A-40** · `bolumler/01-giris.tex:89` · *uzun cümle*

Önce:

```latex
Üç katkıyı destekleyen doğrulama altyapısı da tezde ayrıca raporlanmaktadır: benzetim modelleri tez tanımına göre denetlenmiş ve düzeltilmiş (Alt Bölüm~\ref{sec:model-dogrulama-duzeltme}), bütün parametreler kaynak ve tür bilgisiyle tek tabloda toplanmış (Tablo~\ref{tab:sistem-parametreleri}) ve modeller deney özetine kalibre edilmiştir (Alt Bölüm~\ref{sec:kalibrasyon}).
```

Sonra:

```latex
Üç katkıyı destekleyen doğrulama altyapısı da tezde ayrıca raporlanmaktadır. Benzetim modelleri tez tanımına göre denetlenmiş ve düzeltilmiştir (Alt Bölüm~\ref{sec:model-dogrulama-duzeltme}). Bütün parametreler kaynak ve tür bilgisiyle tek tabloda toplanmış (Tablo~\ref{tab:sistem-parametreleri}), modeller deney özetine kalibre edilmiştir (Alt Bölüm~\ref{sec:kalibrasyon}).
```

Gerekçe: İki noktadan sonra üç yan cümleyle süren 40 kelimelik yapı üç cümleye bölündü. Gönderme sırası korundu.

**A-41** · `bolumler/01-giris.tex:89` · *noktalı virgül*

Önce:

```latex
teknolojik yenilik bakımından tamamlayıcı çıktı niteliğindedir; bilimsel doğrulamanın yerine kullanılmamaktadır.
```

Sonra:

```latex
teknolojik yenilik bakımından tamamlayıcı çıktı niteliğindedir. Fikrî mülkiyet çıktıları, bilimsel doğrulamanın yerine kullanılmamaktadır.
```

Gerekçe: İki cümleye bölündü. Yeni cümlenin öznesi, Bölüm 8'deki tablo başlığıyla aynı terim ("fikrî mülkiyet çıktıları").

### 1.4, paragraf 1 (satır 94): kapsam

**A-42** · `bolumler/01-giris.tex:94` · *noktalı virgül*

Önce:

```latex
Prototip üç faz, dört telli yapıdadır ve nötr hattı DA bara orta noktasına bağlıdır; benzetim modelleri ve deney değerlendirmesi ise nötr dönüşü DA bara orta noktasına bağlanan tek faz kolu üzerinde yürütülmüştür.
```

Sonra:

```latex
Prototip üç faz, dört telli yapıdadır ve nötr hattı DA bara orta noktasına bağlıdır. Benzetim modelleri ve deney değerlendirmesi ise nötr dönüşü DA bara orta noktasına bağlanan tek faz kolu üzerinde yürütülmüştür.
```

Gerekçe: 32 kelime ve bir noktalı virgül vardı. "ise" karşıtlığı korunarak iki cümleye bölündü.

**A-43** · `bolumler/01-giris.tex:94` · *noktalı virgül*

Önce:

```latex
Sin\textsuperscript{3} terimi, şebeke geriliminden üretilen ileri besleme kompanzasyonu olarak ele alınmakta; bağımsız bir kapalı çevrim kontrol yasası veya genel amaçlı aktif harmonik filtre yöntemi olduğu iddia edilmemektedir.
```

Sonra:

```latex
Sin\textsuperscript{3} terimi, şebeke geriliminden üretilen bir ileri besleme kompanzasyonu olarak ele alınmaktadır. Terimin bağımsız bir kapalı çevrim kontrol yasası veya genel amaçlı aktif harmonik filtre yöntemi olduğu iddia edilmemektedir.
```

Gerekçe: "-makta;" bağlantısı iki cümleye ayrıldı.

### 1.4, paragraf 2 (satır 96): doğrulama sınırları

**A-44** · `bolumler/01-giris.tex:96` · *noktalı virgül*

Önce:

```latex
Doğrulama, dört senaryonun benzetim modelleri ve düşük güç noktasında yapılan deneylerle gerçekleştirilmiştir; anma gücünde geri beslemeli deney ve GT-tipi şarj yönü deneyi yapılmamıştır.
```

Sonra:

```latex
Doğrulama, dört senaryonun benzetim modelleri ve düşük güç noktasında yapılan deneylerle gerçekleştirilmiştir. Anma gücünde geri beslemeli deney ve GT-tipi şarj yönü deneyi yapılmamıştır.
```

Gerekçe: İki bağımsız yargı iki cümleye ayrıldı.

**A-45** · `bolumler/01-giris.tex:96` · *noktalı virgül*

Önce:

```latex
Sonuçlar; kullanılan DA bara gerilimi,
```

Sonra:

```latex
Sonuçlar kullanılan DA bara gerilimi,
```

Gerekçe: Özneden sonra noktalı virgül gerekmez. Sıralama nesne olarak doğrudan özneyi izliyor, cümlenin geri kalanı değişmiyor.

**A-46** · `bolumler/01-giris.tex:96` · *noktalı virgül*

Önce:

```latex
Deneyle doğrulanmamış çalışma bölgelerine ilişkin ifadeler genellenmemekte; benzetim ve deney sonuçları ayrı biçimde raporlanmaktadır.
```

Sonra:

```latex
Deneyle doğrulanmamış çalışma bölgelerine ilişkin ifadeler genellenmemektedir. Benzetim ve deney sonuçları ayrı ayrı raporlanmaktadır.
```

Gerekçe: İki cümleye bölündü. "ayrı biçimde" yerine daha yalın olan "ayrı ayrı" yazıldı.

**A-47** · `bolumler/01-giris.tex:96` · *noktalı virgül / uzun cümle / terim*

Önce:

```latex
Donanımın anma gücü değerleri tasarım hedefi olarak verilmektedir; şebeke gerilimi güvenlik amacıyla varyak üzerinden yaklaşık \SI{120}{\volt} RMS ile sınırlandırıldığından tam anma gücünde deney yapılmamış, nominal akım koşulu \SI{25}{\ampere} hedefli kapalı çevrim benzetimiyle incelenmiştir.
```

Sonra:

```latex
Donanımın anma gücü değerleri tasarım hedefi olarak verilmektedir. Şebeke gerilimi güvenlik amacıyla varyak üzerinden yaklaşık \SI{120}{\volt} RMS ile sınırlandırıldığından tam anma gücünde deney yapılmamıştır. Anma akımı koşulu, \SI{25}{\ampere} hedefli kapalı çevrim benzetimiyle incelenmiştir.
```

Gerekçe: 33 kelime ve bir noktalı virgül vardı, üç cümleye bölündü. "nominal akım" yerine tezde yerleşik olan "anma akımı" yazıldı.

**A-48** · `bolumler/01-giris.tex:96` · *uzun cümle / anlam açıklığı*

Önce:

```latex
GT-tipi mimarinin maliyet, hacim ve eleman sayısı bakımından sağladığı yararlar, ayrıntılı yaşam döngüsü maliyeti veya seri üretim güvenilirlik çalışması yapılmadığı durumlarda ``potansiyel'' olarak ifade edilmektedir.
```

Sonra:

```latex
GT-tipi mimarinin maliyet, hacim ve eleman sayısı bakımından sağladığı yararlar ``potansiyel'' olarak ifade edilmektedir. Ayrıntılı yaşam döngüsü maliyeti veya seri üretim güvenilirlik çalışması yapılmamıştır.
```

Gerekçe: "yapılmadığı durumlarda" bir koşul gibi okunuyor. Oysa Tablo 1.1 ("sayısal olarak gösterilmemiştir") ve Bölüm 8, söz edilen çalışmaların tezde hiç yapılmadığını söylüyor. Yazarın amacı koşul bildirmekse öneriyi uygulamayın.

### 1.5, şekil başlığı (satır 152)

**A-49** · `bolumler/01-giris.tex:152` · *noktalı virgül (caption)*

Önce:

```latex
yeniden görevlendirilmesine dayanır; yeşil kutular kanıt katmanlarını gösterir.}
```

Sonra:

```latex
yeniden görevlendirilmesine dayanır. Yeşil kutular kanıt katmanlarını gösterir.}
```

Gerekçe: Başlık metninde iki ayrı yargı vardı, iki cümleye ayrıldı. Kısa başlık (\caption[...]) değişmiyor.

### 1.5, paragraf 1 (satır 154): Bölüm 1–3

**A-50** · `bolumler/01-giris.tex:154` · *noktalı virgül*

Önce:

```latex
Birinci bölümde araştırma problemi kurulmuş; amaç, araştırma soruları, katkılar ve sınırlar tanımlanmıştır.
```

Sonra:

```latex
Birinci bölümde araştırma problemi kurulmuş, ardından amaç, araştırma soruları, katkılar ve sınırlar tanımlanmıştır.
```

Gerekçe: Noktalı virgül yerine "ardından" ile sıralı bağ kuruldu.

**A-51** · `bolumler/01-giris.tex:154` · *uzun cümle (ve ... ve)*

Önce:

```latex
İkinci bölümde EDS güç dönüşüm mimarileri, T-tipi eviriciler, düşük güç verimi ve harmonik bozulma, akım kontrolü ve ileri besleme yaklaşımları incelenerek araştırma boşluğu belirlenmektedir.
```

Sonra:

```latex
İkinci bölüm EDS güç dönüşüm mimarilerini, T-tipi eviricileri, düşük güç verimini, harmonik bozulmayı, akım kontrolünü ve ileri besleme yaklaşımlarını inceleyerek araştırma boşluğunu belirlemektedir.
```

Gerekçe: Sıralamada üç "ve" vardı, teke indi. Öğeler virgülle ayrıldı.

**A-52** · `bolumler/01-giris.tex:154` · *uzun cümle*

Önce:

```latex
Üçüncü bölüm, sonraki bütün bölümlerin ortak tabanı olan sistem mimarisini, T-tipi çalışma kiplerini, LCL filtre ve şebeke modelini, kontrol yapısını, elektriksel parametreleri, doğrulama yöntemini ve benzetim modelinin doğrulanmasını sunmaktadır.
```

Sonra:

```latex
Üçüncü bölüm, sonraki bütün bölümlerin ortak tabanını oluşturur. Bölümde sistem mimarisi, T-tipi çalışma kipleri, LCL filtre ve şebeke modeli, kontrol yapısı, elektriksel parametreler, doğrulama yöntemi ve benzetim modelinin doğrulanması sunulmaktadır.
```

Gerekçe: 30 kelimelik, uzun sıfat tamlamalı cümle ikiye bölündü.

### 1.5, paragraf 2 (satır 156): Bölüm 4–6

**A-53** · `bolumler/01-giris.tex:156` · *noktalı virgül*

Önce:

```latex
Beşinci bölüm Sin\textsuperscript{3} tabanlı ileri besleme kompanzasyonunu matematiksel olarak tanımlamakta; akım geri beslemeli kapalı çevrim modelini, düşük, orta ve anma akımı başarımını ve kararlılık incelemesini vermektedir (katkı~2).
```

Sonra:

```latex
Beşinci bölüm Sin\textsuperscript{3} tabanlı ileri besleme kompanzasyonunu matematiksel olarak tanımlamaktadır. Bölümde akım geri beslemeli kapalı çevrim modeli ile kararlılık incelemesi de verilmekte, başarım düşük, orta ve anma akımında değerlendirilmektedir (katkı~2).
```

Gerekçe: İki cümleye bölündü. "düşük, orta ve anma akımı başarımını ve kararlılık" dizisindeki iç içe virgül ve "ve" çözüldü.

**A-54** · `bolumler/01-giris.tex:156` · *noktalı virgül*

Önce:

```latex
benzetim modelini deney özetine kalibre etmektedir; tam anma gücünde deney bulunmadığını sınırlılık olarak belirtmektedir.
```

Sonra:

```latex
benzetim modelini deney özetine kalibre etmektedir. Bölüm, tam anma gücünde deney bulunmadığını sınırlılık olarak belirtmektedir.
```

Gerekçe: İki cümleye bölündü. Özne ad tekrarıyla ("Bölüm") kuruldu.

### 1.5, paragraf 3 (satır 158): Bölüm 7–8

**A-55** · `bolumler/01-giris.tex:158` · *noktalı virgül / yazım*

Önce:

```latex
Deney düzeneği GT-tipi olarak kurulmuştur; Bölüm~\ref{chap:deney}'daki deneyler donanımın evirici kipine, Yedinci bölümdeki şarj zinciri benzetim kayıtları ise şarj yönüne aittir.
```

Sonra:

```latex
Deney düzeneği GT-tipi olarak kurulmuştur. Bölüm~\ref{chap:deney}'daki deneyler donanımın evirici kipine, yedinci bölümdeki şarj zinciri benzetim kayıtları ise şarj yönüne aittir.
```

Gerekçe: İki cümleye bölündü. Cümle ortasındaki "Yedinci" küçük harfle yazılmalı (TDK, sıra sayısı özel ad değil).

### Değişiklik önerilmeyen paragraflar ve öğeler

- **Satır 31–35 ve 37 (amaç listesi):** öğeler virgülle bitiyor, liste "amaçlanmıştır." yüklemiyle biten tek bir cümle oluşturuyor. Öğelerin her biri 30 kelimenin altında. A-21 yalnız giriş cümlesini ve "doğrultusunda;" sonundaki noktalı virgülü düzeltiyor. Liste yapısı tek cümle olarak 70 kelimeyi aşıyor. Okunurluk yeterli bulunursa olduğu gibi kalabilir. İstenirse giriş "Genel amaç doğrultusunda aşağıdaki hedefler belirlenmiştir:" diye kurulup öğeler mastar cümlesi olarak bırakılabilir ve satır 37'deki "amaçlanmıştır." silinebilir. Bu seçenek isteğe bağlı olduğu için öneri setine konmadı.
- **Satır 39 ve AS2–AS4 (satır 43–45):** soru cümleleri kısa ve tek yargılı. Noktalı virgül yok.
- **Satır 63 (tablo başlığı):** noktalı virgül yok, 30 kelimenin altında.
- **Satır 101 (Tezin Düzeni girişi):** iki kısa cümle, sorun yok.
- **Satır 7, 9, 59, 94, 101 ve 158'deki öteki cümleler:** 25 kelimenin altında, sorun yok.

## 3. Teknik notlar (sadeleştirmeden bağımsız)

Aşağıdaki önerilerin bir kısmı içeriği değiştiriyor ya da içeriğe bir şey ekliyor. Bu yüzden A-xx setine **konmadı**, otomatik uygulanmamalı. Her birini tez sahibi onaylamalı. "Önce" metni, belirtildiği yerde ilgili A-önerisi uygulandıktan sonraki metindir.

**T-1 · satır 15 · senkron alçaltıcı eşdeğerini oluşturan anahtarlar (teknik anlam).**
Metin, senkron alçaltıcı davranışını yalnız "sıfır gerilim durumunu oluşturan nötr anahtarlara" bağlıyor. Bölüm 4 (satır 108) şöyle diyor: "her yarım periyot, iki yönlü iletebilen alt ve üst anahtardan oluşan senkron alçaltıcıya karşılık gelir". Pozitif yarım periyotta $P$–$O$ durumları arasında dış anahtar ve nötr anahtar birlikte senkron alçaltıcı hücresini oluşturuyor. Tek başına nötr anahtar bir alçaltıcı değil, onun serbest dolaşım anahtarı. Jüri bu noktaya takılabilir. Önerilen düzeltme (A-xx ile çakışmıyor):

```latex
Çıkış akımının küçük olduğu bölgelerde T-tipi faz kolunun dış anahtarı ile sıfır gerilim durumunu oluşturan nötr anahtarlar, akımın işaret değiştirmesine izin veren senkron bir alçaltıcı dönüştürücü (synchronous buck) gibi davranabilir.
```
Önce: `Çıkış akımının küçük olduğu bölgelerde T-tipi faz kolunun sıfır gerilim durumunu oluşturan nötr anahtarları, akımın işaret değiştirmesine izin veren senkron bir alçaltıcı dönüştürücü (synchronous buck) davranışı gösterebilir.`

**T-2 · satır 13 · çok seviyeli topolojide gerilim zorlanması (kontrol edilmeli).**
"çok seviyeli topolojiler ... yarı iletken gerilim zorlanmasını ve anahtarlama dalgalanmasını azaltabilmektedir" genel olarak doğru. Ancak cümle hemen T-tipine bağlanıyor ve T-tipi yapıda **dış anahtarlar DA bara geriliminin tamamını** bloke ediyor. Yarı gerilim zorlanmasını yalnız nötr kol görüyor (NPC'den farklı olarak). "anahtarlama dalgalanması" da belirsiz bir ifade: akım dalgalanmasından mı, gerilim basamağından mı söz edildiği belli değil. Öneri (A-xx ile çakışmıyor):

```latex
İki seviyeli eviricilere alternatif olan çok seviyeli topolojiler, çıkış gerilimini daha fazla seviyede oluşturarak anahtarlama anındaki gerilim basamağını ve endüktör akım dalgalanmasını azaltabilmektedir.
```
Önce: `İki seviyeli eviricilere alternatif olan çok seviyeli topolojiler, çıkış gerilimini daha fazla seviyede oluşturarak yarı iletken gerilim zorlanmasını ve anahtarlama dalgalanmasını azaltabilmektedir.`
İstenirse Bölüm 2 ya da 3'te T-tipindeki dış anahtar ve nötr anahtar gerilim zorlanmaları ayrıca belirtilebilir.

**T-3 · satır 26, 55, 78 · Sin³ teriminin kararlılığı "değiştirmediği" iddiasının koşulu (kontrol edilmeli).**
Bölüm 5 (satır 377) analizini açıkça şu varsayıma dayandırıyor: "$\theta$ yalnız zamana bağlıdır ve şebekeye kilitlidir". Bu varsayım sert şebekeye ve ideal (ya da çevrim dinamiğinden ayrık) bir faz kilitlemeye karşılık geliyor. Zayıf şebekede PCC gerilimi akıma bağlı bir bileşen taşır. Faz açısı PLL ile bu gerilimden elde ediliyorsa, ileri besleme yolu dolaylı bir geri besleme yoluna dönüşebilir. Satır 19 tam olarak bu etkileşimi kaynak gösteriyor (\citep{Lu2016,Wang2024}). Satır 26 (sav) ve satır 55 ise iddiayı koşulsuz veriyor. Jüri, savdaki "kararlılığını değiştirmeyen" ifadesini satır 19 ile çelişkili bulabilir. Savın kendisine dokunmadan katkı cümlesine koşul eklemek yeterli olur (A-26 uygulandıktan sonraki metin):

```latex
Kararlılık analizi, şebekeye kilitli faz açısı varsayımı altında terimin karakteristik denklemde yer almadığını göstermiştir.
```
Önce (A-26 sonrası): `Kararlılık analizi, terimin karakteristik denklemde yer almadığını göstermiştir.`
Savda da "kabul edilen şebeke modelinde" gibi bir niteleme düşünülebilir. Sav cümlesi tez sahibinin ana iddiası olduğu için burada öneri olarak bırakıldı.

**T-4 · tablo, satır 73 · 10 A bulgusunun kaynağı (kontrol edilmeli).**
"\SI{10}{\ampere}'de ... THD \%20 düzeyindedir" bulgusu Bölüm 5'teki S4 kapalı çevrim benzetiminden geliyor (Bölüm 5, satır 299: "10 A: sınır dışı. THD yaklaşık %20"). S4'te Sin³ ve PI denetleyici de etkin. Katkı 1 satırında kaynak belirtilmeden durduğu için deney bulgusu ya da yalnız susturmanın (S2) sonucu gibi okunabilir. Öneri (A-31 uygulandıktan sonraki metin):

```latex
S4 benzetiminde \SI{10}{\ampere}'de süreksiz iletim şebeke periyodunun büyük kısmını kaplar ve THD \%20 düzeyindedir.
```
Önce (A-31 sonrası): `\SI{10}{\ampere}'de süreksiz iletim şebeke periyodunun büyük kısmını kaplar ve THD \%20 düzeyindedir.`

**T-5 · satır 11 · kısmi yükte "sabit" kayıplar (kontrol edilmeli).**
"sabit sürme, anahtarlama ve manyetik eleman kayıpları" ifadesi anahtarlama kayıplarını da sabit sayıyor. Oysa sert anahtarlamada geçiş kayıpları büyük ölçüde akımla orantılı. Yükten bağımsız kısım sürme kayıpları, çıkış kapasitesi ($C_{oss}$) ve ters toparlanma payı ile gerilimin belirlediği çekirdek kayıpları. Kısmi yükte verimin düşmesinin nedeni bu yükten bağımsız kayıp payı. Öneri (A-06 uygulandıktan sonraki metin):

```latex
Kısmi yükte sürme kayıpları, kapasitif anahtarlama kayıpları ve manyetik çekirdek kayıpları gibi yükten büyük ölçüde bağımsız kayıpların aktarılan güce oranı büyür.
```
Önce (A-06 sonrası): `Kısmi yükte sabit sürme, anahtarlama ve manyetik eleman kayıplarının aktarılan güce oranı büyür.`

**T-6 · satır 94 · "anahtarlama durumları" bir performans ölçütü değil (teknik anlam).**
"anahtarlama durumları, ters akım, dönüştürücü verimi, şebeke akımı THD'si ve üçüncü harmonik temel performans ölçütleridir" cümlesinde anahtarlama durumları ve ters akım, incelenen mekanizmanın parçaları. Ölçüt değiller. Öneri (A-xx ile çakışmıyor):

```latex
Düşük güç incelemesinde anahtarlama durumları ile ters akım mekanizması çözümlenmektedir. Temel performans ölçütleri dönüştürücü verimi, şebeke akımı THD'si ve üçüncü harmoniktir.
```
Önce: `Düşük güç incelemesinde anahtarlama durumları, ters akım, dönüştürücü verimi, şebeke akımı THD'si ve üçüncü harmonik temel performans ölçütleridir.`

**T-7 · satır 26 · literatür cümlesinde kapsam (kontrol edilmeli).**
"Literatürde T-tipi eviricinin yüksek güç yoğunluğu, şebeke kontrolü, hafif yük dönüştürücü kipleri ve ileri besleme yolları ayrı ayrı incelenmiştir \citep{Blaabjerg2006,Wang2020,Chen2010,Lu2016}." Tamlayan "T-tipi eviricinin" dört öğenin hepsine bağlanıyor. Oysa Chen2010 senkron alçaltıcı dönüştürücüler üzerine (satır 15'te öyle kaynak gösteriliyor), Blaabjerg2006 ve Lu2016 ise genel şebeke dönüştürücüleri üzerine görünüyor. Kaynak içerikleri denetlenmeli. Gerekirse şöyle yazılabilir:

```latex
Literatürde T-tipi eviricinin yüksek güç yoğunluğu, şebekeye bağlı dönüştürücülerin kontrolü, dönüştürücülerin hafif yük kipleri ve ileri besleme yolları ayrı ayrı incelenmiştir \citep{Blaabjerg2006,Wang2020,Chen2010,Lu2016}.
```

**T-8 · satır 56, 83, 140 · "aynı yarı iletkenler" ve ek PFC diyotları (kontrol edilmeli).**
GT-tipi mimari "aynı yarı iletkenlerin farklı görevlerle kullanılması" diye tanıtılıyor. Ancak Bölüm 3 (Şekil başlığı, satır 90) ve Bölüm 7 (satır 69), Vienna PFC kipinde ayrı $D_1$–$D_2$ PFC yükseltici diyotlarının ve $RL1$–$RL2$ kip rölelerinin kullanıldığını gösteriyor. Jüri "aynı yarı iletkenler" ifadesini eleman sayısıyla karşılaştırabilir. Katkı 3 tanımında "T-tipi anahtarlarının yeniden görevlendirilmesi (ek PFC diyotları ve kip röleleriyle)" türünden bir açıklama düşünülebilir. Tablo satır 83 zaten "Kayıp, maliyet ve hacim üstünlüğü sayısal olarak gösterilmemiştir" diyor, bu yüzden iddianın gücü sınırlı. Yalnız eleman tanımının netleşmesi öneriliyor.

**T-9 · satır 13 ve 15 · terim notu.** "senkron alçaltıcı dönüştürücü (synchronous buck)" (metin) ile "senkron-buck eşdeğeri" (tablo, Bölüm 3–4) birlikte kullanılıyor. Tezin genelinde iki biçim de var. Tablo sıkışık olduğu için kısa biçimin orada kalması uygun.

**T-10 · terim ve yazım notları (öteki bölümler için).**
- Bölüm 1'de "kontrol" 10, "denetim/denetleyici" 2 kez geçiyor. Bölüm 3'te "denetim" 36, Bölüm 5'te "denetleyici" 35 kez kullanılıyor. A-14 ve A-25 yalnız "kontrolcü" ve "kontrol döngüsü" biçimlerini değiştiriyor. "akım kontrolü", "kontrol yapısı" gibi kalıplar Bölüm 2 ile uyumlu olduğu için bırakıldı. Tez genelinde tek bir karar verilmesi önerilir.
- "PWM'in" Bölüm 7'de 3, Bölüm 8'de 1 kez daha geçiyor. TDK okunuşuna göre ("pe-ve-me") doğrusu "PWM'nin" (Bölüm 4 böyle yazıyor).
- `Bölüm~\ref{chap:deney}'daki` (satır 158): ek, bölüm numarasının (6) okunuşuna göre doğru. Bölüm sırası değişirse ek elle güncellenmeli.

**T-11 · LaTeX notu (satır 154).** "Birinci bölümde ..." paragrafı `\end{figure}` ile aynı satırda başlıyor. Arada boş satır olmadığı için LaTeX metni şekilden önceki paragrafın devamı sayıyor ve ilk satır girintisiz basılabilir. `\end{figure}`dan sonra boş satır bırakmak yeterli. Metne dokunulmadığı için A-setine konmadı.

**Teknik açıdan doğrulanan noktalar.** Özdeşlik $\sin^3\theta=[3\sin\theta-\sin3\theta]/4$ doğru (satır 19). Gerilim seviyeleri $\pm V_{\mathrm{dc}}/2$ ve $0$, Bölüm 3'teki $V_{\mathrm{dc}}$ tanımıyla uyumlu. Deney sayıları Bölüm 6 ve 8 ile tutarlı: S1 %92,5 / THD %15; S2 %94,2 / %47; S3 %94,5 / %14. Faz marjı $54^{\circ}$ ve kazanç marjı 35 dB Bölüm 5 tablosuna gönderme yapıyor. Yüzde ve birimlere gelen ekler (%15'ten, %47'ye, %94,5'e, 25 A'i, 10 A'de) TDK'ye uygun.

## 4. Öneriler uygulandığında beklenen sayılar

| Ölçüt | Şimdi | A-01–A-55 sonrası | Not |
|---|---|---|---|
| Noktalı virgül (TikZ hariç) | 46 | **1** | Satır 79, kaynak listesi hücresi (kural 2'ye göre kalabilir) |
| Paragraf başına noktalı virgül | en çok 4 (satır 96) | en çok 1 (tablo satır 2) | Düz metin paragraflarında 0 |
| 30 kelimeyi aşan cümle | 14 | **0** | Amaç listesi (satır 28–37) yapı olarak tek cümle, ayrı not |
| 25 kelimeyi aşan cümle | 29 | 5 | En uzunu 28 kelime |
| Ortalama cümle uzunluğu | 19,9 | 14,7 | Aynı yöntemle |
| Cümle sayısı | 121 | 166 | |
| Yasak gösterme sözcüğü | 1 ("şudur") | **0** | |
| `\cite` / `\ref` / `\label` | 11 / 28 / 8 | 11 / 28 / 8 | `$`, `\SI`, `~` sayıları da aynı |

T-1 – T-8 önerileri de uygulanırsa noktalı virgül ve uzun cümle sayıları değişmez, T-6 bir cümle ekler.

### Yasak sözcük taraması

55 "Sonra" metninin tamamı ve önerilerin uygulandığı dosya kopyası aşağıdaki listeye karşı büyük/küçük harf duyarsız, tam sözcük olarak tarandı: bu, bunun, buna, bunu, bunlar\*, bundan, bunda, bununla, böyle, böylece, şu\* (şudur, şunu, şunlar dahil), "o" (tek başına), söz konusu, adı geçen. Ek olarak burada/bura\*, öyle ve şöyle de tarandı. **Sonuç: 0 eşleşme.** Cümleler arasındaki bağ ad tekrarıyla ("Yöntem ...", "Susturma ...", "Terim ...", "Bölüm ...", "İki konu ...", "Dört konu ...") ya da bağlaçla ("Ancak", "Dolayısıyla", "ayrıca", "ardından") kuruldu. Teknik notlardaki (T-1 – T-8) önerilen metinler de aynı taramadan geçti, eşleşme yok.
