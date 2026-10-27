# Dosya envanteri ve sürüm notları

Tarih: 12 Temmuz 2026

## Kaynak arşivler

| Arşiv | Boyut | Açılan dosya | SHA-256 |
|---|---:|---:|---|
| `BOLUM1.rar` | 51,10 MB | 43 | `3BCDB5EDFADB9A0EEB60BAC99128227C5FC8C4D7F5F2E3312BAEACB61F02280D` |
| `BOLUM2.rar` | 97,52 MB | 46 | `1F59062F7D56B4DA3EB9BE5CAA6BA92BC2A2F5FA9E4E7C02F6593BA925E3EE74` |
| `BOLUM3.rar` | 79,84 MB | 27 | `030B1B772F4D7BD31D0578B405A52BDCA4418F2E58A83244D089B81E0C1A334F` |
| `BOLUM4.rar` | 121,85 MB | 64 | `8F3D36F8936896CF79A65EEAE3D936582F4F31F23B8FE23D2D8333C66879D855` |
| `tez_tumu_8.rar` | 59,88 MB | 1 | `D36DF299F896425BBA648A13A3F9A4AAAC5B859C87CC315ADF0598B16B18A98A` |

Arşivler `00_ORIJINAL_ARSIVLER` altına taşındı. Açılan içerikler ayrı klasörlere kopyalandı; arşivlerin içeriği değiştirilmedi.

## Kategorilere göre içerik

| Bölüm | Ana metin | Kaynak listesi/özeti | Kaynak analizi | Ham kaynak | Şekil | Yedek/geçici |
|---|---:|---:|---:|---:|---:|---:|
| Bölüm 1 | 2 | 1 | 15 | 15 | 10 | 0 |
| Bölüm 2 | 2 | 2 | 16 | 16 | 10 | 0 |
| Bölüm 3 | 1 | 2 | 4 | 4 | 16 | 0 |
| Bölüm 4 | 1 | 1 | 10 | 29 | 21 | 2 |

Toplam kategorize edilmiş bölüm dosyası: 180. Tam tez dosyası: 1. Özgün arşiv: 5.

## Sürüm bulguları

- Bölüm 1'de `bolum_14.docx` ve `bolum_15.docx` vardır. Boş olmayan paragrafların benzersiz kümelerine göre benzerlik oranı yaklaşık %46'dır. Bu nedenle biri diğerinin basit kopyası sayılmamalıdır.
- Bölüm 2'de `bolum_23.docx` ve `bolum_24.docx` vardır. Aynı ölçüte benzerlik yaklaşık %61'dir; iki sürüm de korunmuştur.
- Bölüm 4'te ana `bolum_413.docx` yanında bir `bolum_413.rar` bulunmaktadır. RAR içindeki DOCX ile ana DOCX'in SHA-256 değerleri farklıdır; ikisi de sürüm adayı olarak korunmalıdır.
- Bölüm 4'teki `~$YNAKLAR.docx` bir Word geçici/kilit dosyası görünümündedir. Yeni tez derlemesine kaynak olarak alınmamalıdır.
- Tam tezde 164 izlenen ekleme (tracked insertion) işareti vardır. Yeni ana sürüm oluşturulmadan önce değişikliklerin kabul/red durumu bilinçli olarak kararlaştırılmalıdır.

## Dosya adı sorunları

Bazı RAR girdilerindeki Türkçe karakterler arşiv kodlaması nedeniyle bozuk görünmektedir. Kaynak kaybını önlemek için ilk kategorizasyonda adlar zorla değiştirilmemiştir. Yeni tez için kullanılan şekiller seçildiğinde bunlar anlamlı, ASCII uyumlu ve tek bir adlandırma standardına göre yeniden adlandırılmalıdır.

