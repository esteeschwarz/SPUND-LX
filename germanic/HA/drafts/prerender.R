#docdir<-".."
qa<-c("Wie KI unsere Sprache","yakura-llm")

get.notes<-function(docdir){
  f<-list.files(docdir)
  m<-grep("docx",f)
  f[m]
  m<-m[2] # latest docx export
  library(officer)
#  f<-list.files()
 # m<-grep("docx",f)
  t<-read_docx(paste(docdir,f[m],sep="/"))
  #t[[7]]
  #library(xml2)
  d<-docx_summary(t)
  d
  
  get.qnotes<-function(q,d){
  #q<-"Wie KI unsere Sprache"
  # m<-grep("Wie KI unsere Sprache",d$text)
    m<-grep(q,d$text)
    h1<-d$style_name=="Heading 1"
  d$text[h1]
  #h1<-d$level==1 # wks only on tapee, different officer version?
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
#  p<-2
 # q<-qa[p]
  #x<-q
  notes<-lapply(qa,function(x){
    nx<-get.qnotes(x,d)
    nx<-data.frame(n=x,nx)
    
  })
  library(abind)
  notes<-data.frame(abind(notes,along = 1))
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

# notes<-lapply(qa,function(x){
  notes.df<-get.notes("..")
# 
#   })

  #notes[1:50]
#notes[39]
t2<-notes.df
notes<-notes.df
#x<-38
put.qmd<-function(t2){
  library(stringi)
#  t2<-t2[2:length(t2)]
  # tdf<-data.frame(paper=t2,id=1:length(t2),a=NA,t=NA)
  tdf<-data.frame(paper=t2$n,id=1:length(t2$n),a=NA,t=NA)
  a2<-lapply(seq_along(t2$nx), function(x){

  t<-t2$nx[x]
 # t
 # a<-stri_match(t,regex="([0-9]+)\\. (.+)( \\\\>\\\\>)")
  a<-stri_match(t,regex="(.*)(HYPERLINK.*>>)")
#  a<-stri_match(t,regex="(.*)")
 # a
  n<-x
  p<-t2$n[x]
  #cat("run",n,"\n")
  #print(length(a[2]))
  #print(a[2])
  #print(length(t))
  #print(t)
  t<-gsub("^\n","",t)
  #print(t)
  tdf$id[x]<-n
  #print(sum(is.na(a))==length(a))
  ifelse(sum(is.na(a))==length(a),tdf$a[n]<-t,tdf$a[n]<-a[2])
  #print("chk1")
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
#a2<-put.qmd(notes$nx)
a2<-put.qmd(notes)
#a2$t[1:10]
a2$t<-gsub("(http[s]*://.+)(?>[ \\\n])","[see linked source](\\1)",a2$t,perl = T)
write.csv(a2,"qa.csv")
#notes
#a2

get.slides<-function(a2){
#a3<-readLines("_slides.qmd")
#m<-grep("x-content",a3)
#a4<-c(a3,a2)
refs<-"# references{#references}"
# a4<-c(a3,a2,"",refs)
# a4<-c(a3,a2$t,"",refs)
# writeLines(a4,"slides.qmd")
a3<-readLines("_qa.qmd")
a4<-c(a3,a2$t,"",refs)
#writeLines(a4,"qa.qmd")
#writeLines(a3,"qa.qmd")
#cat("-------- written qa.qmd: ------\n")

### get notes from marginnote docx export
return(a3) # without slides included
}
a4<-get.slides(a2)
writeLines(a4,"qa.qmd")

#src<-"_abstractB-ul.md"
f<-list.files()
k<-2
m<-grep("-ul.md",f)
for(k in m){
src<-f[k]  

### correct ulysses md issues
t<-readLines(src)
#lines <- gsub("\\\\_", "_", t)
#lines <- gsub("(?={{)\\\\>", ">", lines,perl = T)
lines <- gsub("(?=\\\\)([>_])", "\\1du", t,perl = T)
#md<-tempfile(fileext = ".md")
#srcqmd<-paste0(src,".qmd")
#writeLines(lines,srcqmd)
writeLines(lines,src)
cat("-------- written md: ",src,"------\n")
}

