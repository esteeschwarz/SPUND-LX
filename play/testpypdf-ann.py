import fitz  # PyMuPDF

def highlight_area(pdf_path, output_path, page_number, rect):
    doc = fitz.open(pdf_path)
    page = doc.load_page(page_number - 1)  # page_number is 1-based
    highlight = page.add_highlight_annot(rect)
    highlight.update()
    doc.save(output_path)

pdf_path = 'path/to/your/input.pdf'
output_path = 'path/to/your/output.pdf'
page_number = 1  # Page number to highlight (1-based)
rect = fitz.Rect(100.1, 100.2, 120.3, 120.4)  # (x0, y0, x1, y1) coordinates
print(rect)
highlight_area("/Users/guhl/Documents/GitHub/SPUND-LX/play/14-wolf_handout.pdf", "/Users/guhl/Documents/GitHub/SPUND-LX/play/14-wolf_handout.m.pdf", 1, rect)
