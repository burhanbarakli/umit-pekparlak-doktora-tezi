# Windows (MATLAB R2023b) tarafından istenenler

Mac'te MATLAB yok. Bu dosya, Mac oturumunun MATLAB gerektiren isteklerini toplar.
Windows'taki oturum her işi bitirince ilgili satırı "yapıldı (tarih, commit)" diye işaretler.
Karar kaydı: `01_KARAR_DEFTERI.md` K-39, K-40.

## İstek 1: Bölüm 5 şekillerini yeniden üret (K-40 üçüncü ve dördüncü tur) — yapıldı (18.11.2026)

**Windows sonucu (18.11.2026, 62d200b üzerine):** Betik hatasız çalıştı; `yama bulunamadi` ya da
`b5_son:dusey` uyarısı çıkmadı. Geçici analitik kopyanın dokuz CSV'si (`lg_taramasi`, `kararlilik_marjlar`,
`kararlilik_gecisler`, `kararlilik_kutuplar`, `gecikme_taramasi`, `kazanc_taramasi`, `k34_degismezlik`,
`bode_L_S_T_A`, `sin3_bozucu_etkisi`) özgünle bayt düzeyinde aynı. Betikteki `marjlar_ozet.csv` adı
diskte yoktu (gerçek ad `kararlilik_marjlar.csv`), bu yüzden o satır sessizce atlanıyordu; ad düzeltildi.
Tez 213 sayfa, tanımsız referans ve taşan satır yok. Aşağıdaki tablodaki sekiz beklenti PDF'lerde
gözle denetlendi ve karşılanıyor (5.1 "V_h − v_g" eksi işareti, 5.4 dik µ, 5.6 sağ eksen −100/0/100,
5.7 iki satırlı y adı, 5.8 −1,75…1,25 ve iki panelde 55 ms çizgisi, 5.9 işaretçiler eksen içinde,
5.10 $K_{34}=0$ işaretçileri ve gösterge girdisi, 5.11 ortak alt gösterge).

**Neden:** 1e2ed42 ile üretilen şekillerde denetçi dört sorun buldu. Mac'te betiğe
eklendiler, ama PDF'ler henüz eski. Altyazılar yeni şekillere göre yazıldı: 5.10
altyazısı "$K_{34}=0$ durumu işaretçiyle gösterilmiştir" diyor, yani betik
çalışana kadar metin ile şekil uyuşmuyor.

**Ne yapılacak:**

```powershell
cd "C:\CODES\ümit abi"
git pull
& "C:\Program Files\MATLAB\R2023b\bin\matlab.exe" -sd "C:\CODES\ümit abi\tez-matlab-simulink" -batch "run('scripts/duzelt_bolum5_sekiller_20261117.m')"
```

Betik benzetimi yeniden koşturmaz. Yalnız `yeni_tez/sekiller/b5/*.pdf` dosyaları değişir.
Çıktıda `lg_taramasi.csv ozgunle ayni: 1` ve `marjlar_ozet.csv ozgunle ayni: 1` görülmeli.

**Beklenen sonuç (PDF'e bakarak denetle):**

| Şekil | Dosya | Beklenen |
|---|---|---|
| 5.1 | `harmonik_olusum_mekanizmasi.pdf` | (b) göstergesinde "V_h − v_g" yazmalı, tire değil eksi işareti |
| 5.4 | `s3_l1_akimi.pdf` | Eksen adları ve başlık 8 pt, gösterge 7,5 pt; µ dik yazılı |
| 5.6 | `s4_akim_izleme_25A.pdf` | Sağ eksende yalnız −100, 0, 100; köşede "40" ile "−200" çakışmamalı |
| 5.7 | `s4_tarama_ozet.pdf` | Orta panelin y adı iki satır ("Şebeke akımı" / "THD’si (%)"); üstteki göstergeye binmemeli |
| 5.8 | `s4_basamak_PI_10_25A.pdf` | Alt eksen −1,75…1,25; +1 doyum çizgisi görünür; 55 ms noktalı çizgi iki panelde de |
| 5.9 | `kararlilik_L_bode_K34.pdf` | $K_{34}=0$ işaretçileri 1 Hz eksen kenarında değil, biraz içeride |
| 5.10 | `kararlilik_S_T.pdf` | Her $\lvert S\rvert$ ve $\lvert T\rvert$ eğrisinin üstünde $K_{34}=0$ işaretçileri (o); göstergede "K_{34} = 0" girdisi |
| 5.11 | `kararlilik_nyquist_A_B.pdf` | Panel içinde gösterge kalmamalı; iki panelin altında P, PI, PIR için tek ortak gösterge |

**Hata çıkarsa:**
- `yama bulunamadi` hatasında `b5_yama` aranan satırı yazar. Kaynak betikteki satır değişmiş demektir: yamayı o satıra uydur.
- `b5_son:dusey` uyarısı, 55 ms çizgisinin üst panelde bulunamadığını gösterir. Şekil yine üretilir, ama alt panelde çizgi olmaz; 5.8 altyazısı bunu varsayıyor.
- 5.11'de `lg.Layout.Tile` atanamazsa `disari` işlevi göstergeyi kendi ekseninin altına koyar (`southoutside`). Bu kabul edilebilir.
- 5.10'da `getLoopTransfer(ara{k, 2}, ...)` hata verirse `ara` değişkeni o noktada tanımsızdır. Şekil 5.9'daki aynı satır nerede çalışıyorsa hesabı oraya taşı.

**Bitince:** `git add yeni_tez/sekiller/b5 tez-tamamlama` → commit → push.
Bu dosyada İstek 1'i "yapıldı" diye işaretle. Mac tarafı çekip derler ve yeniden denetletir.

## Bilerek bırakılanlar

- **5.14 alt panelin $t<0$ boşluğu:** Geçici bileşen $i_{L1}(t)-i_{L1}(t+20\,\mathrm{ms})$ yalnız basamaktan sonra anlamlı. Panellerin aynı zaman eksenini paylaşması, eksen kesmekten daha açık. Değiştirilmeyecek.
- **5.10'daki "150 Hz" yazısının 200 Hz ızgara çizgisine oturması:** Okunuyor, işlem yapılmayacak.
