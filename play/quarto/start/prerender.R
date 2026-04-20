# check system, adapt output
s<-Sys.getenv("SYS")
buildmdb<-function(){
  qa<-c(litKI="Wiener_Einführung.pdf",nietzsche=c("nietzsche, kga 3-1, geburt d tragödie.pdf","nietzsche briefe ggl.pdf"),textur=NA) # margin note studyset
  source("getnotesql.R")
}
outputdir<-ifelse (s=="mini12","/var/www/html/play/pages","../output/pages/004")
ifelse (s=="mini12",F,buildmdb())

### vars
docdir<-"."
qa<-c(litKI="wiener_kybernetik_1992",nietzsche=c("nietzsche_kga_2024","nietzsche_friedrich_1902"),textur=NA) # margin note studyset


qa
#bibyml<-c("lit-ki","textur","nietzsche") # zotero folders
bibyml<-qa
########
qa
source("fetch-zotero.R")
source("annotations.R")
