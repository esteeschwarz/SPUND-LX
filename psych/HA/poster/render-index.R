library(rmarkdown)
mdns<-"index"
wdr<-paste0(Sys.getenv("GIT_TOP"),"/SPUND-LX/psych/HA/poster/")
wdr
mdns<-paste0(wdr,mdns)
render(paste0(mdns,".Rmd"),output_format = "bookdown::html_document2")
md<-readLines(paste0(mdns,".md"))
md
m<-md=="---"
mw<-which(m)
md<-md[(mw[3]+2):length(md)]
md
mdout.ns<-paste0(wdr,"poster.md")
mdout.ns
img.repl<-function(md){
  m<-grep("<img src",md)
  md[m]<-gsub('(<img src=")(.+)(".+/>)',"![](https://github.com/esteeschwarz/SPUND-LX/raw/main/psych/HA/poster/\\2)",md[m])
  return(md)
}
md2<-img.repl(md)
md2
#writeLines(md,mdns)
writeLines(md2,mdout.ns)
m2<-md=="----"
m2<-which(m2)
m2<-c(1,m2)
i<-2
chars<-lapply(seq_along(m2), function(i){
  p0<-m2[i]
  ifelse(i!=length(m2),p1<-m2[i+1],p1<-length(md))
  t<-md[p0:p1]
  chars<-strsplit(t,"")
  chars.n<-length(unlist(chars))
})
chars
n_obs
