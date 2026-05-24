from pathlib import Path
from reportlab.lib.pagesizes import A4
from reportlab.pdfbase import pdfmetrics
from reportlab.pdfbase.cidfonts import UnicodeCIDFont
from reportlab.pdfgen import canvas


def md_to_pdf(md_path: Path, pdf_path: Path) -> None:
    text = md_path.read_text(encoding="utf-8")

    pdfmetrics.registerFont(UnicodeCIDFont("STSong-Light"))
    c = canvas.Canvas(str(pdf_path), pagesize=A4)
    width, height = A4

    left = 45
    right = width - 45
    y = height - 50
    line_height = 16

    c.setFont("STSong-Light", 11)

    def new_page():
        nonlocal y
        c.showPage()
        c.setFont("STSong-Light", 11)
        y = height - 50

    # Keep markdown content, remove trailing spaces only.
    lines = [ln.rstrip() for ln in text.splitlines()]
    for raw in lines:
        line = raw if raw else " "
        # Simple wrapping by character count (works for mixed Chinese/ASCII text).
        chunk = ""
        for ch in line:
            test = chunk + ch
            if c.stringWidth(test, "STSong-Light", 11) <= (right - left):
                chunk = test
            else:
                if y < 50:
                    new_page()
                c.drawString(left, y, chunk)
                y -= line_height
                chunk = ch
        if y < 50:
            new_page()
        c.drawString(left, y, chunk)
        y -= line_height

    c.save()


def main() -> None:
    base = Path(__file__).resolve().parent
    targets = [
        base / "exp5" / "report.md",
        base / "exp6" / "report.md",
    ]
    for md in targets:
        pdf = md.with_suffix(".pdf")
        md_to_pdf(md, pdf)
        print(f"generated: {pdf}")


if __name__ == "__main__":
    main()
