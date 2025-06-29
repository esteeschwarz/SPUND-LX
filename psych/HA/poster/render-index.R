library(rmarkdown)
mdns<-"index"
render(paste0(mdns,".Rmd"),output_format = "bookdown::html_document2")
md<-readLines(paste0(mdns,".md"))
md
m<-md=="---"
mw<-which(m)
md<-md[(mw[3]+2):length(md)]
md
mdout.ns<-"poster.md"
writeLines(md,mdout.ns)
