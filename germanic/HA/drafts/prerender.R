#docdir<-".."
get.notes<-function(docdir){
  f<-list.files(docdir)
  m<-grep("docx",f)
  library(officer)
#  f<-list.files()
 # m<-grep("docx",f)
  t<-read_docx(paste(docdir,f[m],sep="/"))
  #t[[7]]
  #library(xml2)
  d<-docx_summary(t)
  d
  m<-grep("Wie KI unsere Sprache",d$text)
  h1<-d$style_name=="Heading 1"
  h1<-d$level==1
  h1<-which(h1)
  hb<-m==h1
  hba<-which(hb)
  d$text[h1[hb]]
  hba<-h1[hb]
  hbb<-h1>m
  hbc<-h1[which(hbb)][1]-1
  if(is.na(hbc))
     hbc<-length(d$doc_index)
  hbc
  d$text[hba:hbc]
  notes<-d$text[hba:hbc]
  notes<-notes[notes!=""]
  
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
notes[1:10]
#t2<-notes
#x<-2
put.qmd<-function(t2){
  library(stringi)
  t2<-t2[2:length(t2)]
  tdf<-data.frame(id=1:length(t2),a=NA,t=NA)
  a2<-lapply(seq_along(t2), function(x){

  t<-t2[x]
  t
 # a<-stri_match(t,regex="([0-9]+)\\. (.+)( \\\\>\\\\>)")
  a<-stri_match(t,regex="(.*)(HYPERLINK.*)+")
  a
  n<-x
  cat("run",n,"\n")
  print(length(a[2]))
  #print(a[2])
  print(length(t))
  #print(t)
  t<-gsub("^\n","",t)
  #print(t)
  tdf$id[x]<-n
  print(sum(is.na(a))==length(a))
  ifelse(sum(is.na(a))==length(a),tdf$a[n]<-t,tdf$a[n]<-a[2])
  print("chk1")
  ifelse(sum(is.na(a))==length(a),tdf$t[n]<-paste0(t,"\n"),tdf$t[n]<-paste0("## ",n,"\n",a[2],"\n"))
  a
  return(tdf[n,])
  #t<-t
  #n<-a[2]
  
#  a<-strsplit(t,"[0-9]+\\. ")
  n<-paste0("## ",n)
  c(n,t,"")
})
library(abind)
a3<-data.frame(abind(a2,along = 1))
}
notes
a2<-put.qmd(notes)
a2$t[1:10]
a2$t<-gsub("(http[s]*://.+)(?>[ \\\n])","[see linked source](\\1)",a2$t,perl = T)
write.csv(a2,"qa.csv")
#notes
#a2

get.slides<-function(){
a3<-readLines("_slides.qmd")
#m<-grep("x-content",a3)
#a4<-c(a3,a2)
refs<-"# references{#references}"
a4<-c(a3,a2,"",refs)
a4<-c(a3,a2$t,"",refs)
writeLines(a4,"slides.qmd")
a3<-readLines("_qa.qmd")
a4<-c(a3,a2$t,"",refs)
writeLines(a4,"qa.qmd")

### get notes from marginnote docx export

}

src<-"_abstractB-ul.md"
### correct ulysses md issues
t<-readLines(src)
lines <- gsub("\\\\_", "_", t)
#md<-tempfile(fileext = ".md")
srcqmd<-paste0(src,".qmd")
#writeLines(lines,srcqmd)
writeLines(lines,src)

cat("-------- written qmd: ",srcqmd,"------\n")

