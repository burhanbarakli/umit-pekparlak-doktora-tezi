# Ümit - bekleyen senaryo ve parametre girdileri

Durum: **Kaynak olarak kaydedildi; LCL endüktans ayrımı 2026-08-26'da
sonuçlandırıldı, kaynak `.slx` dönüşüm sorunu nedeniyle yerinde değiştirilmedi.**

Alınma tarihi: 2026-08-22  
Kaynak: Ümit'in e-posta metni ve `tam_topoloji.pdf`  
MATLAB karşılığı: `parameters/pending_2026_08_22_umit_parameters.m`

## 1. Kullanım kuralı

Bu dosyadaki veriler yeni ve daha güçlü aday girdilerdir; ancak kaynaklar
arasındaki farklar giderilmeden mevcut `DENEME` parametrelerinin üzerine
yazılmayacaktır. E-postadaki verim ve THD değerleri hedefe ayarlanacak sayılar
değil, aynı model ve analiz koşullarında bağımsız olarak yeniden üretilmesi
gereken bildirilmiş sonuçlardır.

## 2. E-postayla bildirilen ortak parametreler

| Parametre | Değer | Birim | Not |
|---|---:|---|---|
| `L1` | 600 | µH | Filtre bobini |
| `L1r` | 0,02 | Ω | Seri direnç |
| `L2` | 200 | µH | 2026-08-26 kaynak ayrıştırmasıyla nihai LCL-L2 değeri seçildi |
| `L2r` | 0,02 | Ω | Seri direnç |
| `C` | 8 | µF | PDF'deki C7-C9 değerleriyle uyumlu görünüyor |
| `Cr` | 0,01 | Ω | Kondansatör ESR/seri direnç yorumu doğrulanacak |

`S12` ve `S34` için aynı anahtarlama zamanları verilmiştir:

- Açılma gecikmesi: 165 ns
- Kapanma gecikmesi: 400 ns
- Yükselme süresi: 600 ns
- Düşme süresi: 600 ns

`DS12`, `DS34` ve `D12` için aynı diyot parametreleri verilmiştir:

| Parametre | Değer |
|---|---:|
| İleri gerilim `Vf` | 1,35 V |
| İletim direnci `Ron` | 8,5 mΩ |
| Eklem kapasitesi `Cj` | 31 pF |
| Ters toparlanma tepe akımı `iRM` | -13 A |
| İleri akım test değeri `Iif` | 60 A |
| Ters toparlanma akım eğimi `Iroffcrg` | -300 A/µs |
| Ters toparlanma süresi `trr` | 380 ns |

## 3. Bildirilen senaryolar

| Senaryo | Denetim/anahtarlama tanımı | Ortak elektriksel nokta | Bildirilen sonuç |
|---|---|---|---|
| 1 | Komplement anahtarlamalı T-tipi mevcut model | `Vdc=431 V`, `Vrms=169 V` | Excel değerleriyle uyum, verim %92,5 |
| 2 | Nötr IGBT'lerde komplement anahtarlama iptal; her anahtar bir alternans boyunca 1/0 | `Vdc=431 V`, `Vrms=169 V` | Verim %94,2; THD yaklaşık %47 |
| 3 | Denetim çıkışına `K1*sin(x) + K3*sin^3(x)` ileri beslemesi | `Vdc=431 V`, `Vrms=169 V` | Verim %94,5; THD yaklaşık %14 |
| 4 | Senaryo 3 ileri beslemesine PI çıkışı; geri besleme `L1` anlık akımı; referans sinüsoidal akım | Henüz bildirilmedi | Akımın yaklaşık 30 A'da kararlı çalıştığı gösterilecek |

## 4. PDF'den görsel olarak doğrulanan topoloji

Tek sayfalı Proteus şeması ortak bir giriş/EMI katından beslenen, yapısal
olarak tekrarlanan üç güç hücresi göstermektedir. Şemada:

- Üç hücrenin ana anahtar modülleri `Q1-Q2`, `Q5-Q6`, `Q9-Q10` olarak
  `SKM100GB12T4` etiketi taşıyor.
- Nötr kolu anahtar çiftleri `Q3-Q4`, `Q8-Q7`, `Q12-Q11` olarak
  `XYN100N65C3H1` etiketi taşıyor.
- `D1-D6`, `DSEI2X61-12B`; DA bağlantı kondansatörleri `C10-C11`,
  `C13-C14`, `C16-C17`, `470 µF / 450 V` olarak etiketlenmiş.
- Giriş tarafında `C2-C5 = 1 µF X2`, `C6 = 26 nF Y2` ve
  `C7-C9 = 8 µF X2` etiketleri bulunuyor.
- Şema üzerinde `L1=600 µH`, `L2=600 µH` ve `L3=600 µH` okunuyor. Bunlar
  LCL sırasını değil, sırasıyla A/B/C faz bobinlerini gösteriyor; dolayısıyla
  e-postadaki ikinci filtre bobini `L2=200 µH` ile doğrudan çelişmiyor.
- Hücre çıkışları `TR1-TR3` transformatörlerine bağlanıyor.

PDF künye bilgisi: Proteus 8.17, şema adı `guc_yapi_01`, sayfa 1/1,
şema tarih alanı 19.07.2026. İncelenen kaynak PDF'nin SHA-256 değeri:

`133f1e967ff1e49aa8b349b75eca0b75964f449ab43158836d8f75a927b39b3d`

Kaynak PDF'nin hash değeri doğrulanmış, değiştirilmemiş kopyası
`incoming_real_data/schematics/tam_topoloji_2026-08-22.pdf` olarak
arşivlenmiştir. İncelemede üretilen tam sayfa görseli de
`incoming_real_data/schematics/tam_topoloji_2026-08-22_rendered.png` altında
korunmaktadır.

## 5. 2026-08-26 endüktans kararı

- Faz-başına evirici tarafı bobini: `L1=600 µH`.
- Şönt filtre kapasitörü: `Cf=8 µF`.
- Faz-başına ikinci/şebeke tarafı bobin: `L2=200 µH`.
- Kaynak Senaryo 1 modelindeki `CL1=400 µH`, eski model ayarı olarak arşivde
  korunacak; R2025b dönüşümü onarılınca `200 µH` ile ayrı çalışma kopyasında
  sınanacak.
- İdeal LCL rezonansı (`fs=10 kHz` kabulüyle) `4,594 kHz`'dir. Bu değer
  `fs/2` sınırına yalnız yaklaşık `406 Hz` uzakta olduğundan gerçek gecikme,
  sönüm ve denetleyiciyle kararlılık doğrulaması zorunludur.

Karar dosyası: `parameters/validated_filter_parameters_20260826.m`  
Duyarlılık deneyi: `scripts/evaluate_l2_candidates_20260826.m`

## 6. Model güncellenmeden önce netleştirilecekler

1. `Vrms=169 V` faz-nötr, hat-hat veya kaynak referansı mı?
2. Anahtarlama frekansı, şebeke frekansı, çözücü adımı ve denetim
   örnekleme zamanı nedir?
3. `K1`, `K3`, PI kazınçları, sınırlar ve anti-windup yapısı nedir?
4. Senaryo 2'de pozitif/negatif alternansta hangi nötr IGBT açık kalıyor?
5. `sin^3(x)` gerçekten PLL sinyalinin küpü mü; işareti ve enjeksiyon
   noktası nedir?
6. Verim hesabının giriş/çıkış sınırları, kayıp modeli ve THD
   analiz penceresi/harmonik sayısı nedir?
7. PDF'deki gerçek yarı iletken parça numaralarıyla e-postadaki eşdeğer
   elektriksel parametrelerin hangi elemanlara uygulanacağı teyit edilmelidir.
