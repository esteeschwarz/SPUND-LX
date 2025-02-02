import fitz  # PyMuPDF
import sys

def highlight_area(pdf_path, output_path, page_number, rect):
    doc = fitz.open(pdf_path)
    page = doc.load_page(page_number-1)  # page_number is 1-based
    highlight = page.add_highlight_annot(rect)
    highlight.update()
    doc.save(output_path)

def main(arg1, arg2):
    print(f"Argument 1: {arg1}")
    print(f"Argument 2: {arg2}")

if __name__ == "__main__":
    arg1 = sys.argv[1] #in
    arg2 = sys.argv[2] #out
    pos = sys.argv[3]
    arg3 = float(sys.argv[3]) #xs
    arg4 = float(sys.argv[4]) #ys
    arg5 = float(sys.argv[5]) #xe
    arg6 = float(sys.argv[6]) #ye
    arg7 = int(sys.argv[7]) #pg # always 1
    outfile = arg2+"m.pdf"
    print(outfile)
    rect = fitz.Rect(arg3, arg4, arg5, arg6)  # (x0, y0, x1, y1) coordinates
   # rect = fitz.Rect(pos)
    print(rect)
    #print(f"Arguments: {sys.argv}")
    highlight_area(arg1, outfile, 1, rect)
    print("success...")
#pdf_path = arg1
#output_path = arg2
#page_number = 1  # Page number to highlight (1-based)

#highlight_area(pdf_path, output_path, page_number, rect)
