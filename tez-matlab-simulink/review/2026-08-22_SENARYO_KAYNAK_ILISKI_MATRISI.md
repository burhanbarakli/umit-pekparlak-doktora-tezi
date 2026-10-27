# Senaryo kaynak ilişki matrisi

Tarih: 2026-08-22  
Durum: Kaynaklar arşivlendi ve eşlendi; etkin model değiştirilmedi.  
Kapsam: `Inverter2.slx`, `değerler.xlsx`, `simulasyon_duzeltmeleri.docx`,
üç veri sayfası ve dört Simscape parametre ekranı.

## 1. Ana sonuç

`Inverter2.slx`, Senaryo 1'in çalışma noktasına açıkça karşılık gelen
tek fazlı T-tipi Simscape modelidir. Modelde `Vdc=431,5 V`, şebeke kaynağı
`169,4 V tepe` (yaklaşık `119,8 V RMS`), `50 Hz`, `10 kHz PWM`, sürekli
çözücü, 50 Hz RMS/THD ölçüm blokları ve 25 °C sıcaklık kaynakları
bulunmaktadır. Bunlar Excel'deki Senaryo 1 satırıyla doğrudan eşleşir.

Ancak cihaz veri sayfası parametrelerinin son hâliyle hazırlanmış bazı
IGBT blokları etkin devreye bağlı değildir. Bağlı anahtarların bir kısmı
geçici veya farklı parametre taşımaktadır. Bu nedenle model için şu anda
doğru ifade şudur:

> Senaryo 1 topolojisi ve ölçüm zinciri hazırdır; nihai yarı iletken
> parametrelerinin etkin anahtarlara eksiksiz uygulandığı henüz doğrulanmamıştır.

Excel dosyasında zaman damgalı ham kayıt veya dalga şekli yoktur. Dosya,
Senaryo 1-3 için toplu ölçüm/sonuç özetidir. “Gerçek uygulama” ve
“Simülasyon” bölümlerindeki temel sayılar birebir aynı girildiğinden, bu
tablo tek başına bağımsız model doğrulaması sayılamaz.

## 2. Kaynakların rolü

| Kaynak | Kanıt rolü | Bağlandığı konu |
|---|---|---|
| `models/Inverter2_senaryo1_2026-08-16.slx` | Çalışan/uyarlanmış Simscape model | Senaryo 1 topolojisi, kapılama, kayıp ve ölçüm zinciri |
| `measurements/degerler_senaryo_ozeti_2026-08-17.xlsx` | Özet sonuç ve kalibrasyon tablosu | Senaryo 1-3 Vdc, Idc, VAC, akım, güç, THD ve verim |
| `parameters/simulasyon_duzeltmeleri_2026-08-16.docx` | Modelleme protokolü | Sürekli çözücü, ideal anahtarlamayı kapatma, thermal port, 25 °C ve cihaz verileri |
| `datasheets/DSEI2x61_12B-3311080.pdf` | Birincil cihaz kaynağı | D1-D2 hızlı diyotlar |
| `datasheets/IXYN100N65C3H1_Datasheet.pdf` | Birincil cihaz kaynağı | S3-S4 nötr IGBT'leri ve ters paralel diyotları |
| `datasheets/SKM100GB12T4.pdf` | Birincil cihaz kaynağı | S1-S2 ana kol IGBT modülü ve dahili diyotları |
| `parameters/screenshots/*.jpg` | Simscape'e girilmesi amaçlanan değerlerin ekran kanıtı | Veri sayfasından modele geçiş |
| `schematics/tam_topoloji_2026-08-22.pdf` | Sistem seviyesinde bağlantı kanıtı | Üç tekrarlı güç hücresi ve gerçek parça numaraları |

## 3. Senaryo eşlemesi

| Senaryo | E-posta tanımı | Excel sonucu | Mevcut model durumu |
|---|---|---|---|
| 1 | Komplement anahtarlamalı T-tipi | THD %15, verim %92,5 | `Inverter2.slx` bu senaryoya ait; Vdc ve şebeke çalışma noktası Excel'le eşleşiyor |
| 2 | Nötr IGBT'lerde komplement iptal; alternans boyunca 1/0 | THD %47, verim %94,2 | Ayrı `.slx` veya etkin varyant yok; kapı mantığı henüz uygulanacak |
| 3 | Senaryo 2 + `K1*sin(x)+K3*sin^3(x)` | THD %14, verim %94,5 | Ayrı `.slx`, K1/K3 ve enjeksiyon noktası yok; uygulanacak |
| 4 | İleri besleme + PI, L1 akım geri beslemesi, yaklaşık 30 A | Excel satırı boş | Model ve sonuç henüz yok |

## 4. Excel sonuçları ve aritmetik kontrol

### 4.1 Gerçek uygulama başlığı altındaki değerler

| Senaryo | Vdc (V) | Idc (A) | VAC RMS (V) | Ifaz (A) | Po (W) | cosφ | THD (%) | Verim (%) |
|---|---:|---:|---:|---:|---:|---:|---:|---:|
| 1 | 431,5 | 0,624 | 119,8 | 2,26 | 249,6 | 1,000 | 15 | 92,5 |
| 2 | 395,0 | 0,684 | 121,0 | 2,33 | 253,2 | -0,995 | 47 | 94,2 |
| 3 | 427,5 | 0,697 | 124,3 | 2,31 | 281,2 | -0,997 | 14 | 94,5 |

Excel'in “Simülasyon sonuçları” bölümünde Vdc, Idc, VAC RMS, Ifaz,
Po, cosφ, THD ve verim değerleri bu satırlarla aynıdır. Değerlerin çoğu
formül değil sabit sayıdır.

Basit `Po/(Vdc*Idc)` kontrolü:

| Senaryo | Vdc·Idc (W) | Yeniden hesaplanan verim (%) | Excel'den fark (yüzde puan) |
|---|---:|---:|---:|
| 1 | 269,2560 | 92,6999 | +0,1999 |
| 2 | 270,1800 | 93,7153 | -0,4847 |
| 3 | 297,9675 | 94,3727 | -0,1273 |

Bu farklar büyük değildir; fakat verim hücreleri formül yerine sabit
girildiği için verim tanımı, ortalama penceresi ve işaret kuralları açıkça
yazılmalıdır. Senaryo 2-3'te negatif `cosφ` ile pozitif aktif güç birlikte
bulunduğundan işaret/yön konvansiyonu da tanımlanmalıdır.

### 4.2 Excel'deki birim ve eksik alanlar

- `120 V RMS * sqrt(2) = 169,706 V`; e-postadaki `Vrms=169 V` ifadesi fiilen
  tepe değeri gibi kullanılmıştır.
- Gerçek uygulama tablosunda `LL [H]` için Senaryo 1-2'de `0,0002 H`,
  Senaryo 3'te `100` bulunuyor; Senaryo 3 birimi bu başlık altında hatalıdır.
- Simülasyon tablosunda `LL [uH]=100` yazıyor. Bu satır gerçek uygulama
  parametresi değildir ve özet sonuçların sabit tekrarlandığı bölümde yer alır.
  2026-08-26 ayrıştırmasında e-posta ile gerçek uygulama S1-S2 satırlarında
  tekrarlanan `L2=200 µH` nihai değer seçilmiştir; modeldeki `CL1=400 µH`
  eski ayar, şemadaki `L2=600 µH` ise B fazı bobin etiketidir.
- Senaryo 3 için `Vout` ve bazı yük alanları boş; Senaryo 4 tamamen boş.

## 5. `Inverter2.slx` ile Senaryo 1 ilişkisi

### 5.1 Doğrudan eşleşen noktalar

| Model alanı | `Inverter2.slx` | Excel Senaryo 1 |
|---|---:|---:|
| DA kaynak | 431,5 V | 431,5 V |
| Şebeke | 169,4 V tepe, 50 Hz | 119,8 V RMS (yaklaşık 169,4 V tepe) |
| PWM | 10 kHz | Excel'de yok; e-posta/planla uyumlu |
| Benzetim | 0-0,1 s, `ode15s`, azami adım `1e-7 s` | Excel'de yok |
| Powergui | Continuous | Word belgesindeki 1. maddeyle uyumlu |
| RMS/THD | True RMS, 50 Hz; THD 50 Hz | Excel RMS ve THD sütunları |
| Sıcaklık | Bağlı thermal-port elemanlarda 25 °C kaynaklar | Word belgesindeki 4. maddeyle uyumlu |
| Model ekranları | Vdc, Idc, AC aktif/reaktif güç, RMS, THD, cosφ, verim | Excel sütunlarıyla doğrudan aynı metrik ailesi |

Model, MathWorks `Solar Power Inverter` örneğinden uyarlanmıştır. Dosya
R2023b olarak kaydedilmiş; ön yükleme ve kapatma kodunda `irradiance`,
`v_dc_ref`, `v_ac_nom` ve `SolarPowerInverter` gibi eski örnek kalıntıları
vardır. Bunlar kullanılan tez parametrelerinden ayrıştırılmalı veya
temizlenmelidir.

### 5.2 Pasif elemanlarda kaynak farkları

| Eleman | E-posta | `Inverter2.slx` | Durum |
|---|---:|---:|---|
| L1 | 600 µH, 0,02 Ω | 600 µH, 0,1 Ω | Endüktans uyumlu, direnç 5 kat farklı |
| L2 / çıkış bobini | 200 µH, 0,02 Ω | `CL1=400 µH, 0,2 Ω` | 2026-08-26: 200 µH nihai; 400 µH eski model ayarı |
| C | 8 µF, 0,01 Ω | 8 µF, `1e-6 Ω` | Kapasite uyumlu, seri direnç uyumsuz |

## 6. Yarı iletken kanıt zinciri

### 6.1 D1-D2: DSEI2x61-12B

Veri sayfası, 150 °C kayıp hesabı için `VF0=1,58 V` ve `rF=8,5 mΩ`;
`CJ=31 pF`; 25 °C'de `IRM=13 A`, `trr=190 ns`; 100 °C'de
`IRM=20 A`, `trr=380 ns` vermektedir. Simscape ekranı ise
`Vf=1,35 V`, `Ron=8,5 mΩ`, `CJ=31 pF`, `iRM=-13 A`, `iF=60 A`,
`di/dt=-300 A/µs`, `trr=380 ns` kullanıyor. Bu seçim 25, 100 ve 150 °C
koşullarını tek blokta karıştırıyor.

Modelde bağlı `Diode7` ekranla eşleşiyor. Aynı çiftteki bağlı `Diode6`
ise `iRM=-3 A` taşıyor; iki DSEI diyodu henüz birebir aynı değil.

Excel'de DSEI için `V0=1,58 V`, `R0=0,0066 Ω` bulunuyor. `V0` veri
sayfasıyla uyumlu, `R0` ise veri sayfasındaki 8,5 mΩ'dan farklı bir doğrusal
uydurmadır; hangi akım/sıcaklık aralığında türetildiği kaydedilmelidir.

### 6.2 S1-S2: SKM100GB12T4

Veri sayfasında `RGint=7,5 Ω`; 100 A için tipik `VCE(sat)` değerleri
25/150 °C'de 1,8/2,2 V'dur. `td(on)=165 ns`, `tr=47 ns`,
`td(off)=400 ns`, `tf=75 ns`, `Eon=15 mJ`, `Eoff=10,2 mJ` tablosu
150 °C ve `RGon=RGoff=1 Ω` test koşuluna aittir.

Word belgesi gerçek sürücüyle toplam kapı direncinin S1-S2 için 10 Ω
alındığını söylüyor. Buna karşın ekran/modeldeki zaman ve enerji
uçları veri sayfasının 1 Ω tablosuyla aynıdır. 10 Ω için Şekil 4
eğrilerinden yeniden örnekleme yapılması gerekir.

`N-Channel IGBT1` bloğu SKM'e yakın parametre taşır, fakat devreye bağlı
değildir. Bağlı dış anahtarlar `N-Channel IGBT` ve `N-Channel IGBT4`
adlarıyla genel 0-600 A tabloları kullanmaktadır. SKM parametreleri etkin
S1-S2'ye henüz geçmemiştir.

SKM'in dahili ters diyotları için veri sayfasında `VF0=1,3/0,9 V` ve
`rF=9/12,5 mΩ` (25/150 °C), 150 °C'de `IRRM=54 A`, `Qrr=15,7 µC`
veriliyor. Word ekranı ve bağlı diyot blokları bu değerlerin farklı
karışımlarını kullanıyor; tek bir sıcaklık koşuluna indirgenmelidir.

### 6.3 S3-S4: IXYN100N65C3H1

Veri sayfasında 25 °C ve `RG=3 Ω` için `td(on)=23 ns`, `tr=42 ns`,
`Eon=1,30 mJ`, `td(off)=107 ns`, `tf=60 ns`, `Eoff=0,83 mJ` verilir.
Word belgesi gerçek sürücü için toplam 5 Ω kapı direnci kabul ediyor;
ekran değerleri ise 3 Ω veri sayfası tablosuyla aynıdır. 5 Ω'a göre
enerji ve zamanlar yeniden türetilmelidir.

Bağlı `N-Channel IGBT2` ve `N-Channel IGBT3` bloklarının I-V tabloları
IXYN eğrilerine yakındır; ancak zamanlar `100/100/200/100 ns` geçici
değerlerdir. Veri sayfasıyla eşleşen `23/42/107/60 ns` değerli
`N-Channel IGBT6` bloğu ise bağlantısızdır.

### 6.4 Ekran adlarının kullanımı

Ekran görüntülerindeki `N-Channel IGBT1/2/3` adları kararlı cihaz kimliği
değildir. Örneğin genel `IGBT_parameters.jpg` zamanları modeldeki bağlantısız
`N-Channel IGBT5` ile, IXYN ekranı ise bağlantısız `N-Channel IGBT6` ile
eşleşmektedir. Bundan sonra bloklar `S1_SKM`, `S2_SKM`, `S3_IXYN`,
`S4_IXYN`, `D1_DSEI`, `D2_DSEI` gibi işlev ve parça numarasıyla
adlandırılmalıdır.

## 7. Güvenilir yeniden üretim için uygulama sırası

1. Senaryo 1 modelinin arşiv kopyası korunacak; doğrulanmış bloklar ayrı
   bir çalışma kopyasında etkin S1-S4 ve D1-D2'nin yerine bağlanacak.
2. Tek bir sıcaklık/kapı direnci koşulu seçilecek. `VCE`, `Eon/Eoff`,
   zamanlar, diyot `VF`, `IRM`, `trr/Qrr` aynı koşuldan türetilecek.
3. L1/Cf/L2 endüktans-kapasitans seti 2026-08-26'da
   `600 µH / 8 µF / 200 µH` olarak kilitlenmiştir. Seri dirençler, gerçek
   sönümleme ve `fs/2`'ye yakın 4,594 kHz rezonansın denetleyiciyle
   kararlılığı ayrıca doğrulanacaktır.
4. Senaryo 1 çalıştırılacak; modelin hesapladığı değerler Excel'e
   sabit kopyalamak yerine ham MATLAB sonuç dosyasına yazılacak.
5. Doğrulama toleransları önceden tanımlanacak. Modelin Excel sayılarını
   tam olarak vermesi zorunlu kılınmayacak.
6. Senaryo 2, Senaryo 1'in aynı fiziksel modelinde yalnız kapılama varyantı;
   Senaryo 3 ise aynı varyanta Sin³ ileri besleme eklenerek kurulacak.
7. Excel'in yanına en az Vdc, Idc, VAC, IL1, Iout ve dört kapı işaretinin
   zaman damgalı CSV/MAT kayıtları istenecek.

## 8. Arşiv bütünlüğü

| Dosya | SHA-256 |
|---|---|
| `degerler_senaryo_ozeti_2026-08-17.xlsx` | `22b2d88ca35f565e7ca9ba1d590f811ee82d28e3e5cd3a375644d55cff4a3e16` |
| `Inverter2_senaryo1_2026-08-16.slx` | `92c472f5f13d02d89c2f75fb57b025cfe28fde8ab1a8b9be406b854943ca487a` |
| `simulasyon_duzeltmeleri_2026-08-16.docx` | `ad6d6b1167144c0d2731ed024aae5d4a6bd70271db923c526a78815c035d7717` |
| `DSEI2x61_12B-3311080.pdf` | `a0e0ac3615ae7de262234811e253667401b891fa734c50eda7c0e00623eca1d7` |
| `IXYN100N65C3H1_Datasheet.pdf` | `12132c408254f52eeca4131766b83daf3608f1418c871ed5b3b42397c808705c` |
| `SKM100GB12T4.pdf` | `04fd8926c1855355304891b2a9b46d05ea435e06e757841e1fece83e79bc9c68` |
