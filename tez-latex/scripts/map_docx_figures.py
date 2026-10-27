"""Map DOCX drawing relationships to nearby figure captions."""

from __future__ import annotations

import argparse
import csv
import re
from pathlib import Path

from docx import Document
from docx.oxml.ns import qn


FIGURE_RE = re.compile(r"^Şekil\s+\d+\.\d+", re.IGNORECASE)


def paragraph_media(paragraph) -> list[str]:
    targets: list[str] = []
    for blip in paragraph._p.xpath(".//*[local-name()='blip']"):
        rid = blip.get(qn("r:embed")) or blip.get(qn("r:link"))
        if rid and rid in paragraph.part.rels:
            targets.append(Path(paragraph.part.rels[rid].target_ref).name)
    return targets


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("docx", type=Path)
    parser.add_argument("output", type=Path)
    args = parser.parse_args()

    document = Document(args.docx)
    paragraphs = document.paragraphs
    rows: list[dict[str, str | int]] = []

    for index, paragraph in enumerate(paragraphs):
        media = paragraph_media(paragraph)
        if not media:
            continue

        caption = ""
        caption_index = ""
        for look_ahead in range(index, min(index + 7, len(paragraphs))):
            candidate = paragraphs[look_ahead].text.strip()
            if FIGURE_RE.match(candidate):
                caption = candidate
                caption_index = str(look_ahead)
                break

        rows.append(
            {
                "paragraph_index": index,
                "style": paragraph.style.name,
                "media": ";".join(media),
                "caption_index": caption_index,
                "caption": caption,
            }
        )

    args.output.parent.mkdir(parents=True, exist_ok=True)
    with args.output.open("w", newline="", encoding="utf-8-sig") as handle:
        writer = csv.DictWriter(handle, fieldnames=rows[0].keys() if rows else [])
        writer.writeheader()
        writer.writerows(rows)

    print(f"Mapped {len(rows)} drawing paragraphs to {args.output}")


if __name__ == "__main__":
    main()
