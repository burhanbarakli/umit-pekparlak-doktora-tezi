# Kontrol ve topoloji kesimlerinde sözel fazlalık, denkleme dönüştürme ve tekrar incelemesi

- **Kapsam:** `yeni_tez/bolumler/` altında 02:138–156 ve 02:303–320, 03:71–430, 04:8–162, 05:233–535, 07:19–318. Simgeler için `onkisim/simgeler.tex`, denetim betiği için `tez-matlab-simulink/scripts/analiz_kararlilik_20261028.m` okundu.
- **Görev kipi:** yalnız inceleme (tez-hakem ajanı). Hiçbir dosya değiştirilmedi, derleme yapılmadı.
- **Tarih:** 17.11.2026. Satır numaraları commit `0d6deae` hâline aittir.
- **Sayfa:** "s." basılı sayfa numarasıdır (`tez.pdf`, 217 sayfa). PDF'teki fiziksel sayfa numarası basılı numaradan 34 fazladır.
- **Kelime kestirimi:** `wc -w` ile yapıldı, LaTeX komutları dahil. Bir sayfa yaklaşık 280 kelime sayıldı.
- **Önceki raporlar:** 12 ve 14 numaralı raporlarda önerilmiş maddeler yeniden yazılmadı, yalnız kimlikleriyle anıldı.
- **Ana oturum notu (17.11.2026):** J-06 uygulandı. `eq:ccm-akim-cozumu` $k_1$, $k_3$ ile yeniden türetildi: $\cos\theta$ katsayısı $V_m-V_h(k_1+3k_3/4)$, $\cos3\theta$ terimi $+V_hk_3/(12\omega_0L)$. Kalıntı K-35'teki yeniden adlandırmadan kalmıştı. **Yüksek öncelikli maddeler (§7, 1–6) 17.11.2026'da uygulandı (K-38); J-07 kaynak bulunamadığı için açık. Orta ve düşük öncelikliler açık.**

---

## 1. Özet

**Genel tanı.** Şikâyet yerinde. Topoloji ve denetim kesimlerinde üç tür metin hacim tutuyor:
- (a) Jürinin bildiği ders kitabı bilgisinin düzyazıyla anlatılması: iki seviye/üç seviye, senkron ve diyotlu buck, LCL'in neden kullanıldığı, akım denetleyicisinin hatadan komut üretmesi, L/S/T ile marj tanımları, Coulomb sayımı.
- (b) Denklemin ya da tablonun hemen ardından aynı bilginin sözle yinelenmesi: "Eşitlik … göstermektedir", tablo sütunlarının tek tek anlatılması, şekillerin cümle cümle betimlenmesi.
- (c) Aynı kavramın bölümler arasında 4–9 kez yeniden anlatılması: susturulan anahtar, tümleyen çiftler, S1–S4, açık çevrim.

**Denklem açığı.** Tezin denklem altyapısı aslında sağlam: anahtarlama fonksiyonu, LCL durum denklemleri, PI/PIR, L(s), S/T, κ kuralı, CC–CV ve geçiş izni zaten denklemle verilmiş (bkz. §3.1). Asıl eksik, birkaç kilit ilişkinin hâlâ sözle anlatılması:
- kapı mantığının tamamı,
- köprünün CCM ve DCM'deki ortalama kutup gerilimi (yani "akım kaynağına yaklaşma" önermesi),
- $Q_{\mathrm{rev}}$,
- marj ve gecikme marjı bağıntısı,
- gerçekleme (B)'nin ayrık modeli,
- DA bara orta nokta salınımı,
- GT-tipi eleman görev eşlemesi.

Önerilen 17 denklem ya da tablonun hepsi tezdeki sayıları yeniden üretiyor ya da metindeki cümlelerden türetiliyor. Uydurma değer yok. §3.2'de her biri için doğrulama notu var.

**Toplam tahmini kazanç:**
- Sözel kısaltma ~2 600 kelime, yani ~9 sayfa.
- Şekil/tablo birleştirme ve EK'e taşıma ~1,6 sayfa.
- Eklenen denklem ve tablolar ~1,6 sayfa tutar.
- **Net kazanç ~8–9 sayfa.**

| Bölüm | Sözel kısaltma | Şekil/tablo | Eklenen | Net |
|---|---:|---:|---:|---:|
| 2 (kuramsal temel, denetim) | ~190 kelime | – | – | ~0,7 s |
| 3 (faz kolu, eşdeğer, LCL, denetim) | ~1 000 kelime | – | ~0,5 s (D-01…D-07) | ~3 s |
| 4 (mekanizma, kural, kapı, düzeltme) | ~450 kelime | – | ~0,3 s (D-04, D-09, D-10) | ~1,2 s |
| 5 (S4 yapısı, kararlılık) | ~400 kelime | – | ~0,4 s (D-11…D-14) | ~1 s |
| 7 (GT-tipi yapı, modlar, geçiş) | ~560 kelime | ~1,6 s | ~0,4 s (D-15…D-17) | ~3,2 s |

**En önemli 5 öneri:**
1. **Kapı mantığını tek Boole bloğuyla ver (D-01).** Bir denklem bloğu, 3:157, 3:427, 4:80, 4:121 ve 4:149'daki kapı anlatımının yerini alır, susturulan anahtar tekrarlarını (T-03, T-04) da bitirir.
2. **Kararlılık kesimindeki ders kitabı tanımlarını sil (S-42, S-46, S-47).** Yerlerine marj, gecikme marjı ve faz katkısı bağıntılarını koy (D-12, D-13). Gerçekleme (B)'yi ayrık modelle yaz (D-14). Kutup hesabında Padé kullanıldığı tezde yazmıyor; jüri riski (J-03).
3. **Bölüm 3'te tek denetim denklemi ve senaryo tablosu kur (D-07).** `eq:modulasyon-toplami` ile `eq:s4-denetim-yapisi` birleşir, $C$/$C_i$ ikiliği kalkar, S1–S4 tanım tekrarları biter.
4. **Bölüm 3'teki buck ve LCL düzyazısını denkleme indir (D-02, D-03, D-05, D-06).** İki denklem bire iner, üç bölgeli liste tek satır olur.
5. **Bölüm 7'de yeniden görevlendirmeyi eleman görev tablosuyla ver (D-15).** Benzetim kayıtlarındaki şekil betimlemelerini teke indir, primer ve sekonder şekillerini alt şekil olarak birleştir.

**Önceki raporlardan bugün hâlâ açık olanlar** (yalnız kimlikleriyle anılıyor):
- F-07/G-04: kapı mantığı tekrarı, 3:157 ve 3:427.
- F-13: PI sıfırı, 3:359.
- F-26: $G_{vi}$ ile $C_i$ birliği.
- F-28: 3:7, 3:139 ve 3:209.
- F-42: `fig:t-tipi-uc-seviye`.
- G-05: 4:28. G-11: 4:75. G-17: 4:26.
- **G-27'nin Bölüm 3 eşleri (3:107, 3:161) düzeltilmemiş.** Bölüm 4'te düzeltildi.

---

## 2. Sözel ve basit kısımlar

Öneri kodları: **Sil**, **Tek** (tek cümleye indir), **Atıf** (kaynağa atıfla geç), **Denk** (denkleme dönüştür, §3'teki kimlik).

### 2.1 Bölüm 2 (kuramsal temel ve denetim literatürü)

| Kimlik | Yer | s. | Alıntı | Öneri | Kazanç |
|---|---|---|---|---|---|
| S-01 | 02:140 (cümle 1–5) | 14 | "Gerilim kaynaklı iki seviyeli evirici, faz çıkışını DA baranın pozitif ve negatif uçları arasında anahtarlamaktadır." | **Atıf + Tek.** İlk iki cümle (duyuru) ve iki seviyeli eviricinin tanımı silinsin. Önerilen metin: "Çok seviyeli dönüştürücüler çıkış gerilimini daha küçük basamaklarla kurarak gerilim zorlanmasını, $dv/dt$ değerini ve filtre gereksinimini azaltır \citep{Mohan2003,Holmes2003}. NPC yapı sıfır seviyesini kenetleme diyotlarıyla, T-tipi yapı çift yönlü nötr anahtar koluyla üretir." | ~60 kelime |
| S-02 | 02:142 | 14 | "Pozitif ve negatif aktif durumlarda akım dış anahtarlar üzerinden, sıfır durumunda ise…" | **Tek, sayıya bağla.** Seviye ve akım yolu anlatımı Bölüm 3'te denklemle var (T-02). Önerilen metin: "T-tipi kolda dış anahtarlar $V_{\mathrm{dc}}$'yi, nötr anahtarlar $V_{\mathrm{dc}}/2$'yi keser. Aktif durumda akım yolunda T-tipide bir, NPC'de iki seri eleman bulunur \citep{Schweizer2013}." | ~50 kelime |
| S-03 | 02:307 (cümle 4–6) | 23 | "akım denetleyicisi, referans akım ile ölçülen akım arasındaki hatadan modülasyon gerilimi üretmektedir" | **Atıf + Tek.** Önerilen metin: "Akım denetiminde senkron eksen PI, durağan eksen PI ve PR yapıları ile PLL tabanlı eşzamanlama yaygındır \citep{Teodorescu2006PR,Teodorescu2011,Blaabjerg2006,Zhou2018}." `Zhou2018` tek kalan atıftır, korunmalı. | ~45 kelime |
| S-04 | 02:309 (cümle 1–3) | 23 | "LCL filtre, daha küçük toplam endüktansla yüksek frekanslı anahtarlama bileşenlerini zayıflatabilir." | **Tek.** Önerilen metin: "LCL filtrenin rezonans tepesi pasif ya da aktif sönümleme gerektirir \citep{Zhang2014PR}." Lu2016 ve Wang2024 cümleleri kalsın. Nicel karşılığı D-05'te. | ~40 kelime |

### 2.2 Bölüm 3 (faz kolu, düşük güç eşdeğeri, LCL, denetim)

| Kimlik | Yer | s. | Alıntı | Öneri | Kazanç |
|---|---|---|---|---|---|
| S-05 | 03:11 (cümle 2–4), kapsam kıyısı | 29 | "Deşarj yönünde enerjinin kaynağı batarya veya ayarlanabilir DA kaynaktır." | **Sil.** Şekli düzyazıyla anlatıyor. | ~45 kelime |
| S-06 | 03:50 (cümle 2–4), kapsam kıyısı | 30 | "Denetim katmanı ölçüm, akım regülasyonu, modülasyon ve kapı sinyali üretimini içermektedir." | **Sil.** `tab:model-katmanlari` aynı bilgiyi veriyor. | ~45 kelime |
| S-07 | 03:73 (cümle 3–5) | 31 | "Nötr kolun eklediği sıfır seviyesi, iki seviyeli yapıya göre daha küçük gerilim basamakları oluşturmaktadır." | **Sil.** 02:140 ve 3:95–100 denklemiyle tekrar (T-02). Q/S eşleme cümlesi kalsın. | ~45 kelime |
| S-08 | 03:75 | 31 | "Tezde bütün topoloji üç amaçla kullanılmaktadır" | **Kısalt, ~209→~90 kelime.** "Üç amaç" ve "Tek faz indirgemesi yalnız gösterimi sadeleştirmektedir…" silinsin. Sistem sınırı, üç hücre, RL1/diyotlar ve L1/L2/L3 etiket uyarısı (K-04) kalsın. | ~110 kelime |
| S-09 | 03:100 | 35 | "$s_x=1$, $0$ ve $-1$ için sırasıyla pozitif, sıfır ve negatif kutup gerilimini vermektedir." | **Sil.** Denklem kendisi söylüyor. | ~20 kelime |
| S-10 | 03:107 (cümle 2–3) ve 03:161 (son cümle) | 35, 36 | "modülasyon komutunun genliği azaldığında sıfır durumunun payının neden arttığını doğrudan göstermektedir" | **Sil (J-01).** G-27'nin Bölüm 3 eşleri. "Gerçek taşıyıcı tabanlı PWM'de … değiştirebilir" de silinsin. Ölü zaman ve ideal görev oranı cümleleri kalsın (K-01). | ~60 kelime |
| S-11 | 03:109 | 35 | "hangi anahtarlama durumunun yalnızca bağlantı noktasını değiştirdiğini görmeyi kolaylaştırmaktadır" | **Sil.** F-42 önceki incelemede var. | ~25 kelime |
| S-12 | 03:139 | 35 | "``1'' iletim komutu, ``0'' kesim komutudur." | **Sil.** Son iki cümle F-28'dir. | ~40 kelime |
| S-13 | 03:150–152 (tablo "İşlevsel açıklama" sütunu) | 36 | "Pozitif yarım periyotta enerji üst DA bara kolundan faz çıkışına aktarılmaktadır." | **Sütunu bilgiyle değiştir.** "$i_x>0$ / $i_x<0$ iletim yolu": $P$: $Q_1$ / $DS_1$; $O$: $Q_4{+}DS_3$ / $Q_3{+}DS_4$; $N$: $DS_2$ / $Q_2$. 4:101 ve 3:174–202 ile uyumlu. | 0 (S-15'i olanaklı kılar) |
| S-14 | 03:157 (cümle 3–4) | 36 | "Yalnızca gerilim seviyesini üreten asgari durum gösterilecekse" | **Sil.** Kalan kısım D-01'e bağlansın (F-07). | ~40 kelime |
| S-15 | 03:159 (cümle 2–4) | 36 | "Endüktif çıkış filtresi nedeniyle faz akımı anahtarlama anında sürekliliğini korumaktadır." | **Sil.** Akım yönüne bağlı yol S-13 sütununda görünür. | ~50 kelime |
| S-16 | 03:161 | 36 | "Akım yolunun okunabilirliğini korumak için filtre elemanları alt çizimlerde tekrarlanmamıştır." | **Tek.** "Şekil~\ref{fig:t-tipi-akim-yollari}(a) faz başına güç katını ve LCL filtreyi, (b)–(e) dört temel iletim yolunu göstermektedir." | ~70 kelime |
| S-17 | 03:233 (cümle 2), 03:247 (cümle 1) | 37–38 | "içindeki iki ifade yalnızca aynı yerel volt--saniye dengesi altında eşdeğerdir" | **Denk D-02.** | ~40 kelime |
| S-18 | 03:252 | 38 | "Diyotlu alçaltıcı dönüştürücüde akım sıfıra ulaştığında serbest dolaşım diyodu doğal olarak kesime gitmektedir." | **Sil.** Ders kitabı bilgisi; literatür 02:259, T-tipi uyarlaması 4:13 ve 4:103 (T-05). Şekil göndermesi 3:215'e taşınabilir. | ~60 kelime |
| S-19 | 03:254–260 (üç maddelik liste) | 38 | "Ortalama akım ile akım dalgalanması arasındaki ilişki üç çalışma bölgesi tanımlamaktadır" | **Denk D-03.** Madde 2'deki "histerezis gereklidir" J-04'tür. | ~60 kelime |
| S-20 | 03:267 (son cümle) | 39 | "Sabit bir yüzde güç eşiği yerine fiziksel değişkenlerden türetilen sınır akımı" | **Sil (J-04).** Uygulanmayan kip geçişine "sağlamaktadır" diyor. | ~30 kelime |
| S-21 | 03:271 (cümle 1–2) | 39 | "LCL filtre, anahtarlama frekansı çevresindeki gerilim bileşenlerini daha küçük toplam endüktansla bastırabilmektedir" | **Denk D-05.** Atıflar kalsın. | ~35 kelime |
| S-22 | 03:273 (cümle 3) | 39 | "Ölçülen akımın $i_1$ veya $i_2$ olması, denetlenen sistemin modelini … değiştirmektedir" | **Sil.** C noktası cümleleri kalsın (K-02). | ~20 kelime |
| S-23 | 03:343 (cümle 2–3) | 40 | "$L_1$, $L_2$ ve $C_f$ enerji depolayan filtre elemanlarıdır." | **Sil.** | ~25 kelime |
| S-24 | 03:349 (son cümle), 03:355 (cümle 1–2) | 40–41 | "Gerçek modelde seri dirençler, kapasitör sönümleme kolu, sayısal gecikme ve şebeke empedansı … eklenmelidir" | **Tek.** "Kararlılık analizi, kayıpları, EMC süzgecini ve gecikmeyi içeren modelle yapılmıştır (Alt Bölüm~\ref{sec:kararlilik-bode})." | ~45 kelime |
| S-25 | 03:359 (cümle 1, 4–6) | 41 | "Akım çevrimi, referans akım $i^{\ast}$ ile ölçülen akım arasındaki hatadan modülasyon komutu üretmektedir." | **Sil + Denk D-07.** PI sıfırı 5:264'te var (F-13). "S1–S3 açık çevrim" cümlesi kalsın (K-03). | ~60 kelime |
| S-26 | 03:366 (son cümle), 03:422 (cümle 4–5) | 41–42 | "aynı ifadede karıştırmamak için tamamen Laplace alanında yazılmıştır" | **Sil.** Meta yorum; D-07 ile gerek kalmaz. | ~65 kelime |
| S-27 | 03:422 (cümle 2–3) | 42 | "toplam bir gecikme $G_d(s)$ oluşturmaktadır" | **Sil, gönder (J-02).** $G_d$ başka yerde yok. "$1+C_i(s)G(s)=0$" yerine "$1+L(s)=0$ (Eşitlik~\eqref{eq:sin3-acik-cevrim})". | ~25 kelime |
| S-28 | 03:427 | 42 | "her blok, modelin blok yapısı ve sinyal bağlantıları okunarak doğrulanmıştır" | **Denk D-01.** "$V_{\mathrm{dc}}$ normalizasyonu yoktur" korunmalı (K-01). | ~60 kelime |

### 2.3 Bölüm 4 (mekanizma, yöntem, kapı mantığı, denetleyici düzeltmesi)

| Kimlik | Yer | s. | Alıntı | Öneri | Kazanç |
|---|---|---|---|---|---|
| S-29 | 04:13 (cümle 2–4) | 57 | "LCL filtre kapasitöründe ve şebeke eşdeğerinde bulunan enerji ters yönde akım oluşturmaktadır" | **Denk D-08**, mevcut denklemle. J-05'i de kapatır. | ~50 kelime |
| S-30 | 04:15 (cümle 1) | 58 | "tamamlayıcı sürme, serbest dolaşım akımını diyot yerine MOSFET kanalından geçirerek iletim kaybını azaltmaktadır" | **Sil, kalanı teke indir.** "Nötr kol IGBT'li olduğundan tamamlayıcı sürmenin kanal iletimi kazancı yoktur. Düşük güçteki başlıca etkisi ters dolaşım yolunu açık tutmasıdır." (K-05) | ~25 kelime |
| S-31 | 04:26 | 58 | "Pozitif alternansta aktif enerji aktarımının yolu $P$ durumu, serbest dolaşımın yolu $O$ durumudur." | **Sil (G-17).** | ~50 kelime |
| S-32 | 04:28 | 58 | "Benzetim ve deney, prototipin tek faz kolunu kapsamaktadır." | **Sil (G-05).** | ~40 kelime |
| S-33 | 04:30 (cümle 2–4) | 59 | "Düşük güçte aynı iki yönlü iletim dezavantaja dönüşmektedir." | **Tek.** 4:13–22'yi yineliyor. | ~35 kelime |
| S-34 | 04:75 (cümle 3–5) | 60 | "Süreksiz iletimde görev oranı ile anahtarlama anındaki endüktör gerilim farkı birlikte değiştiğinden" | **Denkleme göndererek teke indir.** "Akım zarfı, Eşitlik~\eqref{eq:dcm-sinus-zarfi} uyarınca $\sin\theta\,[V_h-V_m\sin\theta]$ çarpımıyla biçimlenir, sıfır geçişlerinde hızlı yükselir ve alternans ortasında çöker." (G-11) | ~45 kelime |
| S-35 | 04:103 (cümle 2, son cümle) | 61 | "her yarım periyot, iki yönlü iletebilen alt ve üst anahtardan oluşan senkron alçaltıcıya" | **Sil + Denk D-04.** 3:215 tekrarı; son cümle 02:303 ve 05:74 ile aynı (T-06). | ~60 kelime |
| S-36 | 04:121 (cümle 2–4) | 62 | "pozitif yarım periyotta $Q_1$'in 10 kHz PWM ile anahtarlandığını, $Q_4$'ün iletimde" | **Tek.** Cümle 1 (K-06) ve son cümle kalsın. | ~35 kelime |
| S-37 | 04:133 (cümle 1) | 62 | "Kapalı çevrim akım denetiminde denetleyici, her denetim periyodunda … bir düzeltme komutu üretmektedir" | **Sil.** Yalnız ders kitabı cümlesi çıkıyor. | ~25 kelime |
| S-38 | 04:149 (cümle 2–4) | 63 | "Klasik kapı düzeninde komut referansla aynı işarettedir. Pozitif yarım periyotta $Q_1$ PWM ile sürülmekte" | **Denk D-10.** Tablonun dördüncü kez sözle anlatımı. | ~45 kelime |
| S-39 | 04:162 (cümle 1–2) | 65 | "S1 klasik senkron anahtarlama, S2 nötr anahtar susturma, S3 ise susturma ile" | **Sil (G-05, T-07).** Cümle 4–5 kalsın (K-07). | ~35 kelime |

### 2.4 Bölüm 5 (S4 yapısı ve kararlılık)

| Kimlik | Yer | s. | Alıntı | Öneri | Kazanç |
|---|---|---|---|---|---|
| S-40 | 05:236 (cümle 1), 05:243 | 81–82 | "Alt Bölüm~\ref{sec:s4-kapali-cevrim} içindeki S4 sonuçları kalibre benzetim modeliyle elde edilmiştir" | **Birleştir.** Alt bölüm kendisine gönderme yapıyor; cümle `\end{figure}` satırına yapışık. (K-09) | ~40 kelime |
| S-41 | 05:264 (cümle 7–8) ↔ 03:429 ↔ 05:383 | 83 | "S4 denetimi analog eşdeğer olarak modellenmiştir" | **Tek yerde bırak (T-09):** 05:264. | ~30 kelime |
| S-42 | 05:360 (cümle 6–8) | 87 | "çevrim bir noktadan açıldığında işaretin çevrimi bir kez dolaşırken uğradığı toplam kazançtır" | **Sil.** L, S, T 5:362–370'te tanımlı. Adlar ilk geçişte kalsın (K-12). | ~70 kelime |
| S-43 | 05:360 (antirezonans tanımı) | 87 | "akımına giden yolun kazancının çöktüğü frekanstır" | **Denk D-06.** Silinmesin, denkleme bağlansın (K-12). | ~30 kelime |
| S-44 | 05:383 (son iki cümle) | 88 | "periyot ortalamalı örnekleme, bir periyotluk hesaplama gecikmesi ve sıfırıncı mertebe tutucu içeren durumdur" | **Denk D-14.** | ~20 kelime (net) |
| S-45 | 05:385 (marj tanımları) | 88 | "gecikme marjı $\mathrm{DM}_i$, $-1$ noktasına ulaşmak için gereken ek saf gecikmedir" | **Denk D-12.** | ~20 kelime (net) |
| S-46 | 05:409 | 89 | "Kazanç geçişleri sütunu $\lvert L\rvert=1$ olan frekansları, $\mathrm{PM}_i$ sütunu her geçişteki faz marjını" | **İki cümleye indir.** Tasarım ölçütleri ve negatif GM yorumu kalsın; ölçütlere kaynak (J-07). | ~110 kelime |
| S-47 | 05:411 (cümle 1–3) | 89–90 | "kazanç geçişlerini 586, 2454 ve 3386 Hz'te, faz marjlarını sırasıyla 77,7…" | **Kısalt.** "31°" cümlesi D-13 ile denkleme bağlansın. | ~50 kelime |
| S-48 | 05:411, 05:431, 05:534 | 89–97 | "gecikme marjı 44 µs" (üç kez); "$T_d=2$ µs üst sınır" (383, 534) | **Bir yerde bırak (T-12):** 05:534. | ~40 kelime |

### 2.5 Bölüm 7 (GT-tipi yapı, modlar, geçişler)

| Kimlik | Yer | s. | Alıntı | Öneri | Kazanç |
|---|---|---|---|---|---|
| S-49 | 07:22 (cümle 2) | 130 | "… ile verildiğinden yeniden basılmamıştır" | **Sil.** F-42 uygulanırsa gönderme `fig:t-tipi-akim-yollari`'ya. | ~25 kelime |
| S-50 | 07:24 | 130 | "şebekeden düşük harmonikli ve birim güç faktörüne yakın akım çekmek için Vienna katı" | **Denk D-16 + Atıf.** Vienna için kaynak yok (J-08). | ~40 kelime |
| S-51 | 07:33 (cümle 2) | 131 | "Her çıkışta diyot doğrultma, DA bağlantı kondansatörü, kontrollü anahtar, serbest dolaşım diyodu" | **Sil.** | ~25 kelime |
| S-52 | 07:42, 51, 60, 69, 78 | 132–135 | "yarı iletkenlerin atıl kalmasını önleyen birinci yeniden kullanım yoludur" | **Tablo D-15 + kısalt (~300→~130 kelime).** | ~170 kelime |
| S-53 | 07:116 (cümle 1) | 136 | "farklı şekillere dağılan güç ve denetim katmanlarını tek bir işlevsel akışta birleştirmektedir" | **Sil.** | ~20 kelime |
| S-54 | 07:121–191 (8 şekil) | 136–141 | "Görsel, PFC katının şebekeden dengeli akım çekme işlevini yerine getirdiğini göstermektedir." | **Kısalt ve birleştir.** 7:123, 132, 141, 182'nin ikinci cümleleri silinsin; primer ve sekonder gerilim/akım şekilleri ikişer alt şekil olsun; 7:191'in ilk cümlesi silinsin. Nitel kanıt cümlesi kalsın (K-13). | ~150 kelime + ~1 s |
| S-55 | 07:196 (cümle 1) | 141 | "GT-tipi yapının çalışması tek bir ``çift yönlü'' komutla açıklanamaz." | **Sil.** | ~15 kelime |
| S-56 | 07:231–237 (`eq:gt-soc-guncelleme`) | 142 | "Coulomb sayımına dayalı ayrık zamanlı şarj durumu güncellemesi" | **Atıf + Tek.** "Batarya başına SoC, Coulomb sayımı ve dönemsel düzeltmeyle kestirilir \citep{Plett2015}." | ~70 kelime + ~0,2 s |
| S-57 | 07:242 (cümle 1–2) | 142 | "akım taşıyan bir bağlantının açılması röle kontaklarında ark … oluşturabilir" | **Tek.** | ~20 kelime |
| S-58 | 07:294; `tab:gt-koruma-dogrulama` | 143 | "Hızlı yarı iletken koruması donanım düzeyinde çevrimden çevrime çalışmalı" | **Tek + EK.** GT-tipine özgü üç satır ana metinde kalsın, tam tablo EK'e. 7:317 kalsın (K-13). | ~45 kelime + ~0,4 s |

---

## 3. Denkleme dönüştürülebilecek yerler

### 3.1 Önerilmeyenler (tezde zaten var)

- `eq:t-tipi-anahtarlama-fonksiyonu` ($v_{xN}=s_xV_{\mathrm{dc}}/2$), `eq:t-tipi-gorev-oranlari`.
- `eq:lcl-durum-denklemleri`, `eq:lcl-aktarim`, `eq:lcl-rezonans`.
- `eq:s4-denetleyiciler` (P/PI/PIR).
- `eq:sin3-acik-cevrim` ($L=C\,K_{\mathrm{pwm}}e^{-sT_d}GH_m$), `eq:sin3-duyarlilik`, `eq:sin3-kapali-cevrim-girisleri`.
- `eq:susturma-etkinlestirme`, `eq:notr-susturma-kurali`, `eq:denetleyici-duzeltme`.
- `eq:ccm-diferansiyel`, `eq:dcm-*`.
- `eq:gt-cccv-referansi`, `eq:gt-gecis-izni`, `tab:gt-calisma-modlari`. Eksik olan eleman görev eşlemesi (D-15).

### 3.2 Önerilen denklemler

Yeni simgeler `simgeler.tex` ile çakışmayacak biçimde seçildi (D yalnız diyot, $k_1,k_3$ Sin³ katsayısı, $Q_{g,1}$ reaktif güç, $Q_1$–$Q_4$ anahtar).

**D-01 — Kapı mantığının Boole ifadesi.** Yer: 3:427, 3:157, 4:80, 4:121, 4:149 (s. 36, 42, 60–63). Yüksek öncelik.
```latex
\begin{equation}
\begin{aligned}
  g_{Q1}&=\kappa\,\mathbb{1}\!\left[\,|u|>c_{\mathrm{tr}}(t)\right], &
  g_{Q2}&=(1-\kappa)\,\mathbb{1}\!\left[\,|u|>c_{\mathrm{tr}}(t)\right],\\
  g_{Q3,\mathrm{kl}}&=1-g_{Q1}, &
  g_{Q4,\mathrm{kl}}&=1-g_{Q2},\\
  g_{Qj}^{\mathrm{uyg}}(t)&=g_{Qj}(t)\,g_{Qj}(t-t_d), & j&=1,\ldots,4
\end{aligned}
\label{eq:kapi-mantigi}
\end{equation}
```
- $c_{\mathrm{tr}}$: 0–1 aralıklı, $f_s$ frekanslı testere dişi taşıyıcı (yeni simge). Üçüncü satır yalnız yükselen kenarı geciktiren ölü zaman.
- `eq:notr-susturma-kurali` ile $g_{Q3,\mathrm{yeni}}=(1-g_{Q1})(1-\kappa)$, $g_{Q4,\mathrm{yeni}}=(1-g_{Q2})\kappa$.
- Doğrulama: `tab:t-tipi-durumlar` ve `tab:model-kapi-mantigi`'nin sekiz satırı bire bir örtüşüyor.
- Yerleşim: Bölüm 3 `sec:denetim-modelden`. 4:80 ve 4:121 bu denkleme gönderir. İstenirse $\mathbb{1}$ yerine $\mathrm{H}(\cdot)$.

**D-02 — Dalgalanmanın tek ifadesi.** Yer: 3:233–247, 4:11. Yüksek öncelik.
```latex
\begin{equation}
  \Delta i_L(t)\simeq\frac{V_hT_s}{L}\,d(t)\left[1-d(t)\right],\qquad
  d(t)\simeq\frac{v_g(t)}{V_h},\qquad
  \Delta i_{L,\max}=\frac{V_hT_s}{4L}\quad\left(d=\tfrac12\right)
  \label{eq:buck-akim-dalgalanmasi}
\end{equation}
```
- Doğrulama: 214 V, 100 µs, 600 µH → 8,9 A (4:11'de "yaklaşık 9 A").

**D-03 — Sınır akımı ve çalışma bölgesi.** Yer: 3:247–267. Yüksek öncelik.
```latex
\begin{equation}
  I_{\mathrm{B}}=\frac{\Delta i_L}{2},\qquad
  \begin{cases}
    \text{CCM}, & |\bar i_L|>I_{\mathrm{B}},\\
    \text{zorlanmış CCM (klasik) ya da DCM (susturma)}, & |\bar i_L|<I_{\mathrm{B}},
  \end{cases}
  \qquad i_{L,\min}=\bar i_L-I_{\mathrm{B}}
  \label{eq:sinir-akimi}
\end{equation}
```
- `eq:ters-akim-esigi` kalkar; `eq:sinir-akimi` etiketi korunur (4:11'den anılıyor).

**D-04 — Köprünün ortalama kutup gerilimi.** Yer: 4:101–103, 4:173, 5:467, 5:502, 3:343. Orta öncelik.
```latex
\begin{equation}
  \langle v_{xN}\rangle_{T_s}=
  \begin{cases}
    d\,V_h=K_{\mathrm{pwm}}\,u, & \text{CCM (S1)},\\
    v_c, \quad \bar i_L=\dfrac{T_sV_h}{2L}\dfrac{V_h-v_g}{v_g}\,d^2, & \text{DCM (S2, S3)}
  \end{cases}\qquad (u\geq0)
  \label{eq:kopru-ortalama-gerilim}
\end{equation}
```
- DCM satırı volt–saniye dengesinden ($\delta=(V_h/v_g-1)d$) çıkar; `eq:dcm-bosalma-suresi` ile aynı. "Köprü akım kaynağına yaklaşır" ve "etkin kazanç düşer" önermelerini, $\lambda$ ve $Z_{\mathrm{th}}$'yi denkleme bağlar. $K_{\mathrm{pwm}}$ bugün yalnız 5:360'ta sözle tanımlı.

**D-05 — LCL'in yüksek frekans zayıflatması.** Yer: 3:271, 2:309. Orta öncelik.
```latex
\begin{equation}
  \left|\frac{I_2(j\omega)}{V_{\mathrm{inv}}(j\omega)}\right|
  \simeq\frac{1}{\omega^3L_1L_2C_f}
  =\frac{1}{\omega(L_1+L_2)}\left(\frac{\omega_r}{\omega}\right)^{2},
  \qquad \omega\gg\omega_r
  \label{eq:lcl-yuksek-frekans}
\end{equation}
```
- Tasarım değerleriyle $f_s$'te $(2{,}9/10)^2\approx0{,}084$ (≈ −21,5 dB).

**D-06 — Antirezonans.** Yer: 3:353, 5:360, 5:449. Orta öncelik.
```latex
  \omega_r=\sqrt{\frac{L_1+L_2}{L_1L_2C_f}},\qquad
  \omega_{\mathrm{ar}}=\frac{1}{\sqrt{L_2C_f}}
```
- `eq:lcl-rezonans`'a eklenir; $\omega_{\mathrm{ar}}$ `eq:lcl-aktarim` payının sıfırı. Tasarım değerleriyle 1,78 kHz. $f_{\mathrm{antirez}}$ → $f_{\mathrm{ar}}$, simgelere eklensin.

**D-07 — Tek denetim denklemi ve senaryo tablosu.** Yer: 3:359–371 ↔ 5:247–257. Yüksek öncelik.
```latex
\begin{equation}
  u=\operatorname{sat}_{\pm1}\!\left(u_{\mathrm{ff}}+u_{\mathrm{fb}}\right),\quad
  u_{\mathrm{ff}}=K_{1x}\sin(\theta+\varphi_x)+K_{3x}\sin^3(\theta+\varphi_x),\quad
  u_{\mathrm{fb}}=C_i(s)\left[i_{\mathrm{ref}}-H_m(s)\,i_{L1}\right]
  \label{eq:s4-denetim-yapisi}
\end{equation}
```

| Senaryo | $C_i(s)$ | $K_{3x}$ | Kapı mantığı | Çevrim |
|---|---|---|---|---|
| S1 | 0 | 0 | klasik | açık |
| S2 | 0 | 0 | susturma | açık |
| S3 | 0 | ≠0 | susturma | açık |
| S4 | P/PI/PIR | ≠0 | susturma | kapalı |

- `eq:modulasyon-toplami` kalkar; $C$/$C_i$ ikiliği biter (J-02); 5:257 ve 5:360 göndermeleri korunur.

**D-08 — Ters akımın fiziği (yeni numara gerekmez).** Yer: 4:13. Orta öncelik.
- "$O$ durumunda Eşitlik~\eqref{eq:lcl-durum-denklemleri}'nin ilk satırı $L_1\,\mathrm{d}i_1/\mathrm{d}t=-v_c-R_1i_1$ olur. Pozitif yarım periyotta $v_c>0$ olduğundan nötr kol iki yönlü iletken kaldıkça akım sıfırda durmaz ve $i_{L1,\min}=\bar i_{L1}-I_{\mathrm{B}}<0$ değerine iner." (J-05)

**D-09 — Ters akım yükü.** Yer: 4:17 (sözle), 4:158 (sayısal). Orta öncelik.
```latex
\begin{equation}
  Q_{\mathrm{rev}}=\int_{t_0}^{t_0+T_w}\max\!\left[0,\,-\operatorname{sgn}\{\sin\theta(t)\}\,i_{L1}(t)\right]\mathrm{d}t
  \label{eq:ters-akim-yuku}
\end{equation}
```
- G-12'de çıkarılmıştı; 4:158 "%88" sonucunu $Q_{\mathrm{rev}}$ üzerinden verdiği için tanımın dönmesi gerekli.

**D-10 — Ters κ koşulu.** Yer: 4:149. Düşük-orta öncelik.
```latex
\begin{equation}
  \operatorname{sgn}u\neq\operatorname{sgn}\sin\theta
  \iff
  \operatorname{sgn}u_{\mathrm{fb}}\neq\operatorname{sgn}u_{\mathrm{ff}}
  \ \land\ |u_{\mathrm{fb}}|>|u_{\mathrm{ff}}|
  \label{eq:ters-kappa-kosulu}
\end{equation}
```
- $K_{1x},K_{3x}\geq0$ için geçerli (kalibre S4: $k_1\approx0{,}44$, $k_3\approx0{,}38$).

**D-11 — DA bara orta nokta salınımı.** Yer: 5:266. Orta öncelik.
```latex
\begin{equation}
  \hat v_{N}\simeq\frac{\hat I_g}{\omega_0\,(C_A+C_B)}
  \label{eq:orta-nokta-salinimi}
\end{equation}
```
- Doğrulama: 2×470 µF ile 2,3 A'de 11,0 V, 25 A'de 119,7 V; 2×5,6 mF ile 25 A'de 10,1 V (metindeki 11, 120, 10 V ile %1 içinde).

**D-12 — Marj tanımları tek blokta.** Yer: 5:385, 5:409. Yüksek öncelik.
```latex
\begin{equation}
\begin{aligned}
  \mathrm{PM}_i&=180^{\circ}-\left|\angle L(j\omega_i)\right|, & |L(j\omega_i)|&=1,\\
  \mathrm{DM}_i&=\frac{\mathrm{PM}_i}{360^{\circ}f_i}\quad(\angle L(j\omega_i)<0), &
  \mathrm{GM}&=-20\log_{10}\left|L(j\omega_{\pi})\right|,\ \angle L(j\omega_{\pi})=-180^{\circ},\\
  Z&=N+P=0\quad(P=0), & M_s&=\|S\|_\infty
\end{aligned}
\label{eq:marj-tanimlari}
\end{equation}
```
- Doğrulama: PI 54,2°/(360°·3386 Hz) ≈ 44,5 µs (tabloda 44,4), P 45,3 µs. İkinci geçişte faz pozitif, formül orada geçerli değil.

**D-13 — Ölçüm süzgeci ve gecikmenin faz katkısı.** Yer: 5:257, 5:411. Orta öncelik.
```latex
  H_m(s)=\frac{1}{1+s/\omega_m},\ \ \omega_m=2\pi f_m;\qquad
  \angle\!\left[H_m(j\omega)e^{-j\omega T_d}\right]=-\arctan\frac{f}{f_m}-360^{\circ}fT_d
```
- Doğrulama: 2,8 kHz'te −29,2° − 2,0° ≈ −31°. $f_m$, $H_m(s)$, $K_i$ simgelere eklensin.

**D-14 — Gerçekleme (B)'nin ayrık modeli ve Padé.** Yer: 5:383, 5:427, 5:431. Yüksek öncelik (J-03).
```latex
\begin{equation}
  P_{\mathrm{B}}(z)=z^{-1}\,\frac{1-z^{-1}}{T_s}\,
  \mathcal{Z}\!\left\{\frac{1-e^{-sT_s}}{s}\cdot\frac{K_{\mathrm{pwm}}G(s)}{s}\right\},
  \qquad
  T_{d,\mathrm{B}}\simeq\tfrac{T_s}{2}+T_s+\tfrac{T_s}{2}=2T_s
\end{equation}
\begin{equation}
  e^{-sT_d}\simeq\frac{1-sT_d/2+(sT_d)^2/12}{1+sT_d/2+(sT_d)^2/12}
\end{equation}
```
- Kaynak: `scripts/analiz_kararlilik_20261028.m` satır 58 (ortalamalı örnekleme, ZOH, $z^{-1}$), satır 50 (kutuplarda 2. mertebe Padé; Bode tam $e^{-j\omega T_d}$), satır 226 (gecikme taramasında 6. mertebe Padé). Tezde Padé anılmıyor.

**D-15 — GT-tipi eleman görev tablosu.** Yer: 7:22–78. Yüksek öncelik.

| Eleman | Deşarj (evirici kipi) | Şarj (PFC + BYS kipi) | Dayanak |
|---|---|---|---|
| $Q_1$–$Q_2$ | T-tipi dış anahtarlar, 10 kHz PWM | İki seviyeli yarım köprü, BYS trafosu primeri | 7:60 |
| $Q_3$–$Q_4$ | Nötr kol ($O$ durumu, düşük güçte susturma) | Vienna PFC nötr anahtarları | 7:69 |
| $D_1$–$D_2$ | Kararlı çalışmada iletimde değil | PFC yükseltici diyotları | 7:69, 4:73, 3:90 |
| RL1 | Evirici konumu (T-tipi + LCL) | PFC / yarım köprü konumu | 7:42 |
| $L_1$–$C_f$–$L_2$ | LCL çıkış filtresi | PFC giriş süzgeci | 7:69 |

**D-16 — Vienna kutup gerilimi.** Yer: 7:24. Düşük-orta öncelik.
```latex
  v_{xN}=\operatorname{sgn}\!\left(i_{x}^{\mathrm{ş}}\right)\left(1-g_{n,x}\right)\frac{V_{\mathrm{dc}}}{2},
  \qquad s_x\,i_x^{\mathrm{ş}}\geq0
```
- Vienna kolu, `eq:t-tipi-anahtarlama-fonksiyonu`'nun $s_x\in\{0,\operatorname{sgn}i_x^{\mathrm{ş}}\}$ kısıtlı hâli.

**D-17 — BYS primer gerilimi.** Yer: 7:150. Düşük öncelik, J-09'a bağlı.
```latex
  v_{\mathrm{pr},jk}=(s_j-s_k)\frac{V_{\mathrm{dc}}}{2},\qquad s_j,s_k\in\{-1,1\}
```
- Koşul: primerlerin kollar arasına bağlı olduğu çizimden (`onceki_tez_6_6_iki_seviye_trafo_modu.jpeg`) doğrulanmadan yazılmamalı.

---

## 4. Tekrarlar

| Kimlik | Kavram | Geçtiği yerler | Kalacak yer | Önceki rapor |
|---|---|---|---|---|
| T-01 | $Q_1$–$Q_3$ / $Q_2$–$Q_4$ tümleyen çiftler | 02:144, 03:81, 03:90, 07:74 (başlıklar) | 02:144 + `simgeler.tex` | – |
| T-02 | Üç seviye ve P/O/N durumları | 02:142, 03:73, 3:98–100, `fig:t-tipi-uc-seviye`, `tab:t-tipi-durumlar`, 03:159, 03:161, 04:11, 04:26 | Denklem + tablo | F-42, G-17 |
| T-03 | Susturulan anahtar | 04:52, 71, 80, 101, 110/115, 117, 121, 126, 149 | `eq:notr-susturma-kurali` + tablo + alt başlıklar | G-04 |
| T-04 | "Klasikte tümleyen, susturmada sabit 1/0" | 03:157, 03:427, 04:80, 04:121, 04:126, 04:149 | D-01 | F-07 |
| T-05 | Senkron/diyotlu buck ve ters akım | 02:259–261, 02:303, 03:215, 03:252, 04:11, 13, 15, 103, 195, 05:320 | 02:259, 03:215 + denklemler, 04:13 | F-12, G-02 |
| T-06 | Ters akım kesimi ile süreksiz iletim aynı nedenin iki sonucu | 02:303, 04:6, 04:103, 05:74 | 04:103 | – |
| T-07 | S1–S4 tanımları | 01:57, 03:547, 04:4, 04:162, 05:236, 07:51, 07:121 | 03:547 + D-07 tablosu | F-14, G-05 |
| T-08 | S1–S3 açık çevrim | 03:359, 03:547, 04:158, 04:162, 05:236 | 03:359 ve 04:158 | – |
| T-09 | S4 analog eşdeğer, 1 µs adım | 03:429, 05:264, 05:383, 05:534 | 05:264 + 05:534 | – |
| T-10 | PI sıfırı 60 Hz / geçiş 586 Hz | 03:359 ↔ 05:264 | 05:264 | F-13 |
| T-11 | Sin³ çevrim dışı | 02:317, 02:319, 03:422, 04:158, 05:356, 05:377, 05:379 | 05:377 | F-02 |
| T-12 | Gecikme marjı 44 µs, $T_d=2$ µs | 05:383, 411, 431, 534 | 05:534 | – |
| T-13 | 9 A tepe–tepe / 4,5 A eşiği | 04:11, 05:320 | 04:11 | G-02 |
| T-14 | "S1–S3 deneyleri evirici kipine aittir" | 07:4, 07:8, 07:51, 07:191, `tab:gt-calisma-modlari` | 07:8 | – |
| T-15 | Yeniden kullanım ve GT adının gerekçesi | 07:6, 22, 60, 69, 78 | 07:6 + D-15 | – |
| T-16 | L/S/T ve ‖S‖∞ tanımları | 05:356, 05:360, `eq:sin3-duyarlilik`, 05:385, 05:409 | Denklemler + D-12 | – |
| T-17 | "$K_{34}$ açık/kapalı bit düzeyinde aynı" | 05:389, 409, 416, 429 | Başlık + 05:429 | – |
| T-18 | Akım eşiği, histerezis, kip geçişi | 03:258, 03:267, 04:45, 04:73, 04:158 | 04:73 | G-29 |
| T-19 | 20 kVA, 20–25 kW | 07:4 ↔ 07:15 | 07:15 | G-09 |

---

## 5. Dokunulmaması gerekenler (kısaltılabilir, anlam korunmalı)

| Kimlik | Yer | Taşıdığı anlam |
|---|---|---|
| K-01 | 03:107 (son 3 cümle); 03:427 "$V_{\mathrm{dc}}$ normalizasyonu yoktur", yükselen kenar gecikmesi | Ölü zaman ve görev oranı temsili |
| K-02 | 03:273 (cümle 4–6) | C noktası ölçüm yeri; S4'ün $i_{L1}$'i geri beslemesi |
| K-03 | 03:359 (cümle 2); 03:429 | S1–S3 açık çevrim; S4 analog eşdeğer |
| K-04 | 03:75 L1/L2/L3 etiket uyarısı | "L2 = 600 µH" etiketi ile $L_2=1000$ µH karışmasın |
| K-05 | 04:15 (IGBT'de kanal iletimi yok) | G-28 düzeltmesinin özü |
| K-06 | 04:121 (cümle 1) | S2 kapı yolunun tez tanımına göre düzeltilmesi (D-xx bağı) |
| K-07 | 04:73, 04:162 (cümle 4–5), 04:173 | G-29–G-31 düzeltmeleri; kanıt sınırı |
| K-08 | 04:140, 145, 154 "temsilî"; 04:158 kanıt sınırı | Temsilî şekil uyarıları |
| K-09 | 05:236, 05:243 | Şekil ile koşturulan model arasındaki fark |
| K-10 | 05:264, 05:266, 05:270 | Donanımdan bilinçli sapmalar ve karşılaştırma sınırı |
| K-11 | 05:383, 05:493, 05:502, 05:534 | Kararlılık varsayımları ve ölçüm belirsizliği |
| K-12 | 05:360 antirezonans tanımı ve L/S/T adları | Tez sahibinin okuma notlarıyla eklendi; silinmemeli |
| K-13 | 07:8, 07:191, 07:212, 07:229, 07:255, 07:317 | Deney, benzetim ve tasarım ayrımı |

---

## 6. Yan bulgular (jüri riski)

| Kimlik | Öncelik | Yer | Sorun | Öneri |
|---|---|---|---|---|
| J-01 | Yüksek | 03:107, 03:161 | "Modülasyon genliği azaldıkça sıfır durumunun payı artar" önermesi; şebekeye bağlı eviricide $d\simeq v_g/V_h$ olduğundan savunulamaz (Bölüm 4'te G-27 ile düzeltildi) | S-10 ile sil |
| J-02 | Orta | 03:422 ↔ 05:360–377 | Bölüm 3'te $1+C_i(s)G(s)=0$: $K_{\mathrm{pwm}}$, gecikme ve $H_m$ yok; $G_d$ tek geçiş; $C_i$/$C$ ikiliği | D-07, S-27 |
| J-03 | Orta | 05:383, 427, 431 | Padé ve (B)'nin ayrık modeli yazmıyor | D-14 |
| J-04 | Orta | 03:258, 03:267, 04:45, 04:158 | Uygulanmamış eşik/histerezis/kip geçişi kesin dille | Sil ya da "genişletme (Bölüm 8)" |
| J-05 | Düşük | 04:13 ↔ 03:252 | Ters akım enerjisi bir yerde "nötr noktaya", bir yerde "DA tarafa" | D-08 |
| J-06 | Orta | 05:106–107 | $D_1$, $D_3$ tanımsız (K-35 kalıntısı) | **Uygulandı (17.11.2026)** |
| J-07 | Düşük | 05:409 | PM≳45°, GM≳6 dB, ‖S‖∞≲6 dB kaynaksız | Doğrulanmış kaynak ekle |
| J-08 | Orta | 07:24, 07:69 | Vienna için kaynak yok | Künyesi doğrulanmış özgün kaynak ekle |
| J-09 | Düşük | 07:150 | Primer geriliminin üç seviyesi "görev oranı" ile açıklanıyor | Çizime göre D-17 |

---

## 7. Öncelik sıralı uygulama listesi

**Yüksek:**
1. J-01: 03:107 ve 03:161'deki G-27 kalıntılarını sil (S-10).
2. D-01 kapı mantığı; ardından S-14, S-28, S-36, S-38; T-03, T-04.
3. D-07 tek denetim denklemi ve senaryo tablosu; S-25–S-27; J-02; T-07, T-08, T-10.
4. Kararlılık: S-42, S-46, S-47 silmeleri; D-12, D-13, D-14; J-03; T-12, T-16, T-17.
5. Bölüm 3 eşdeğer ve LCL: D-02, D-03, D-05, D-06; S-17–S-19, S-21, S-23, S-24.
6. Bölüm 7: D-15, S-52, S-54 (iki şekil birleştirmesi); T-14, T-15.

**Orta:**
7. D-04 köprünün ortalama kutup gerilimi (S-35, 05:467 ve 05:502 bağlantısı).
8. D-11 orta nokta salınımı.
9. D-09 $Q_{\mathrm{rev}}$ ve D-08 ters akım fiziği (J-05).
10. Bölüm 2: S-01–S-04.
11. Bölüm 4 kalanları: S-29–S-34, S-37, S-39.
12. J-04, J-08; S-56, S-58.

**Düşük:**
13. S-05–S-09, S-11–S-13, S-15, S-16, S-20, S-22.
14. S-40, S-41, S-43–S-45, S-48–S-51, S-53, S-55, S-57.
15. D-10, D-16, D-17; J-07, J-09; T-01, T-05, T-06, T-11, T-13, T-18, T-19.

**Uygulama notları:**
- `eq:s4-denetim-yapisi` Bölüm 3'e geçer; `eq:sinir-akimi` ve `eq:buck-akim-dalgalanmasi` korunur.
- Kaldırılabilen etiketler: `eq:ters-akim-esigi`, `eq:buck-enduktor-gerilimleri`, `eq:modulasyon-toplami`, `eq:gt-soc-guncelleme`.
- `simgeler.tex`'e: $c_{\mathrm{tr}}$, $\omega_{\mathrm{ar}}$/$f_{\mathrm{ar}}$, $f_m$, $H_m(s)$, $K_i$, $\hat v_N$; uygulanırsa $g_{n,x}$, $v_{\mathrm{pr}}$. $G_d$ eklenmesin.
- Sayısal doğrulamalar (8,9 A; 11/120/10 V; 44,5 µs; −31°; 1,78 ve 2,9 kHz) tasarım değerlerinden ve tezin sonuçlarından üretildi; yeni bulgu olarak sunulmamalı.
- **Toplam tahmini kısalma: net ~8–9 sayfa.**
