from __future__ import annotations

import json
import re
import sys
import zipfile
from pathlib import Path
from xml.etree import ElementTree as ET


W = "{http://schemas.openxmlformats.org/wordprocessingml/2006/main}"
CAPTION_RE = re.compile(
    r"^\s*(?P<kind>Şekil|Tablo)\s+(?P<number>\d+\.\d+)\.?\s*(?P<title>.*)$",
    re.IGNORECASE,
)
HEADING_RE = re.compile(r"^\s*(?P<number>\d+(?:\.\d+)*\.?)\s+(?P<title>\S.*)$")


def paragraph_text(p: ET.Element) -> str:
    chunks: list[str] = []
    for node in p.iter():
        if node.tag == f"{W}t" and node.text:
            chunks.append(node.text)
        elif node.tag == f"{W}tab":
            chunks.append("\t")
        elif node.tag in {f"{W}br", f"{W}cr"}:
            chunks.append(" ")
    return re.sub(r"\s+", " ", "".join(chunks)).strip()


def paragraph_style(p: ET.Element) -> str:
    ppr = p.find(f"{W}pPr")
    if ppr is None:
        return ""
    style = ppr.find(f"{W}pStyle")
    if style is None:
        return ""
    return style.attrib.get(f"{W}val", "")


def main() -> int:
    if len(sys.argv) != 3:
        raise SystemExit("usage: extract_old_thesis_inventory.py INPUT.docx OUTPUT.json")

    source = Path(sys.argv[1]).resolve()
    target = Path(sys.argv[2]).resolve()
    with zipfile.ZipFile(source) as archive:
        root = ET.fromstring(archive.read("word/document.xml"))

    paragraphs: list[dict[str, object]] = []
    captions: list[dict[str, object]] = []
    headings: list[dict[str, object]] = []
    current_heading = ""

    for index, p in enumerate(root.findall(f".//{W}body//{W}p"), start=1):
        text = paragraph_text(p)
        if not text:
            continue
        style = paragraph_style(p)
        heading_match = HEADING_RE.match(text)
        if style.lower().startswith(("heading", "balik", "başlık")) or (
            heading_match and len(text) < 180 and not CAPTION_RE.match(text)
        ):
            current_heading = text
            headings.append({"index": index, "style": style, "text": text})

        record = {"index": index, "style": style, "text": text, "context": current_heading}
        paragraphs.append(record)
        caption_match = CAPTION_RE.match(text)
        if caption_match:
            captions.append(
                {
                    **record,
                    "kind": caption_match.group("kind").capitalize(),
                    "number": caption_match.group("number"),
                    "title": caption_match.group("title").strip(" .\t"),
                }
            )

    payload = {
        "source": str(source),
        "paragraph_count": len(paragraphs),
        "caption_count": len(captions),
        "headings": headings,
        "captions": captions,
    }
    target.parent.mkdir(parents=True, exist_ok=True)
    target.write_text(json.dumps(payload, ensure_ascii=False, indent=2), encoding="utf-8")

    for item in captions:
        print(f"{item['kind']}\t{item['number']}\t{item['title']}\t{item['context']}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
