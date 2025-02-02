install.packages("qpdf")
# Create highlight annotation using qpdf
add_highlight <- function(pdf_path, x_start, y_start, x_end, y_end, output_path) {
  command <- paste(
    "qpdf --highlight-annotations=",
    x_start, ",", y_start, ",", x_end, ",", y_end,
    pdf_path, output_path
  )
  system(command)
}

# Example positions for highlighting (adjust based on your document)
x_start <- 100
x_end <- 300
y_start <- 200
y_end <- 220
output_path <- "path/to/your/highlighted_document.pdf"

add_highlight(pdf_path, x_start, y_start, x_end, y_end, output_path)

m<-grep("Gossip",dbnotes.s$doc)
we<-dbnotes.s[m,]
library(pdftools)

get.pdf.path<-function(){
mnfolder<-"/Users/guhl/Library/Mobile Documents/iCloud~QReader~MarginStudy~easy/Documents/MN3/"
q<-unique(we$doc)
q
q1<-q[1]
q1
pdf_dirs <- list.dirs(mnfolder)
print(pdf_dirs)
#script_dirs <- list.dirs("../work")
pdfs<-list()
extract_path <- function(p) {
pdf.p<-lapply(pdf_dirs, function(x,q){
  print(p)
  #print(x)
  pf<-list.files(x)
  print(pf)
  mp<-grep(p,pf)
#  print(p)
  if(length(mp)>0){
    print(mp)
  return(paste(x,p,sep = "/"))
  }
#  return(data.frame(folder=pf,no=mp))
})
  
}
q1<-q[2]
q1
ppdf<-extract_path(q1)
pdf.p<-unlist(ppdf)
}
pdf.p
pages<-we$spage[we$doc==q1]
p.pages<-pages[!is.na(pages)]
p.pages
library(pdftools)
pdf.p
pdf_length(pdf.p)
out.pdf.folder<-"/Users/guhl/boxHKW/21S/DH/local/AVL/2024/pdfann"
dir.create(out.pdf.folder)
pdf_split(pdf.p,out.pdf.folder)
p.m<-we$doc==q1
sum(p.m)
p.ns<-list.files(out.pdf.folder)
p.fns<-paste(out.pdf.folder,p.ns,sep = "/")
p<-1
python_script <- "/Users/guhl/Documents/GitHub/SPUND-LX/scripts/fitz-pdf.py"

#for(p in 1:length(which(p.m))){
  for(p in which(p.m)){
    #  out.pdf.ns<-paste(out.pdf.folder,"wolf-ann-",p,".pdf")
  sub<-we[p,]
  sudb<-dbnotes.s[10247,]
  sub
  p.pg<-as.double(we$spage[p])
  p.s<-ceiling(as.double(unlist(strsplit(we$xys[p],","))))
  p.s
  mode(p.s)
  p.e<-ceiling(as.double(unlist(strsplit(we$xye[p],","))))
  f.ns<-p.fns[p.pg]
  f.ns

  #  add_highlight(f.ns, p.s[1], p.s[2], p.e[1], p.e[2], f.ns)
  param<-c(python_script, f.ns, f.ns,p.s[1], p.s[2], p.e[1], p.e[2], p.pg)
  param
  pos<-c(xe=344,ye=355,xs=288,ys=272)
  pos2<-c(277.998,468.767,424.000,518.000) #p75, sternmull
  pos<-as.character(pos2)
  zend<-c(277.998902,468.767204)
  zstart<-c(424.000000,518.000000)
pos.s<-c(zend,zstart)
  pos.s<-strsplit(pos,"\\.")
  pos.s
  xs1<-pos.s[[3]][1]
  xs2<-pos.s[[3]][2]
  xe1<-pos.s[[4]][1]
  xe2<-pos.s[[4]][2]
  ys1<-pos.s[[1]][1]
  ys2<-pos.s[[2]][2]
  ye1<-pos.s[[2]][1]
  ye2<-pos.s[[1]][2]
  pos.a<-c(xs1,ys1,xe1,ye1,xs2,ys2,xe2,ye2)
  pos.a[is.na(pos.a)]<-000
  p.pg
  #rect<-c(120.1, 120.2, 130.3, 130.4)  # (x0, y0, x1, y1) coordinates
  #param<-list(python_script, f.ns, f.ns,p.s[1], p.s[2], p.e[1], p.e[2], p.pg)
  #param<-list(python_script, f.ns, f.ns,pos[1],pos[3],pos[2],pos[4], 1)
  pos.a
  param<-list(python_script, f.ns, f.ns,pos.a[1],pos.a[4],pos.a[3],pos.a[6], 1)
  #param<-list(python_script, f.ns, f.ns,0,0,20,100, 1)
  param
  print(rect)
  #param[2]<-"/Users/guhl/Documents/GitHub/SPUND-LX/play/14-wolf_handout.pdf"
  #param[3]<-"/Users/guhl/Documents/GitHub/SPUND-LX/play/14-wolf_handout.m.pdf"
  highlight_area("/Users/guhl/Documents/GitHub/SPUND-LX/play/14-wolf_handout.pdf", "/Users/guhl/Documents/GitHub/SPUND-LX/play/14-wolf_handout.m.pdf", 1, rect)
  
  if(sum(is.na(param))==0)
   # system2(paste0("python ",param[1]), args = param)
    system2("python", args = unlist(param))
  
#pdf_subset(pdf.p,pages=p,output = out.pdf.ns)


}
library(reticulate)
python_script <- "~/Documents/GitHub/SPUND-LX/scripts/fitz-pdf.py"
system2("python", args = c(python_script, f.ns, p.s[1],))
  # reticulate::py_install("PyMuPDF") # no, install with pip!
  # reticulate::py_list_packages()
  # 