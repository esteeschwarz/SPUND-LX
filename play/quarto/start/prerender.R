# check system, adapt output
s<-Sys.getenv("SYS")
qax<-list(litKI=c("Wiener_Einführung.pdf","Foerster_Ethik+und+Kybernetik+zweiter+Ordnung_m Kopie.pdf"),
nietzsche=c("nietzsche, kga 3-1, geburt d tragödie.pdf","nietzsche briefe ggl.pdf","Günther 2008, Der Wettkampf.pdf","Nietzsche, Homers Wettkampf, KGW III.2"),
textur=c("2 - Behmenburg, Lena - Das Weben von Texten und Texturen.pdf","langlois-2019-distributed-intelligence-silk-weaving-and-the-jacquard-mechanism.pdf","07_Munk+Rosing.pdf",
"3 - Julia Abel, Andreas Blödom, Michael Scheffel - Ambivalenz und Kohärenz, Einleitung.pdf"),
LXtech=c("Zinsmeister 2013.pdf","Frankowsky_2022.pdf")) # margin note studyset
#####################
buildmdb<-function(){
cloud<-"~/Library/Mobile Documents/iCloud~QReader~MarginStudy~easy/Documents/MN3/A_UNI/"
nietzsche<-"~/Library/Mobile Documents/iCloud~QReader~MarginStudy~easy/Documents/MN3/A_UNI/SZONDI/nietzsche"
litKI<-paste0(cloud,"SZONDI/lit-KI")
stratling<-paste0(cloud,"SZONDI/strätling")
stratling<-"~/Library/Mobile Documents/iCloud~QReader~MarginStudy~easy/Documents/MN3/A_UNI/SZONDI/strätling"
textur<-paste0(cloud,"SZONDI/textur")
  textur<-"~/Library/Mobile Documents/iCloud~QReader~MarginStudy~easy/Documents/MN3/A_UNI/SZONDI/textur"
LXtech<-paste0(cloud,"COMP/LX-tech")
LFG<-paste0(cloud,"COMP/LFG")
LXtech<-"~/Library/Mobile Documents/iCloud~QReader~MarginStudy~easy/Documents/MN3/A_UNI/COMP/LX-tech"
  LFG<-"~/Library/Mobile Documents/iCloud~QReader~MarginStudy~easy/Documents/MN3/A_UNI/COMP/LFG"
clist<-list(litKI=litKI,nietzsche=nietzsche,VSstr=stratling,textur=textur,LXtech=LXtech,LFG=LFG)
  clist
  #list.files(textur)
  #litKIb<-"~/Library/Mobile Documents/iCloud~QReader~MarginStudy~easy/Documents/MN3/A_UNI/SZONDI/lit-KI"
  #list.files("~/Library/Mobile Documents/iCloud~QReader~MarginStudy~easy/Documents/MN3/A_UNI/SZONDI/lit-KI")
  #list.files(textur)
#litKI
#litKIb
c2<-lapply(clist,function(x){
  n<-names(x)
  print(x)
  f<-c(list.files(x))
  list.files(x)
})

  c2
  qa<-c2
  setwd(paste0(Sys.getenv("GIT_TOP"),"/SPUND-LX/play/quarto/start"))
#source("getnotesql.R")
smdb(qa)
return(qa)
}
smdb<-function(qa){
  ############################################
### get notes from sqlite
# qa<-list(litKI="Wiener_Einführung.pdf",
# nietzsche=c("nietzsche, kga 3-1, geburt d tragödie.pdf","nietzsche briefe ggl.pdf"),
# textur=c("2 - Behmenburg, Lena - Das Weben von Texten und Texturen.pdf","langlois-2019-distributed-intelligence-silk-weaving-and-the-jacquard-mechanism.pdf","07_Munk+Rosing.pdf")) # margin note studyset
source(paste0(Sys.getenv("GIT_TOP"),"/R-essais/scripts/marginnotesdb.R"))
margindb<-get.notes(qa)
qa
dbsub<-margindb[margindb$doc%in%unlist(qa),]
names(qa)
qa
#dbsub<-margindb[margindb$doc%in%names(qa),]
margin_sf<-margindb
margindb<-list(qa=qa,dbsub=dbsub)
save(margindb,file="margindb.RData")


}
outputdir<-ifelse (s=="mini12","/var/www/html/play/pages","../output/pages/004")
qaz<-c(litKI=NA,nietzsche=NA,textur=NA,LXtech=NA,VSstr=NA,LFG=NA)# margin note studyset
ifelse (s%in%c("lapsi"),qa<-buildmdb(),qa<-qaz)

### vars
docdir<-"."


qa
#bibyml<-c("lit-ki","textur","nietzsche") # zotero folders
bibyml<-qa
########
#qa
print("------ prerender fin, > fetch-zotero.R")
source("fetch-zotero.R")
#source("annotations.R")
