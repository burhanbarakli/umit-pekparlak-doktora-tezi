"""05_sonradan_gelenler DOCX/PDF dosyalarını aranabilir metne dönüştürür."""

from __future__ import annotations

import csv
import re
import zipfile
from pathlib import Path

from lxml import etree
from pypdf import PdfReader


ROOT = Path(__file__).resolve().parents[1]
SOURCE = ROOT.parent / "dosyalar" / "05_sonradan_gelenler"
OUT = ROOT / "review" / "05_sonradan_gelenler" / "extracted_text"
OUT.mkdir(parents=True, exist_ok=True)


def clean(text: str) -> str:
    text = text.replace("\u00a0", " ")
    text = re.sub(r"[ \t]+", " ", text)
    text = re.sub(r"\n{3,}", "\n\n", text)
    return text.strip()


def extract_docx(path: Path) -> tuple[str, int]:
    lines: list[str] = []
    with zipfile.ZipFile(path) as zf:
        xml_names = [
            name
            for name in zf.namelist()
            if name.startswith("word/")
            and name.endswith(".xml")
            and any(
                token in name
                for token in (
                    "document.xml",
                    "header",
                    "footer",
                    "footnotes.xml",
                    "endnotes.xml",
                    "comments.xml",
                )
            )
        ]
        for name in xml_names:
            root = etree.fromstring(zf.read(name))
            lines.append(f"\n===== {name} =====")
            for paragraph in root.xpath(".//*[local-name()='p']"):
                parts = paragraph.xpath(".//*[local-name()='t' or local-name()='delText']/text()")
                value = clean("".join(parts))
                if value:
                    lines.append(value)
    return clean("\n".join(lines)), len(xml_names)


def extract_pdf(path: Path) -> tuple[str, int]:
    reader = PdfReader(str(path))
    pages: list[str] = []
    for index, page in enumerate(reader.pages, start=1):
        pages.append(f"\n===== PAGE {index} =====\n{page.extract_text() or ''}")
    return clean("\n".join(pages)), len(reader.pages)


rows: list[dict[str, object]] = []
for path in sorted(SOURCE.iterdir()):
    suffix = path.suffix.lower()
    if suffix not in {".docx", ".pdf"}:
        continue
    if suffix == ".docx":
        text, units = extract_docx(path)
        kind = "DOCX_XML_PARTS"
    else:
        text, units = extract_pdf(path)
        kind = "PDF_PAGES"
    target = OUT / f"{path.stem}.txt"
    target.write_text(text, encoding="utf-8")
    rows.append(
        {
            "source": str(path),
            "type": suffix[1:].upper(),
            "unit_kind": kind,
            "units": units,
            "characters": len(text),
            "output": str(target),
        }
    )

with (OUT.parent / "extraction_manifest.csv").open("w", newline="", encoding="utf-8-sig") as handle:
    writer = csv.DictWriter(handle, fieldnames=rows[0].keys() if rows else [])
    writer.writeheader()
    writer.writerows(rows)

print(f"Extracted {len(rows)} documents to {OUT}")
