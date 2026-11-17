# Bölüm 5 jüri riski önerileri (rapor 17'nin açık kalan maddeleri)

- **Kapsam:** `yeni_tez/bolumler/05-sin3-kompanzasyon.tex` (HEAD = 20e3a74, 549 satır). Gerektiği yerde 03, 06, 08 ile `tez-matlab-simulink/review/2026-10-28_S4_KAPALI_CEVRIM.md`, `review/2026-10-28_KARARLILIK_BODE.md`, `review/2026-11-07_S4_VAC_DC_VE_SEKIL_FONT.md`, `runs/2026-10-28_s4_kapali_cevrim/results/*/metrik.csv`, `runs/2026-10-28_kararlilik/{results,frekans,karsilastirma}/*.csv`, `results/sin3_rescan_20260901/*.csv` okundu. Bölüm 5 şekillerinin hepsi PDF olarak açılıp şekil içi yazıları tek tek denetlendi.
- **Görev kipi:** yalnız rapor. Hiçbir `.tex` dosyası değişmedi, commit yapılmadı.
- **Satır numaraları** bugünkü dosyaya aittir (rapor 17'deki numaralar kaymıştır).
- **İşaretler:** **[HESAP]** yeni benzetim gerektirmeyen elle hesap (tezde yeni sayı olur, tez sahibi onayı gerekir). **[YENİ SAYI]** yeni benzetim ya da kayıtlardan yeni çıkarım gerektirir. Her [YENİ SAYI] önerisinin yanında yeni sayı gerektirmeyen bir seçenek de verilmiştir.
- **Kullanıcı kararları uygulandı:** H-39 kapalı (S4 analog eşdeğer olarak modellenmiştir, aktif sönümleme yalnız Gelecek Çalışmalar'da). Önerilen metinlerin hiçbiri olumsuz kurgu kullanmaz.

---

## 1. Özet tablosu

| Kimlik | Konu | Öncelik | Durum | Yeni sayı | Önerilen eylem (tek satır) |
|---|---|---|---|---|---|
| H-47 | S4 THD'sinin hangi akıma ait olduğu; %9,4 ↔ %9,2 | **yüksek** | açık | hayır | Tablo başlığına "şebeke akımı ($i_g$)" yaz, 05:511'deki %9,4/%5,6'yı "$L_1$ akımı, enjeksiyon benzetimi" diye adlandır |
| H-49 | Büyütülmüş bara kapsamı ve üç faz gerekçesi | **yüksek** | açık | A: hayır / B: [HESAP] | "orta ve anma" → "bütün S4 benzetimleri" (05:239, 03:507); "üç katı" cümlesini temel bileşen götürmesi gerekçesiyle değiştir |
| H-48 | "7,2 W kayıp farkı" yanlış; gerçek fark 6,1 W | **yüksek** | açık | A: hayır / B: [HESAP] | 05:243'teki iki sayılı cümleyi çıkar, model farkını tek cümleyle yaz (H-27, Y-02 ile birlikte) |
| H-46 | $|u|_{\max}=1{,}49$ ile $u=\operatorname{sat}_{\pm1}(\cdot)$ çelişkisi | orta | açık | hayır | Basamak tablosunda "doyum öncesi $|u_{\mathrm{ff}}+u_{\mathrm{fb}}|_{\max}$" yaz, noktalı virgülü kaldır |
| H-55 | Aynı basamak koşusu için %0,2/0,44 ms ↔ %0,17/0,43 ms | orta | açık | hayır | Dört yerde tek değer (%0,17, 0,43 ms) ya da H-34 birleştirmesi |
| H-44 | 2,3 A'de kritik bölge ölçümü yok, hüküm faz öndeliğinden | orta | açık | A: hayır / B: [YENİ SAYI] | "Çevrim yavaş ama kararlıdır" yerine kararlılığı zaman alanı oturmasına bağla |
| H-45 | Çevrim dışı ayrımı ideal PLL'e dayanıyor; Lu2016 cümlesi çelişiyor | orta | açık | hayır | 05:350'ye ideal PLL koşulu, 05:200'deki iki cümleyi çıkar |
| H-51 | "ölçeklenmektedir", "daha geniş çerçevede ele alınmıştır", "denetim eforu" | orta | kısmen kapandı | hayır | Üç yerde "akım düzeyine bağlıdır", bir cümle silinir, 03:433 kısalır |
| H-31 | Bölüm 3 doğrulama matrisi "anahtarlamalı model doğrusallaştırması"; $K_1/K_3$ simgesi | orta | açık | hayır | 03:587 "enjeksiyon ölçümü", 03:532–535 $K_{1x}$, $K_{3x}$, $\varphi_x$ |
| H-28 | Faz payı baralı PI 25 A koşusunun dört sayısı (oturmamış koşu) | orta | açık | hayır | Sayıları "doyum + periyottan periyoda değişim" ile değiştir |
| H-37 | Şekil içi yazılar (10 şekil) | orta | açık | hayır | MATLAB ile yeniden aktarım ya da pgfplots (4 şekil CSV'den çizilebilir) |
| H-53 | PM/GM/$M_s$ ölçütü kaynaksız "yaygın" | düşük | açık | hayır | Ölçütü tezin tasarım seçimi olarak yaz |
| H-52 | $d$, $L$, $N/P/Z$, $i_g$ simge çakışmaları | düşük | açık | hayır | $u_{\mathrm{inj}}$, $L_1$, $N_{\mathrm{s}}/P_{\mathrm{a}}/Z_{\mathrm{k}}$, $\bar i_L$ |
| H-56 | "farklar ölçüm belirsizliği düzeyindedir" iddia gücü | düşük | açık | hayır | 05:500'ün ifadesini Değerlendirme'ye taşı |
| H-58 | "yumuşak gerilim kaynağı" ↔ "akım kaynağına yakın" | düşük | açık | hayır | Tek terim "yumuşak kaynak" |
| H-57 | Farklı $V_{\mathrm{dc}}$/güçte "2,0 puan" | düşük | **Bölüm 5'te kapandı**, Bölüm 8'de açık | hayır | 08:34'e deney koşulu yan cümlesi |
| H-27 | S3–S4 verim karşılaştırma cümleleri | düşük | açık | hayır | H-48 ile birlikte çözülür |
| H-42 | Karşılaştırma çiftleri, (0,44, 0,38) ≈ kalibre S3 | düşük | kısmen kapandı | hayır | İsteğe bağlı: (0,44, 0,38) çiftini çıkar; savunma yanıtı hazır |
| H-39, H-40, H-41(a), H-43, H-50, H-19, H-01, H-04 | — | — | **kapandı** | — | — |
| **Y-01** | Nyquist şeklinde kritik kesişim çizim aralığının dışında | orta | yeni | hayır | Başlığa tek cümle ya da şekli genişletilmiş eksenle yeniden çiz |
| **Y-02** | S4 2,3 A THD (%7,0) ile S3 THD (%14,8) farkı açıklanmamış | orta | yeni | hayır | H-48 cümlesine "THD" ekle (model farkı), savunma yanıtı hazırla |
| **Y-03** | "45 µs'ye kadar kararlı" ↔ $\mathrm{DM}_{\min}=44{,}4$ µs | düşük | yeni | hayır | "toplam gecikme" ve "2 µs'ye eklenen marj" ayrımını yaz |
| **Y-04** | D-11 bağıntısı üst sınırdır (T-tipi orta nokta akımı $|d|\,i$) | düşük | yeni | — | Yalnız savunma |
| **Y-05** | η: Display / betik / Simscape kayıp toplamı ~1 puan farklı | düşük | yeni | — | Yalnız savunma |
| **Y-06** | Başlıklarda süreç bilgisi "(01.09.2026 hesabı)", "parametre dosyasındaki değerdir" | düşük | yeni (H-24'ün kalanı) | hayır | Üç ifadeyi sil |

**Sayım:** 18 kimlik incelendi (kapsam listesi + H-42, H-27). 14 açık, 2 kısmen kapandı (H-51, H-42), 1 Bölüm 5'te kapandı (H-57). Rapor 17'nin jüri riski tablosundaki H-39, H-40, H-41(a), H-43, H-50 kapandı. 6 yeni risk (Y-01…Y-06).

**Rapor 17'nin bir öncülü düzeltildi (H-47):** `tab:s4-tarama` içindeki THD$_I$ $i_{L1}$ akımına değil, **şebeke akımına** ($i_{ac}$ = $i_g$, C noktası) aittir. Tablodaki sekiz değerin hepsi `metrik.csv` içindeki `THD_I_ac_h50_pct` sütunuyla, $I_3/I_1$ sütunu `I_ac_h3_pct` ile eşleşmektedir. $i_{L1}$ THD'si yalnız 05:511'deki %9,4 ve %5,6'dır.

## 2. Önce uygulanması önerilen 7 madde

1. **H-47:** `tab:s4-tarama` başlığına THD'nin şebeke akımına ait olduğunu yaz. 05:511'de %9,4/%5,6'yı "$L_1$ akımı, enjeksiyon benzetimi" diye adlandır. Tablo ile metin arasındaki tek sayı tutarsızlığı kalkar.
2. **H-49 (seçenek A):** 05:239 ve 03:507'de "orta ve anma akımı" → "bütün S4 benzetimleri". "Üç katı" cümlesi yerine dengeli üç fazda temel bileşen orta nokta akımlarının götürmesi.
3. **H-48 + H-27 + Y-02:** 05:243'ün son üç cümlesi yerine tek bir model farkı cümlesi (yanlış 7,2 W önermesi kalkar).
4. **H-46:** Basamak tablosunda "doyum öncesi $|u_{\mathrm{ff}}+u_{\mathrm{fb}}|_{\max}=1{,}49$".
5. **H-55:** %0,17 ve 0,43 ms değerleri 05:310, 05:312, 05:547 ve 06:465'te.
6. **H-44 + H-45:** 05:509'da kararlılığı zaman alanı oturmasına bağla. 05:350'ye ideal PLL koşulu, 05:200'den Lu2016 ve "daha geniş çerçeve" cümlelerini çıkar.
7. **H-51 + H-31:** "ölçeklenmektedir" → "bağlıdır" (05:511, 05:547). Bölüm 3 doğrulama matrisinde "enjeksiyon ölçümü" ve $K_{1x}$, $K_{3x}$.

---

## 3. Doğrulanan hesaplar

### 3.1 H-48: kayıplar

| Koşu | $P_{\mathrm{ac}}$ (W) | $\eta$ | $P_{\mathrm{dc}}=P_{\mathrm{ac}}/\eta$ (W) | Kayıp (W) | Kaynak |
|---|---:|---:|---:|---:|---|
| S4 P, 2,3 A | 280,7 | %96,24 | 291,67 | **10,97** | 05:255, `KC_P_2p3A/metrik.csv` (`D_DC_Guc` 291,646 − `D_AC_Aktif_Guc` 280,674 = 10,97 W) |
| S4 PI, 2,3 A | 279,5 | %96,20 | 290,54 | 11,04 | 05:256 |
| S3 benzetimi | 279,90 | %94,25 | 296,98 | **17,08** | 06:563, 06:567 |

- **Toplam kayıp farkı: 17,08 − 10,97 = 6,11 W** (PI ile 6,04 W). Metindeki "yaklaşık 7,2 W'lık kayıp farkı" yanlıştır.
- 7,2 W'ın kaynağı (review S4 notu, Bulgu 3): S4'te $L_1$ çekirdek kaybı direnci kaybı 4,78 W (`kayip_L1Rp_W`, 1500 Ω). Aynı gerilimde 600 Ω ile 4,78 × 1500/600 = 11,95 W olurdu. **Fark 7,17 W.**
- Sonuç: çekirdek direnci farkı 7,2 W, toplam fark 6,1 W. S4'ün öteki kayıpları S3'ünkinden ~1,1 W yüksektir (S4: 10,97 − 4,78 = 6,19 W, S3: 17,08 − 11,95 ≈ 5,13 W).

### 3.2 H-49: DA bara orta nokta salınımı [HESAP – tez sahibi onayı]

**D-11 bağıntısı** $\hat v_N\simeq\hat I/(\omega(C_A+C_B))$, tezdeki değerlerle ($V_{\mathrm{dc}}/2=213{,}75$ V):

| Durum | $\hat I$ (A) | $\omega$ | $C_A+C_B$ | $\hat v_N$ | Tezdeki değer |
|---|---:|---|---:|---:|---|
| Faz payı, 2,3 A | 3,25 | $2\pi50$ | 940 µF | **11,0 V** (%5,2) | "yaklaşık 11 V (%5)" ✔ |
| Faz payı, 25 A | 35,36 | $2\pi50$ | 940 µF | **119,7 V** (%56) | "yaklaşık 120 V (%56)" ✔ |
| Büyütülmüş, 25 A | 35,36 | $2\pi50$ | 11,2 mF | **10,05 V** (%4,7) | "yaklaşık 10 V (%4,7)" ✔ |
| Büyütülmüş, 2,3 A | 3,25 | $2\pi50$ | 11,2 mF | 0,92 V | tezde yok |

Tezdeki üç değer bağıntıyla tutarlıdır.

**Hangi koşular büyütülmüş barayla:** Review notu (`2026-10-28_S4_KAPALI_CEVRIM.md`, "Kesin tarama `KC_*`: DC bara 2 × 5,6 mF") ve `metrik.csv` içindeki `Cdc_F = 0.0056`, 2,3 A dahil **sekiz `KC_*` koşusunun hepsinin** 2×5,6 mF ile koşulduğunu göstermektedir. Enjeksiyon koşuları da 5,6 mF iledir (`kosu_bilgisi.txt`). `tab:s4-tarama` başlığı ("büyütülmüş DA bara", bütün satırlar) doğrudur. 05:239 ("S4 orta ve anma akımı benzetimlerinde") ve 03:507 ("S4 orta ve anma akımı benzetimleri") kapsamı daraltmaktadır.

**"Üç katı" gerekçesinin sınaması:** Toplam kapasitans 3×940 µF ile tek fazın akımı D-11 bağıntısına konursa 25 A'de 119,7/3 ≈ **40 V (%19)** çıkar. Gerekçe tek başına 5,6 mF seçimini (%4,7) açıklamaz. Asıl gerekçe dengeli üç faz dört telli çalışmada temel bileşenin götürülmesidir.

**Üç fazlı orta nokta akımı, iki yaklaşım:**

1. *Nötr hattı yaklaşımı (rapor 17):* orta noktaya yalnız fazların üçlü harmonik akımları döner. PI 25 A'de şebeke akımı $I_3=\%8{,}743\times24{,}516=2{,}144$ A RMS (`KC_PI_25A`, `I_ac_h3_pct`). Nötr akımı $3\times2{,}144=6{,}43$ A RMS, tepe 9,09 A, 150 Hz. Toplam kapasitansla ($C_A+C_B=2\times1410$ µF, $\omega=2\pi150$): $\hat v_N=9{,}09/(942{,}5\times2{,}82\cdot10^{-3})=$ **3,4 V (%1,6)**.
2. *T-tipi anahtarlama işlevi yaklaşımı (daha doğru):* orta nokta düğümünde KCL, kapasitör akımını $i_C=-\sum_x(1-d_{O,x})\,i_x=-\sum_x|d_x|\,i_x$ verir. Nötr anahtar iletimdeyken akım kapasitörlerden geçmez. Saf sinüs görev oranı $d_x=m\sin\theta_x$ ve aynı fazlı akım $i_x=\hat I\sin\theta_x$ ile $\sin\theta|\sin\theta|$ açılımının üçüncü harmonik katsayısı $-8/(15\pi)$ olduğundan üç fazın toplamı
   $$\hat I_{N,3}=\frac{8}{5\pi}\,m\,\hat I\simeq0{,}509\,m\,\hat I .$$
   $m\simeq0{,}73$–0,80 ve $\hat I=35{,}36$ A ile $\hat I_{N,3}=13{,}1$–14,4 A, $\hat v_N\simeq$ **4,9–5,4 V (%2,3–2,5)**. Sin³ ve akımın üçüncü harmonikleri faz ilişkisine göre eklenince sayısal hesap $\hat I_{N,3}=15$–27 A, $\hat v_N\simeq$ **6–10 V** vermektedir (oturum betiği, numpy'siz 20 000 noktalı Fourier).
   - Temel bileşen her iki yaklaşımda da sıfırdır (sayısal hesapta $h_1=0{,}000$).

**Yorum:** Üç fazlı donanımda 2×1410 µF ile orta nokta salınımı 150 Hz'te birkaç volt ile ~10 V arasındadır. Büyütülmüş baralı faz başına model (~10 V, 50 Hz) aynı büyüklük düzeyindedir. Büyütülmüş bara, üç fazlı götürmenin faz başına modeldeki vekilidir. Rapor 17'nin 3,4 V'u yalnız nötr hattı yolunu sayar ve T-tipi anahtarlama işlevinin ürettiği 150 Hz bileşenini atlar. Tezde sayı verilecekse seçenek B'deki kapalı biçim (≈5 V) önerilir, çünkü tek varsayıma dayanır ve açıkça yazılabilir.

### 3.3 H-47: %9,4 ve %9,2'nin kaynağı

| Değer | Akım | Koşu | Pencere | Kaynak |
|---|---|---|---|---|
| %9,2 (`tab:s4-tarama`, PI 25 A) | **şebeke akımı $i_{ac}$** (C noktası) | `KC_PI_25A` (enjeksiyonsuz, 0,06 s) | son periyot | `THD_I_ac_h50_pct` = 9,2044 |
| %9,05 (tezde yok) | $i_{L1}$ | `KC_PI_25A` | son periyot | `THD_I_L1_h50_pct` = 9,0514 |
| **%9,4** (05:511, $K_{34}$ açık) | **$i_{L1}$** | `PI25_K34_A` (**enjeksiyonlu**, 0,11 s) | son periyot, ton sızıntısı dahil | `THD_I_L1_h50_pct` = 9,4236 |
| **%5,6** (05:511, $K_{34}=0$) | $i_{L1}$ | `PI25_K340_A` (enjeksiyonlu) | son periyot | `THD_I_L1_h50_pct` = 5,6322 |
| %9,1 (`tab:s4-basamak`) | şebeke akımı | `KC_PI_basamak_10_25A` | son periyot | `THD_I_ac_h50_pct` = 9,1283 ($i_{L1}$: 8,97) |

- Fark iki kaynaktan gelir: akım ($i_g$ ↔ $i_{L1}$, ~0,15 puan) ve enjeksiyon tonlarının 20 ms pencereye sızması (~0,35 puan).
- Bütün tablo satırlarında eşleşme: P 2,3 A 7,02→7,0; PI 2,3 A 7,16→7,2; P 10 A 22,58→22,6; PI 10 A 20,76→20,8; PIR 10 A 19,63→19,6; P 25 A 9,82→9,8; PI 25 A 9,20→9,2; PIR 25 A 8,47→8,5. $i_{L1}$ sütunu (6,86; 7,04; 22,40; 20,42; 19,41; 9,72; 9,05; 8,35) hiçbir satırla eşleşmez.
- Bölüm 3 (03:608 dolayı, `eq:thd-rmse-tanimlari`) THD'yi C noktası şebeke akımı $i_g$ üzerinden tanımlamaktadır. Tablo tanımla uyumludur. Bölüm 6 aynı büyüklüğü THD$_{i,\mathrm{faz}}$ diye yazmaktadır (06:338).
- $K_{34}=0$ için şebeke akımı THD'si kayıtlı değildir (`PI25_K340_A/metrik.csv` yalnız $i_{L1}$ içerir, `dalga.mat` bu kopyada yok).

### 3.4 H-46 ve H-55: tablo değerleri

- `tab:s4-tarama` bütün sütunları `KC_*/metrik.csv` ile eşleşti: $I_{L1,1}$, genlik/faz hatası, THD ($i_{ac}$), $I_3/I_1$ (`I_ac_h3_pct`), $P_{\mathrm{ac}}$, η (`D_Verim`, Display), doyum (`doyum_orani_pct`=0), $|u|_{\max}$ (`u_top_max`: 0,862; 0,8625; 0,875; 0,879; 0,874; 0,904; 0,904; 0,933). PIR satırları `_02s` koşularındandır.
- `u_top` doyum **öncesi** toplamdır: özgün baralı `PI_25A` koşusunda `u_top_max` = 2,12 çıkmaktadır. Basamak koşusunda `u_top_max_tum` = 1,493, `doyum_orani_tum_pct` = 0,8165 → tablo "%0,8; 1,49" ✔. Şekil `s4_basamak_PI_10_25A_KC.pdf` alt paneli "u = uff + ufb" eğrisini −1,49'a kadar çizmektedir. Bölüm 3'teki tanım $u=\operatorname{sat}_{\pm1}(u_{\mathrm{ff}}+u_{\mathrm{fb}})$ (03:358) ile aynı simge iki büyüklüğü göstermektedir.
- Basamak: `KC_PI_basamak_10_25A/metrik.csv` → `yerlesme_hata_ms` = 0,439, zarf tepeleri [37,70; 37,93; 37,86] → aşım (37,93−37,86)/37,86 = %0,185 → "%0,2". `karsilastirma/basamak_karsilastirma.csv` → aynı koşu için `zarf_asim_pct` = 0,169, `yerlesme_hata_ms` = 0,43, tepeler [37,69; 37,92; 37,86]. Fark, karşılaştırma betiğinin zarfı daha kaba (10 µs) ızgarada aramasından gelmektedir. Tanım aynıdır.

---

## 4. Risk başına öneriler

**H-47 — S4 THD'sinin akım tanımı ve %9,4 ↔ %9,2 — yüksek**
- Güncel yer: 05:511 "THD sırasıyla \%9,4 ve \%5,6'dır." ↔ 05:247 tablo başlığı ve 05:253 sütun başlığı "THD$_I$" ↔ 05:263 "\%9,2" ↔ 05:314, 05:289.
- Durum: açık. Rapor 17'nin "S4 THD'si $i_{L1}$'e aittir" öncülü tablo için geçerli değildir (bkz. §3.3).
- Jürinin soracağı soru: "Anma akımında PI ile THD %9,2 mi, %9,4 mü ve hangi akımın THD'si?"
- Önerilen metin değişikliği:
  - 05:511 — **Mevcut:** "\SI{25}{\ampere}'de $I_{L1,3}$, $K_{34}$ açıkken \SI{2.13}{\ampere}, $K_{34}=0$ iken \SI{0.43}{\ampere}'dir. THD sırasıyla \%9,4 ve \%5,6'dır."
    - **Önerilen A:** "\SI{25}{\ampere}'de $I_{L1,3}$, $K_{34}$ açıkken \SI{2.13}{\ampere}, $K_{34}=0$ iken \SI{0.43}{\ampere}'dir. Enjeksiyon benzetimlerinde $L_1$ akımının THD'si sırasıyla \%9,4 ve \%5,6'dır."
    - **Önerilen B (daha kısa):** İkinci cümleyi sil. $I_{L1,3}$ değerleri bulguyu tek başına taşımaktadır.
  - 05:247 `tab:s4-tarama` başlığı — **Mevcut:** "S4 kapalı çevrim benzetimi: düşük, orta ve anma akımında akım izleme, harmonik, verim ve doyum (büyütülmüş DA bara, S3 ileri besleme değerleri). PIR benzetimleri \SI{0.2}{\second}, diğerleri \SI{0.06}{\second}."
    - **Önerilen:** "S4 kapalı çevrim benzetimi: düşük, orta ve anma akımında akım izleme, harmonik, verim ve doyum (büyütülmüş DA bara, S3 ileri besleme değerleri). THD$_I$ ve $I_3/I_1$ şebeke akımına ($i_g$, C noktası, $h\leq50$) aittir. PIR benzetimleri \SI{0.2}{\second}, diğerleri \SI{0.06}{\second}."
  - 05:314 — **Mevcut:** "Basamak sonrası THD$_I$ & \%9,1 \\" → **Önerilen:** "Basamak sonrası şebeke akımı THD'si & \%9,1 \\"
  - 05:289 — **Mevcut:** "...verim, akım THD'si ($h\leq50$) ve temel bileşen..." → **Önerilen:** "...verim, şebeke akımı THD'si ($h\leq50$) ve temel bileşen..."
- Savunmada sözlü yanıt: "Tablodaki %9,2 şebeke akımının, Bölüm 3'teki THD tanımıyla hesaplanan değeridir. %9,4 aynı noktadaki $L_1$ akımına aittir ve küçük işaret enjeksiyonlu benzetimden alınmıştır, enjeksiyon tonlarının pencereye sızması ~0,35 puan ekler. Enjeksiyonsuz koşuda $L_1$ akımı THD'si %9,05'tir."
- Yeni sayı gerekir mi: hayır. ($K_{34}=0$ için şebeke akımı THD'si istenirse [YENİ SAYI]: enjeksiyonsuz $K_{34}=0$ koşusu ya da `dalga.mat` kayıtlarından hesap.)
- Etkilenen: `tab:s4-tarama` (06:463–464, 08:25–55 gönderme alıyor, değer değişmiyor), `tab:s4-basamak`, `fig:s4-tarama-ozet`. `\umitnot` (05:273) %5,6'yı IEEE 1547 şebeke akımı sınırıyla karşılaştırıyor; not $L_1$ akımına aittir (PDF'te görünmez, bilgi için).

**H-49 — Büyütülmüş DA bara kapsamı ve üç faz gerekçesi — yüksek**
- Güncel yer: 05:239 "Üç fazlı donanımda toplam kapasitans faz payının üç katıdır." ve "Salınımı sınırlamak amacıyla S4 orta ve anma akımı benzetimlerinde bara kapasitansı…"; 03:507 "DA bara kapasitörleri, S4 orta ve anma akımı benzetimleri"; 06:389 "üç fazlı donanımda toplam bara kapasitansı faz payının üç katıdır"; 05:541 son cümle.
- Durum: açık.
- Jürinin soracağı soru: "2,3 A satırları hangi barayla koşuldu, üç katı kapasitans 25 A'de neden yetmiyor da on iki katına çıkıldı?"
- Önerilen metin değişikliği:
  - 05:239 kapsam — **Mevcut:** "Salınımı sınırlamak amacıyla S4 orta ve anma akımı benzetimlerinde bara kapasitansı 2$\times$\SI{5.6}{\milli\farad} değerine büyütülmüş ve salınım yaklaşık \SI{10}{\volt}'a (\%4,7) inmiştir (Tablo~\ref{tab:sistem-parametreleri})."
    - **Önerilen:** "Salınımı sınırlamak amacıyla bütün S4 benzetimlerinde bara kapasitansı 2$\times$\SI{5.6}{\milli\farad} değerine büyütülmüş ve \SI{25}{\ampere}'deki salınım yaklaşık \SI{10}{\volt}'a (\%4,7) inmiştir (Tablo~\ref{tab:sistem-parametreleri})."
  - 05:239 gerekçe — **Mevcut:** "Üç fazlı donanımda toplam kapasitans faz payının üç katıdır."
    - **Önerilen A (yeni sayı yok):** "Üç fazlı dört telli donanımda dengeli çalışmada fazların temel bileşen orta nokta akımları birbirini götürmektedir. Orta noktada yalnız \SI{150}{\hertz} ve katlarındaki bileşenler kalmaktadır." ve paragrafın sonuna: "Büyütülmüş bara kapasitansı, üç fazlı donanımdaki küçük orta nokta salınımını faz başına modelde temsil etmektedir."
    - **Önerilen B [HESAP – tez sahibi onayı]:** A'daki iki cümleden sonra: "Saf sinüs görev oranı ve akım kabulüyle üç fazın orta nokta akımı, $m$ modülasyon genliği olmak üzere $(8/5\pi)\,m\hat I$ tepe değerli \SI{150}{\hertz} bileşendir. \SI{25}{\ampere}'de toplam kapasitansla (2$\times$\SI{1410}{\micro\farad}) salınım yaklaşık \SI{5}{\volt}'tur." Paragraf sonu A ile aynı.
  - 03:507 — **Mevcut:** "DA bara kapasitörleri, S4 orta ve anma akımı benzetimleri & \num{5600} & …" → **Önerilen:** "DA bara kapasitörleri, S4 benzetimleri & \num{5600} & …"
  - 06:389 — **Mevcut:** "S4 benzetiminde \SI{25}{\ampere} için büyütülen DA bara kapasitansı faz başına modelden kaynaklanır; üç fazlı donanımda toplam bara kapasitansı faz payının üç katıdır (Alt Bölüm~\ref{sec:s4-kapali-cevrim})."
    - **Önerilen:** "S4 benzetiminde büyütülen DA bara kapasitansı, üç fazlı donanımdaki orta nokta akımı götürmesini faz başına modelde temsil etmektedir (Alt Bölüm~\ref{sec:s4-kapali-cevrim})." (Noktalı virgül ve "kaynaklanır" geniş zamanı da kalkar. H-09 uyarınca cümle tümüyle de çıkabilir.)
  - 05:541 son cümle — **Mevcut:** "Kararlılık analizi, S4 anma akımı benzetimlerindeki büyütülmüş bara kapasitansıyla (2$\times$\SI{5.6}{\milli\farad}) yapılmıştır." → **Önerilen:** "Anahtarlamalı modeldeki kararlılık ölçümleri, S4 benzetimlerindeki büyütülmüş bara kapasitansıyla (2$\times$\SI{5.6}{\milli\farad}) yapılmıştır." (Ortalama modelde bara sabit $V_{\mathrm{dc}}/2$'dir, review Sınırlılıklar 5.)
- Savunmada sözlü yanıt: "Faz başına modelde 50 Hz faz akımının tamamı bara kapasitörlerinden döner. Dengeli üç faz dört telli donanımda fazların temel bileşenleri orta noktada birbirini götürür ve geriye 150 Hz bileşeni kalır. Üç fazın toplam kapasitansıyla 25 A'de salınım yaklaşık 5–10 V'tur, büyütülmüş baralı faz başına model de yaklaşık 10 V verir. Büyütülmüş bara, üç fazlı davranışın faz başına vekilidir. D-11 bağıntısı faz akımının tamamını kullandığı için bir üst sınırdır (Y-04)."
- Yeni sayı gerekir mi: A hayır, B [HESAP].
- Etkilenen: 03:507, 05:239, 05:541, 06:389, 08:111 (doğru, "orta ile anma akımı benzetimleri … büyütülmüş DA bara koşulunda" ifadesi yanlış değil, dokunulmasa da olur).

**H-48 — "7,2 W kayıp farkı" — yüksek (H-27 ve Y-02 ile birlikte)**
- Güncel yer: 05:243 "Yaklaşık \SI{280}{\watt} çıkışta S4 verimi \%96,2, S3 benzetiminin verimi \%94,25'tir. Aradaki yaklaşık \SI{7.2}{\watt}'lık kayıp farkı çekirdek kaybı parametresinden gelmektedir."
- Durum: açık. Hesap §3.1: toplam fark 6,1 W.
- Jürinin soracağı soru: "Verdiğiniz verimlerden kayıp farkı 6,1 W çıkıyor, 7,2 W nereden geliyor?"
- Önerilen metin değişikliği (05:243'ün son üç cümlesi):
  - **Mevcut:** "S4, $L_1$ çekirdek kaybı için S1--S3'ten farklı bir paralel direnç kullandığından (Tablo~\ref{tab:sistem-parametreleri}) S4 verimi S4 benzetimleri arasında karşılaştırılmaktadır. Yaklaşık \SI{280}{\watt} çıkışta S4 verimi \%96,2, S3 benzetiminin verimi \%94,25'tir. Aradaki yaklaşık \SI{7.2}{\watt}'lık kayıp farkı çekirdek kaybı parametresinden gelmektedir."
  - **Önerilen A (yeni sayı yok, önerilen):** "S4, $L_1$ çekirdek kaybı direnci ve DA bara kapasitansı için S1--S3'ten farklı değerler kullanmaktadır (Tablo~\ref{tab:sistem-parametreleri}). Dolayısıyla S4 verimi ve THD'si S4 benzetimleri arasında karşılaştırılmaktadır."
  - **Önerilen B [HESAP]:** A'nın iki cümlesine ek: "Yaklaşık \SI{280}{\watt} çıkışta toplam kayıp S4'te \SI{11.0}{\watt}, S3 benzetiminde \SI{17.1}{\watt}'tır. Çekirdek kaybı direncindeki fark tek başına yaklaşık \SI{7.2}{\watt} kayıp farkı oluşturmaktadır."
- Savunmada sözlü yanıt: "Toplam kayıp farkı 6,1 W'tır. Çekirdek kaybı direnci S4'te 1500 Ω, S3'te 600 Ω'dur ve aynı gerilimde 7,2 W fark yaratır. Öteki kayıplar S4'te yaklaşık 1 W yüksektir. Dolayısıyla tezde S4 verimi yalnız S4 koşuları arasında karşılaştırılmaktadır."
- Yeni sayı gerekir mi: A hayır, B [HESAP].
- Etkilenen: yok (gönderme yok). B seçilmezse S3–S4 verim karşılaştırması tezden çıkar.

**H-27 — S3–S4 verim karşılaştırma cümleleri — düşük**
- Güncel yer: 05:243 (yukarıdaki üç cümle). Durum: açık. H-48 seçenek A ile kapanır. Rapor 17'nin "cümleyi tablo başlığına taşı" önerisi yerine metinde tek cümle kalması önerilir, çünkü tablo başlığı H-47 ile zaten uzamaktadır.
- Jürinin sorusu, sözlü yanıt ve etiketler H-48 ile aynı. Yeni sayı: hayır.

**H-46 — $|u|_{\max}=1{,}49$ ile doyum tanımı — orta**
- Güncel yer: 05:313 "Geçişte doyum & zamanın \%0,8'i; $|u|_{\max}=1{,}49$ \\" ↔ 03:358 $u=\operatorname{sat}_{\pm1}(u_{\mathrm{ff}}+u_{\mathrm{fb}})$ ↔ 05:253 `tab:s4-tarama` son sütunu ↔ 05:350 "$|u|_{\max}\leq0{,}93$".
- Durum: açık. Ayrıca hücrede noktalı virgül var (kural 2).
- Jürinin soracağı soru: "$u$ ±1'e doyuruluyorsa nasıl 1,49 olabiliyor?"
- Önerilen metin değişikliği:
  - 05:313 — **Mevcut:** "Geçişte doyum & zamanın \%0,8'i; $|u|_{\max}=1{,}49$ \\"
  - **Önerilen:** "Geçişte doyum & zamanın \%0,8'i, doyum öncesi $|u_{\mathrm{ff}}+u_{\mathrm{fb}}|_{\max}=1{,}49$ \\"
  - İsteğe bağlı, tutarlılık için `tab:s4-tarama` sütun başlığı "$|u|_{\max}$" kalabilir, çünkü sekiz satırın hepsinde değer 1'in altındadır ve doyum öncesi toplam ile $u$ eşittir.
  - Şekil `s4_basamak_PI_10_25A_KC.pdf` göstergesi "u = uff + ufb" → "$u_{\mathrm{ff}}+u_{\mathrm{fb}}$ (doyum öncesi)" (H-37).
- Savunmada sözlü yanıt: "1,49, doyum bloğuna giren toplamın tepe değeridir ve yalnız basamak anında, zamanın %0,8'i boyunca görülür. Uygulanan komut ±1'dir. PI integratörü geri hesaplamalı doyum önlemeyle korunduğu için yaklaşık 0,4 ms içinde doyumdan çıkılmaktadır."
- Yeni sayı gerekir mi: hayır.
- Etkilenen: `tab:s4-basamak` (06:465 gönderme alıyor), `fig:s4-basamak`.

**H-55 — Basamak aşımı ve yerleşme süresi için iki değer — orta**
- Güncel yer: 05:310 "Aşım (son kararlı zarfa göre) & \%0,2", 05:312 "\SI{0.44}{\milli\second}" ↔ 05:524 "Anahtarlamalı, $K_{34}$ açık & \%0,17 & 0,43" ↔ 05:547 "aşım \%0,2, yerleşme \SI{0.44}{\milli\second}" ↔ 06:465 "Aşım \%0,2, yerleşme süresi \SI{0.44}{\milli\second}".
- Durum: açık. Kaynak farkı §3.4.
- Jürinin soracağı soru: "Aynı koşunun yerleşme süresi iki tabloda neden farklı?"
- Önerilen metin değişikliği:
  - **Seçenek A (en az değişiklik):** dört yerde karşılaştırma tablosunun değerleri kullanılır, çünkü dört satırlık karşılaştırma aynı çözünürlükle hesaplanmıştır.
    - 05:310 **Mevcut:** "Aşım (son kararlı zarfa göre) & \%0,2 \\" → **Önerilen:** "Aşım (son kararlı zarfa göre) & \%0,17 \\"
    - 05:312 **Mevcut:** "Yerleşme süresi (hata bandı) & \SI{0.44}{\milli\second} \\" → **Önerilen:** "Yerleşme süresi (hata bandı) & \SI{0.43}{\milli\second} \\"
    - 05:547 **Mevcut:** "…basamağında son kararlı zarfa göre aşım \%0,2, yerleşme \SI{0.44}{\milli\second}'dir." → **Önerilen:** "…basamağında son kararlı zarfa göre aşım \%0,17, yerleşme \SI{0.43}{\milli\second}'dir."
    - 06:465 **Mevcut:** "Aşım \%0,2, yerleşme süresi \SI{0.44}{\milli\second}." → **Önerilen:** "Aşım \%0,17, yerleşme süresi \SI{0.43}{\milli\second}."
  - **Seçenek B:** H-34 birleştirmesi (rapor 17): iki tablo tek tabloya iner, `tab:s4-basamak` etiketi birleşik tabloya verilir, tek değer kalır.
- Savunmada sözlü yanıt: "İki değer aynı koşudan, aynı tanımla gelmektedir. Fark, zarf tepelerinin 1 µs ve 10 µs ızgarada aranmasından doğan 0,01 ms ve 0,02 puanlık çözünürlük farkıdır."
- Yeni sayı gerekir mi: hayır (iki değer de mevcut CSV'lerde).
- Etkilenen: `tab:s4-basamak`, `tab:kararlilik-basamak`, 06:465.

**H-44 — 2,3 A'de kararlılık hükmünün dayanağı — orta**
- Güncel yer: 05:509 "Çevrim kazancı \SI{212}{}--\SI{1037}{\hertz} aralığında $-7$ ile \SI{-10}{\decibel} arasında, fazı $-49^{\circ}$'den öndedir. Çevrim yavaş ama kararlıdır." ↔ `tab:kararlilik-olcum` 2,3 A sütunu (587,5, 2025, 3362,5 Hz boş) ↔ 05:541.
- Durum: açık. 05:541 ölçüm aralığını olumlu biçimde yazıyor, 05:509'daki hüküm ise hâlâ düşük frekans ölçümüne dayanıyor.
- Jürinin soracağı soru: "2,3 A'de rezonans bölgesini ölçmediniz, kararlılık hükmünü neye dayandırıyorsunuz?"
- Önerilen metin değişikliği:
  - **Mevcut:** "Çevrim kazancı \SI{212}{}--\SI{1037}{\hertz} aralığında $-7$ ile \SI{-10}{\decibel} arasında, fazı $-49^{\circ}$'den öndedir. Çevrim yavaş ama kararlıdır."
  - **Önerilen A (yeni sayı yok):** "Çevrim kazancı \SI{212}{}--\SI{1037}{\hertz} aralığında $-7$ ile \SI{-10}{\decibel} arasında, fazı $-49^{\circ}$'den öndedir. \SI{2.3}{\ampere}'de kararlılık, P ve PI kapalı çevrim benzetimlerinin kararlı duruma oturmasıyla gösterilmiştir (Tablo~\ref{tab:s4-tarama}). Enjeksiyon ölçümü aynı noktada köprü kazancındaki düşüşü nicelemektedir."
  - **Önerilen B [YENİ SAYI]:** 2,3 A'de B kümesi tonlarıyla (587,5 / 2025 / 3362,5 Hz) bir enjeksiyon koşusu (~30 dk, mevcut betik `run_enjeksiyon_kararlilik_20261028.m`). Tez sahibi yeni koşu istemediği için A önerilir.
- Savunmada sözlü yanıt: "2,3 A'de köprü süreksiz iletimdedir ve etkin kazancı tasarım değerinin 0,14–0,71 katına düşer. Kazanç taraması λ = 0,05–50 aralığının tamamında kararlılığı gösterir, yani kazanç düşüşü kararlılığı bozmaz. Zaman alanında P ve PI benzetimleri son iki periyot arasında %0,12'den az farkla oturmuştur."
- Yeni sayı gerekir mi: A hayır, B [YENİ SAYI].
- Etkilenen: `tab:s4-tarama` (gönderme eklenir, aynı bölüm içi).

**H-45 — Çevrim dışı ayrımının ideal PLL varsayımı — orta**
- Güncel yer: 05:350 "$\theta$ yalnız zamana bağlıdır ve şebekeye kilitlidir. Dolayısıyla $\sin^3\theta$ işaretinin bütün girişleri çevrimin dışındadır." ↔ 05:200 "…aynı yol sanal empedans ile aktif sönümleme etkisi de oluşturabilir \citep{Lu2016}. İleri besleme yolunun etkisi, gerilim düşümü hesabından daha geniş bir çerçevede ele alınmıştır."
- Durum: açık.
- Jürinin soracağı soru: "Gerçek bir eviricide $\theta$ ölçülen gerilimden PLL ile üretilir. Zayıf şebekede ileri besleme yolu PLL üzerinden çevrime bağlanmaz mı?"
- Önerilen metin değişikliği:
  - 05:350 — **Mevcut:** "$\theta$ yalnız zamana bağlıdır ve şebekeye kilitlidir. Dolayısıyla $\sin^3\theta$ işaretinin bütün girişleri çevrimin dışındadır."
    - **Önerilen:** "Analizde $\theta$, ideal PLL ile şebeke kaynağına kilitli açıdır ve yalnız zamana bağlıdır. Sin\textsuperscript{3} terimi yalnız $\theta$ açısını kullanmaktadır. Dolayısıyla $\sin^3\theta$ işaretinin bütün girişleri çevrimin dışındadır."
  - 05:200 — **Mevcut:** "Şebeke gerilimi ileri beslemesi ideal durumda evirici ile şebeke gerilimini yaklaştırarak düşük akımdaki göreli gerilim hatasını azaltabilir. LCL filtre, ortak bağlantı noktası ölçümü ve sayısal gecikme eklendiğinde aynı yol sanal empedans ile aktif sönümleme etkisi de oluşturabilir \citep{Lu2016}. İleri besleme yolunun etkisi, gerilim düşümü hesabından daha geniş bir çerçevede ele alınmıştır."
    - **Önerilen:** "Şebeke gerilimi ileri beslemesi evirici ile şebeke gerilimini yaklaştırarak düşük akımdaki göreli gerilim hatasını azaltabilir."
  - İsteğe bağlı, 08:115 sonuna (Gelecek Çalışmalar, öneri dili): "PLL dinamiğinin ve zayıf şebekede ölçülen ortak bağlantı noktası geriliminin ileri besleme yoluna etkisi de aynı aşamada incelenmelidir \citep{Lu2016}."
- Savunmada sözlü yanıt: "Sin³ terimi şebeke geriliminin genliğini değil, yalnız faz açısını kullanır (Eşitlik s4-denetim-yapisi). Gerçek uygulamada açı PLL'den gelir ve PLL bant genişliği onlarca hertz düzeyindedir, akım çevriminin 586 Hz'lik birinci geçişinin çok altındadır. Dolayısıyla PLL üzerinden oluşabilecek bağlaşım akım çevriminin kritik bölgesine girmez. Zayıf şebeke etkisi ideal PLL ile 0–5 mH ek endüktans taramasında incelenmiştir, PLL dinamiğiyle birlikte incelenmesi önerilen gelecek çalışmadır."
- Yeni sayı gerekir mi: hayır.
- Etkilenen: `Lu2016` 05:438'de ve başka bölümlerde kalır, atıf düşmez.

**H-51 — Yapılmamış işi yapılmış gibi okutan ifadeler — orta**
- Güncel yer ve durum: 05:41 ve 05:45 kesimle birlikte kalktı (kısmen kapandı). Kalanlar: 05:511 "akım düzeyiyle ölçeklenen bir büyüklüktür", 05:547 "akım düzeyiyle ölçeklenmektedir", 05:200 "daha geniş bir çerçevede ele alınmıştır" (H-45 ile kalkar), 03:433 "denetim eforu … değerlendirilmektedir".
- Jürinin soracağı soru: "Sin³ genliğini akımla ölçeklediniz mi? Denetim eforunu nerede ölçtünüz?"
- Önerilen metin değişikliği:
  - 05:511 — **Mevcut:** "Temel bileşendeki yarar ile üçüncü harmonikteki bedel birlikte gözetildiğinde en uygun ileri besleme genliği, akım düzeyiyle ölçeklenen bir büyüklüktür." → **Önerilen:** "Temel bileşendeki yarar ile üçüncü harmonikteki bedel birlikte gözetildiğinde en uygun ileri besleme genliği akım düzeyine bağlıdır."
  - 05:547 — **Mevcut:** "Nötr susturma düşük güç bölgesi için tasarlanmıştır. En uygun Sin\textsuperscript{3} genliği ise akım düzeyiyle ölçeklenmektedir." → **Önerilen:** "Nötr susturma düşük güç bölgesi için tasarlanmıştır. En uygun Sin\textsuperscript{3} genliği ise akım düzeyine bağlıdır."
  - 03:433 — **Mevcut:** "Sin\textsuperscript{3} teriminin başarısı yalnızca düşük güç THD değeriyle değil, akım izleme hatası, kararlılık marjı, denetim eforu, doyum süresi ve anma akımındaki etkisiyle birlikte değerlendirilmektedir." → **Önerilen:** "Sin\textsuperscript{3} teriminin etkisi, düşük güç THD değerinin yanında akım izleme hatası, kararlılık marjı, doyum ve anma akımındaki üçüncü harmonik katkısıyla birlikte incelenmiştir."
- Savunmada sözlü yanıt: "Tezde Sin³ genliği sabittir ve 2,3 A'e kalibre edilmiştir. Anma akımındaki üçüncü harmonik bedeli ve temel bileşendeki yarar ayrı ayrı nicelenmiştir. Akıma göre genlik ayarı Gelecek Çalışmalar'da önerilmektedir."
- Yeni sayı gerekir mi: hayır. Etkilenen: 03:433, 05:511, 05:547, 08:76 ("akım düzeyine göre ayarlanabilen bir tasarım parametresidir", doğru, dokunulmaz).

**H-31 — Bölüm 3 doğrulama matrisinde yöntem adı ve simge — orta**
- Güncel yer: 03:587 "Kararlılık & S4: P, PI, PIR; $K_3$ açık ve kapalı & Ortalama model ve anahtarlamalı model doğrusallaştırması. $L$, $S$, $T$, marjlar, kutuplar"; 03:532–535 "$K_1$", "$K_3$", "$\varphi$", "$K_3/K_1$ oranı sabit".
- Durum: açık. Bölüm 5 (05:478) anahtarlamalı modelin doğrusallaştırılamadığını, kazancın enjeksiyonla ölçüldüğünü yazıyor. `simgeler.tex`:34 ve 03:365 $K_{1x}$, $K_{3x}$, $\varphi_x$ kullanıyor.
- Jürinin soracağı soru: "Bölüm 3 anahtarlamalı modelin doğrusallaştırıldığını söylüyor, Bölüm 5 doğrusallaştırılamadığını. Hangisi?"
- Önerilen metin değişikliği:
  - 03:587 — **Önerilen:** "Kararlılık & S4: P, PI ve PIR, $K_{34}$ açık ve kapalı & Ortalama modelin doğrusallaştırılması ve anahtarlamalı modelde enjeksiyon ölçümü. $L$, $S$, $T$, marjlar, kutuplar & Alt Bölüm~\ref{sec:kararlilik-bode} \\" (hücredeki noktalı virgül de virgüle döner.)
  - 03:532 "Temel modülasyon genliği $K_1$" → "Temel modülasyon genliği $K_{1x}$"
  - 03:533 "Sin\textsuperscript{3} kazancı $K_3$ & … & KL; $K_3/K_1$ oranı sabit" → "Sin\textsuperscript{3} kazancı $K_{3x}$ & … & KL, $K_{33}/K_{13}$ oranı sabit" (06:522 ile aynı yazım, hücredeki noktalı virgül de virgüle döner)
  - 03:534 "Referans fazı $\varphi$" → "Referans fazı $\varphi_x$"
  - 03:535 "S4 ileri besleme $K_1$, $K_3$, $\varphi$" → "S4 ileri besleme $K_{14}$, $K_{34}$, $\varphi_4$"
- Savunmada sözlü yanıt: "Anahtarlamalı modelde PWM karşılaştırıcısının yerel türevi hemen her yerde sıfırdır, doğrusallaştırma denetlenen sistemin yolunu keser. Dolayısıyla anahtarlamalı modelde çevrim kazancı üç tonlu küçük işaret enjeksiyonuyla ölçülmüştür, ortalama model ise Simulink Control Design ile doğrusallaştırılmıştır."
- Yeni sayı gerekir mi: hayır. Etkilenen: `tab:dogrulama-matrisi`, `tab:sistem-parametreleri`; `simgeler.tex`:79 "$\varphi$" girdisi kalabilir.

**H-28 — Faz payı baralı PI 25 A koşusunun sayıları — orta (Y kapsamıyla genişledi)**
- Güncel yer: 05:239 "Faz payı kapasitansla yapılan PI benzetiminde evirici darbe yüksekliği … \SI{270}{\volt}'tan \SI{100}{\volt}'a inmiş, modülasyon zamanın \%20,6'sında doyuma girmiş, temel akım genlik hatası $-$\%31,9, THD \%57,4 olmuştur." ve "Aynı PI denetleyicide genlik hatası $-$\%2,1'e, THD \%9,2'ye inmekte ve doyum ortadan kalkmaktadır."
- Durum: açık. **Yeni bulgu:** review notuna göre özgün baralı `PI_25A` koşusu oturmamıştır (`dP_ac_onceki_periyot_pct` = −31,1, "kararlı durum yok"). Ayrıca özgün bara taraması parametre dosyasındaki ileri besleme değerleriyle (0,45 / 0,39 / 0°) koşulmuştur, kesin tarama ise kalibre S3 değerleriyle. "Aynı PI denetleyicide" karşılaştırması iki değişkeni birlikte değiştirmektedir.
- Jürinin soracağı soru: "−%31,9 ve %57,4 kararlı durumdan mı alındı, karşılaştırılan iki koşu yalnız barada mı farklı?"
- Önerilen metin değişikliği:
  - **Mevcut:** yukarıdaki iki cümle.
  - **Önerilen:** "Faz payı kapasitansla yapılan \SI{25}{\ampere} PI benzetiminde modülasyon zamanın \%20,6'sında doyumda kalmakta ve çözüm periyottan periyoda yaklaşık \%31 değişmektedir. Büyütülmüş barayla PI denetleyici referansı $-$\%2,1 genlik hatasıyla doyumsuz izlemekte, THD \%9,2'ye inmektedir."
- Savunmada sözlü yanıt: "Özgün barada integratör doyumdan çıkamadığı için kararlı periyodik durum oluşmaz, sayılar son periyodun anlık değeridir. İleri besleme değerlerindeki fark yaklaşık %1,5'tir ve 120 V'luk orta nokta salınımı yanında belirleyici değildir. Belirleyici olan, evirici darbe yüksekliğinin alternans içinde 270 V'tan 100 V'a inmesidir."
- Yeni sayı gerekir mi: hayır (%31 review notunda ve `metrik.csv`'de).
- Etkilenen: yok.

**H-53 — Kaynaksız tasarım ölçütü — düşük**
- Güncel yer: 05:416 "Yaygın tasarım ölçütleri her kazanç geçişinde $\mathrm{PM}_i\gtrsim45^{\circ}$, $\mathrm{GM}\gtrsim\SI{6}{\decibel}$ ve $\|S\|_\infty\lesssim\SI{6}{\decibel}$'dir. Ayrıca $\mathrm{DM}_{\min}$ toplam denetim gecikmesinden büyük olmalıdır."
- Durum: açık. `references.bib` içinde denetim ders kitabı yok (Skogestad, Åström, Franklin aranmadı bulundu).
- Jürinin soracağı soru: "PM, GM ve $M_s$ ölçütleri hangi kaynaktan?"
- Önerilen metin değişikliği:
  - **Önerilen A (önerilen):** "Tasarım ölçütü olarak her kazanç geçişinde $\mathrm{PM}_i\gtrsim45^{\circ}$, $\mathrm{GM}\gtrsim\SI{6}{\decibel}$ ve $\|S\|_\infty\lesssim\SI{6}{\decibel}$ alınmıştır. $\mathrm{DM}_{\min}$ değerinin toplam denetim gecikmesinden büyük olması da ölçütlere eklenmiştir."
  - **Önerilen B:** A'ya künyesi tez sahibince doğrulanmış bir kaynak eklenir (ör. Skogestad ve Postlethwaite, *Multivariable Feedback Control*, 2. baskı, Wiley, 2005; kitap GM > 2, PM > 30°, $M_s$ < 2 verir, 45° için ayrı kaynak gerekir). Yeni bib girdisi gerektirir.
- Savunmada sözlü yanıt: "$\|S\|_\infty\leq6$ dB koşulu tek başına GM ≥ 6 dB ve PM ≥ 29° güvencesi verir. 45° faz marjı akım çevrimlerinde aşımı küçük tutmak için kullanılan olağan seçimdir. Tasarım bütün ölçütleri analog eşdeğerde sağlamaktadır (PM 54°, GM 35 dB, $M_s$ 2,4 dB)."
- Yeni sayı: hayır. Etkilenen: yok.

**H-52 — Simge çakışmaları — düşük**
- Güncel yer ve durum: hepsi açık.
  - $d$: görev oranı (05:33) ve enjeksiyon işareti (05:478, dört yer).
  - $L$: eşdeğer endüktans (05:33–91) ve çevrim kazancı $L(s)$ (05:329 sonrası).
  - $N$, $P$, $Z$ (`eq:marj-tanimlari`, 05:387, 05:392): P denetleyicisi, $P/O/N$ durumları ve orta nokta $N$ ile çakışıyor.
  - $i_g$ (05:102): tek endüktanslı analitik modelde "şebeke akımı", oysa Bölüm 3'te $i_g$ C noktası akımıdır.
- Jürinin soracağı soru: "$L$ hem endüktans hem çevrim kazancı mı?"
- Önerilen metin değişikliği:
  - 05:478: "$d$" → "$u_{\mathrm{inj}}$" (dört yer): "…modülasyon toplamına küçük bir işaret $u_{\mathrm{inj}}$ eklenmiştir ($u_x=u_{\mathrm{fb}}+u_{\mathrm{inj}}$). $u_{\mathrm{inj}}=0$ iken model taramadaki modelle matematiksel olarak aynıdır. $u_{\mathrm{inj}}$, her biri 0,015 genlikli üç tonlu (Schroeder fazlı) bir toplamdır."
  - 05:102 — **Mevcut:** "Tam periyot şebeke akımı $i_g(\theta)$ yarım dalga tek simetrisine sahipse…" → **Önerilen:** "Tam periyot ortalama akımı $\bar i_L(\theta)$ yarım dalga tek simetrisine sahipse…", `eq:akim-fourier-katsayisi` içinde $i_g$ → $\bar i_L$ (ya da rapor 17 H-20 ile eşitlik çıkar).
  - $L$ → $L_1$: 05:33'te "eşdeğer endüktans $L$" → "eşdeğer endüktans $L_1$", `eq:dcm-tepe-akimi`, `eq:dcm-ortalama-akim`, `eq:dcm-sinus-zarfi`, `eq:ccm-diferansiyel`, `eq:ccm-akim-cozumu` içinde $L$ → $L_1$. 05:57 ve 05:113'teki "$L=L_1$" ifadeleri kalkar. (Matematik değişikliği, tez sahibi onayıyla.)
  - `eq:marj-tanimlari`: "$Z=N+P=0,\ P=0$" → "$Z_{\mathrm{k}}=N_{\mathrm{s}}+P_{\mathrm{a}}=0,\ P_{\mathrm{a}}=0$"; 05:392 tanım: "$N_{\mathrm{s}}$ $(-\infty,-1)$ ışınının net kesişim sayısı, $P_{\mathrm{a}}$ ve $Z_{\mathrm{k}}$ sırasıyla açık ve kapalı çevrimin sağ yarı düzlemdeki kutup sayısıdır." ve "($P_{\mathrm{a}}=0$) kararlılık koşulu $N_{\mathrm{s}}=0$'dır."
- Savunmada sözlü yanıt: gerekmez (biçimsel düzeltme).
- Yeni sayı: hayır. Etkilenen: `simgeler.tex` (girdi eklenebilir).

**H-56 — Değerlendirme'de iddia gücü — düşük**
- Güncel yer: 05:549 "Anahtarlamalı modelde ise farklar ölçüm belirsizliği düzeyindedir." ↔ 05:500 "Fark her noktada iki ölçümün birleşik belirsizliği içinde ya da sınırındadır."
- Durum: açık.
- Jürinin soracağı soru: "3362,5 Hz'te fark 4,2°, belirsizlik ±3,6°. 'Belirsizlik düzeyinde' demek doğru mu?"
- Önerilen metin değişikliği: **Mevcut:** yukarıdaki cümle. **Önerilen:** "Anahtarlamalı modelde farklar iki ölçümün birleşik belirsizliği içinde ya da sınırındadır ve iki benzetimin farklı akımda çalışmasından kaynaklanmaktadır."
- Savunmada sözlü yanıt: "$K_{34}=0$ koşusunda temel akım 21,9 A, $K_{34}$ açık koşuda 24,5 A'dir. Kalan fark çalışma noktasından gelir, ortalama modelde ve doğrusallaştırmada fark tam sıfırdır."
- Yeni sayı: hayır. Etkilenen: yok.

**H-58 — Köprü davranışı terimi — düşük**
- Güncel yer: 05:158 "köprünün süreksiz iletimdeki yumuşak gerilim kaynağı davranışından" ↔ 05:509 "Köprü \SI{2.3}{\ampere}'de süreksiz iletimde akım kaynağına yakın davranmaktadır." ↔ 06:526 "Köprünün yumuşak kaynak davranışı".
- Durum: açık.
- Jürinin soracağı soru: "Köprü süreksiz iletimde gerilim kaynağı mı, akım kaynağı mı?"
- Önerilen metin değişikliği:
  - 05:158 — "köprünün süreksiz iletimdeki yumuşak gerilim kaynağı davranışından" → "köprünün süreksiz iletimdeki yumuşak kaynak davranışından"
  - 05:509 — **Mevcut:** "Köprü \SI{2.3}{\ampere}'de süreksiz iletimde akım kaynağına yakın davranmaktadır." → **Önerilen:** "\SI{2.3}{\ampere}'de köprünün yumuşak kaynak davranışı belirginleşmekte ve köprü akım kaynağına yaklaşmaktadır."
- Savunmada sözlü yanıt: "Süreksiz iletimde köprünün temel bileşen gerilimi akıma bağlıdır, yani iç empedansı büyüktür. Bölüm 6'da yumuşak kaynak olarak tanımlanan davranışın uç durumunda köprü akım kaynağına yaklaşır. Enjeksiyonda bitkinin 212–1037 Hz aralığında neredeyse düz kazanç göstermesi, köprünün akım kaynağına yaklaştığını ölçümle göstermektedir."
- Yeni sayı: hayır. Etkilenen: yok.

**H-57 — Farklı DA bara ve güçte verim karşılaştırması — düşük**
- Güncel yer: Bölüm 5'teki cümle H-04 ile kalktı (**kapandı**). Bölüm 8'de kalıyor: 08:34 "THD klasik anahtarlamanın \%15 düzeyine dönerken verim klasik anahtarlamadan 2,0 puan yüksek kalmıştır."
- Jürinin soracağı soru: "S1 431,5 V ve 249,6 W'ta, S3 427,5 V ve 281,2 W'ta. 2,0 puan aynı koşulda mı?"
- Önerilen metin değişikliği (08:34): **Önerilen:** "THD klasik anahtarlamanın \%15 düzeyine dönerken verim klasik anahtarlamadan 2,0 puan yüksek kalmıştır. S1 ve S3 deneyleri sırasıyla \SI{431.5}{\volt} ve \SI{427.5}{\volt} DA bara geriliminde yürütülmüştür."
- Savunmada sözlü yanıt: "Deneyler aynı akım düzeyinde ama farklı DA bara gerilimi ve güçte yapılmıştır. Kalibre edilmiş benzetim aynı sıralamayı vermektedir."
- Yeni sayı: hayır (değerler 06:563–568'de). Etkilenen: 08:34.

**H-42 — Karşılaştırma çiftleri — düşük (kısmen kapandı)**
- Güncel yer: 05:137 "Karşılaştırma için alınan $(0{,}45,\ 0{,}37)$, $(0{,}44,\ 0{,}38)$ ve $(0{,}41,\ 0{,}41)$ çiftleri S1 noktasında…"
- Durum: kısmen kapandı. "%1–2" iddiası ve "dört katı" karşılaştırması kalktı, tepe değer ve CCM'ye geçiş nedeni yazıldı. Kalan risk: $(0{,}44,\ 0{,}38)$ kalibre S3 katsayılarına ($0{,}4434$, $0{,}3843$) neredeyse eşit.
- Jürinin soracağı soru: "S3'te %14,8 THD veren katsayı analitik modelde %68 THD veriyor. Analitik model güvenilir mi?"
- Önerilen metin değişikliği (isteğe bağlı): üç çift yerine iki çift yazılır, "$(0{,}44,\ 0{,}38)$" çıkar. Sayılar CSV'de olduğu gibi kalır ($I_1$ 8,5–9,2 A aralığı iki çiftle de geçerli).
- Savunmada sözlü yanıt: "Analitik katman tek endüktanslı ve kayıpsızdır, S1 noktasında kritik görev oranı 0,785'tir. Tepe görev oranı 0,82 olan çift analitik modelde alternans ortasında CCM'ye girer. Anahtarlamalı modelde kayıplar, ölü zaman, $C_f$–$L_2$ ağı ve köprünün yumuşak kaynak davranışı etkin görev oranını düşürür, ayrıca S3 noktasında kritik oran 0,822'dir."
- Yeni sayı: hayır.

**H-37 — Şekil içi yazılar — orta**
- Durum: açık. Bölüm 5'teki 13 şeklin hepsi açılıp okundu. Bulgular:

| Şekil (etiket, dosya) | Şekil içinde yazan | Sorun | Önerilen yazı | Yeniden çizim yolu |
|---|---|---|---|---|
| `fig:harmonik-mekanizma`, `tez-latex-v2/figures/sin3/harmonik_olusum_mekanizmasi.pdf` | (d) ve (e) göstergesi "kalibre S2 benzetimi"; eksen sayıları "0.5" | Kural 12; ondalık nokta (gösterge içi "0,768" virgüllü, eksenler noktalı) | "S2 benzetimi"; eksenlerde virgül | MATLAB: `tez-latex-v2/figures/sin3/uret_harmonik_mekanizma.m` satır 83 ve 93'te gösterge dizesi. Veri `runs/2026-10-29_tez_sekilleri/results/s2/sekil_kayit.mat` (git dışı, Windows makinesinde). pgfplots: (a)–(c) kapalı biçimden çizilebilir, (d)–(e) için S2 kaydı CSV'ye aktarılmalı. **MATLAB önerilir.** |
| `fig:sin3-yeniden-tarama`, `results/sin3_rescan_20260901/sin3_katsayi_taramasi_20260901_k.pdf` | "Ucuncu harmonik orani; beyaz: Irms uyumlu bolge, yildiz: en iyi nokta (k1=0.34, k3=0.40)" (sol başlık soldan kesik); "k1 (temel katsayi)", "k3 (sin3 katsayisi)", "Ortalama L1 akimi (A)", "Pozitif alternans ortalama akim zarfi", "k1=0.34, k3=0.40 (I3/I1=0.1%)", "Saf sinus dm=0.60 (I3/I1=40.0%)", "Temel bilesen" | Türkçe karakter yok, ondalık nokta, % sonda, **%0,1 ↔ metin %0,15**, başlık kesik | Sol: başlık kaldırılır (altyazı taşıyor), "$k_1$ (temel katsayı)", "$k_3$ (Sin³ katsayısı)", renk çubuğu "$I_3/I_1$ (%)"; sağ: "Ortalama $L_1$ akımı (A)", "$k_1=0{,}34$, $k_3=0{,}40$ ($I_3/I_1=\%0{,}15$)", "Saf sinüs $d_m=0{,}60$ ($I_3/I_1=\%39{,}96$)", "Temel bileşen" | MATLAB: `scripts/relabel_sin3_coefficients_20261116.m` (yalnız yazıları değiştirir, `.fig` var). pgfplots: sol panel `katsayi_taramasi.csv` (4131 satır: D1, D3, I3_over_I1_pct, Irms_A, clipped) ile `matrix plot*` olarak çizilebilir, sağ paneldeki zarf eğrileri CSV'de yok. **MATLAB relabel önerilir.** |
| `fig:s4-akim-izleme-25a`, `tez-latex-v2/figures/s4/s4_akim_izleme_25A_KC.pdf` | Panel başlıkları "KC P 25A: IL1,1 = 22.15 A (ref 25.0 A), genlik hatası -11.41 %, faz -2.60°, THDI = 9.8 %, η (Display) = 96.69 %", "KC PI 25A: …", "KC PIR 25A 02s: …" | İç koşu kodu (KC, 02s), Simulink blok adı (Display), ondalık nokta, % sonda; sayılar tabloyu yineliyor | "(a) P", "(b) PI", "(c) PIR" (sayılar `tab:s4-tarama`'da) | MATLAB: `runs/2026-10-28_s4_kapali_cevrim/sekiller/s4_akim_izleme_25A_KC.fig` açılıp başlıklar değiştirilir (`yeniden_ciz_bolum5_turkce_font_20261107.m` kalıbı). pgfplots önerilmez (1 µs anlık dalga, `dalga.mat` git dışı). |
| `fig:s4-tarama-ozet`, `s4_tarama_ozet_KC.pdf` | Y ekseni "ηη (Display) [%]", "THDI (h ≤ 50) [%]", sayılar "96.5", "97.5" | η iki kez, blok adı, ondalık nokta | "$\eta$ (%)", "Şebeke akımı THD'si (%)", "Genlik hatası (%)" | H-33 ile şekil çıkarsa iş kalmaz. Kalırsa **pgfplots önerilir**: 8 nokta, veri `runs/2026-10-28_s4_kapali_cevrim/s4_tarama_KC.csv` (sütunlar `D_Verim`, `THD_I_ac_h50_pct`, `izleme_genlik_hatasi_pct`) ya da doğrudan `tab:s4-tarama` değerleri. |
| `fig:s4-basamak`, `s4_basamak_PI_10_25A_KC.pdf` | Gösterge "u = uff + ufb", eksen "-0.5", "0.5", "modülasyon [-]" | Doyum öncesi toplam −1,49'a iniyor (H-46), ondalık nokta | "$u_{\mathrm{ff}}+u_{\mathrm{fb}}$ (doyum öncesi)", virgüllü eksen | MATLAB `.fig` (aynı klasör). H-34 ile şekil çıkarsa iş kalmaz. |
| `fig:kararlilik-l-bode`, `runs/2026-10-28_kararlilik/frekans/kararlilik_L_bode_K34.pdf` | Başlık "Çevrim kazancı L = C Kpwm G Hm e-sTd (ortalama model, gerçekleme A)" | $C$ yerine $C_i$, sıra Eşitlik `eq:sin3-acik-cevrim`'den farklı; başlık altyazıyı yineliyor | Başlık kaldırılır ya da "$L=C_iK_{\mathrm{pwm}}e^{-sT_d}GH_m$" | `.fig` yok. MATLAB: `scripts/analiz_kararlilik_20261028.m` (analitik, dakikalar). **pgfplots mümkün:** `frekans/bode_L_S_T_A.csv` (3000 satır; `L_dB_P/PI/PIR`, `L_deg_*`). $K_{34}=0$ işaretçileri ayrı sütun değildir (`k34_degismezlik.csv` fark 0), aynı sütundan `only marks` ile çizilir ve altyazı "örtüşmektedir" der. |
| `fig:kararlilik-s-t`, `kararlilik_S_T.pdf` | Başlık "Duyarlılık S = 1/(1+L) ve tümleyen T = L/(1+L) (K34 açık ve kapalı aynı)" | "tümleyen" ↔ metin "tamamlayıcı duyarlılık"; $K_{34}$ tekrarı (T-17) | Başlık kaldırılır | **pgfplots mümkün:** aynı CSV (`S_dB_*`, `T_dB_*`), 50 ve 150 Hz düşey çizgileri. |
| `fig:kararlilik-nyquist`, `kararlilik_nyquist_A_B.pdf` | "(A) analog eşdeğeri", "(B) sayısal, Ts = 100 µs, 1 Ts gecikme" | (B)'nin toplam gecikmesi $2T_s$ (05:438); **kritik kesişim çizim dışında (Y-01)** | "(B) sayısal, $T_s=\SI{100}{\micro\second}$, $1T_s$ hesaplama gecikmesi" | MATLAB analiz betiği ((B) eğrisi CSV'de yok). (A) `bode_L_S_T_A.csv`'den Re/Im türetilerek pgfplots ile çizilebilir. |
| `fig:kararlilik-lg`, `kararlilik_Lg_taramasi.pdf` | Gösterge "Lg = 0.0 mH" … "Lg = 5.0 mH" | Ondalık nokta | "$L_g=0$", "0,5", "1", "2", "5 mH" | `lg_taramasi.csv` yalnız özet, eğri yok → MATLAB. H-35 ile şekil çıkarsa iş kalmaz. |
| `fig:kararlilik-olcum`, `karsilastirma/kararlilik_L_olcum_karsilastirma.pdf` | Gösterge "anahtarlamalı, 2,3 A" (virgüllü), "ortalama Simulink modeli, 25 A" | Kendi içinde doğru, öteki şekillerle tutarsız; başlık altyazıyı yineliyor | Başlık kaldırılır | **pgfplots önerilir:** eğri `frekans/bode_L_S_T_A.csv` (`L_dB_PI`, `L_deg_PI`), noktalar `karsilastirma/ton_karsilastirma.csv` (`kosu`, `f_Hz`, `L_olcum_dB`, `L_olcum_deg`). |
| `fig:kararlilik-basamak`, `karsilastirma/kararlilik_basamak_K34.pdf` | Başlıklar "PI, 10 → 25 A basamağı (t = 55 ms)", "Geçici bileşen iL1(t) - iL1(t + 20 ms)" | Sorun yok (başlıklar altyazıyı yineliyor, biçim tercihi) | — | Dalga kayıtları CSV'de yok. |
| `fig:s3-kalibre-l1`, `model_dogrulama/s3_kalibre_l1.pdf` | "(a) S3, son periyot", "t - 80,6 ms [µs]" | Sorun yok (dosya adındaki "kalibre" görünmez) | — | — |
| `fig:s4-anahtarlama-girisi`, `umit_2026-11-09/s4_anahtarlama_girisi.pdf` | Simulink çizimi: K14, K34, Kp, ANAHTARLAMA | Metinle uyumlu (yalnız oransal kazanç gösteriliyor, K-09) | — | — |

- Jürinin soracağı soru: "Şekilde 'KC PIR 25A 02s' ne demek, 'ηη (Display)' nedir, neden %0,1 yazıyor da metinde %0,15?"
- Önerilen eylem sırası: (1) MATLAB ile dört `.fig` yeniden etiketleme (harmonik mekanizma, katsayı taraması, S4 akım izleme, S4 basamak); (2) pgfplots ile dört frekans alanı şekli (L Bode, S/T, ölçüm karşılaştırması, H-33 kalırsa tarama özeti). pgfplots `tezpaketleri.sty`:18–20'de zaten yüklü (`compat=1.18`, `groupplots`). CSV'ler `\graphicspath` gibi göreli yolla okunabilir. Örnek iskelet (ölçüm karşılaştırması, üst panel):
  ```latex
  \begin{tikzpicture}
  \begin{semilogxaxis}[width=\textwidth, height=5cm, xmin=100, xmax=5000,
      ylabel={$|L|$ (dB)}, /pgf/number format/use comma, legend pos=south west]
    \addplot[black, thick] table[x=f_Hz, y=L_dB_PI, col sep=comma]
      {../tez-matlab-simulink/runs/2026-10-28_kararlilik/frekans/bode_L_S_T_A.csv};
    \addplot[only marks, mark=square, blue] table[x=f_Hz, y=L_olcum_dB, col sep=comma,
      restrict expr to domain={...}{...}]   % kosu süzgeci: ör. pgfplotstable ile önceden ayıklanmış alt CSV
      {../tez-matlab-simulink/runs/2026-10-28_kararlilik/karsilastirma/ton_karsilastirma.csv};
  \end{semilogxaxis}
  \end{tikzpicture}
  ```
  `ton_karsilastirma.csv` içinde `kosu` sütunu metin olduğundan koşu başına ayrı küçük CSV çıkarmak (ya da `\pgfplotstableread` + `discard if not`) en sade yoldur.
- Savunmada sözlü yanıt: gerekmez (biçim).
- Yeni sayı gerekir mi: hayır.
- Etkilenen: şekil dosyaları; altyazılar (H-47 için `fig:s4-tarama-ozet`).

---

## 5. Yeni jüri riskleri

**Y-01 — Nyquist şeklinde kritik kesişim çizim aralığının dışında — orta**
- Güncel yer: 05:443 altyazı "Bir periyot hesaplama gecikmeli durumda (B) ek gecikme, rezonans tepesini negatif gerçel eksende $-1$ noktasının soluna taşımaktadır." ↔ `kararlilik_nyquist_A_B.pdf` (eksenler −3…2, −3…3).
- Durum: yeni. (B) için GM = −30,1 dB, yani faz geçişinde $|L|\simeq32$, kesişim $\mathrm{Re}\,L\simeq-32$'dedir ve şeklin dışında kalır. Okur altyazının anlattığı sarmayı göremez. (A)'nın rezonans tepesi de (+30 dB, pozitif gerçel eksen) şeklin dışındadır.
- Jürinin soracağı soru: "Şekilde −1'in sarıldığını göremiyorum, nerede?"
- Önerilen metin değişikliği:
  - **Önerilen A (yeni sayı yok):** altyazının sonuna: "Rezonans tepesinin gerçel ekseni kestiği noktalar, Tablo~\ref{tab:kararlilik-marjlar} içindeki GM değerlerine karşılık gelmekte ve çizim aralığının dışında kalmaktadır."
  - **Önerilen B (şekil):** MATLAB analiz betiğinde ikinci bir panel ya da logaritmik yarıçaplı Nyquist ($\log_{10}(1+|L|)$ ölçekli) çizimi. Yeni sayı gerektirmez, şekil yeniden üretilir.
- Savunmada sözlü yanıt: "(B)'de faz −180°'yi 2811 Hz'te keserken kazanç +30 dB'dir, kesişim yaklaşık −32'dedir ve −1'i sarar. Nyquist sayımı tabloda 1 olarak verilmiştir. Şekil −1 çevresini büyüterek iki gerçeklemenin birinci geçiş bölgesindeki farkını göstermektedir."
- Yeni sayı: hayır. Etkilenen: `fig:kararlilik-nyquist`.

**Y-02 — S4 2,3 A THD ile S3 THD farkı — orta**
- Güncel yer: `tab:s4-tarama` P/PI 2,3 A satırları (THD %7,0/%7,2) ↔ 05:214 (S3 %14,8). Metin 2,3 A satırlarını hiç yorumlamıyor.
- Durum: yeni. İki değer artık aynı büyüklüktür (şebeke akımı THD'si, H-47). Okur "kapalı çevrim THD'yi yarıya indiriyor" sonucuna varabilir.
- Jürinin soracağı soru: "Akım geri beslemesi 2,3 A'de THD'yi %14,8'den %7'ye indiriyorsa deneyde neden kapalı çevrim kullanılmadı ve Sin³'ün payı ne?"
- Önerilen metin değişikliği: H-48 seçenek A ("…S4 verimi ve THD'si S4 benzetimleri arasında karşılaştırılmaktadır.") riski metin düzeyinde kapatır.
- Savunmada sözlü yanıt (kontrol edilmeli): "S4, S3 ileri beslemesine akım geri beslemesini ekler ve ayrıca farklı çekirdek kaybı direnci ile büyütülmüş bara kullanır. Özgün bara ve parametre dosyası ileri beslemesiyle P denetleyicide de 2,3 A THD'si %8,1'dir (S4 review notu, Tablo 3), dolayısıyla farkın büyük kısmı bara değil, geri besleme ve S4'e özgü model parametreleridir. Deneydeki donanım açık çevrim modülasyonla çalışmaktadır, kapalı çevrimin donanımda denenmesi gelecek çalışmadır." Farkın bileşenlerine ayrıştırılması yapılmamıştır, ayrıştırma istenirse [YENİ SAYI].
- Yeni sayı: hayır. Etkilenen: yok.

**Y-03 — Gecikme taraması ile gecikme marjının okunuşu — düşük**
- Güncel yer: 05:438 "Gecikme taraması, analog eşdeğer PI çevriminin $T_d=\SI{45}{\micro\second}$'ye kadar kararlı kaldığını göstermekte ve Tablo~\ref{tab:kararlilik-marjlar} içindeki $\mathrm{DM}_{\min}$ değerini doğrulamaktadır." ↔ tablo $\mathrm{DM}_{\min}=44{,}4$ µs.
- Durum: yeni. Tarama toplam gecikmeyi değiştirir (`gecikme_taramasi.csv`, 2 µs'de PM 54,2°). DM ise 2 µs'ye eklenen gecikmedir, kritik toplam ≈ 46 µs. Okur 45 > 44,4 görüp çelişki sanabilir.
- Önerilen metin değişikliği: **Önerilen:** "Gecikme taraması, analog eşdeğer PI çevriminin toplam gecikme \SI{45}{\micro\second} olduğunda kararlı kaldığını göstermektedir. Sonuç, \SI{2}{\micro\second} gecikmeye eklenen $\mathrm{DM}_{\min}=\SI{44.4}{\micro\second}$ marjla uyumludur."
- Savunmada sözlü yanıt: "DM, çevrimde zaten bulunan 2 µs'nin üzerine eklenebilecek gecikmedir. Kritik toplam gecikme yaklaşık 46 µs'dir, tarama 45 µs'de kararlı, 50 µs'de kararsız sonuç vermektedir."
- Yeni sayı: hayır.

**Y-04 — D-11 bağıntısı bir üst sınırdır — düşük (yalnız savunma)**
- Güncel yer: 05:239 salınım değerleri (11, 120, 10 V).
- T-tipi kolda nötr anahtar iletimdeyken akım kapasitörlerden geçmez, faz başına orta nokta akımı $|d|\,i$'dir. Temel bileşeni $(8/3\pi)\,m\hat I\simeq0{,}85\,m\hat I$, $m\simeq0{,}8$ ile ≈ 0,68 $\hat I$'dır. D-11 $\hat I$ kullandığı için salınımı ~1,4 kat büyük verir (25 A, 940 µF: ~85 V ↔ 120 V). Tezdeki önerme ("salınım akımla büyümektedir", büyütülmüş bara gerekçesi) değişmez. Metin değişikliği önerilmez.
- Savunmada sözlü yanıt: "Verilen salınım değerleri faz akımının tamamının kapasitörlerden geçtiği kabulüyle hesaplanmış üst sınırlardır."

**Y-05 — Verim tanımı: Display, betik ve kayıp toplamı — düşük (yalnız savunma)**
- `KC_P_2p3A`: Display η = %96,24 (tablodaki), betik η = %97,24 (`verim_pct`), Simscape kayıp toplamı 12,05 W → η ≈ %95,9. Review notu farkı `i_dc` kaydının Display ölçüm noktasından farklı olmasına bağlıyor. Tablo Display değerini kullanıyor ve 05:243 bunu söylüyor ("modelin DA ve AA güç ölçüm bloklarından").
- Savunmada sözlü yanıt: "Tablodaki verim modelin kendi güç ölçüm bloklarından alınmıştır, S1–S3 kalibrasyonunda da aynı kaynak kullanılmıştır. Ayrı bir kayıp toplamı yöntemiyle değer %0,4 puan içinde kalır."

**Y-06 — Başlıklarda süreç bilgisi — düşük**
- Güncel yer: 05:119 "(01.09.2026 hesabı)", 05:154 "Parçalı DCM/CCM analitik modeli, 01.09.2026 hesabı.", 05:237 "Oransal kazanç parametre dosyasındaki değerdir." (rapor 17 H-24'ün açık kalanları).
- Önerilen metin değişikliği: üç ifade silinir. 05:154 sonu: "…yıldız en iyi noktayı göstermektedir. Eğriler parçalı DCM/CCM analitik modelinden elde edilmiştir."
- Yeni sayı: hayır.

---

## 6. Kapanan maddeler (kısa)

- **H-39:** 05:438 "Kesimde verilen kararlılık sonucu analog eşdeğer gerçekleme (A) için elde edilmiştir." ve gecikme duyarlılığı tablo/şekle bağlandı. Kullanıcı kararıyla kapandı.
- **H-40, H-19:** "Geçerlilik Sınırı" kesimi kaldırıldı.
- **H-41(a):** 05:158 iki çalışma noktasını ($0{,}785$, $0{,}822$) ve "%4 içinde örtüşme" ölçüsünü yazıyor.
- **H-43:** 05:509 önermesi kazanç geçişlerine daraltıldı. Tabloyla denetlendi: 587,5 Hz'te üç ölçüm de önde, 3362,5 Hz'te $K_{34}$ açık −1,1° (±2,5° içinde), 2025 Hz'teki kazançlar −10,08…−11,00 dB → "−10 dB ya da altında" doğru.
- **H-50:** başlık "Analitik Katsayı Taraması", 05:4 "trigonometrik özdeşlikle". Görünmeyen etiket `eq:sin3-duzeltilmis-optimum` sorun değil.
- **H-01, H-04:** uygulandı. **H-57:** Bölüm 5'te kapandı (Bölüm 8 tarafı §4).

---

## 7. Uygulama sırası

1. **Sayı ve tanım tutarlılığı (tek oturum, yeni sayı yok):** H-47 (tablo başlığı, 05:511, 05:314, 05:289), H-46 (05:313), H-55 seçenek A (05:310, 05:312, 05:547, 06:465), H-48/H-27/Y-02 seçenek A (05:243).
2. **Kapsam ve gerekçe:** H-49 seçenek A (05:239 iki yer, 05:541, 03:507, 06:389), H-28 (05:239).
3. **Koşul cümleleri:** H-44 seçenek A (05:509), H-45 (05:350, 05:200, isteğe bağlı 08:115), H-51 (05:511, 05:547, 03:433), Y-03 (05:438), H-53 seçenek A (05:416).
4. **Bölüm 3 ve 8:** H-31 (03:532–535, 03:587), H-57 (08:34).
5. **Terim ve simge:** H-58, H-56, H-52, Y-06, isteğe bağlı H-42.
6. **Şekiller (ana oturum):** H-37 ve Y-01. Önce H-33/H-34/H-35 kararları verilmeli (çıkan şekil yeniden çizilmez). MATLAB yeniden etiketleme Windows makinesinde, pgfplots çizimleri Ayakaleaf'te yapılabilir.
7. Her adımdan sonra Ayakaleaf'te derleme ve tanımsız gönderme denetimi (ana oturum).

## 8. Tez sahibinin onayını gerektiren maddeler

| Madde | Karar |
|---|---|
| H-49 seçenek B | Üç fazlı orta nokta salınımı için yeni sayı (≈5 V, $(8/5\pi)\,m\hat I$) tezde yer alsın mı? Seçenek A yeni sayısızdır. |
| H-48 seçenek B | Toplam kayıp sayıları (11,0 W / 17,1 W) tezde kalsın mı? Önerilen A'dır. |
| H-44 seçenek B | 2,3 A'de kritik bölge enjeksiyonu [YENİ SAYI]. Tez sahibi yeni koşu istemediği için A önerilir. |
| H-47 ek | $K_{34}=0$ için şebeke akımı THD'si [YENİ SAYI]. Gerekmez, A yeterlidir. |
| H-53 seçenek B | Yeni kaynak (bib girdisi, künye doğrulaması). |
| H-52 ($L\to L_1$, $N/P/Z$) | Eşitliklerde simge değişikliği. |
| H-45 isteğe bağlı | 08:115'e PLL dinamiği cümlesi (Gelecek Çalışmalar kapsamı genişler). |
| H-57 | Bölüm 8'e deney koşulu cümlesi. |
| H-42 isteğe bağlı | $(0{,}44,\ 0{,}38)$ çiftinin çıkarılması. |
| H-34 / H-55 seçenek B | Basamak tablolarının birleştirilmesi (rapor 17 kararıyla birlikte). |
| Y-02 savunma yanıtı | "Farkın büyük kısmı geri beslemeden" yorumu kontrol edilmeli, ayrıştırma koşusu yoktur. |
