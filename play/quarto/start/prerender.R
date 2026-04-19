# check system, adapt output
s<-Sys.getenv("SYS")
outputdir<-ifelse (s=="mini12","/var/www/html/play/pages","../output/pages/004")

### vars
docdir<-"."
qa<-c(litKI="wiener_kybernetik_1992",nietzsche="nietzsche_kga_2024",textur=NA) # margin note studyset
#bibyml<-c("lit-ki","textur","nietzsche") # zotero folders
bibyml<-qa
########
qa
source("fetch-zotero.R")
source("annotations.R")
