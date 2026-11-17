# Bölüm 5 jüri riski önerilerinin uygulama kaydı (rapor 18)

- **Kapsam:** rapor 18'deki öneriler, tez sahibinin "yeni sayı gerektirmeyen seçenekler" kararıyla uygulandı.
- **Değişen dosyalar:** `yeni_tez/bolumler/05-sin3-kompanzasyon.tex`, `03-sistem-model-metodoloji.tex`, `06-deneysel-dogrulama.tex`, `08-sonuc.tex`, `yeni_tez/onkisim/simgeler.tex`.
- **Commit yok, Ayakaleaf'e gönderilmedi.** Derleme yapılmadı.
- Satır numaraları düzenleme sonrası dosyaya aittir.

## Uygulanan kimlikler

| Kimlik | Dosya:satır | Mevcut → yeni (kısaltılmış) |
|---|---|---|
| H-47 | 05:247 | `tab:s4-tarama` başlığına "THD$_I$ ve $I_3/I_1$ şebeke akımına ($i_g$, C noktası, $h\leq50$) aittir." eklendi |
| H-47 | 05:511 | "THD sırasıyla %9,4 ve %5,6'dır." → "Enjeksiyon benzetimlerinde $L_1$ akımının THD'si sırasıyla %9,4 ve %5,6'dır." |
| H-47 | 05:314 | "Basamak sonrası THD$_I$" → "Basamak sonrası şebeke akımı THD'si" |
| H-47 | 05:289 | `fig:s4-tarama-ozet` başlığı "akım THD'si" → "şebeke akımı THD'si" |
| H-49 (A) | 05:239 | "Üç fazlı donanımda toplam kapasitans faz payının üç katıdır." → dengeli üç faz dört telli donanımda temel bileşen orta nokta akımlarının götürülmesi, orta noktada 150 Hz ve öteki üçlü harmoniklerin kalması (iki cümle) |
| H-49 (A) | 05:239 | "S4 orta ve anma akımı benzetimlerinde" → "bütün S4 benzetimlerinde", "salınım" → "25 A'deki salınım"; paragraf sonuna "Büyütülmüş bara kapasitansı, üç fazlı donanımdaki küçük orta nokta salınımını faz başına modelde temsil etmektedir." |
| H-49 (A) | 05:541 | "Kararlılık analizi, S4 anma akımı benzetimlerindeki…" → "Anahtarlamalı modeldeki kararlılık ölçümleri, S4 benzetimlerindeki…" |
| H-49 (A) | 03:507 | "DA bara kapasitörleri, S4 orta ve anma akımı benzetimleri" → "DA bara kapasitörleri, S4 benzetimleri" |
| H-49 / H-09 | 06:389 | Tekrar eden "üç katı" cümlesi (noktalı virgüllü, `\ref{sec:s4-kapali-cevrim}` içeren) çıkarıldı. Alt bölüm 06:387'de gönderme almaya devam etmektedir |
| H-28 | 05:239 | Oturmamış koşunun dört sayısı (−%31,9, %57,4 ve doyum cümlesi) → "Aynı benzetimde modülasyon zamanın %20,6'sında doyumda kalmakta ve çözüm periyottan periyoda yaklaşık %31 değişmektedir." 270 V → 100 V darbe yüksekliği gözlemi ayrı cümle olarak korundu. "Aynı PI denetleyicide…" → "Büyütülmüş barayla PI denetleyici referansı −%2,1 genlik hatasıyla doyumsuz izlemekte, THD %9,2'ye inmektedir." |
| H-48 + H-27 + Y-02 (A) | 05:243 | Üç cümle (7,2 W dahil) → "S4, $L_1$ çekirdek kaybı direnci ve DA bara kapasitansı için S1–S3'ten farklı değerler kullanmaktadır (Tablo). Dolayısıyla S4 verimi ve THD'si S4 benzetimleri arasında karşılaştırılmaktadır." |
| H-46 | 05:313 | "zamanın %0,8'i; $\lvert u\rvert_{\max}=1{,}49$" → "zamanın %0,8'i, doyum öncesi $\lvert u_{\mathrm{ff}}+u_{\mathrm{fb}}\rvert_{\max}=1{,}49$" (noktalı virgül kalktı) |
| H-55 (A) | 05:310, 05:312, 05:547, 06:465 | %0,2 → %0,17, 0,44 ms → 0,43 ms (05:524 zaten bu değerdeydi) |
| H-44 (A) | 05:509 | "Çevrim yavaş ama kararlıdır." → "2,3 A noktasının kararlılığı, P ve PI kapalı çevrim benzetimlerinin kararlı duruma oturmasıyla gösterilmiştir (Tablo~\ref{tab:s4-tarama}). Enjeksiyon ölçümü aynı noktada köprü kazancındaki düşüşü nicelemektedir." |
| H-45 | 05:350 | "$\theta$ yalnız zamana bağlıdır ve şebekeye kilitlidir." → "Analizde $\theta$, ideal PLL ile şebeke kaynağına kilitli açıdır ve yalnız zamana bağlıdır. Sin³ terimi yalnız $\theta$ açısını kullanmaktadır." |
| H-45 + H-51 | 05:200 | "ideal durumda" sözü, Lu2016 atıflı sanal empedans cümlesi ve "daha geniş bir çerçevede ele alınmıştır" cümlesi çıkarıldı |
| H-45 (isteğe bağlı) | 08:115 | "örnekleme ve hesaplama gecikmesi dahil marjlar" → "örnekleme ve hesaplama gecikmesi ile PLL dinamiği dahil marjlar". Atıf eklenmedi. Cümle 32 kelimeye çıktığı için iki nokta yerine nokta ile ikiye bölündü |
| H-51 | 05:511, 05:547 | "akım düzeyiyle ölçeklenen bir büyüklüktür" / "ölçeklenmektedir" → "akım düzeyine bağlıdır" |
| H-51 | 03:433 | "başarısı yalnızca … değil, … denetim eforu, doyum süresi … değerlendirilmektedir" → "etkisi, düşük güç THD değerinin yanında akım izleme hatası, kararlılık marjı, doyum ve anma akımındaki üçüncü harmonik katkısıyla birlikte incelenmiştir" |
| H-31 | 03:587 | "P, PI, PIR; $K_3$ açık ve kapalı & Ortalama model ve anahtarlamalı model doğrusallaştırması" → "P, PI ve PIR, $K_{34}$ açık ve kapalı & Ortalama modelin doğrusallaştırılması ve anahtarlamalı modelde enjeksiyon ölçümü" |
| H-31 | 03:532–535 | $K_1$ → $K_{1x}$, $K_3$ → $K_{3x}$, "KL; $K_3/K_1$" → "KL, $K_{33}/K_{13}$", $\varphi$ → $\varphi_x$, S4 satırı → $K_{14}$, $K_{34}$, $\varphi_4$ |
| H-53 (A) | 05:416 | "Yaygın tasarım ölçütleri … 'dir. Ayrıca … olmalıdır." → "Tasarım ölçütü olarak … alınmıştır. $\mathrm{DM}_{\min}$ değerinin toplam denetim gecikmesinden büyük olması da ölçütlere eklenmiştir." Kaynak eklenmedi |
| H-56 | 05:549 | "farklar ölçüm belirsizliği düzeyindedir" → "farklar iki ölçümün birleşik belirsizliği içinde ya da sınırındadır ve iki benzetimin farklı akımda çalışmasından kaynaklanmaktadır" |
| H-58 | 05:158 | "yumuşak gerilim kaynağı davranışından" → "yumuşak kaynak davranışından" |
| H-58 | 05:509 | "Köprü 2,3 A'de süreksiz iletimde akım kaynağına yakın davranmaktadır." → "2,3 A'de köprünün yumuşak kaynak davranışı belirginleşmekte ve köprü akım kaynağına yaklaşmaktadır." |
| H-57 | 08:34 | "verim klasik anahtarlamadan 2,0 puan…" → "verim, sırasıyla 431,5 V ve 427,5 V DA bara geriliminde yürütülen S1 ve S3 deneylerinde klasik anahtarlamadan 2,0 puan…" (değerler 06:483, 06:485) |
| Y-01 | 05:443 | Nyquist başlığına "Şekil $-1$ noktası çevresini büyüterek göstermektedir. (B) eğrisinin negatif gerçel ekseni kestiği nokta, Tablo~\ref{tab:kararlilik-marjlar} içindeki GM değerine karşılık gelmekte ve çizim aralığının solunda yer almaktadır." eklendi. Yeni sayı yok |
| Y-03 | 05:438 | "$T_d=45$ µs'ye kadar kararlı … DM değerini doğrulamaktadır" → "toplam gecikme $T_d=45$ µs olduğunda kararlı kaldığını göstermektedir. Sonuç, 2 µs gecikmeye eklenen $\mathrm{DM}_{\min}=44{,}4$ µs marjla uyumludur." |
| Y-06 | 05:119, 05:154, 05:237 | "(01.09.2026 hesabı)" silindi; şekil başlığı sonu → "Eğriler parçalı DCM/CCM analitik modelinden elde edilmiştir."; "Oransal kazanç parametre dosyasındaki değerdir." silindi |
| H-52 | aşağıdaki tablo | Simge çakışmaları giderildi |

### H-52 simge değişiklikleri

| Eski | Yeni | Yer |
|---|---|---|
| $d$ (enjeksiyon işareti) | $u_{\mathrm{inj}}$ | 05:478 (dört geçiş). $d$ görev oranı olarak kalmaktadır |
| $L$ (eşdeğer endüktans) | $L_1$ | 05:33 (tanım), 05:35 `eq:dcm-tepe-akimi`, 05:38 ($-v_g/L_1$), 05:46 `eq:dcm-ortalama-akim`, 05:51 `eq:dcm-sinus-zarfi`, 05:82 `eq:ccm-diferansiyel`, 05:89–90 `eq:ccm-akim-cozumu` (iki yer); 05:57 ve 05:113'teki "$L=L_1$" → "$L_1$" |
| $N$, $P$, $Z$ (Nyquist) | $N_{\mathrm{s}}$, $P_{\mathrm{a}}$, $Z_{\mathrm{k}}$ | 05:387 `eq:marj-tanimlari`, 05:392 tanım cümlesi ve "($P_{\mathrm{a}}=0$) … $N_{\mathrm{s}}=0$" |
| $i_g$ (analitik modelde) | $\bar i_L$ | 05:102 ("Anahtarlama periyodu ortalama akımı $\bar i_L(\theta)$ tam şebeke periyodunda…"), 05:104 `eq:akim-fourier-katsayisi` |

- `simgeler.tex`: $\bar i_L$, $N_{\mathrm{s}}$, $P_{\mathrm{a}}$, $u_{\mathrm{inj}}$, $Z_{\mathrm{k}}$ eklendi. Silinen girdi yok: $d$, $L(s)$, $N$, $i_g$, $\varphi$ başka yerlerde kullanılmaya devam etmektedir ($\varphi$ 06:526'da referans fazı olarak geçmektedir).
- Grep denetimi: 05:1–160 arasında endüktans anlamında yalın $L$ kalmadı. 05'te kalan yalın $L$ geçişlerinin hepsi çevrim kazancıdır. $i_g$ 05'te yalnız C noktası akımı anlamında (05:210, 05:247) kalmaktadır. Enjeksiyon anlamında $d$ kalmadı.

## Uygulanmayan kimlikler

| Kimlik | Neden |
|---|---|
| H-47 ek | [YENİ SAYI] ($K_{34}=0$ için şebeke akımı THD'si) |
| H-49 B | [HESAP] (≈5 V / 3,4 V üç fazlı salınım) tez sahibi kararıyla yazılmadı |
| H-48 B | [HESAP] (11,0 W / 17,1 W kayıp) tez sahibi kararıyla yazılmadı |
| H-44 B | [YENİ SAYI] (2,3 A kritik bölge enjeksiyonu) |
| H-53 B | Yeni kaynak eklenmedi |
| H-34 / H-55 B | Tablolar birleştirilmedi |
| H-37 | Şekil yeniden çizimi ana oturumun işidir |
| H-42 (isteğe bağlı) | $(0{,}44,\ 0{,}38)$ çifti çıkarılmadı |
| Y-04, Y-05 | Yalnız savunma |
| 08:111 | Rapor "dokunulmasa da olur" dediği için değiştirilmedi |

## Denetim

- `\label` sayıları değişmedi (03: 35, 05: 49, 06: 40, 08: 4). Hiçbir etiket silinmedi ya da yeniden adlandırılmadı.
- `\cite`: 05'te 7 → 6 (05:200'deki `\citep{Lu2016}` kalktı). Başka atıf eklenmedi ya da çıkarılmadı.
- `\ref`/`\eqref`: 05'te 86 → 87 (05:509'a `tab:s4-tarama`, Nyquist başlığına `tab:kararlilik-marjlar` eklendi, 05:438'deki `tab:kararlilik-marjlar` kalktı), 06'da 82 → 81 (06:389).
- **Lu2016:** 05:438'de (`\citep{Lu2016,Wang2024}`), 01:19, 01:26, 02:309, 02:357 ve 03:351'de atıf almaya devam etmektedir. Kaynakça girdisi kullanılmaya devam ettiği için dokunulmadı.
- Eklenen satırlarda yasak gösterme sözcüğü yok, yeni noktalı virgül yok (03:532–534'teki noktalı virgüller değer listesini ayırmaktadır ve önceden vardı), 30 kelimeyi aşan cümle yok.
