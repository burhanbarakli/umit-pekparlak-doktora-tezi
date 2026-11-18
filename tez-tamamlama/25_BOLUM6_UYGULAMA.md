# Bölüm 6 düzeltmelerinin uygulanması (rapor 23 ve 24)

- **Tarih:** 18.11.2026
- **Onay:** tez sahibi, "yeni sayı gerektirmeyen düzeltmeleri uygula, tez sahibi kararlarını kırmızı kutuyla işaretle".
- **Değişen dosyalar:** `yeni_tez/bolumler/06-deneysel-dogrulama.tex` (606 → 615 satır). Yalnız madde (d) için `yeni_tez/bolumler/01-giris.tex`, `yeni_tez/bolumler/08-sonuc.tex` (iki kutu) ve `yeni_tez/onkisim/ozet.tex` dosyalarına birer `\kirmizinot` eklendi. Bu dosyaların metni değişmedi.
- **Değişmeyenler:** deney ve benzetim sayıları (yalnız 06:590'daki yanlış zincir çıktı), tablo sayı hücreleri, `\label` kümesi (40, adlar aynı), `\umitnot` bloğu, EMF dosyaları, Şekil 6.9. Derleme ve commit yapılmadı.
- **Sayımlar (06):** `\label` 40 → 40, `\ref` 78 → 82, `\eqref` 2 → 2, `\includegraphics` 26 → 26, `\clearpage` 4 → 0, `\kirmizinot` 0 → 7. Bütün `\ref` hedefleri `yeni_tez/bolumler` altında var. Ayraç ve ortam dengesi tutuyor. Eklenen ve değişen satırlarda yasak gösterme sözcüğü yok. Düz metinde yeni noktalı virgül yok.
- **Kırmızı notlar:** Bölüm 6'da 7, öteki dosyalarda 4 (Bölüm 1, Bölüm 8 AS3, Bölüm 8 genel sonuç, Özet), toplam 11.

## Özet sayım

| Rapor | Toplam | Uygulandı | Kısmen | Yalnız kırmızı not | Uygulanmadı |
|---|---:|---:|---:|---:|---:|
| 23 | 57 | 37 | 7 | 2 | 11 |
| 24 | 28 | 10 | 5 | 0 | 13 |

Uygulanan maddelerden beşi (B6-J01, J04, J06, J07, J14) ayrıca kırmızı not taşıyor.

## Rapor 23

| Madde | Durum | Not |
|---|---|---|
| B6-T01 | uygulandı | 06:10 son cümle, 06:605 cümle 7 ve 06:413 ilk iki cümle çıktı. Kapsam 06:4'te tek kez kaldı. |
| B6-T02 | uygulandı | 06:6 cümle 3, 06:387 cümle 3–4 (yerine `sec:kalibrasyon` göndermesi), 06:586 cümle 4, 06:588 son cümle çıktı. |
| B6-T03 | kısmen | 06:300 son cümlesi çıktı. "Farkın durumu" sütunu ve THD satırları kaldı (Y-5 gereği sütun düzeltildi). Hücrelerde noktalı virgül ve geniş zaman giderildi, yöntem adı yalnız grubun ilk satırında. |
| B6-T04 | uygulanmadı | Gerilim sayıları J02 kararına bağlı (kırmızı not). Tablo birleştirme sayı hücrelerini taşır. |
| B6-T05 | uygulandı | 06:407 son cümlesi çıktı. |
| B6-T06 | kısmen | Tablo silinmedi (tablo ve etiket silme görev dışı). 06:413 kısaldı. Orta güç satırına "büyütülmüş DA bara" eklendi (rapor 18 H-49, 08:113 ile uyumlu). |
| B6-T07 | uygulandı | 06:58 ve 06:90 üçüncü cümleleri çıktı. İsteğe bağlı şekil çıkarma yapılmadı. |
| B6-T08 | uygulanmadı | Bölüm 3 (03:595); görev yalnız madde (d) için başka bölüme izin veriyor. |
| B6-T09 | uygulanmadı | Bölüm 4 (04:134); aynı neden. |
| B6-T10 | uygulanmadı | 06:268 hücresi sayı içeriyor (tablo sayı hücresine dokunulmadı). |
| B6-T11 | uygulandı | 06:125 ölü zaman cümlesi çıktı. |
| B6-T12 | uygulanmadı | Rapor değişikliği isteğe bağlı bırakıyor. |
| B6-T13 | uygulandı | 06:586 zarf betimi şekil göndermesine indi. |
| B6-T14 | uygulandı | 06:4 son cümle, 06:6 cümle 4 ("özgün çözünürlükleriyle"), 06:409 ilk cümle, 06:411 son cümle, 06:599 son cümle, 06:605 cümle 6 çıktı. 06:603 tek cümle oldu ve 06:605 ile birleşti. 07:8 kapsam dışı. |
| B6-A01 | uygulanmadı | Numaralı lejant çıkarılırsa Şekil 6.7'deki 1–11 numaraları açıklamasız kalıyor. |
| B6-A02 | kısmen | 06:141 son cümlesi (ADC aralığı, J20) ve 06:165 TLV431/MC33269 cümlesi çıktı. 06:143 parça adları EK A sayfalarına gönderme taşıdığı için kaldı. |
| B6-A03 | uygulanmadı | Şekil silme ve birleştirme etiket değiştiriyor. Şekil 6.2 yalnız küçültüldü (O-1). |
| B6-A04 | uygulanmadı | Şekil silme. 06:156 son cümlesi J18 ile çıktı. |
| B6-A05 | uygulandı | 06:285 baud ve veri sırası cümleleri çıktı, kalan cümle 06:283 paragrafına katıldı. |
| B6-A06 | uygulandı | Diferansiyel giriş ve Miller kenetleme açıklama cümleleri çıktı. |
| B6-A07 | uygulandı | 06:530 ilk cümle bulgu olarak yazıldı, 06:549 son cümle çıktı. |
| B6-A08 | uygulandı | `tab:olcum-cihazlari` üç hücresi "Üretici veri sayfası." oldu. |
| B6-Y01 | uygulandı | S03 göndermeleriyle S2/S3 PC ekranları metne girdi. |
| B6-Y02 | uygulandı | Osiloskop kanal adı açıklaması 06:309'a taşındı. |
| B6-S01 | uygulandı | Tablo 6.12 altyazısı sadeleşti. Fark gösterimi (yüzde / p) 06:582'ye metin cümlesi olarak girdi. |
| B6-S02 | uygulandı | Tablo 6.11 altyazısı sadeleşti. Kalibrasyon öncesi bilgisi 06:530'da zaten var. |
| B6-S03 | uygulandı | `fig:deney-susturma-pc` ve `fig:deney-sin3-pc` için klasik yöntemdeki cümlenin eşi eklendi (THD$_i$ aralıkları Tablo 6.7'den). |
| B6-S04 | kısmen | "Yorum" sütunu kaldı (Y-5 gereği raggedright). 06:427 hücresindeki noktalı virgül iki cümle oldu. |
| B6-S05 | uygulandı | TikZ'de "PF" → $\cos\varphi_1$. |
| B6-S06 | uygulandı | D-6 ile altı osiloskop altyazısı kısaldı. Kanal düzeni 6.21 ve 6.24 paragraflarında metne girdi. |
| B6-S07 | uygulandı | Tablo 6.2 altyazısı "Faz donanımı bileşenleri." oldu. |
| B6-S08 | kısmen | $P_o$/$P_{\mathrm{out}}$ → $P_{\mathrm{ac}}$ (06:476, 485, 528), $I_{\mathrm{faz}}$, $\eta_{\mathrm{VI}}$, "THDi" → THD$_i$. THD$_{i,\mathrm{faz}}$ başlıkları ve Bölüm 5 THD$_I$ kaldı. |
| B6-S09 | uygulanmadı | Tez geneli terim kararı. "Kapasitör" tez genelinde çoğunlukta, rapor "kondansatör" öneriyor. |
| B6-J01 | uygulandı + kırmızı not | 06:294, 06:582, 06:588 A cümleleri eklendi. "Bildirilen verim"in kaynağı kırmızı not. |
| B6-J02 | kırmızı not | 06:411 sonrası. İki değer kümesi ve hangisinin hangi kaynağa ait olduğu. |
| B6-J03 | uygulandı | 06:526 son iki cümle ("THD hedefi", "ikincil ölçüt") çıktı. |
| B6-J04 | kısmen + kırmızı not | 06:517 "toplam güç faktörü (PF)", TikZ $\cos\varphi_1$. 07:395 kapsam dışı. K-29'un Bölüm 8 cümlesi kırmızı not. |
| B6-J05 | uygulandı | 06:590 sayı zinciri (4,4 V, 10 Ω, 0,44 A, %20) çıktı. Niteliksel sonuç kaldı. |
| B6-J06 | uygulandı + kırmızı not | Öz-karşılaştırma kalktı. Paragraf "0,1 s anında oturma sürmektedir" biçiminde yeniden kuruldu, sayılar aynı. Review notu pencereleri adlandırmıyor ve iki farklı aralık veriyor, kırmızı not. |
| B6-J07 | uygulandı + kırmızı not | 06:407'ye S1→S2 belirsizlik cümlesi eklendi. "Artırmıştır/taşımıştır" ifadeleri için Bölüm 6, Bölüm 1, Bölüm 8 (iki yer) ve Özet'te kırmızı not. |
| B6-J08 | uygulandı | 06:407'ye S1–S3 karşılaştırma cümlesi eklendi (2,0 puan, 06:597 ile aynı). |
| B6-J09 | uygulandı | T01 ile kapsam tek yerde (06:4). |
| B6-J10 | uygulandı | 06:528'e "S1 bandı özet okumasındaki 1,000 değerinden hesaplanmıştır." eklendi. |
| B6-J11 | uygulandı | 06:285 cümleleri 06:309'a taşındı, "benzetim modelinin yapısına göre" ifadesi kalktı. |
| B6-J12 | uygulandı | 06:4 "Anma akımındaki (25 A)". |
| B6-J13 | kırmızı not | 06:10 sonrası. K-08 ve Bölüm 7/8 ile birlikte karar gerekiyor. |
| B6-J14 | uygulandı + kırmızı not | 06:279'a ölçüm sınırı cümlesi eklendi. Yardımcı besleme ve fanın kaynağı kırmızı not. |
| B6-J15 | kısmen | 06:176 ve 06:205'e görselin üretici belgesinden alındığı ve veri sayfasının EK A'da olduğu cümleleri eklendi. (b) alt şekilleri kaldı (şekil silme görev dışı). |
| B6-J16 | uygulandı | 06:499'a mertebe sınırı cümlesi. |
| B6-J17 | uygulanmadı | Rapor değişiklik önermiyor. |
| B6-J18 | uygulandı | 06:156 son cümle çıktı. |
| B6-J19 | uygulandı | "Güç yönünde üretici (generator) işaret kuralı kullanılmıştır." Anlam aynı. |
| B6-J20 | uygulandı | Belirsiz ADC aralığı cümlesi çıktı (A02 ile). |
| B6-J21 | uygulandı | Belirsiz 12 V cümlesi çıktı (A seçeneği). |
| B6-J22 | uygulandı | $\Delta i_L$ tanımı eklendi (04'teki yaklaşık −2,6 A ile aynı, yeni sayı yok). Bölümler arası gönderme eklenmedi (kural 11). |
| B6-J23 | uygulandı | "…kanıt zinciri deneysel doğrulamayla tamamlanmaktadır." |
| B6-J24 | uygulanmadı | Bölüm 3 (03:629). |

## Rapor 24

| Madde | Durum | Not |
|---|---|---|
| Y-1 | uygulandı | S03 ile aynı. |
| Y-2 | uygulandı | Ok DA bara kutusunun batı ucundan 5 mm sola çıkıp aşağı iniyor ve PC kutusuna batıdan giriyor. `meas` 32 mm, `data` 45 mm. "CT" → "akım trafosu". Derlemede gözle denetlenmeli. |
| Y-3 | uygulanmadı | Kırpma değerleri derlemede ayarlanmalı (derleme görev dışı). |
| Y-4 | uygulandı | S01 ile aynı. |
| Y-5 | uygulandı | Tablo 6.6 ve 6.7 `L{}` ve `>{\teksatir\raggedright\arraybackslash}X` sütunlarıyla. Tablo 6.7'de yöntem adı yalnız grubun ilk satırında. |
| Y-6 | kısmen | Dört `\clearpage` kalktı (yatay ya da uzun tablo öncesi değil). Şekil 6.8 `0.45\textheight`. Şekil 6.4/6.5 birleştirmesi etiket değiştirdiği için yapılmadı. Boşluklar derlemede yeniden ölçülmeli. |
| O-1 | kısmen | Şekil 6.2 `0.6\textwidth`. Birleştirme yapılmadı. 6.3'ün kesik işaretleri yeni kaynak ister. |
| O-2 | uygulanmadı | Şekil 6.9 yeniden çizilmedi (görev gereği bırakıldı). |
| O-3 | kısmen | 6.12(a) altyazısı "Panodaki AcuDC240." oldu, kaynak cümleleri metne girdi. Kırpma ve kaynakça girdisi yapılmadı. |
| O-4 | kısmen | `tabularx` → `tabular{c *{7}{c}}`, $I_{\mathrm{faz}}$, $\eta_{\mathrm{VI}}$. 92,700 → 92,70 sayı hücresi olduğu için yapılmadı. |
| O-5 | uygulanmadı | EMF dönüştürme görev dışı. "Özgün çözünürlükleriyle" cümlesi T14 ile çıktı. |
| O-6 | uygulandı | "5 VA" (`inter-unit-product={}`), "23 mV/A" (`per-mode=symbol`), "0,1 doğruluk sınıfı" (tablo ve metin), Tablo 6.8 `L{}` sütunları, `$-12\ldots{-25}$`, Tablo 6.11 altyazısı. Satır arası (`\Ts`) §3 kapsamında bırakıldı. |
| O-7 | uygulandı | Altyazı "PC ana kumanda yazılımının arayüzü." Şekil kaldı. |
| D-1 | uygulandı | S07 ile aynı. |
| D-2 | kısmen | "Boost diyotları", "Ölçüm kartı", Şekil 6.8 "kartı" uygulandı. Kondansatör/kapasitör tez geneli karar (S09). |
| D-3 | uygulandı | Şekil 6.13 altyazısında "/". |
| D-4 | uygulanmadı | Tablo 6.5 sayı hücresi. |
| D-5 | uygulanmadı | Kırpma derleme ister. |
| D-6 | uygulandı | S06 ile aynı. |
| D-7 | uygulanmadı | EMF dönüştürme gerekiyor. |
| D-8 | uygulandı | Y-6 küçültmesi. Yeni kaynak yok. |
| D-9 | uygulanmadı | Rapor değişiklik önermiyor. |
| D-10 | uygulanmadı | İsteğe bağlı `\umitnot`. Şekil değişmiyor. |
| D-11 | uygulanmadı | Rapor işlem önermiyor. |
| §3.1 siunitx yazı tipi | uygulanmadı | Global değişiklik görev dışı. |
| §3.2 `\Ts` satır yüksekliği | uygulanmadı | Global değişiklik görev dışı. |
| §3.3 Tablo 6.12 `\scriptsize` | uygulanmadı | SAÜ alt sınırı denetimi ve yerleşim kararı gerekiyor. |
| §3.4 altyazı ilk satır gerilmesi | uygulanmadı | Global. Altyazı kısaltmaları (Y-4, O-6, D-6) kısmen karşılıyor. |

## Kırmızı notların yerleri

| Konu | Yer |
|---|---|
| (a) Verim tanımı: bildirilen verim ↔ $P_{\mathrm{ac}}/P_{\mathrm{dc}}$ | 06, Tablo 6.12'den sonraki paragraf |
| (b) "Deney özeti" adıyla iki değer kümesi | 06, 06:411 paragrafından sonra |
| (c) 20 kVA ↔ "20–25 kW" | 06:10 paragrafından sonra |
| (d) S2→S3 verim farkı belirsizlik içinde | 06:407 sonrası, 01 katkı maddesi 2, 08 AS3, 08 genel sonuç, Özet |
| Yardımcı besleme ve fan ölçüm sınırında mı (J14) | 06:279 sonrası |
| K-29 Bölüm 8 PF cümlesi, 07:395 (J04) | 06:517 sonrası |
| Benzetim penceresi kaydı (J06) | 06:599 sonrası |

## Emin olunmayan noktalar

1. **J06:** review notu (`2026-10-28_KALIBRASYON_S1_S3.md`) karşılaştırılan iki pencereyi adlandırmıyor ve aynı fark için iki ayrı aralık veriyor (satır 269–271 ve 327–328). Metin "0,1 s anında oturma sürmektedir" biçiminde yeniden kuruldu. Sayılar aynı kaldı ve kırmızı not eklendi.
2. **J22:** $\Delta i_L$'nin S1'deki ters yönlü akım tepesi olduğu yorumu rapor 23'ten ve 04'teki "−2,6 A" cümlesinden alındı.
3. **Y-2:** TikZ yeni yolu ölçüyle denetlendi (dikey kol `ctrl` kutusunun yaklaşık 3 mm solundan geçiyor). Derlemede gözle bakılmalı.
4. **siunitx seçenekleri:** `inter-unit-product={}` ve `per-mode=symbol` yerel seçenek olarak verildi. Derlemede çıktı denetlenmeli.
5. **01-giris.tex:** kırmızı kutu `enumerate` içindeki ikinci maddenin içinde. Derlemede görünümü denetlenmeli.

## Tez sahibinin kararı (18.11.2026)

Karar gerektiren maddeler (verim tanımları, iki değer kümesi, kVA/kW, S2→S3 farkının belirsizlik içinde kalması, yardımcı besleme, K-29 cümlesi) için kırmızı KONTROL kutusu konmadı; tez sahibi "gerek yok" dedi. Uygulama sırasında eklenen 11 kutu kaldırıldı. Global öneri olarak siunitx `mode=text` uygulandı (sayılar metin yazı tipiyle).
