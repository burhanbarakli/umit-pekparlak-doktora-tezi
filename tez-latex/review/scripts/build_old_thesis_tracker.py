from __future__ import annotations

import csv
import html
import json
import re
from collections import Counter
from pathlib import Path


ROOT = Path(__file__).resolve().parents[2]
RAW = ROOT / "review" / "onceki_tez_envanter_ham.json"
OUT_BASE = ROOT / "review" / "ONCEKI_TEZ_SEKIL_TABLO_TAKIP_LISTESI_2026-07-13"
AUX_CANDIDATES = [
    ROOT / "build" / "main.aux",
    ROOT / "main.aux",
    ROOT / "build_html_numbers" / "main.aux",
    ROOT / "build_guncel" / "main.aux",
]


LABEL_OVERRIDES = {
    ("Şekil", "1.4"): ["tab:eds-maliyet-dagilimi"],
    ("Şekil", "3.11"): ["fig:onceki-tez-ccm-ters-akim"],
    ("Şekil", "3.12"): ["fig:onceki-tez-dcm-akim"],
    ("Şekil", "6.1"): ["fig:t-tipi-uc-seviye"],
    ("Şekil", "6.2"): ["fig:gt-eski-viyana-pfc"],
    ("Şekil", "6.3"): ["fig:gt-eski-cok-sekonderli-bys"],
    ("Şekil", "6.4"): ["fig:gt-eski-ana-topoloji"],
    ("Şekil", "6.5"): ["fig:gt-eski-evirici-lcl"],
    ("Şekil", "6.6"): ["fig:gt-eski-iki-seviye-trafo"],
    ("Şekil", "6.7"): ["fig:gt-eski-pfc"],
    ("Şekil", "6.8"): ["fig:gt-eski-simulink-modeli"],
    ("Şekil", "6.9"): ["fig:gt-eski-pfc-akimlari"],
    ("Şekil", "6.10"): ["fig:gt-eski-da-bara"],
    ("Şekil", "6.11"): ["fig:gt-eski-primer-gerilim"],
    ("Şekil", "6.12"): ["fig:gt-eski-primer-akim"],
    ("Şekil", "6.13"): ["fig:gt-eski-sekonder-gerilim"],
    ("Şekil", "6.14"): ["fig:gt-eski-sekonder-akim"],
    ("Şekil", "6.15"): ["fig:gt-eski-batarya-soc"],
    ("Şekil", "4.1"): ["fig:klasik-kapi-darbeleri-tam"],
    ("Şekil", "4.2"): ["fig:klasik-kapi-darbeleri-yakin"],
    ("Şekil", "4.3"): ["fig:onceki-faz-modeli"],
    ("Şekil", "4.4"): ["fig:onceki-simulasyon-modeli"],
    ("Şekil", "4.5"): ["fig:klasik-l1-tam"],
    ("Şekil", "4.6"): ["fig:klasik-l1-yakin"],
    ("Şekil", "4.7"): ["fig:klasik-dort-kanal"],
    ("Şekil", "4.8"): ["fig:klasik-l1-fft"],
    ("Şekil", "4.9"): ["fig:klasik-iout-fft"],
    ("Şekil", "4.10"): ["fig:susturma-kapi-darbeleri-tam"],
    ("Şekil", "4.11"): ["fig:susturma-kapi-darbeleri-yakin"],
    ("Şekil", "4.12"): ["fig:susturma-l1-tam"],
    ("Şekil", "4.13"): ["fig:susturma-l1-yakin"],
    ("Şekil", "4.14"): ["fig:susturma-dort-kanal"],
    ("Şekil", "4.15"): ["fig:susturma-l1-fft"],
    ("Şekil", "4.16"): ["fig:susturma-iout-fft"],
    ("Şekil", "4.18"): ["fig:eski-feedforward-etkisi"],
    ("Şekil", "4.19"): ["fig:eski-espotansiyel-dalga"],
    ("Şekil", "4.20"): ["fig:eski-tam-guc-feedforward"],
    ("Şekil", "4.21"): ["fig:eski-dusuk-guc-feedforward"],
    ("Şekil", "4.22"): ["fig:eski-dogrusal-olmayan-sistem"],
    ("Şekil", "4.24"): ["fig:senkron-buck-esdeger"],
    ("Şekil", "4.25"): ["fig:eski-dcm-dmax-taramasi"],
    ("Şekil", "4.26"): ["fig:eski-dcm-ccm-adaylari"],
    ("Şekil", "4.27"): ["fig:eski-dcm-harmonik-dagilim"],
    ("Şekil", "4.28"): ["fig:eski-katsayi-yuzeyi"],
    ("Şekil", "4.29"): ["fig:sin3-l1-yakin"],
    ("Şekil", "4.30"): ["fig:sin3-dort-kanal"],
    ("Şekil", "4.31"): ["fig:sin3-l1-fft"],
    ("Şekil", "4.32"): ["fig:sin3-iout-fft"],
    ("Şekil", "5.1"): ["fig:deney-duzenegi-genel"],
    **{("Şekil", f"5.{n}"): [f"fig:deney-eski-5-{n}"] for n in range(2, 25)},
    ("Tablo", "4.1"): ["tab:eski-dcm-harmonik-katsayilari"],
    ("Tablo", "4.2"): ["tab:eski-dcm-harmonik-katsayilari"],
    ("Tablo", "5.1"): ["tab:deney-alt-birimler"],
    ("Tablo", "5.2"): ["tab:deney-eski-5-2"],
    ("Tablo", "5.3"): ["tab:deney-eski-5-3"],
    ("Tablo", "5.4"): ["tab:deney-dusuk-guc-ozeti"],
}


PDF_NOTES = {
    ("Şekil", "1.4"): "Eski şekil çıkarıldı; bilgi yeni PDF'de tabloya aktarıldı.",
    ("Şekil", "3.11"): "Geçici açıklama şeması.",
    ("Şekil", "3.12"): "Geçici açıklama şeması.",
    ("Şekil", "3.13"): "Kavramsal karşılık; Bölüm 5'te üretilecek nihai şekil henüz yok.",
    ("Şekil", "3.14"): "Kavramsal karşılık; Bölüm 5'te üretilecek nihai şekil henüz yok.",
    ("Şekil", "6.1"): "Tekrar basılmadı; Bölüm 3'teki T-tipi üç seviyeli faz koluna çapraz başvuru verildi.",
    **{("Şekil", f"6.{n}"): "Özgün görsel yeni Bölüm 7'de ayrı sarı tarihsel şekil olarak aktarıldı; ham model, devre veya sayısal kayıtla doğrulama bekliyor." for n in range(2, 16)},
    **{("Şekil", f"4.{n}"): f"Ayrı Şekil 4.{n} olarak aktarıldı; birleşik eşleme kaldırıldı." for n in range(1, 5)},
    **{("Şekil", f"4.{n}"): "Sonradan gelen Senaryo 1 kaynak ekranıyla doğrulanan ayrı Şekil 4.5–4.9 karşılığında veriliyor." for n in range(5, 10)},
    **{("Şekil", f"4.{n}"): f"Ayrı Şekil 4.{n} olarak aktarıldı; birleşik eşleme kaldırıldı." for n in range(10, 17)},
    **{("Şekil", f"4.{n}"): "Bölüm 5'te özgün sırası ve sarı tarihsel etiketiyle ayrı şekil olarak aktarıldı; görsel/metin sayıları gerçek modelle doğrulanacak." for n in range(18, 23)},
    **{("Şekil", f"4.{n}"): "Bölüm 5'te ayrı sarı tarihsel şekil olarak aktarıldı; ham modelle yeniden üretim bekliyor." for n in range(25, 29)},
    **{("Şekil", f"4.{n}"): "Bölüm 5'te ayrı Senaryo 3 kaydı olarak aktarıldı; ham zaman serisi bekliyor." for n in range(29, 33)},
    **{("Şekil", f"5.{n}"): f"Özgün görsel ayrı tutuldu ve yeni Şekil 6.{n} olarak metin içi açıklamasıyla aktarıldı." for n in range(1, 25)},
    ("Şekil", "5.3"): "Numaralı donanım görünümü yeni Şekil 6.3 olarak korundu; 1--14 işaretleri yeni Tablo 6.1 ile doğrudan ilişkilidir.",
    ("Şekil", "5.4"): "Birinci faz-donanım görünümü yeni Şekil 6.4 olarak korundu; 1--8 işaretleri yeni Tablo 6.2 ile ilişkilidir.",
    ("Şekil", "5.5"): "İkinci faz-donanım görünümü yeni Şekil 6.5 olarak korundu; 1--8 işaretleri yeni Tablo 6.2 ile ilişkilidir.",
    ("Şekil", "5.6"): "Giriş devresi görünümü yeni Şekil 6.6 olarak korundu; 1--6 işaretleri yeni Tablo 6.3 ile ilişkilidir.",
    ("Tablo", "4.1"): "Eski Tablo 4.1 ve 4.2 yeni Tablo 5.1'de birleştirildi.",
    ("Tablo", "4.2"): "Eski Tablo 4.1 ve 4.2 yeni Tablo 5.1'de birleştirildi.",
    **{("Tablo", f"5.{n}"): f"İçerik ve satır eşleşmeleri korunarak ayrı yeni Tablo 6.{n} olarak aktarıldı." for n in range(1, 4)},
    ("Tablo", "5.4"): "Yeni Tablo 6.4'te kaynak Word tablosunun dolu deney hücreleri ve boş simülasyon hücreleri aynen korundu.",
}


TITLE_OVERRIDES = {
    ("Şekil", "4.12"): "Önerilen nötr anahtar susturma stratejisinde L1 endüktans akımının tam-periyot dalga biçimi (eski başlıktaki büyütülmüş kesit ifadesi eksen ölçeğine göre düzeltildi)",
    ("Şekil", "4.14"): "Önerilen nötr anahtar susturma stratejisinde filtre giriş gerilimi, filtrelenmiş gerilim, L1 endüktans akımı ve LC filtre çıkış akımı",
    ("Şekil", "4.25"): "dmax=0,1--0,8 değerleri için L1 akımının pozitif alternans dalga şekli",
    ("Şekil", "4.26"): "Klasik sinüzoidal ve Sin³ bileşenli görev oranı tanımlarının karşılaştırılması",
    ("Şekil", "4.27"): "d(wt)=Vm sin(wt) için farklı dmax değerlerinde harmonik bileşenler",
    ("Şekil", "4.28"): "d(wt)=V1m sin(wt)+V3m sin³(wt) için katsayı taraması ve harmonik bileşenler",
    ("Şekil", "4.29"): "Sin³ kompanzasyonlu nötr anahtar susturma benzetiminden büyütülmüş endüktör akımı",
    ("Şekil", "5.12"): "(a) Evirici üzerindeki AcuDC240 DA bara analizörü, (b) DA bara bağlantısı",
    ("Şekil", "5.17"): "Osiloskop kaydı: kontrol işareti, şebeke gerilimi ve endüktans akımı kanalları",
    ("Tablo", "4.4"): "Simülasyon sonucunda elde edilen verim ve THD değerlerinin üç yaklaşımla karşılaştırılması",
}


def decision(kind: str, number: str) -> dict[str, str]:
    ch, seq = (int(x) for x in number.split("."))

    if kind == "Şekil" and ch == 1:
        if seq == 1:
            return d("Bölüm 2", "Aktarıldı", "fig:eds-mimarisi", "Sarı etiketli vektörel karşılığı kullanılıyor.")
        if seq in (2, 3):
            return d("Bölüm 2", "Birleştirildi", "fig:batarya-omur-guvenlik", "Eski iki şekil tek bileşik şekilde; temsilî veri sınırı korunacak.")
        if seq == 4:
            return d("Ana metinden çıkarıldı", "Çıkarıldı", "Tablo 1.1 ile temsil ediliyor", "Maliyet bilgisini tekrarladığı için ayrı grafik kullanılmayacak.")
        if seq == 5:
            return d("Bölüm 2", "Aktarıldı", "fig:bys-mimarisi", "BYS işlevleriyle birlikte metin içinde açıklanıyor.")
        if 6 <= seq <= 9:
            return d("Bölüm 2", "Birleştirildi", "fig:dengeleme-yontemleri", "Dört eski şekil tek karşılaştırmalı vektör şekilde toplandı.")
        if seq == 10:
            return d("Bölüm 2 (koşullu)", "Koşullu", "Henüz kullanılmıyor", "Yaşlanma denklemi bulunursa MATLAB'da üret; bulunamazsa tezden çıkar.")

    if kind == "Tablo" and ch == 1:
        mapping = {
            1: ("tab:eds-maliyet-dagilimi", "Dış kaynak aralıklarıyla birlikte aktarıldı."),
            2: ("tab:dengeleme-karsilastirma", "Başlıklar bilimsel olarak izlenebilir biçimde düzeltildi."),
            3: ("tab:bys-islev-karsilastirma", "Doğrudan ömür optimizasyonu iddiası sınırlandırıldı."),
        }
        label, action = mapping[seq]
        return d("Bölüm 2", "Aktarıldı", label, action)

    if kind == "Şekil" and ch == 2:
        if seq in (1, 2, 4, 5):
            return d("Bölüm 2", "Birleştirildi", "fig:fv-calisma-profilleri", "Temsilî profil olarak MATLAB'da yeniden üretildi; PVGIS metadatası gelirse güncellenecek.")
        if seq == 3:
            return d("Bölüm 2", "Geçici", "fig:fv-yil-saat-yuzeyi", "Eski raster sarı etiketle duruyor; ham diziler bulunursa MATLAB'da vektörel üret.")
        if seq in (6, 7, 9, 10):
            return d("Bölüm 2", "Birleştirildi", "fig:fv-verim-thd-profilleri", "Verim ve THD profilleri tek bileşik MATLAB şeklinde toplandı.")
        if seq == 8:
            return d("Bölüm 2", "Aktarıldı", "fig:chicco-guc-thd", "Birincil dış kaynaklı, kırmızı etiketli karşılaştırma olarak kullanılıyor.")

    if kind == "Tablo" and ch == 2:
        if seq == 1:
            return d("Bölüm 2", "Yeniden hesaplandı", "tab:fv-guc-dagilimi", "Eski yüzdeler yerine 144 temsilî nokta yeniden gruplanarak hesaplandı.")
        if seq in (2, 3):
            return d("Bölüm 2", "Birleştirildi", "tab:agirlikli-verim-katsayilari", "Avrupa ve CEC katsayıları tek tabloda ve denklemlerle verildi.")
        if seq == 4:
            return d("Bölüm 2", "Geçici", "tab:ticari-evirici-thd", "Sayılar korundu; cihaz, analizör, zaman ve ham ölçüm dosyası doğrulanacak.")

    if kind == "Şekil" and ch == 3:
        if seq == 1:
            return d("Bölüm 2", "Aktarıldı", "fig:t-tipi-faz-kolu", "Kuramsal topoloji olarak Bölüm 2'de; Bölüm 3'ten çapraz başvuru var.")
        if 2 <= seq <= 4:
            return d("Bölüm 3", "Birleştirildi", "fig:t-tipi-uc-seviye", "P-O-N durumları ortak devre tabanında vektörel yeniden çizildi.")
        if 5 <= seq <= 8:
            return d("Bölüm 3", "Birleştirildi", "fig:t-tipi-akim-yollari", "Dört yol, tam güç topolojisi ve ortak renk lejandıyla Şekil 3.3'te toplandı.")
        if seq in (9, 10):
            return d("Bölüm 3", "Birleştirildi", "fig:senkron-buck-esdeger", "Pozitif ve negatif yarım periyotlar tek vektörel şekilde toplandı.")
        if seq in (11, 12):
            return d("Bölüm 2", "Geçici", "fig:onceki-tez-ccm-ters-akim / fig:onceki-tez-dcm-akim", "Sarı etiketli açıklama şeması; gerçek model çıkınca ana metin/ek/çıkarma kararı verilecek.")
        if seq == 13:
            return d("Bölüm 5", "MATLAB'da yeniden üretilecek", "Bölüm 3'te fig:denetim-modulasyon-blok kavramsal karşılığı var", "Üçüncü harmonik oluşum mekanizmasını gerçek modelden zaman alanı ve FFT ile göster.")
        if seq == 14:
            return d("Bölüm 5", "MATLAB'da yeniden üretilecek", "Bölüm 3'te fig:denetim-modulasyon-blok kavramsal karşılığı var", "Aynı koşuda referans akım, ölçülen akım ve kontrolör çıkışını karşılaştır.")
        if seq == 15:
            return d("Bölüm 4", "Vektörel çizilecek", "Anahtarlama yöntemi akışı", "Teorik anahtarlama sırasını durum/koşul/kapı komutu akışı olarak yeniden çiz.")
        if seq == 16:
            return d("Bölüm 4 + Bölüm 5", "MATLAB'da yeniden üretilecek", "Mantık: Bölüm 4; dalga biçimleri: Bölüm 5", "Gerçek kapı komutları, kontrolör çıkışı ve akımı aynı zaman ekseninde ver.")

    if kind == "Şekil" and ch == 4:
        if 1 <= seq <= 4:
            counterparts = {
                1: "fig:klasik-kapi-darbeleri-tam",
                2: "fig:klasik-kapi-darbeleri-yakin",
                3: "fig:onceki-faz-modeli",
                4: "fig:onceki-simulasyon-modeli",
            }
            action = "Eski görsel ayrı ve sarı etiketli tarihsel kanıt olarak aktarıldı; birleşik eşleme kaldırıldı."
            if seq in (3, 4):
                action += " Kesin .slx modeli geldiğinde okunur vektör/model çıktısıyla değiştirilecek."
            return d("Bölüm 4", "Aktarıldı", counterparts[seq], action)
        if 5 <= seq <= 9:
            counterparts = {
                5: "fig:klasik-l1-tam",
                6: "fig:klasik-l1-yakin",
                7: "fig:klasik-dort-kanal",
                8: "fig:klasik-l1-fft",
                9: "fig:klasik-iout-fft",
            }
            return d("Bölüm 4", "Aktarıldı", counterparts[seq], "Sonradan gelen Senaryo 1 kaynak ekranlarıyla dalga biçimi ve FFT değerleri doğrulandı; ham zaman serisi bulunmadığı için ikincil kanıt statüsü korunuyor.")
        if 10 <= seq <= 16:
            counterparts = {
                10: "fig:susturma-kapi-darbeleri-tam",
                11: "fig:susturma-kapi-darbeleri-yakin",
                12: "fig:susturma-l1-tam",
                13: "fig:susturma-l1-yakin",
                14: "fig:susturma-dort-kanal",
                15: "fig:susturma-l1-fft",
                16: "fig:susturma-iout-fft",
            }
            return d("Bölüm 4", "Aktarıldı", counterparts[seq], "Eski görsel ayrı ve sarı etiketli tarihsel kanıt olarak aktarıldı; ham model/zaman serisi gelirse ortak pencere ve parametrelerle yeniden üretilecek.")
        if seq == 17:
            return d("Bölüm 3", "Yeniden çizildi", "fig:denetim-modulasyon-blok", "Eski genel blok diyagramı ayrı kullanılmayacak; yeni işlevsel blok diyagramı yeterli.")
        if 18 <= seq <= 22:
            counterparts = {
                18: "fig:eski-feedforward-etkisi",
                19: "fig:eski-espotansiyel-dalga",
                20: "fig:eski-tam-guc-feedforward",
                21: "fig:eski-dusuk-guc-feedforward",
                22: "fig:eski-dogrusal-olmayan-sistem",
            }
            return d("Bölüm 5", "Aktarıldı — tarihsel", counterparts[seq], "Eski görsel ayrı ve sarı etiketli olarak korundu; metin içi işlevi açıklandı. Sayısal değerler gerçek kapalı çevrim modelinde yeniden doğrulanacak.")
        if seq == 23:
            return d("Bölüm 3", "Yeniden çizildi", "fig:denetim-modulasyon-blok", "Önerilen kontrol yapısı yeni işlevsel blok diyagramına aktarıldı; kodla son doğrulama bekliyor.")
        if seq == 24:
            return d("Bölüm 3 + Bölüm 5", "Yeniden çizildi", "fig:senkron-buck-esdeger", "İki buck eşdeğeri Bölüm 3'te vektörel verildi; Bölüm 5 denklemlerinde doğrudan kullanıldı.")
        if 25 <= seq <= 28:
            counterparts = {
                25: "fig:eski-dcm-dmax-taramasi",
                26: "fig:eski-dcm-ccm-adaylari",
                27: "fig:eski-dcm-harmonik-dagilim",
                28: "fig:eski-katsayi-yuzeyi",
            }
            return d("Bölüm 5", "Aktarıldı — tarihsel", counterparts[seq], "Sarı etiketle ve kanıt sınırıyla korundu; gerçek kod/model gelince aynı tanımla yeniden üretilecek.")
        if 29 <= seq <= 32:
            counterparts = {
                29: "fig:sin3-l1-yakin",
                30: "fig:sin3-dort-kanal",
                31: "fig:sin3-l1-fft",
                32: "fig:sin3-iout-fft",
            }
            return d("Bölüm 5", "Aktarıldı", counterparts[seq], "Senaryo 3 kaynak ekranıyla ayrı şekil olarak korundu; ham zaman serisiyle yeniden hesaplama bekliyor.")

    if kind == "Tablo" and ch == 4:
        if seq in (1, 2):
            return d("Bölüm 5", "Birleştirildi — tarihsel", "tab:eski-dcm-harmonik-katsayilari", "Eski genlik ve oran tabloları yeni Tablo 5.1'de birleştirildi; gerçek modelle yeniden hesaplanacak.")
        if seq == 3:
            return d("Bölüm 5", "Metinde özetlendi", "Şekil 5.4 ile birlikte optimum çelişkisi açıklandı", "24 aday çift tarihsel tarama olarak korundu; nihai katsayı gerçek betikle seçilecek.")
        if seq == 4:
            return d("Bölüm 4", "Geçici", "tab:onceki-benzetim-ozeti", "Eski sonuçlar korunuyor; verim hesabı ve THD ham model çıktısıyla doğrulanacak.")

    if kind == "Şekil" and ch == 5:
        if 1 <= seq <= 15:
            return d("Bölüm 6", "Ayrı olarak aktarıldı", f"Yeni Şekil 6.{seq}", PDF_NOTES.get((kind, number), "Kaynak görsel ayrı şekil olarak korundu; metin içi açıklaması eklendi."))
        if seq == 16:
            return d("Bölüm 6", "Ayrı olarak aktarıldı — doğrulama bekliyor", "Yeni Şekil 6.16", "Kaynak PC izleme grafiği korundu; deney koşulu ve ham dosya eşleşmesi sonradan doğrulanacak.")
        if seq in (17, 18):
            return d("Bölüm 6", "Ayrı olarak aktarıldı — doğrulama bekliyor", f"Yeni Şekil 6.{seq}", "Deney seti 1 görseli ayrı tutuldu; çalışma noktası ve ham kayıt eşleşmesi doğrulanacak.")
        if seq in (19, 20, 21):
            return d("Bölüm 6", "Ayrı olarak aktarıldı — doğrulama bekliyor", f"Yeni Şekil 6.{seq}", "Deney seti 2 görseli ayrı tutuldu; tarih, çalışma noktası ve ham kayıt eşleşmesi doğrulanacak.")
        if seq in (22, 23, 24):
            return d("Bölüm 6", "Ayrı olarak aktarıldı — doğrulama bekliyor", f"Yeni Şekil 6.{seq}", "Deney seti 3 görseli ayrı tutuldu; tarih, çalışma noktası ve ham kayıt eşleşmesi doğrulanacak.")

    if kind == "Tablo" and ch == 5:
        if 1 <= seq <= 3:
            return d("Bölüm 6", "Aynen ve ayrı olarak aktarıldı", f"Yeni Tablo 6.{seq}", PDF_NOTES[(kind, number)])
        if seq == 4:
            return d("Bölüm 6", "Aynen aktarıldı — doğrulama bekliyor", "Yeni Tablo 6.4", PDF_NOTES[(kind, number)] + " Gerçek ham veriler geldiğinde aynı çalışma noktalarında yeniden doğrulanacak.")

    if kind == "Şekil" and ch == 6:
        if seq == 1:
            return d("Bölüm 7", "Çapraz başvuru", "fig:t-tipi-uc-seviye", "Aynı T-tipi devre yeniden basılmadı; Bölüm 3'teki tam topolojiye atıf verildi.")
        if 2 <= seq <= 7:
            counterparts = {
                2: "fig:gt-eski-viyana-pfc",
                3: "fig:gt-eski-cok-sekonderli-bys",
                4: "fig:gt-eski-ana-topoloji",
                5: "fig:gt-eski-evirici-lcl",
                6: "fig:gt-eski-iki-seviye-trafo",
                7: "fig:gt-eski-pfc",
            }
            return d("Bölüm 7", "Aktarıldı — tarihsel", counterparts[seq], "Eski devre/topoloji görseli ayrı sarı şekil olarak korundu ve metin içi işlevi açıklandı; ham donanım/model gelirse vektörel olarak yeniden doğrulanacak.")
        if 8 <= seq <= 15:
            counterparts = {
                8: "fig:gt-eski-simulink-modeli",
                9: "fig:gt-eski-pfc-akimlari",
                10: "fig:gt-eski-da-bara",
                11: "fig:gt-eski-primer-gerilim",
                12: "fig:gt-eski-primer-akim",
                13: "fig:gt-eski-sekonder-gerilim",
                14: "fig:gt-eski-sekonder-akim",
                15: "fig:gt-eski-batarya-soc",
            }
            return d("Bölüm 7", "Aktarıldı — tarihsel", counterparts[seq], "Eski Simulink ekranı veya grafik ayrı sarı şekil olarak korundu; nihai iddia için ham model ve zaman serisiyle aynı kanallar yeniden üretilecek.")

    if kind == "Tablo" and ch == 7 and seq == 1:
        return d("Ek B (koşullu)", "Koşullu", "Fikri mülkiyet/çıktı listesi", "Yalnızca başvuru/yayın numaraları resmî belgelerle doğrulanırsa ekle; bilimsel sonuç tablosu gibi kullanma.")

    return d("Karar gerekli", "Kontrol edilecek", "-", "Kaynak belge ve yeni bölüm kapsamıyla elle denetle.")


def d(target: str, status: str, counterpart: str, action: str) -> dict[str, str]:
    return {"target": target, "status": status, "counterpart": counterpart, "action": action}


def load_pdf_labels() -> tuple[dict[str, tuple[str, str]], Path]:
    available = [path for path in AUX_CANDIDATES if path.exists()]
    if not available:
        raise FileNotFoundError("Yeni PDF numaralarını içeren main.aux bulunamadı")
    aux_path = max(available, key=lambda path: path.stat().st_mtime)
    labels: dict[str, tuple[str, str]] = {}
    pattern = re.compile(r"\\newlabel\{([^}]+)\}\{\{([^}]+)\}\{([^}]+)\}")
    for match in pattern.finditer(aux_path.read_text(encoding="utf-8", errors="replace")):
        label, number, page = match.groups()
        if label.startswith(("fig:", "tab:")):
            labels[label] = (number, page)
    return labels, aux_path


def add_pdf_reference(row: dict[str, str], labels: dict[str, tuple[str, str]]) -> None:
    key = (row["kind"], row["number"])
    label_names = LABEL_OVERRIDES.get(key)
    if label_names is None:
        label_names = re.findall(r"\b(?:fig|tab):[A-Za-z0-9:-]+", row["counterpart"])

    resolved = [(label, *labels[label]) for label in label_names if label in labels]
    if not resolved:
        row["new_pdf_number"] = "—"
        row["new_pdf_page"] = ""
        row["new_pdf_note"] = PDF_NOTES.get(key, "PDF'de henüz numaralı karşılık yok.")
        return

    number_parts = []
    page_parts = []
    for label, number, page in resolved:
        prefix = "Şekil" if label.startswith("fig:") else "Tablo"
        rendered = f"{prefix} {number}"
        if rendered not in number_parts:
            number_parts.append(rendered)
        if page not in page_parts:
            page_parts.append(page)
    row["new_pdf_number"] = " / ".join(number_parts)
    row["new_pdf_page"] = ", ".join(page_parts)
    row["new_pdf_note"] = PDF_NOTES.get(key, "Etiket kaydından doğrulandı.")


def load_rows() -> list[dict[str, str]]:
    pdf_labels, aux_path = load_pdf_labels()
    payload = json.loads(RAW.read_text(encoding="utf-8"))
    first: dict[tuple[str, str], dict] = {}
    for item in payload["captions"]:
        key = (item["kind"], item["number"])
        first.setdefault(key, item)

    rows = []
    for (kind, number), item in first.items():
        title = TITLE_OVERRIDES.get((kind, number), item["title"])
        info = decision(kind, number)
        ch, seq = (int(x) for x in number.split("."))
        rows.append(
            {
                "kind": kind,
                "number": number,
                "old_chapter": str(ch),
                "title": title,
                **info,
                "sort_ch": ch,
                "sort_kind": 0 if kind == "Şekil" else 1,
                "sort_seq": seq,
            }
        )
        add_pdf_reference(rows[-1], pdf_labels)
    rows.sort(key=lambda x: (x["sort_ch"], x["sort_kind"], x["sort_seq"]))
    load_rows.aux_path = aux_path
    return rows


def write_csv(rows: list[dict[str, str]]) -> None:
    path = OUT_BASE.with_suffix(".csv")
    fields = ["kind", "number", "new_pdf_number", "new_pdf_page", "new_pdf_note", "old_chapter", "title", "target", "status", "counterpart", "action"]
    with path.open("w", encoding="utf-8-sig", newline="") as handle:
        writer = csv.DictWriter(handle, fieldnames=fields, extrasaction="ignore")
        writer.writeheader()
        writer.writerows(rows)


def write_markdown(rows: list[dict[str, str]]) -> None:
    figures = sum(r["kind"] == "Şekil" for r in rows)
    tables = sum(r["kind"] == "Tablo" for r in rows)
    numbered = sum(r["new_pdf_number"] != "—" for r in rows)
    lines = [
        "# Önceki tez şekil ve tablo takip listesi",
        "",
        f"Kaynak: `dosyalar/01_TAM_TEZ/tez_tumu_8.docx`  ",
        f"Envanter: **{figures} şekil + {tables} tablo = {len(rows)} öğe**.",
        "",
        "> Eski no sütunu önceki tezi; yeni PDF no sütunu güncel LaTeX derlemesindeki gerçek şekil/tablo numarasını gösterir. `—`, öğenin güncel PDF'de henüz numaralı bir karşılığı olmadığını belirtir.",
        "",
    ]
    for ch in sorted({int(r["old_chapter"]) for r in rows}):
        lines += [f"## Eski Bölüm {ch}", "", "| Tür | Eski no | Yeni PDF no | Eski başlık | Yeni hedef | Durum | Yeni karşılık | Yapılacak / kabul ölçütü |", "|---|---:|---|---|---|---|---|---|"]
        for r in (x for x in rows if int(x["old_chapter"]) == ch):
            pdf_no = r["new_pdf_number"] + (f" (s. {r['new_pdf_page']})" if r["new_pdf_page"] else "")
            vals = [str(v).replace("|", "\\|").replace("\n", " ") for v in (r["kind"], r["number"], pdf_no, r["title"], r["target"], r["status"], r["counterpart"], r["action"])]
            lines.append("| " + " | ".join(vals) + " |")
        lines.append("")
    OUT_BASE.with_suffix(".md").write_text("\n".join(lines), encoding="utf-8")


def write_html(rows: list[dict[str, str]]) -> None:
    data = json.dumps([{k: v for k, v in r.items() if not k.startswith("sort_")} for r in rows], ensure_ascii=False)
    counts = Counter(r["status"] for r in rows)
    figures = sum(r["kind"] == "Şekil" for r in rows)
    tables = sum(r["kind"] == "Tablo" for r in rows)
    numbered = sum(r["new_pdf_number"] != "—" for r in rows)
    status_cards = "".join(f'<div class="mini"><strong>{html.escape(k)}</strong><span>{v}</span></div>' for k, v in counts.most_common())
    doc = f"""<!doctype html>
<html lang="tr">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Önceki Tez Şekil ve Tablo Takip Listesi</title>
  <style>
    :root {{--ink:#18212b;--muted:#647182;--line:#dce3ea;--paper:#fff;--bg:#f3f6f8;--navy:#173f5f;--blue:#e8f2fa;--green:#e8f7ed;--amber:#fff4d8;--red:#fdeaea;--purple:#f2ecfb}}
    * {{box-sizing:border-box}} body {{margin:0;background:var(--bg);color:var(--ink);font:14px/1.45 "Segoe UI",Arial,sans-serif}}
    header {{background:linear-gradient(135deg,#123650,#276d83);color:#fff;padding:28px clamp(18px,4vw,54px)}}
    h1 {{margin:0 0 8px;font-size:clamp(24px,3vw,38px);line-height:1.15}} header p {{margin:4px 0;max-width:1100px;color:#dcebf3}}
    main {{max-width:1500px;margin:auto;padding:20px}} .callout {{background:#fff;border-left:5px solid #e7b33c;padding:15px 18px;margin-bottom:16px;box-shadow:0 2px 10px #173f5f14}}
    .cards {{display:grid;grid-template-columns:repeat(auto-fit,minmax(145px,1fr));gap:10px;margin:14px 0}} .card,.mini {{background:#fff;border:1px solid var(--line);border-radius:10px;padding:13px}}
    .card strong {{display:block;font-size:25px;color:var(--navy)}} .card span,.mini span {{display:block;color:var(--muted)}} .mini strong {{font-size:12px}}
    .toolbar {{position:sticky;top:0;z-index:5;background:#f3f6f8f2;backdrop-filter:blur(8px);display:grid;grid-template-columns:2fr repeat(3,minmax(145px,1fr)) auto auto;gap:8px;padding:10px 0}}
    input,select,button {{font:inherit;border:1px solid #b9c6d1;border-radius:7px;padding:9px 10px;background:#fff}} button {{cursor:pointer;background:var(--navy);color:#fff;border-color:var(--navy)}} button.secondary {{background:#fff;color:var(--navy)}}
    .table-wrap {{overflow:auto;background:#fff;border:1px solid var(--line);border-radius:10px;box-shadow:0 2px 12px #173f5f0d}} table {{border-collapse:collapse;width:100%;min-width:1640px}} th {{position:sticky;top:61px;z-index:4;background:#eaf0f4;color:#173f5f;text-align:left;font-size:12px;letter-spacing:.02em}} th,td {{padding:10px 9px;border-bottom:1px solid var(--line);vertical-align:top}} tr:hover td {{background:#f8fbfd}}
    td:nth-child(1),td:nth-child(2),td:nth-child(3) {{white-space:nowrap}} th:nth-child(3),td:nth-child(3) {{width:150px;min-width:150px}} th:nth-child(4),td:nth-child(4) {{width:340px;min-width:340px}} .old-title {{display:-webkit-box;-webkit-box-orient:vertical;-webkit-line-clamp:2;overflow:hidden;line-height:1.4;min-height:2.8em}} .new-no {{font-weight:800;color:#11616e}} .new-page,.new-note {{display:block;color:var(--muted);font-size:11px;white-space:normal}} .badge {{display:inline-block;border-radius:999px;padding:3px 8px;font-weight:700;font-size:11px;background:var(--blue)}}
    tr[data-status*="Aktarıldı"] .badge,tr[data-status*="Yeniden hesaplandı"] .badge,tr[data-status*="Yeniden çizildi"] .badge {{background:var(--green);color:#196437}}
    tr[data-status*="Birleş"] .badge {{background:#e7f4ff;color:#145579}} tr[data-status*="MATLAB"] .badge,tr[data-status*="Simulink"] .badge,tr[data-status*="Vektörel"] .badge {{background:var(--purple);color:#5a3686}}
    tr[data-status*="Geçici"] .badge,tr[data-status*="bekliyor"] .badge,tr[data-status*="Koşullu"] .badge {{background:var(--amber);color:#795a0b}} tr[data-status*="Çıkar"] .badge {{background:var(--red);color:#8a2525}}
    .note {{width:210px;min-height:36px}} .checked td {{opacity:.53}} .checked td:nth-child(2),.checked td:nth-child(4) {{text-decoration:line-through}} .hidden {{display:none}}
    footer {{color:var(--muted);padding:18px 2px}} @media(max-width:1000px) {{.toolbar {{position:static;grid-template-columns:1fr 1fr}} th {{top:0}}}}
    @media print {{header {{padding:15px;background:#fff;color:#000}} header p {{color:#333}} .toolbar,.note,button {{display:none!important}} main {{max-width:none;padding:0}} .table-wrap {{overflow:visible;box-shadow:none}} table {{min-width:0;font-size:8pt}} th {{position:static}} th:nth-child(3),td:nth-child(3),th:nth-child(4),td:nth-child(4) {{width:auto;min-width:0}} .old-title {{display:block;overflow:visible;-webkit-line-clamp:unset;min-height:0}}}}
  </style>
</head>
<body>
<header><h1>Önceki Tez Şekil ve Tablo Takip Listesi</h1><p>Kaynak: dosyalar/01_TAM_TEZ/tez_tumu_8.docx • Güncelleme: 14 Temmuz 2026</p><p>Eski numaranın yanında güncel LaTeX derlemesindeki yeni PDF numarası verilir. Numaralandırma kaynağı: <a href="../main.pdf" style="color:#fff">güncel tez PDF'si</a>.</p></header>
<main>
  <section class="callout"><strong>Şekil 3.13 ve 3.14 kararı:</strong> Her ikisi de Bölüm 5'te gerçek MATLAB/Simulink modelinden yeniden üretilecek. Eski rasterlar nihai kanıt olmayacak. Şekil 3.15 Bölüm 4'e; Şekil 3.16'nın mantığı Bölüm 4'e, dalga biçimleri Bölüm 5'e gidecek.</section>
  <section class="cards"><div class="card"><strong>{len(rows)}</strong><span>toplam öğe</span></div><div class="card"><strong>{figures}</strong><span>şekil</span></div><div class="card"><strong>{tables}</strong><span>tablo</span></div><div class="card"><strong>{numbered}</strong><span>PDF numarası eşleşen</span></div>{status_cards}</section>
  <section class="toolbar">
    <input id="q" type="search" placeholder="Numara, başlık, hedef veya eylem ara…">
    <select id="chapter"><option value="">Tüm eski bölümler</option></select>
    <select id="target"><option value="">Tüm yeni hedefler</option></select>
    <select id="status"><option value="">Tüm durumlar</option></select>
    <button id="export">CSV indir</button><button id="reset" class="secondary">Kontrolleri sıfırla</button>
  </section>
  <div class="table-wrap"><table><thead><tr><th>✓</th><th>Tür / eski no</th><th>Yeni PDF no</th><th>Eski başlık</th><th>Yeni hedef</th><th>Durum</th><th>Yeni karşılık</th><th>Yapılacak / kabul ölçütü</th><th>Notum</th></tr></thead><tbody id="rows"></tbody></table></div>
  <footer>Onay kutuları ve notlar yalnızca bu tarayıcıda saklanır. “—”, öğenin güncel PDF'de henüz numaralı bir şekil veya tablo karşılığı bulunmadığını gösterir.</footer>
</main>
<script>
const data={data};
const store=JSON.parse(localStorage.getItem('tez-transfer-tracker')||'{{}}');
const esc=s=>String(s).replace(/[&<>"']/g,c=>({{'&':'&amp;','<':'&lt;','>':'&gt;','"':'&quot;',"'":'&#39;'}}[c]));
const key=r=>r.kind+'-'+r.number;
function optionize(id,values,label){{const s=document.getElementById(id);[...new Set(values)].sort((a,b)=>a.localeCompare(b,'tr',{{numeric:true}})).forEach(v=>s.insertAdjacentHTML('beforeend',`<option>${{esc(v)}}</option>`));}}
optionize('chapter',data.map(x=>x.old_chapter));optionize('target',data.map(x=>x.target));optionize('status',data.map(x=>x.status));
function render(){{const q=document.getElementById('q').value.toLocaleLowerCase('tr');const ch=document.getElementById('chapter').value,t=document.getElementById('target').value,st=document.getElementById('status').value;document.getElementById('rows').innerHTML=data.map(r=>{{const k=key(r),saved=store[k]||{{}};const hay=Object.values(r).join(' ').toLocaleLowerCase('tr');const hide=(q&&!hay.includes(q))||(ch&&r.old_chapter!==ch)||(t&&r.target!==t)||(st&&r.status!==st);return `<tr class="${{hide?'hidden ':''}}${{saved.checked?'checked':''}}" data-key="${{k}}" data-status="${{esc(r.status)}}"><td><input class="done" type="checkbox" ${{saved.checked?'checked':''}}></td><td><strong>${{esc(r.kind)}} ${{esc(r.number)}}</strong></td><td><span class="new-no">${{esc(r.new_pdf_number)}}</span>${{r.new_pdf_page?`<span class="new-page">PDF s. ${{esc(r.new_pdf_page)}}</span>`:''}}<span class="new-note">${{esc(r.new_pdf_note)}}</span></td><td><div class="old-title" title="${{esc(r.title)}}">${{esc(r.title)}}</div></td><td>${{esc(r.target)}}</td><td><span class="badge">${{esc(r.status)}}</span></td><td>${{esc(r.counterpart)}}</td><td>${{esc(r.action)}}</td><td><input class="note" value="${{esc(saved.note||'')}}" placeholder="Kendi notun…"></td></tr>`}}).join('');bind();}}
function save(){{localStorage.setItem('tez-transfer-tracker',JSON.stringify(store));}}
function bind(){{document.querySelectorAll('#rows tr').forEach(tr=>{{const k=tr.dataset.key;tr.querySelector('.done').onchange=e=>{{store[k]=store[k]||{{}};store[k].checked=e.target.checked;save();render();}};tr.querySelector('.note').oninput=e=>{{store[k]=store[k]||{{}};store[k].note=e.target.value;save();}};}})}}
['q','chapter','target','status'].forEach(id=>document.getElementById(id).addEventListener(id==='q'?'input':'change',render));
document.getElementById('reset').onclick=()=>{{if(confirm('Tüm işaret ve kişisel notlar silinsin mi?')){{localStorage.removeItem('tez-transfer-tracker');location.reload();}}}};
document.getElementById('export').onclick=()=>{{const cols=['kind','number','new_pdf_number','new_pdf_page','new_pdf_note','old_chapter','title','target','status','counterpart','action'];const csv=[cols.join(';'),...data.map(r=>cols.map(c=>'"'+String(r[c]).replaceAll('"','""')+'"').join(';'))].join('\\n');const a=document.createElement('a');a.href=URL.createObjectURL(new Blob(['\\ufeff'+csv],{{type:'text/csv'}}));a.download='onceki_tez_sekil_tablo_takip.csv';a.click();URL.revokeObjectURL(a.href);}};
render();
</script>
</body></html>"""
    OUT_BASE.with_suffix(".html").write_text(doc, encoding="utf-8")


def main() -> None:
    rows = load_rows()
    if len(rows) != 123:
        raise RuntimeError(f"Beklenen 123 öğe yerine {len(rows)} öğe bulundu")
    if sum(r["kind"] == "Şekil" for r in rows) != 107:
        raise RuntimeError("Şekil sayısı 107 değil")
    if sum(r["kind"] == "Tablo" for r in rows) != 16:
        raise RuntimeError("Tablo sayısı 16 değil")
    write_csv(rows)
    write_markdown(rows)
    write_html(rows)
    print(f"OK: {len(rows)} öğe -> {OUT_BASE}")


if __name__ == "__main__":
    main()
