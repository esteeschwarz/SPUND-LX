# check system, adapt output
s<-Sys.getenv("SYS")
qa<-list(litKI=c("Wiener_Einführung.pdf","Foerster_Ethik+und+Kybernetik+zweiter+Ordnung_m Kopie.pdf"),
nietzsche=c("nietzsche, kga 3-1, geburt d tragödie.pdf","nietzsche briefe ggl.pdf","Günther 2008, Der Wettkampf.pdf","Nietzsche, Homers Wettkampf, KGW III.2"),
textur=c("2 - Behmenburg, Lena - Das Weben von Texten und Texturen.pdf","langlois-2019-distributed-intelligence-silk-weaving-and-the-jacquard-mechanism.pdf","07_Munk+Rosing.pdf",
"3 - Julia Abel, Andreas Blödom, Michael Scheffel - Ambivalenz und Kohärenz, Einleitung.pdf"),
LXtech=c("Zinsmeister 2013.pdf","Frankowsky_2022.pdf")) # margin note studyset  
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
clist<-list(litKI=litKI,nietzsche=nietzsche,stratling=stratling,textur=textur,LXtech=LXtech,LFG=LFG)
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
source("getnotesql.R")
return(qa)
}
outputdir<-ifelse (s=="mini12","/var/www/html/play/pages","../output/pages/004")
qa<-c(litKI="wiener_kybernetik_1992",nietzsche=c("nietzsche_kga_2024"),textur=NA,LXtech=NA)# margin note studyset
ifelse (s%in%c("lapsi"),qa<-buildmdb(),qa<-qa)

### vars
docdir<-"."


qa
#bibyml<-c("lit-ki","textur","nietzsche") # zotero folders
bibyml<-qa
########
#qa
source("fetch-zotero.R")
#source("annotations.R")
