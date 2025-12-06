#docdir<-".."
get.notes<-function(docdir){
  f<-list.files(docdir)
  m<-grep("docx",f)
  library(officer)
#  f<-list.files()
 # m<-grep("docx",f)
  t<-read_docx(paste(docdir,f[m],sep="/"))
  #t[[7]]
  library(xml2)
  d<-docx_summary(t)
  m<-grep("reception pethes",d$text)
  h1<-d$style_name=="Heading 1"
  h1<-which(h1)
  hb<-m==h1
  hba<-which(hb)
  d$text[h1[hb]]
  hba<-h1[hb]
  hbb<-h1>m
  hbc<-h1[which(hbb)][1]-1
  d$text[hbc]
  notes<-d$text[hba:hbc]
  notes
  
}
# t<-readLines("qa.qmd")
# t<-readLines("notes.raw.md")
# t<-t[t!=""]
# t<-t[!grepl("reception penthes",t)]
# #m<-grep("2.",t)[1]
# #t2<-t[m:length(t)]
# #a<-strsplit(t[m:length(t)],"[0-9]+\\. ")
# #a<-strsplit(t,"[0-9]+\\. ")
# #strsplit(t[1],"[0-9]+\\.")
# stri_match(t,regex="([0-9]+)\\. (.+)( \\\\>\\\\>)")
# t2<-t
# a2<-lapply(a, function(x){
#   c("## ",x[2],"")
# })
notes<-get.notes("..")

#t2<-notes
#x<-2
put.qmd<-function(t2){
  library(stringi)
  t2<-t2[2:length(t2)]
  a2<-lapply(seq_along(t2), function(x){

  t<-t2[x]
  t
 # a<-stri_match(t,regex="([0-9]+)\\. (.+)( \\\\>\\\\>)")
  a<-stri_match(t,regex="(.*)(HYPERLINK.*)+")
  a
  n<-x
  ifelse(sum(is.na(a))==length(a),t<-c(t,""),t<-c(paste0("## ",n),a[2],""))
  a
  return(t)
  #t<-t
  #n<-a[2]
  
#  a<-strsplit(t,"[0-9]+\\. ")
  n<-paste0("## ",n)
  c(n,t,"")
})
a2<-unlist(a2)
}
a2<-put.qmd(notes)
#notes
#a2
a3<-readLines("_slides.qmd")
#m<-grep("x-content",a3)
#a4<-c(a3,a2)
refs<-"# references{#references}"
a4<-c(a3,a2,"",refs)
writeLines(a4,"slides.qmd")

### get notes from marginnote docx export



src<-"task001-ul.md"
### correct ulysses md issues
t<-readLines(src)
lines <- gsub("\\\\_", "_", t)
#md<-tempfile(fileext = ".md")
writeLines(lines,src)