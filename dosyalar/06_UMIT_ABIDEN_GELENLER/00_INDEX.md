# 06 Ümit abiden gelenler — yazışma ve teslim arşivi

Düzenleme tarihi: 27 Ekim 2026

Ümit Pekparlak'tan e-posta ve Drive ile gelen bütün dosyaların **tarih sıralı ham
arşividir**. `00_ORIJINAL_ARSIVLER` gibi referans katmanıdır: dosyaların üzerine
yazılmaz, yeniden adlandırılmaz. Çalışmada kullanılan kopyalar tarihli adlarla
`tez-matlab-simulink/incoming_real_data/` altına alınmıştır (aşağıdaki
"Çalışma kopyası" sütunu). Drive ZIP'leri, açılmış klasörleriyle birlikte
özgün teslim olarak saklanmıştır.

Kısaltma: `IRD` = `tez-matlab-simulink/incoming_real_data`

## Klasörler

| Klasör | İçerik | Durum / çalışma kopyası |
|---|---|---|
| `2026-07-13_senaryo_ekranlari/` | Senaryo 1–3 dalga şekli ve THD ekranları (JPG+EMF) | `dosyalar/05_sonradan_gelenler/Senaryo_1..3/` ile SHA-256 birebir aynı; tez bu kopyayı okur |
| `2026-07-18_juri_yorumu_ve_deney_tablosu/` | Jürinin "odak Sin³ gibi duruyor" maddesine yanıt (tezin üç odağı) + gerçek uygulama sonuç tablosu | Tablo: `IRD/measurements/gercek_uygulama_ozeti_eposta_2026-07-18.csv` |
| `2026-08-14_simulasyon_aciklamalari/` | `simulasyon_duzeltmeleri.docx` ilk sürüm | 17.08 sürümü bunun üst kümesi (IGBT gate direnci paragrafı eklendi); yalnız arşiv |
| `2026-08-17_simulasyon_paketi_ve_tam_topoloji/` | Drive "simulasyon" paketi (Inverter2.slx, değerler.xlsx, veri sayfaları, parametre ekranları) + `tam_topoloji.pdf` + Senaryo 1–4 tanımı ve ilk ortak parametreler (`mail 2.txt`) | Tamamı 22.08.2026'da `IRD/` altına alınmıştı; SHA-256 birebir aynı |
| `2026-09-02_lc_filtre_kaynagi/` | Analytical Design of LC Filter Inductance… (kaynak önerisi) | 06.10 paketindeki aynı PDF ile birebir aynı |
| `2026-09-18_l1_kayip_literatur_ozeti/` | Verim farkı için yapılan denemeler (IGBT parametreleri, harmonikli güç ölçümü, CM akım) ve L1 kayıp literatür özeti | Docx metni 06.10 sürümüyle aynı; çalışma kopyası 06.10 sürümüdür |
| `2026-10-06_tez_06102026_paketi/` | S1+S2 parametrik modeli, ortak parametre dosyası (ilk sürüm), `tezdeki_düzeltmeler.docx`, SKM100 düşük akım uygunlaştırma notu, L1 kayıp özeti, `tam_topoloji.jpg`, 13 literatür PDF'i, `tez_tumu_8.docx` | Model/parametre/notlar `IRD/` altına alındı (aşağıda); `tez_tumu_8.docx` = `dosyalar/01_TAM_TEZ/` ile aynı |
| `2026-10-12_senaryo3_senaryo4_modelleri/` | Senaryo 3 ve 4 modelleri + güncel ortak parametre dosyası | `IRD/models/2026-10-12_dort_senaryo_paketi/` |
| `2026-11-01_s1_thd_degerlendirmesi/` | S1 THD değerlendirmesi: deneysel %15 kabulü, PF, Tablo 5.4, Temmuz benzetimi, THDv ve dalga biçimi (sohbetle iletilen mail metni) | Karar K-29; `tez-matlab-simulink/review/2026-11-01_S1_THD_TEZ_SAHIBI_DEGERLENDIRMESI.md` |
| `2026-11-07_tez_okuma_notlari_bolum7/` | Tez okuma notları (Bölüm 7'ye kadar, teslim PDF'i 01.11.2026 sayfalarıyla), Codex denetim çıktısı ve Bölüm 7'deki 100 kW/proje itirazı (mail metni + `son_tez_sorular_.docx`) | Değerlendirme: `tez-tamamlama/06_UMIT_OKUMA_NOTLARI_2026-11-07.md`; tez henüz değiştirilmedi |
| `2026-11-09_q3q4_sekiller_kimlik/` | Nötr bağlantılı tam topoloji (vektör PDF), S3/S4 Simulink şeması (SVG), düzeltilmiş Şekil 2.5/7.3/7.4 (JPG), Q1–Q3 / Q2–Q4 tümleyen adlandırma isteği, öğrenci no ve jüri listesi (mail metni) | K-31 ile teze işlendi (15.11.2026); çalışma kopyaları `tez-latex-v2/figures/umit_2026-11-09/`. `tam_topoloji.pdf` 1. faz Q3/Q4 etiketleri eski sıradaydı, tez kopyasında düzeltildi |
| `2026-11-16_degisiklik_cevaplari/` | 15.11 değişiklik işaretli PDF'e yanıt notları (74 not, "Lenovo" yazarlı) ve mail metni: jüri listesinin işlenmediği hatırlatması, ayrıntı/uzunluk endişesi | K-36 ile teze işlendi (16.11.2026) |
| `2026-11-22_sarj_modu_gelecek_calismalar/` | Şarj kipi deneylerinin yapılmama gerekçesi: PIC32MK ADC/PWM yapısı, T-tipi (Q1–Q3, Q2–Q4) ve şarj kipi (Q1–Q2, Q3–Q4) PWM çiftlerinin farkı; Ümit kendi kopyasında gelecek çalışmalara eklemiş (mail metni) | `yeni_tez` Alt Bölüm 6.2 (ADC/PWM), 8.3 ve 8.4'e işlendi (81edc0a, 8e2d964). Tez metninde deneyde tek faz kolunun sürüldüğü yazılıdır; maildeki "12 IGBT T-type sürüldü" ifadesi alınmadı. "Q2-A4" → Q2–Q4 |

| `2026-11-24_ilk_doktora_sunumu/` | İlk doktora (tez izleme) sunumu `upekparlak_doktora_sunumu.pptx`, 27 slayt, oluşturma 30.06.2026, son değişiklik 02.07.2026. Eski başlık, "üç aşama" (BYS, düşük güç verim/THD, topoloji), eski benzetim sayıları (S1 %90,45/%2,1; S2 %93/%46,3; S3 %93,7/%7,8), deney sayıları (%92,5/%15, %94,2/%46, %94,5/%14), şarj yönü benzetim ekranları | Proje sahibinden 24.11.2026'da alındı (Downloads kopyası, SHA-256 aynı). Jüri önerileri (`tez-tamamlama/34_JURI_ONERILERINE_YANIT_*`) bu sunuma verilmiştir; yeni sunumun karşılaştırma tabanıdır |

## Çalışma kopyasına alınanlar (27.10.2026)

| Kaynak | IRD hedefi |
|---|---|
| 06.10 `inverter_scenario1_parametric5_etiquetli.slx` (Senaryo 1+2) | `models/2026-10-12_dort_senaryo_paketi/` |
| 12.10 `inverter_senaryo3.slx`, `inverter_senaryo4.slx` | `models/2026-10-12_dort_senaryo_paketi/` |
| 12.10 `inverter_common_parameters.m` (güncel) | `models/2026-10-12_dort_senaryo_paketi/` — modellerin `InitFcn`'i dosyayı aynı klasörden çalıştırır |
| 06.10 `inverter_common_parameters.m` (ilk sürüm) | `parameters/inverter_common_parameters_2026-10-06.m` |
| 06.10 `tezdeki_düzeltmeler.docx` | `parameters/tezdeki_duzeltmeler_2026-10-06.docx` |
| 06.10 `SKM100GB12T4_dusuk_akim_parametre_uygunlastirma.docx` | `parameters/…_2026-10-06.docx` |
| 06.10 `L1_enduktor_kayiplari_literatur_ozeti.docx` | `parameters/…_2026-10-06.docx` |
| 06.10 `tam_topoloji.jpg` (17.08 tarihli) | `schematics/tam_topoloji_2026-08-17.jpg` |

## Literatür PDF'leri (henüz kaynakçada değil)

`2026-10-06_tez_06102026_paketi/…/tez_06102026/` içinde; tezde önerilen yeni
"düşük akımda simülasyon modelleme" kesiminin kaynakları:

- Analytical Design of LC Filter Inductance for Two-Level Inverters Based on Maximum Ripple Current
- Complete Loss and Thermal Model of Power Semiconductors Including Device Rating Information
- SEMIKRON AN 1403 — Determining Switching Losses of SEMIKRON IGBT Modules
- Analysis on the Low Current Turn-on Behavior of IGBT Module
- Light Load Operation of 6.5 kV 200 A IGBTs in Half-Bridge Configuration
- Two-step Parameter Extraction Procedure … IGBT and p-i-n Diode Models
- Prediction of Switching Loss Variations by Averaged Switch Modeling
- Hybrid Switch Use for Light Load Efficiency Improvement …
- A Systems Approach for a Stand-Alone Residential Fuel Cell Power Inverter Design
- Analysis of EV Driving Cycles for Inverter Efficiency Improvement at Partial Load
- Comprehensive Comparison between SiC MOSFETs and Si IGBTs
- Single-Phase T-Type Inverter Performance Benchmark Using Si IGBTs, SiC MOSFETs and GaN HEMTs
- Light Load Efficient Silicon Power Converters (kitap/tez, 56 MB)
- R. Pittini, PhD tezi (DTU)

L1 kayıp özetinin kaynakları (Chen 2010, Lee 2013, Ge 2017, Matsumori 2016/2018)
docx içinde künyeli; PDF'leri pakette yok.

## Teknik özet (yazışmalardan)

- **Senaryo tanımları (17.08, 06.10, 12.10):** S1 klasik tamamlayıcı anahtarlama;
  S2 nötr IGBT'ler alternans boyunca 1/0 (susturma); S3 = S2 + K1·sin + K3·sin³
  ileri besleme; S4 = S3 + L1 akım geri beslemeli kontrolör, yüksek akımda
  (20–30 A) çalışma ve kararlılık gösterimi. 12.10 notuna göre S4'te yalnız
  oransal kontrolör (`Kp=0.03`) var, sistem ~20 A'e çıkıyor; akım biçimi ve verim
  ayarı yapılmadı.
- **Kalibrasyon yaklaşımı (06.10):** Tüm senaryolarda sabit kalacak devre
  parametreleri (L2/L2r şebeke+varyak, EMC CMC, L1r + L1 çekirdek kaybı Rp, IGBT
  zamanlamaları) ve senaryoya özgü serbest ayarlar (K1x, faz, Vdc, Vac, K3x).
  Eski SimPower benzetimleri kayıpları tam hesaplamıyordu, snubber direnci hatası
  vardı; yeni Simscape tabanı termal portlu, kayıp hesaplı.
- **Verim farkı (18.09, 06.10):** IGBT parametreleri, 0–50. harmonik güç ölçümü ve
  CM akım denemeleri deneydeki %92,5'i açıklamadı; L1/EMC çekirdek kaybı
  (Rp paralel direnç) modeli eklenince verim düştü. Güç ölçümü 100 ms'de oturuyor
  (yerleşme tablosu `tezdeki_düzeltmeler.docx` içinde).
- **Tez yapısı önerisi (06.10):** "Düşük akımlarda simülasyon modelleme" kesimi
  (endüktans kayıpları, IGBT/diyot parametreleri, CM akım, harmonik güç ölçümü);
  S4 ayrı alt bölüm (yüksek akım + kararlılık).

## Açık sorular / çelişkiler

1. **THD hedefi:** 18.07 e-posta tablosu S1/S3 için THD %5 / %4 veriyor;
   `değerler.xlsx` ve 12.10 parametre dosyası %15 / %14. Hangisi doğru?
2. **cosφ işareti:** E-posta tablosunda S2/S3 için +0,995/+0,997; xlsx ve
   parametre dosyasında −0,995/−0,997 (Q negatif).
3. **S4 hedef akımı:** Parametre dosyası `Ifaz_rms_target(4)=25 A`; 12.10 e-postası
   "~20 A'e çıkabiliyor". Jüri "nominal güç" istedi; nominal akım tanımı kilitlenmeli.
4. **Parametre dosyası notu:** `addpath` yorumu "aynı klasördeki dört uçlu CMC
   kütüphanesi"nden söz ediyor; modellerde özel kütüphane bloğu bulunmadı
   (yalnız standart Simscape + Specialized Power Systems). Ek dosya gerekmiyor
   gibi görünüyor, koşuda doğrulanacak.
5. **Sürüm riski:** Modeller R2023b; Specialized Power Systems ölçüm blokları
   (`spsTHDLib`, `spsRMSLib`, `spsMeanLib`, `spsPowerLib`) içeriyor. R2025b'de
   Senaryo 1 bu bloklar yüzünden değişmeden koşmamıştı
   (`tez-matlab-simulink/review/2026-08-26_R2025B_SENARYO1_DOGRULAMA.md`).
