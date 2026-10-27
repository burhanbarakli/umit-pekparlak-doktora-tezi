from __future__ import annotations

import html
import json
import re
from collections import Counter
from pathlib import Path
from urllib.parse import quote

from docx import Document


ROOT = Path(__file__).resolve().parents[3]
OLD_THESIS = ROOT / "dosyalar" / "01_TAM_TEZ" / "tez_tumu_8.docx"
NEW_TOC = ROOT / "tez-latex" / "main.toc"
OUTPUT = ROOT / "ANA_SAYFA_TEZ_CALISMA_MERKEZI.html"


TARGETS = {
    "1": "2. LİTERATÜR, KURAMSAL TEMEL VE ARAŞTIRMA BOŞLUĞU",
    "1.1": "2.1 Enerji Depolama Sistemlerinde Güç Dönüşüm Mimarileri",
    "1.2": "2.1 Enerji Depolama Sistemlerinde Güç Dönüşüm Mimarileri",
    "1.2.1": "2.1 altında batarya ömrü bağlamı",
    "1.2.2": "2.1 altında güvenli işletim özeti",
    "1.2.3": "2.1 altında güvenli işletim özeti",
    "1.2.4": "2.1 altında güvenli çalışma bölgesi",
    "1.2.5": "2.1 altında maliyet ve ömür gerekçesi",
    "1.3": "2.1 Enerji Depolama Sistemlerinde Güç Dönüşüm Mimarileri ve 2.6 Araştırma Boşluğu",
    "1.3.1": "2.1 altında hücre dengesizliği nedenleri",
    "1.3.2": "2.1 altında hücre dengesizliği sonuçları",
    "1.3.3": "2.1 altında güvenlik etkileri",
    "1.4": "2.1 altında BYS görevleri",
    "1.4.1": "2.1 altında BYS görevleri",
    "1.4.2": "2.1 altında SoC tanımı",
    "1.4.3": "2.1 altında SoH tanımı",
    "1.4.4": "2.1 altında koruma işlevleri",
    "1.4.5": "2.1 altında dengeleme işlevleri",
    "1.5": "2.1 altında dengeleme yöntemleri",
    "1.5.1": "2.1 altında dengeleme karşılaştırması",
    "1.5.2": "2.1 altında dengeleme karşılaştırması",
    "1.5.3": "2.1 altında dengeleme karşılaştırması",
    "1.5.4": "2.1 altında dengeleme karşılaştırması",
    "1.5.5": "2.1 altında dengeleme karşılaştırması",
    "1.6": "2.6 Araştırma Boşluğu ve 7.1 Tasarım Gereksinimleri",
    "1.6.1": "7.1 Tasarım Gereksinimleri",
    "1.6.2": "7.5 Klasik Mimari ile Karşılaştırma",
    "1.6.3": "7.5; yalnızca doğrulanabilir ömür modeli varsa",
    "1.7": "2.6 Araştırma Boşluğu",
    "1.8": "2.1 Enerji Depolama Sistemlerinde Güç Dönüşüm Mimarileri ve 2.6 Araştırma Boşluğu içinde kısa değerlendirme",
    "2": "2.3 Fotovoltaik Çalışma Profili, Kısmi Yükte Verim ve Harmonik Bozulma merkezli literatür akışı",
    "2.1": "Bölüm 2 açılış metni; ayrı başlık yok",
    "2.2": "2.3 Fotovoltaik Çalışma Profili, Kısmi Yükte Verim ve Harmonik Bozulma",
    "2.3": "2.3 Fotovoltaik Çalışma Profili, Kısmi Yükte Verim ve Harmonik Bozulma",
    "2.4": "2.3 altında ağırlıklı verim",
    "2.4.1": "2.3 altında Avrupa verimliliği denklemi",
    "2.5": "2.3 altında düşük güç verim problemi",
    "2.5.1": "2.3 altında yıllık enerji etkisi; temsili veri sınırıyla",
    "2.6": "2.3 altında harmonik bozulma",
    "2.6.1": "2.3 altında güç–THD ilişkisi",
    "2.6.2": "2.3 altında harmonik artış nedenleri",
    "2.6.3": "2.3 ve 4.5 Verim–harmonik ödünleşimi",
    "2.7": "2.3 ve 2.4 Akım Kontrolü ve İleri Besleme Yaklaşımları",
    "2.7.1": "2.3 altında verim literatürü",
    "2.7.2": "2.4 altında harmonik iyileştirme literatürü",
    "2.8": "2.6 Araştırma Boşluğu",
    "2.8.1": "2.3 ve 4.5",
    "2.8.2": "2.4 Şebeke Akım Kontrolü ve İleri Besleme Yaklaşımları ile 5.3 Önerilen Sin³ Tabanlı İleri Besleme Yapısı ve Kontrol Blok Diyagramı",
    "2.8.3": "2.6 Araştırma Boşluğu",
    "2.9": "2.6 sonundaki sentez ve geçiş paragrafı",
    "3": "3. Sistem Mimarisi ile 4. Düşük Güç Analizi arasında bölünecek",
    "3.1": "Bölüm 3 açılış metni; ayrı başlık yok",
    "3.2": "3.2 T-Tipi Faz Kolu ve Anahtarlama Durumları",
    "3.3": "3.2 T-Tipi Faz Kolu ve Anahtarlama Durumları",
    "3.3.1": "3.2 altında pozitif çalışma modu",
    "3.3.2": "3.2 altında negatif çalışma modu",
    "3.3.3": "3.2 altında sıfır seviyesi",
    "3.4": "3.2 çalışma modları ve 4.1 ters akım mekanizması",
    "3.5": "4.2 Senkron Buck Eşdeğer Modeli",
    "3.5.1": "4.2 altında pozitif yarım periyot",
    "3.5.2": "4.2 altında negatif yarım periyot",
    "3.5.3": "4.2 sonunda modelin kullanım gerekçesi",
    "3.6": "4.1 Ters Akım Dolaşım Mekanizması",
    "3.6.1": "4.1 altında modülasyon indeksi etkisi",
    "3.6.2": "4.1 altında nötr anahtar davranışı",
    "3.6.3": "4.5 Verim ve Harmonik Performans Ödünleşimi",
    "3.6.4": "4.1 Ters Akım Dolaşım Mekanizması",
    "3.7": "5.1 Sin³ Bileşeninin Matematiksel Tanımı",
    "3.7.1": "5.1 altında üçüncü harmonik gözlemi",
    "3.7.2": "5.2 Düşük Güçte Harmonik Oluşum Mekanizması, 5.3 Önerilen Sin³ Tabanlı İleri Besleme Yapısı ve Kontrol Blok Diyagramı ve 5.4 Kapalı Çevrim Modeli",
    "3.8": "4.5 Verim ve Harmonik Performans Ödünleşimi",
    "3.9": "Bölüm 4 sonundaki değerlendirme; ayrı başlık yok",
    "4": "4. Düşük Güç Analizi ve 5. Sin³ Kompanzasyonu arasında bölünecek",
    "4.1": "Bölüm 4 açılış metni; ayrı başlık yok",
    "4.2": "4.1 Ters Akım Dolaşım Mekanizması",
    "4.3": "4.3 Klasik Anahtarlama ve 4.4 Önerilen Anahtarlama",
    "4.4": "3.5 Denetim, Modülasyon ve Sin³ Kompanzasyonu; 5.3 Önerilen Sin³ Tabanlı İleri Besleme Yapısı ve Kontrol Blok Diyagramından çapraz başvuru",
    "4.5": "5.1 Sin³ Bileşeninin Matematiksel Tanımı, 5.2 Düşük Güçte Harmonik Oluşum Mekanizması, 5.3 Önerilen Sin³ Tabanlı İleri Besleme Yapısı ve Kontrol Blok Diyagramı ile 5.4 Kapalı Çevrim Modeli",
    "4.6": "5.1 Sin³ Bileşeninin Matematiksel Tanımı, 5.2 Düşük Güçte Harmonik Oluşum Mekanizması ve 5.4 Kapalı Çevrim Modeli",
    "4.7": "5.6 Düşük, Orta ve Nominal Güç Karşılaştırması; gerçek MATLAB modeliyle",
    "5": "6. DENEYSEL DOĞRULAMA",
    "5.1": "Bölüm 6 açılış metni; ayrı başlık yok",
    "5.2": "6.1 Deney Düzeneği",
    "5.3": "6.1 altında sürücü donanımı; ayrıntı Ek A",
    "5.4": "6.1 altında gerilim ölçümü; ayrıntı Ek A",
    "5.5": "6.2 Ölçüm Cihazları ve Belirsizlikler",
    "5.6": "6.1 ve 6.2 altında ölçüm kartı",
    "5.7": "6.2 altında DA ölçüm zinciri",
    "5.8": "6.2 altında AA ölçüm zinciri",
    "5.9": "6.3 Test Matrisi ve Veri İşleme",
    "5.10": "6.4 Düşük Güç Sonuçları – klasik yöntem",
    "5.11": "6.4 Düşük Güç Sonuçları – önerilen anahtarlama",
    "5.12": "6.4 ve 6.5 – önerilen anahtarlama + Sin³",
    "5.13": "6.6 karşılaştırma sonundaki değerlendirme; ayrı başlık yok",
    "6": "7. GT-TİPİ YENİDEN YAPILANDIRILABİLİR ENERJİ DEPOLAMA MİMARİSİ",
    "6.1": "Bölüm 7 açılış metni; ayrı başlık yok",
    "6.2": "7.2 GT-Tipi Topolojinin Yapısı için klasik evirici karşılaştırması",
    "6.3": "7.3 Şarj ve Deşarj Çalışma Modları",
    "6.4": "7.1 Tasarım Gereksinimleri ve 7.2 Topoloji",
    "6.5": "7.2–7.6 GT-Tipi mimari, çalışma modları ve doğrulama",
    "6.6": "Bölüm 7 sonundaki değerlendirme; ayrı başlık yok",
    "7": "8. SONUÇLAR VE GELECEK ÇALIŞMALAR",
    "7.1": "8.2 Özgün Katkılar; resmî doğrulama sonrası Ekler",
    "7.2": "8.4 Gelecek Çalışmalar",
}


INDEPENDENT = {
    "1.7", "2.3", "2.8", "3.2", "3.5", "3.6", "3.7", "3.8",
    "4.2", "4.3", "4.4", "4.6", "4.7", "5.2", "5.9",
    "5.10", "5.11", "5.12", "6.2", "6.3", "6.4", "6.5", "7.1", "7.2",
}


def heading_number(text: str) -> str:
    match = re.match(r"^(\d+(?:\.\d+)*)(?:\.)?\s+", text)
    return match.group(1) if match else ""


def extract_old_headings() -> list[dict[str, str]]:
    doc = Document(OLD_THESIS)
    raw: list[tuple[int, str, str]] = []
    for index, paragraph in enumerate(doc.paragraphs):
        text = " ".join(paragraph.text.split())
        style = paragraph.style.name if paragraph.style else ""
        if text and style.startswith("Heading"):
            level_match = re.search(r"(\d+)$", style)
            level = int(level_match.group(1)) if level_match else 1
            raw.append((index, text, str(level)))

    merged: list[tuple[int, str, str]] = []
    for index, text, level in raw:
        if not heading_number(text) and merged and merged[-1][1].endswith("Arasındaki"):
            old_index, old_text, old_level = merged[-1]
            merged[-1] = (old_index, f"{old_text} {text}", old_level)
        else:
            merged.append((index, text, level))

    # Word dosyasında 4.6 metni başlık stili taşımadığı için otomatik listede görünmüyor.
    insertion = (1599, "4.6. Harmonik Oluşum Mekanizmasının Matematiksel Olarak Açıklanması", "2")
    insert_at = next(i for i, item in enumerate(merged) if heading_number(item[1]) == "4.7")
    merged.insert(insert_at, insertion)

    return [map_heading(text, level) for _, text, level in merged]


def map_heading(text: str, level: str) -> dict[str, str]:
    number = heading_number(text)
    upper = text.upper()
    if not number:
        front = {
            "ETİK BEYAN FORMU": ("ETİK İLKE VE KURALLARA UYGUNLUK BEYANNAMESİ", "YENİDEN ADLANDIRILACAK", "Evet, yeni adla", "Şablon metni esas alınacak."),
            "TEŞEKKÜR": ("TEŞEKKÜR", "KALACAK", "Evet", "Güncel katkılara göre son aşamada yazılacak."),
            "İÇİNDEKİLER": ("İÇİNDEKİLER", "KALACAK", "Evet", "LaTeX tarafından otomatik üretilecek."),
            "KISALTMALAR": ("KISALTMALAR", "KALACAK", "Evet", "Yalnızca tezde geçen kısaltmalar tutulacak."),
            "TABLO LİSTESİ": ("TABLO LİSTESİ", "KALACAK", "Evet", "LaTeX tarafından otomatik üretilecek."),
            "ŞEKİL LİSTESİ": ("ŞEKİL LİSTESİ", "KALACAK", "Evet", "LaTeX tarafından otomatik üretilecek."),
            "KAYNAKLAR": ("KAYNAKLAR", "KALACAK", "Evet", "Kaynakça veri tabanından otomatik üretilecek."),
            "EK": ("EKLER", "YENİDEN ADLANDIRILACAK", "Evet, yeni adla", "Ayrıntılı devreler, BOM ve doğrulama ekleri burada toplanacak."),
            "ÖZGEÇMİŞ": ("ÖZGEÇMİŞ", "KALACAK", "Evet", "Enstitü şablonuna göre güncellenecek."),
        }
        target, decision, independent, usage = front.get(upper, ("Ön kısım / son kısım", "KONTROL EDİLECEK", "Evet", "Şablonla karşılaştırılacak."))
        return make_row(number or "—", text, level, target, decision, independent, usage)

    target = TARGETS.get(number, "Yeni omurgada üst başlık altında değerlendirilecek")
    chapter = number.split(".")[0]
    if number in {"2.1", "2.9", "3.1", "3.9", "4.1", "5.1", "5.13", "6.1", "6.6"}:
        decision = "AYRI BAŞLIK OLMAYACAK"
        usage = "İçerik bölüm açılışına, geçişe veya sonuç değerlendirmesine yedirilecek."
    elif number.count(".") == 0:
        decision = "YENİDEN KURGULANACAK"
        usage = "Eski bölüm sınırları korunmayacak; yeni tez omurgası esas alınacak."
    elif chapter == "1":
        decision = "LİTERATÜRDE BİRLEŞTİRİLECEK"
        usage = "Kaynaklı kısımlar seçilerek kısaltılacak; kanıtsız ömür ve maliyet iddiaları taşınmayacak."
    elif chapter == "2":
        decision = "LİTERATÜRDE BİRLEŞTİRİLECEK"
        usage = "Literatür ve temsilî veri sınırı korunarak yeniden yazılacak."
    elif chapter == "3":
        decision = "MODEL/ANALİZDE YENİDEN YAZILACAK"
        usage = "Topoloji ve denklemler kullanılabilir; yeni devre çizimleri ve model adlarıyla doğrulanacak."
    elif chapter == "4":
        decision = "YÖNTEMDE YENİDEN YAZILACAK"
        usage = "Eski yöntem anlatımı kaynak olarak kalacak; gerçek kod/model ve doğru Sin³ tanımıyla yeniden kurulacak."
    elif chapter == "5":
        decision = "DENEYSEL BÖLÜME TAŞINACAK"
        usage = "Donanım bilgisi seçilerek alınacak; sonuçlar ham kayıt, çalışma noktası ve belirsizlikle doğrulanacak."
    elif chapter == "6":
        decision = "GT-TİPİ BÖLÜME TAŞINACAK"
        usage = "Topolojik fikir korunacak; yeni vektör devreler ve gerçek Simulink çıktılarıyla doğrulanacak."
    else:
        decision = "SONUÇTA YENİDEN YAZILACAK"
        usage = "Yalnızca tezde kanıtlanan sonuçlar ve resmî olarak doğrulanan çıktılar kullanılacak."

    independent = "Evet, yeni adla" if number in INDEPENDENT else "Hayır, üst başlık altında"
    if number.count(".") == 0:
        independent = "Evet, fakat yeni bölüm adıyla"
    return make_row(number, text, level, target, decision, independent, usage)


def make_row(number: str, title: str, level: str, target: str, decision: str, independent: str, usage: str) -> dict[str, str]:
    return {
        "number": number,
        "old_chapter": number.split(".")[0] if number != "—" else "Ön/Son",
        "level": level,
        "title": title,
        "target": target,
        "decision": decision,
        "independent": independent,
        "usage": usage,
    }


def relative_url(path: Path) -> str:
    rel = path.relative_to(ROOT).as_posix()
    return quote(rel, safe="/._-()")


def html_inventory() -> list[dict[str, str]]:
    descriptions = {
        "TEZ_INCELEME_RAPORU.html": "Jüri istekleri, dosya incelemesi ve yeniden tasarım kararları.",
        "DENKLEM_PARAMETRE_DENETIMI_2026-07-14.html": "Bölüm 1--5 denklem, sembol, kaynak ve eski tez aktarım denetimi.",
        "BOLUM_3_4_5_MATLAB_SIMULINK_DENEY_PLANI_2026-07-14.html": "Bölüm 3--5 için MATLAB/Simulink koşuları, ölçütler ve tez sahibinden istenecek dosya/parametreler.",
        "ONCEKI_TEZ_SAHIBINDEN_ISTEK_LISTESI_2026-07-14.html": "Bölüm 3--5 için önceki tez numaralarına göre kaynak model, kod, benzetim ve eleman parametresi istekleri.",
        "ONCEKI_TEZ_SEKIL_TABLO_TAKIP_LISTESI_2026-07-13.html": "Eski tezdeki 107 şekil ve 16 tablonun yeni tezdeki hedefleri.",
        "SEKIL_4_1_4_2_KARSILASTIRMA_2026-07-14.html": "Eski ve yeniden üretilen Şekil 4.1--4.2 adaylarının karşılaştırması.",
    }
    items = []
    for path in sorted(ROOT.rglob("*.html")):
        if path == OUTPUT or "tmp" in path.parts:
            continue
        items.append({
            "name": path.name,
            "path": path.relative_to(ROOT).as_posix(),
            "url": relative_url(path),
            "description": descriptions.get(path.name, "Proje içinde üretilmiş HTML inceleme veya takip dosyası."),
        })
    return items


def new_toc_summary() -> list[str]:
    chapters = []
    chapter_dir = ROOT / "tez-latex" / "chapters"
    for path in sorted(chapter_dir.glob("[0-9][0-9]-*.tex")):
        first_line = path.read_text(encoding="utf-8", errors="replace").splitlines()[0]
        if not first_line.startswith("\\chapter{"):
            continue
        title = first_line[len("\\chapter{"):-1]
        title = title.replace(r"\texorpdfstring{\textsuperscript{3}}{3}", "³")
        title = re.sub(r"\\[A-Za-z]+\{([^}]*)\}", r"\1", title)
        chapter_number = int(path.name[:2])
        chapters.append(f"{chapter_number}. {title}")
    return chapters


def link_card(title: str, description: str, href: str, tag: str) -> str:
    return f'''<a class="link-card" href="{href}"><span class="file-tag">{html.escape(tag)}</span><strong>{html.escape(title)}</strong><small>{html.escape(description)}</small><span class="open">Aç →</span></a>'''


def build() -> None:
    rows = extract_old_headings()
    html_files = html_inventory()
    chapters = new_toc_summary()
    decisions = Counter(row["decision"] for row in rows)

    important = [
        ("Güncel tez PDF", "14 Temmuz 2026 tarihli, 185 sayfalık güncel LaTeX çıktısı; önceki tezden birleştirilen veya ham kanıtla doğrulanması gereken noktalar Bölüm 1--8 boyunca D1--D8 kodlu 39 görünür yorum kutusuyla işaretlenmiştir. Bölüm 7'de eski GT-tipi görseller ile yeni 100 kW tasarım katmanı ayrı tutulmuş; Bölüm 8'de araştırma soruları, üç katkı, tarihsel fikrî mülkiyet kayıtları, sınırlılıklar ve gelecek çalışmalar mevcut kanıt düzeyine göre yazılmıştır.", relative_url(ROOT / "tez-latex" / "main.pdf"), "PDF"),
        ("Denklem ve parametre denetimi", "Bölüm 1--5 formüllerinin sembol, kaynak, hata ve aktarım kararları.", relative_url(ROOT / "tez-latex" / "review" / "DENKLEM_PARAMETRE_DENETIMI_2026-07-14.html"), "HTML"),
        ("Bölüm 3--5 deney ve istek planı", "MATLAB/Simulink koşuları, ortak ölçütler, teze eklenecek çıktılar ve tez sahibinden beklenecek dosyalar.", relative_url(ROOT / "tez-latex" / "review" / "BOLUM_3_4_5_MATLAB_SIMULINK_DENEY_PLANI_2026-07-14.html"), "HTML"),
        ("Bölüm 3--5 için tez sahibinden istekler", "Eski bölüm, şekil ve tablo numaralarına göre kaynak model, benzetim ve eleman parametresi talepleri.", relative_url(ROOT / "tez-latex" / "review" / "ONCEKI_TEZ_SAHIBINDEN_ISTEK_LISTESI_2026-07-14.html"), "HTML"),
        ("Şekil 4.1--4.2 karşılaştırması", "Eski kapı darbesi ekranları ile MATLAB'da yeniden üretilen adayların yan yana incelemesi.", relative_url(ROOT / "tez-latex" / "review" / "SEKIL_4_1_4_2_KARSILASTIRMA_2026-07-14.html"), "HTML"),
        ("Tez TODO", "Eksik işler, gerçek veri bekleyen noktalar ve sonraki adımlar.", relative_url(ROOT / "tez-latex" / "TODO.md"), "MD"),
        ("Jüri istekleri eylem matrisi", "Her jüri talebinin tezdeki karşılığı ve yapılacak işlem.", relative_url(ROOT / "dosyalar" / "03_INCELEME_VE_PLANLAMA" / "JURI_ISTEKLERI_EYLEM_MATRISI.md"), "MD"),
        ("Önceki tez aktarım haritası", "Eski içeriklerin yeni bölümlere aktarım özeti.", relative_url(ROOT / "tez-latex" / "review" / "ONCEKI_TEZ_AKTARIM_HARITASI_2026-07-13.md"), "MD"),
        ("MATLAB/Simulink deney haritası", "Gelen gerçek dosyaların incelemesi ve doğrulama planı.", relative_url(ROOT / "tez-matlab-simulink" / "review" / "05_sonradan_gelenler" / "INCELEME_VE_DENEY_HARITASI_2026-07-13.md"), "MD"),
        ("MATLAB/Simulink TODO", "Model, deney ve gerçek veri görevleri.", relative_url(ROOT / "tez-matlab-simulink" / "TODO.md"), "MD"),
    ]

    html_cards = "".join(link_card(x["name"], x["description"], x["url"], "HTML") for x in html_files)
    important_cards = "".join(link_card(*x) for x in important)
    chapter_list = "".join(f"<li>{html.escape(chapter)}</li>" for chapter in chapters)
    decision_cards = "".join(
        f'<div class="mini"><strong>{count}</strong><span>{html.escape(label.lower())}</span></div>'
        for label, count in decisions.most_common()
    )
    data = json.dumps(rows, ensure_ascii=False)

    page = f'''<!doctype html>
<html lang="tr">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Tez Çalışma Merkezi</title>
  <style>
    :root{{--ink:#18212b;--muted:#637083;--line:#dbe3ea;--bg:#f2f5f7;--paper:#fff;--navy:#143c59;--teal:#1b7881;--green:#e5f5eb;--blue:#e7f2fb;--amber:#fff2cf;--red:#fde9e9;--purple:#f0eafb}}
    *{{box-sizing:border-box}} html{{scroll-behavior:smooth}} body{{margin:0;background:var(--bg);color:var(--ink);font:14px/1.5 "Segoe UI",Arial,sans-serif}} a{{color:inherit}}
    header{{background:radial-gradient(circle at 85% 20%,#33a0a55c,transparent 28%),linear-gradient(132deg,#102e47,#1b5570 62%,#16727b);color:#fff;padding:38px clamp(20px,5vw,70px) 34px}}
    header h1{{font-size:clamp(28px,4vw,46px);line-height:1.1;margin:0 0 10px}} header p{{max-width:920px;margin:5px 0;color:#dcecf1;font-size:15px}}
    nav{{display:flex;flex-wrap:wrap;gap:8px;margin-top:20px}} nav a{{text-decoration:none;border:1px solid #ffffff55;background:#ffffff14;padding:8px 12px;border-radius:999px}}
    main{{max-width:1560px;margin:auto;padding:22px}} section{{scroll-margin-top:18px;margin-bottom:28px}} .section-head{{display:flex;align-items:end;justify-content:space-between;gap:16px;margin-bottom:12px}} h2{{margin:0;font-size:24px;color:var(--navy)}} .section-head p{{margin:0;color:var(--muted)}}
    .stats{{display:grid;grid-template-columns:repeat(auto-fit,minmax(150px,1fr));gap:10px;margin-top:-44px;position:relative}} .stat,.mini{{background:#fff;border:1px solid var(--line);border-radius:12px;padding:14px;box-shadow:0 8px 22px #173f5f10}} .stat strong{{display:block;font-size:28px;color:var(--navy)}} .stat span,.mini span{{color:var(--muted)}} .mini strong{{font-size:19px;color:var(--teal);margin-right:7px}}
    .link-grid{{display:grid;grid-template-columns:repeat(auto-fit,minmax(245px,1fr));gap:12px}} .link-card{{position:relative;display:flex;min-height:158px;flex-direction:column;text-decoration:none;background:#fff;border:1px solid var(--line);border-radius:14px;padding:16px;box-shadow:0 5px 16px #173f5f0c;transition:.18s ease}} .link-card:hover{{transform:translateY(-2px);border-color:#6ca7b1;box-shadow:0 9px 25px #173f5f18}} .link-card strong{{font-size:16px;color:var(--navy);margin:10px 0 6px;overflow-wrap:anywhere}} .link-card small{{color:var(--muted)}} .file-tag{{align-self:flex-start;font-weight:800;font-size:11px;letter-spacing:.08em;color:#12636c;background:#e6f5f5;padding:4px 8px;border-radius:999px}} .open{{margin-top:auto;padding-top:10px;color:#176a77;font-weight:700}}
    .structure{{display:grid;grid-template-columns:minmax(280px,.72fr) minmax(380px,1.28fr);gap:16px}} .panel{{background:#fff;border:1px solid var(--line);border-radius:14px;padding:17px}} .panel h3{{margin:0 0 10px;color:var(--navy)}} .chapters{{list-style:none;margin:0;padding-left:0}} .chapters li{{padding:5px 0;border-bottom:1px dashed #e2e8ed}} .callout{{border-left:5px solid #e3ad30;background:#fff8e5;padding:13px 15px;border-radius:7px;margin-top:12px;color:#634e18}}
    .decision-stats{{display:grid;grid-template-columns:repeat(auto-fit,minmax(180px,1fr));gap:8px;margin:12px 0}} .mini{{padding:10px 12px;box-shadow:none}}
    .toolbar{{position:sticky;top:0;z-index:6;display:grid;grid-template-columns:2fr repeat(3,minmax(150px,1fr)) auto auto;gap:8px;padding:10px 0;background:#f2f5f7ee;backdrop-filter:blur(8px)}} input,select,button{{font:inherit;border:1px solid #b8c6d1;border-radius:8px;background:#fff;padding:9px 10px}} button{{cursor:pointer;background:var(--navy);border-color:var(--navy);color:#fff}} button.secondary{{background:#fff;color:var(--navy)}}
    .table-wrap{{overflow:auto;background:#fff;border:1px solid var(--line);border-radius:12px;box-shadow:0 3px 14px #173f5f0d}} table{{border-collapse:collapse;width:100%;min-width:1580px}} th{{position:sticky;top:61px;z-index:4;background:#e7eef2;color:var(--navy);text-align:left;font-size:12px}} th,td{{border-bottom:1px solid var(--line);padding:10px 9px;vertical-align:top}} tr:hover td{{background:#f7fafb}} th:nth-child(3),td:nth-child(3){{width:350px;min-width:350px}} th:nth-child(4),td:nth-child(4){{width:310px;min-width:310px}} .old-title{{display:-webkit-box;-webkit-box-orient:vertical;-webkit-line-clamp:2;overflow:hidden;line-height:1.4;min-height:2.8em}} .badge,.yesno{{display:inline-block;border-radius:999px;padding:4px 8px;font-size:11px;font-weight:800}} .badge{{background:var(--blue);color:#175b7f}} .yesno{{background:#edf1f4;color:#465664}} tr[data-decision*="KALACAK"] .badge{{background:var(--green);color:#17653a}} tr[data-decision*="AYRI"] .badge{{background:var(--red);color:#8a2929}} tr[data-decision*="DENEYSEL"],tr[data-decision*="MODEL"],tr[data-decision*="YÖNTEM"]{{background:#fcfbff}} tr[data-decision*="YENİDEN"] .badge{{background:var(--purple);color:#60408b}} tr[data-decision*="BİRLEŞ"] .badge{{background:var(--amber);color:#70540b}} .note{{width:205px}} .done-row td{{opacity:.5}} .hidden{{display:none}} footer{{color:var(--muted);padding:20px 0 8px}}
    @media(max-width:980px){{.structure{{grid-template-columns:1fr}} .toolbar{{position:static;grid-template-columns:1fr 1fr}} th{{top:0}} .stats{{margin-top:0}}}}
    @media(max-width:600px){{main{{padding:14px}} .toolbar{{grid-template-columns:1fr}} header{{padding:28px 18px}}}}
    @media print{{header{{background:#fff;color:#000;padding:10px 0}} header p{{color:#333}} nav,.toolbar,.note,button{{display:none!important}} main{{max-width:none;padding:0}} .stats{{margin:0}} .link-grid{{display:none}} .structure{{grid-template-columns:1fr}} .table-wrap{{overflow:visible;box-shadow:none}} table{{min-width:0;font-size:7.5pt}} th{{position:static}} th:nth-child(3),td:nth-child(3),th:nth-child(4),td:nth-child(4){{width:auto;min-width:0}} .old-title{{display:block;overflow:visible;-webkit-line-clamp:unset;min-height:0}}}}
  </style>
</head>
<body>
<header>
  <h1>Tez Çalışma Merkezi</h1>
  <p>HTML raporları, güncel tez dosyaları ve eski tez başlıklarının yeni tezdeki karşılıkları tek sayfada toplandı.</p>
  <p>Kaynak tez: dosyalar/01_TAM_TEZ/tez_tumu_8.docx · Yeni omurga: tez-latex/main.toc · Güncelleme: 14 Temmuz 2026</p>
  <nav><a href="#html-raporlari">HTML raporları</a><a href="#hizli-dosyalar">Hızlı dosyalar</a><a href="#yeni-omurga">Yeni tez omurgası</a><a href="#baslik-haritasi">Başlık aktarım haritası</a></nav>
</header>
<main>
  <section class="stats"><div class="stat"><strong>{len(html_files)}</strong><span>bağlı HTML raporu</span></div><div class="stat"><strong>{len(rows)}</strong><span>eski tez başlığı</span></div><div class="stat"><strong>{len(chapters)}</strong><span>yeni ana bölüm</span></div><div class="stat"><strong>{sum(1 for r in rows if r['independent'].startswith('Hayır'))}</strong><span>ayrı başlık olmayacak kayıt</span></div></section>

  <section id="html-raporlari"><div class="section-head"><div><h2>HTML raporları</h2><p>Projede bulunan bütün kalıcı HTML dosyaları.</p></div></div><div class="link-grid">{html_cards}</div></section>

  <section id="hizli-dosyalar"><div class="section-head"><div><h2>Hızlı erişim</h2><p>Çalışırken en sık açılacak tez, plan ve deney dosyaları.</p></div></div><div class="link-grid">{important_cards}</div></section>

  <section id="yeni-omurga"><div class="section-head"><div><h2>Yeni tez omurgası</h2><p>Güncel LaTeX içindekilerinden alınmıştır.</p></div></div><div class="structure"><div class="panel"><h3>Ana bölümler</h3><ul class="chapters">{chapter_list}</ul></div><div class="panel"><h3>Aktarım ilkesi</h3><p>Eski tez başlıkları bire bir kopyalanmayacak. Literatür niteliğindeki ayrıntılar Bölüm 2'de birleştirilecek; topoloji ve model Bölüm 3'e, düşük güç anahtarlama analizi Bölüm 4'e, Sin³ yöntemi Bölüm 5'e, deneyler Bölüm 6'ya ve GT-tipi mimari Bölüm 7'ye taşınacak.</p><p>“Hayır, üst başlık altında” işareti içeriğin atılacağı anlamına gelmez. Eski başlığın yeni içindekilerde bağımsız satır olmayacağını, metnin gösterilen üst başlığa yedirileceğini belirtir.</p><div class="callout"><strong>Jüri kontrolü:</strong> Deney, verim, THD, kararlılık ve özgün katkı iddiaları gerçek kod/model ve ham ölçüm kayıtlarıyla doğrulanmadan nihai sonuç olarak yazılmayacak.</div></div></div></section>

  <section id="baslik-haritasi">
    <div class="section-head"><div><h2>Eski içindekiler → yeni tez başlık haritası</h2><p>Arama, filtre, kontrol kutusu ve kişisel not alanı içerir.</p></div></div>
    <div class="decision-stats">{decision_cards}</div>
    <div class="toolbar"><input id="q" type="search" placeholder="Eski başlık, yeni hedef veya karar ara…"><select id="chapter"><option value="">Tüm eski bölümler</option></select><select id="decision"><option value="">Tüm kararlar</option></select><select id="independent"><option value="">Bağımsız başlık durumu</option></select><button id="export">CSV indir</button><button id="reset" class="secondary">İşaretleri sıfırla</button></div>
    <div class="table-wrap"><table><thead><tr><th>✓</th><th>Eski no</th><th>Eski tez başlığı</th><th>Yeni tezde yeri</th><th>Karar</th><th>Bağımsız başlık?</th><th>Eski metin nasıl kullanılacak?</th><th>Notum</th></tr></thead><tbody id="rows"></tbody></table></div>
    <footer>Kontrol kutuları ve notlar yalnızca kullanılan tarayıcıda saklanır. Başlık haritası gerçek veri ve jüri değerlendirmeleri geldikçe güncellenebilir.</footer>
  </section>
</main>
<script>
const data={data};
const store=JSON.parse(localStorage.getItem('tez-heading-map')||'{{}}');
const esc=s=>String(s).replace(/[&<>"']/g,c=>({{'&':'&amp;','<':'&lt;','>':'&gt;','"':'&quot;',"'":'&#39;'}}[c]));
const key=r=>'heading-'+r.number+'-'+r.title;
function optionize(id,values){{const select=document.getElementById(id);[...new Set(values)].sort((a,b)=>a.localeCompare(b,'tr',{{numeric:true}})).forEach(v=>select.insertAdjacentHTML('beforeend',`<option>${{esc(v)}}</option>`));}}
optionize('chapter',data.map(x=>x.old_chapter));optionize('decision',data.map(x=>x.decision));optionize('independent',data.map(x=>x.independent));
function render(){{const q=document.getElementById('q').value.toLocaleLowerCase('tr'),chapter=document.getElementById('chapter').value,decision=document.getElementById('decision').value,independent=document.getElementById('independent').value;document.getElementById('rows').innerHTML=data.map(r=>{{const k=key(r),saved=store[k]||{{}},hay=Object.values(r).join(' ').toLocaleLowerCase('tr');const hide=(q&&!hay.includes(q))||(chapter&&r.old_chapter!==chapter)||(decision&&r.decision!==decision)||(independent&&r.independent!==independent);return `<tr class="${{hide?'hidden ':''}}${{saved.checked?'done-row':''}}" data-key="${{esc(k)}}" data-decision="${{esc(r.decision)}}"><td><input class="done" type="checkbox" ${{saved.checked?'checked':''}}></td><td><strong>${{esc(r.number)}}</strong></td><td><div class="old-title" title="${{esc(r.title)}}">${{esc(r.title)}}</div></td><td>${{esc(r.target)}}</td><td><span class="badge">${{esc(r.decision)}}</span></td><td><span class="yesno">${{esc(r.independent)}}</span></td><td>${{esc(r.usage)}}</td><td><input class="note" value="${{esc(saved.note||'')}}" placeholder="Kendi notun…"></td></tr>`}}).join('');bind();}}
function save(){{localStorage.setItem('tez-heading-map',JSON.stringify(store));}}
function bind(){{document.querySelectorAll('#rows tr').forEach(tr=>{{const k=tr.dataset.key;tr.querySelector('.done').onchange=e=>{{store[k]=store[k]||{{}};store[k].checked=e.target.checked;save();render();}};tr.querySelector('.note').oninput=e=>{{store[k]=store[k]||{{}};store[k].note=e.target.value;save();}};}})}}
['q','chapter','decision','independent'].forEach(id=>document.getElementById(id).addEventListener(id==='q'?'input':'change',render));
document.getElementById('reset').onclick=()=>{{if(confirm('Tüm başlık işaretleri ve kişisel notlar silinsin mi?')){{localStorage.removeItem('tez-heading-map');location.reload();}}}};
document.getElementById('export').onclick=()=>{{const cols=['number','level','title','target','decision','independent','usage'];const csv=[cols.join(';'),...data.map(r=>cols.map(c=>'"'+String(r[c]).replaceAll('"','""')+'"').join(';'))].join('\\n');const a=document.createElement('a');a.href=URL.createObjectURL(new Blob(['\\ufeff'+csv],{{type:'text/csv'}}));a.download='eski_yeni_tez_baslik_haritasi.csv';a.click();URL.revokeObjectURL(a.href);}};
render();
</script>
</body></html>'''
    OUTPUT.write_text(page, encoding="utf-8")
    print(f"OK: {len(html_files)} HTML bağlantısı, {len(rows)} başlık -> {OUTPUT}")


if __name__ == "__main__":
    build()
