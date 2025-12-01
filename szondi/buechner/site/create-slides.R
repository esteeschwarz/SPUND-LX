t<-readLines("qa.qmd")
m<-grep("2.",t)
t2<-t[m:length(t)]
a<-strsplit(t[m:length(t)],"[0-9]+\\. ")
a2<-lapply(a, function(x){
  c("## ",x[2],"")
})
a2<-lapply(t2, function(x){
  c("## ",x,"")
})
a2<-unlist(a2)
a3<-readLines("_slides.qmd")
m<-grep("x-content",a3)
#a4<-c(a3,a2)
a4<-c(a3,a2)
writeLines(a4,"slides.qmd")
