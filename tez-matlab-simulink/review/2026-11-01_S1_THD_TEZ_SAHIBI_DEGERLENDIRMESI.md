# S1 THD: tez sahibi değerlendirmesi ve osilogram denetimi (01.11.2026)

Karar: K-29. Kaynak: Ümit Pekparlak'ın maili
(`dosyalar/06_UMIT_ABIDEN_GELENLER/2026-11-01_s1_thd_degerlendirmesi/`). Model koşusu yapılmadı;
kalibre sonuçlar değişmedi.

## Maildeki değerlendirme

| Madde | İçerik | Tezdeki karşılığı |
|---|---|---|
| 1, 5 | Deneysel THDi %15 doğru kabul edilir; PF anlık değerdir, dikkate alınmaz; osilogram yaklaşık %20 verir | Deney değeri %15; `\%42` ve "tutarsız" ifadeleri kaldırıldı |
| 2 | Tablo 5.4'te THDi faz verilir, THDi L1 çıkarılır, benzetimde %39,5 değerlendirilir | `tab:deney-dusuk-guc-ozeti` yeniden yazıldı |
| 3 | Temmuz benzetimi SimPower'dadır, değerleri güvenilir değildir | Senaryo ekranları, FFT şekilleri ve iki tablo çıkarıldı |
| 4 | Şebeke THDv modelde yok; analizör varyak ile evirici arasında ölçer | Tablo satırı ve "Şebeke gerilimi bozulması" paragrafı |
| Son kısım | S1 dalga biçimi sivri tepeli, osilogramda kamburlu; L-R ve referans fazı etkili | Kesim 6.10 S1 paragrafı |

Proje sahibi yönü belirledi: benzetim yaklaşık değerlerle kalır, model yeniden ayarlanmaz.

## Osilogram denetimi

Betik: `runs/2026-11-01_osiloskop_thd/osiloskop_thd.py`, sonuç: `osiloskop_thd.csv`.
Üç osilogramın faz akımı izi (kanal 4) 800×480 PNG'den sayısallaştırıldı; 150 piksel/periyot,
25. harmoniğe kadar, 2–4 periyot pencereleri.

| Senaryo | Şekil | Osiloskop RMS | THD | h3 | h5 | h7 | Analizör özeti | Analizör anlık | Kalibre model |
|---|---|---|---|---|---|---|---|---|---|
| S1 | 5.18 | 2,874 A | 20,3–20,7 (pencere 17,1–22,4) | 19,0 | 3,7 | 4,0 | 15 | 11,1 | 39,5 |
| S2 | 5.21 | 2,420 A | 47,4 (46,9–47,8) | 46,6 | 5,9 | 2,4 | 47 | 48,6 | 56,7 |
| S3 | 5.24 | 2,293 A | 11,8–12,0 (11,5–12,5) | 8,7 | 6,3 | 3,3 | 14 | 15,7 | 14,8 |

Tezde yuvarlak değerler kullanıldı: yaklaşık %21, %47, %12.

Sonuç: Ümit'in %20 hesabı doğrulandı. Yöntem S2'de analizörü bire bir verdiği için ölçek bağımsız
bir denetim sayılabilir. Analizör ve osiloskop aynı büyüklük düzeyindedir.

Sınırlar:

- Düşey çözünürlük yaklaşık 0,1 A/piksel; değerler yaklaşıktır.
- S3 izinde 595–617. sütunlarda ayrı bir yeşil işaret vardır; 288. satır altı süzgeciyle ayıklandı.
- S1 osilogramı 2,87 A'dadır, analizör özeti 2,26 A'dır; kayıtlar ayrı anlardadır. Akım yüksekken
  THD düşer, yani osilogram S1 THD'sini olduğundan düşük gösteriyor olabilir.
- Üç osilogramın tarihi 2 Ocak 2026, saatleri 10:12, 13:12, 13:39'dur.

## Kaba THDv kestirimi

Analizör ekranları: S1 %3,7, S2 %5,4, S3 %4,8. 120 V'ta %3,7 ≈ 4,4 V. 5. harmonikte
L1 + L2 = 1,6 mH → 10 Ω. Harmonik akım ≈ 0,44 A, 2,26 A'nın ≈ %20'si. Yalnız büyüklük mertebesidir:
THDv'nin tamamı 5. harmonik varsayılmıştır ve okuma evirici akımının kendi etkisini de içerir.

## Açık kalan noktalar

1. Maildeki yön kalibre modele uymuyor. "Benzetim THD'si deneyden düşük" Temmuz benzetimi içindir;
   kalibre model üç senaryoda da deneyden yüksektir. Tezde etki yönsüz yazıldı.
2. PF kararı tartışmaya açık. `P/(VI) = 0,922` özet tablonun kendi sayılarından hesaplanabilir ve
   %15 ile 0,989 beklenirdi. Tezde PF satırı kaldırıldı; karar Kesim 6 ve Bölüm 8'de birer cümleyle
   açıkça yazıldı. Akım eğrisi 2,0–2,3 A arasında değiştiği için tek anlık satır temsil edici değildir.
   Jüri cevabı notlu PDF'te mavi kutudadır.
3. S1 THD ve dalga biçimi model tarafında kapanmadı. Gelecek çalışmaya yazıldı: ölçülen şebeke
   harmonikleri ve şebeke L–R eşdeğeri modele eklenerek yeniden değerlendirme.
4. Maildeki "L-R ve referans fazı etkili" gözlemi Ümit'in denemelerine dayanır, bu çalışmada
   yinelenmedi. Tezde "parametre denemelerinde" diye geçer.
