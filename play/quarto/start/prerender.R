# check system, adapt output
s<-Sys.getenv("SYS")
qa<-list(litKI=c("Wiener_Einführung.pdf","Foerster_Ethik+und+Kybernetik+zweiter+Ordnung_m Kopie.pdf"),
nietzsche=c("nietzsche, kga 3-1, geburt d tragödie.pdf","nietzsche briefe ggl.pdf","Günther 2008, Der Wettkampf.pdf","Nietzsche, Homers Wettkampf, KGW III.2"),
textur=c("2 - Behmenburg, Lena - Das Weben von Texten und Texturen.pdf","langlois-2019-distributed-intelligence-silk-weaving-and-the-jacquard-mechanism.pdf","07_Munk+Rosing.pdf",
"3 - Julia Abel, Andreas Blödom, Michael Scheffel - Ambivalenz und Kohärenz, Einleitung.pdf")) # margin note studyset  
buildmdb<-function(){
setwd(paste0(Sys.getenv("GIT_TOP"),"/SPUND-LX/play/quarto/start"))
source("getnotesql.R")
}
outputdir<-ifelse (s=="mini12","/var/www/html/play/pages","../output/pages/004")
ifelse (s%in%c("lapsi"),buildmdb(),F)

### vars
docdir<-"."
qa<-c(litKI="wiener_kybernetik_1992",nietzsche=c("nietzsche_kga_2024"),textur=NA,LXtech=NA)# margin note studyset


qa
#bibyml<-c("lit-ki","textur","nietzsche") # zotero folders
bibyml<-qa
########
qa
source("fetch-zotero.R")
#source("annotations.R")
