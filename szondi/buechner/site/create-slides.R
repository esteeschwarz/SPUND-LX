t<-readLines("qa.qmd")
t<-readLines("notes.raw.md")
t<-t[t!=""]
t<-t[!grepl("reception penthes",t)]
#m<-grep("2.",t)[1]
#t2<-t[m:length(t)]
#a<-strsplit(t[m:length(t)],"[0-9]+\\. ")
#a<-strsplit(t,"[0-9]+\\. ")
#strsplit(t[1],"[0-9]+\\.")
library(stringi)
stri_match(t,regex="([0-9]+)\\. (.+)( \\\\>\\\\>)")
t2<-t
# a2<-lapply(a, function(x){
#   c("## ",x[2],"")
# })
a2<-lapply(seq_along(t2), function(x){
  
  t<-t2[x]
  a<-stri_match(t,regex="([0-9]+)\\. (.+)( \\\\>\\\\>)")
  n<-a[2]
  t<-a[3]
#  a<-strsplit(t,"[0-9]+\\. ")
  n<-paste0("## ",n)
  c(n,t,"")
})
a2<-unlist(a2)
a3<-readLines("_slides.qmd")
m<-grep("x-content",a3)
#a4<-c(a3,a2)
a4<-c(a3,a2)
writeLines(a4,"slides.qmd")
