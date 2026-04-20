# check system, adapt output
s<-Sys.getenv("SYS")
buildmdb<-function(){
qa<-list(litKI="Wiener_Einführung.pdf",
nietzsche=c("nietzsche, kga 3-1, geburt d tragödie.pdf","nietzsche briefe ggl.pdf"),
textur=c("2 - Behmenburg, Lena - Das Weben von Texten und Texturen.pdf","langlois-2019-distributed-intelligence-silk-weaving-and-the-jacquard-mechanism.pdf","07_Munk+Rosing.pdf")) # margin note studyset  
source("getnotesql.R")
}
outputdir<-ifelse (s=="mini12","/var/www/html/play/pages","../output/pages/004")
ifelse (s%in%c("lapsi","tapee"),buildmdb(),F)

### vars
docdir<-"."
qa<-c(litKI="wiener_kybernetik_1992",nietzsche=c("nietzsche_kga_2024"),textur=NA) # margin note studyset


qa
#bibyml<-c("lit-ki","textur","nietzsche") # zotero folders
bibyml<-qa
########
qa
source("fetch-zotero.R")
#source("annotations.R")
