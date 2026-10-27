"""List paragraphs, tables, and embedded media for one numbered DOCX chapter."""

from __future__ import annotations

import argparse
import sys
from pathlib import Path

from docx import Document
from docx.oxml.ns import qn
from docx.table import Table
from docx.text.paragraph import Paragraph


def iter_blocks(document: Document):
    for child in document.element.body.iterchildren():
        if child.tag == qn("w:p"):
            yield Paragraph(child, document)
        elif child.tag == qn("w:tbl"):
            yield Table(child, document)


def paragraph_media(paragraph: Paragraph) -> list[str]:
    targets: list[str] = []
    for blip in paragraph._p.xpath(".//a:blip"):
        rel_id = blip.get(qn("r:embed"))
        if rel_id and rel_id in paragraph.part.rels:
            targets.append(str(paragraph.part.rels[rel_id].target_ref))
    for data in paragraph._p.xpath(".//*[local-name()='imagedata']"):
        rel_id = data.get(qn("r:id"))
        if rel_id and rel_id in paragraph.part.rels:
            targets.append(str(paragraph.part.rels[rel_id].target_ref))
    return targets


def table_media(table: Table) -> list[str]:
    targets: list[str] = []
    for row in table.rows:
        for cell in row.cells:
            for paragraph in cell.paragraphs:
                targets.extend(paragraph_media(paragraph))
    return list(dict.fromkeys(targets))


def main() -> None:
    sys.stdout.reconfigure(encoding="utf-8", errors="replace")
    parser = argparse.ArgumentParser()
    parser.add_argument("docx", type=Path)
    parser.add_argument("chapter", help="Chapter number, for example 5")
    args = parser.parse_args()

    document = Document(args.docx)
    start_prefix = f"{args.chapter}."
    next_prefix = f"{int(args.chapter) + 1}."
    inside = False
    block_index = 0

    for block in iter_blocks(document):
        block_index += 1
        if isinstance(block, Paragraph):
            text = " ".join(block.text.split())
            if text.startswith(start_prefix) and not inside:
                inside = True
            if inside and text.startswith(next_prefix):
                break
            if not inside:
                continue
            media = paragraph_media(block)
            if text or media:
                print(f"P\t{block_index}\t{text}\t{'|'.join(media)}")
        elif inside:
            rows = []
            for row in block.rows:
                cells = [" ".join(cell.text.split()) for cell in row.cells]
                rows.append(" || ".join(cells))
            media = "|".join(table_media(block))
            print(f"T\t{block_index}\t" + " ### ".join(rows) + f"\t{media}")


if __name__ == "__main__":
    main()
