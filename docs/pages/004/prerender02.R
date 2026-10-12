# check system, adapt output
s<-Sys.getenv("SYS")
mn4<-Sys.getenv("MN4")
mn4
qax<-list(litKI=c("Wiener_Einführung.pdf","Foerster_Ethik+und+Kybernetik+zweiter+Ordnung_m Kopie.pdf"),
nietzsche=c("nietzsche, kga 3-1, geburt d tragödie.pdf","nietzsche briefe ggl.pdf","Günther 2008, Der Wettkampf.pdf","Nietzsche, Homers Wettkampf, KGW III.2"),
textur=c("2 - Behmenburg, Lena - Das Weben von Texten und Texturen.pdf","langlois-2019-distributed-intelligence-silk-weaving-and-the-jacquard-mechanism.pdf","07_Munk+Rosing.pdf",
"3 - Julia Abel, Andreas Blödom, Michael Scheffel - Ambivalenz und Kohärenz, Einleitung.pdf"),
LXtech=c("Zinsmeister 2013.pdf","Frankowsky_2022.pdf")) # margin note studyset
#####################
get.qa<-function(){
#cloud<-"~/Library/Mobile Documents/iCloud~QReader~MarginStudy~easy/Documents/MN3/A_UNI/"
nietzsche<-"~/Library/Mobile Documents/iCloud~QReader~MarginStudy~easy/Documents/MN3/A_UNI/SZONDI/nietzsche"
nietzsche<-paste0(mn4,"/SZONDI/nietzsche")
  nietzsche
litKI<-paste0("~/Library/Mobile Documents/iCloud~QReader~MarginStudy~easy/Documents/MN3/A_UNI/SZONDI/lit-KI")
litKI<-paste0(mn4,"/SZONDI/lit-KI")
  
#stratling<-paste0(cloud,"SZONDI/strätling")
stratling<-"~/Library/Mobile Documents/iCloud~QReader~MarginStudy~easy/Documents/MN3/A_UNI/SZONDI/strätling"
stratling<-paste0(mn4,"/SZONDI/strätling")
#textur<-paste0(cloud,"SZONDI/textur")
  textur<-"~/Library/Mobile Documents/iCloud~QReader~MarginStudy~easy/Documents/MN3/A_UNI/SZONDI/textur"
  textur<-paste0(mn4,"/SZONDI/textur")
#LXtech<-paste0(cloud,"COMP/LX-tech")
#LFG<-paste0(cloud,"COMP/LFG")
LXtech<-"~/Library/Mobile Documents/iCloud~QReader~MarginStudy~easy/Documents/MN3/A_UNI/COMP/LX-tech"
  LXtech<-paste0(mn4,"/COMP/LX-tech")
  LFG<-"~/Library/Mobile Documents/iCloud~QReader~MarginStudy~easy/Documents/MN3/A_UNI/COMP/LFG"
  LFG<-paste0(mn4,"/COMP/LFG")
clist<-list(litKI=litKI,nietzsche=nietzsche,VSstr=stratling,textur=textur,LXtech=LXtech,LFG=LFG)
  clist
#  return(clist)
  #list.files(textur)
  #litKIb<-"~/Library/Mobile Documents/iCloud~QReader~MarginStudy~easy/Documents/MN3/A_UNI/SZONDI/lit-KI"
  #list.files("~/Library/Mobile Documents/iCloud~QReader~MarginStudy~easy/Documents/MN3/A_UNI/SZONDI/lit-KI")
  #list.files(textur)
#litKI
#litKIb
# c2<-lapply(clist,function(x){
#   n<-names(x)
#   print(x)
#   f<-c(list.files(x))
#   list.files(x)
# })
# list.files(LFG)
# list.files(textur)
# textur
# nietzsche
#   list.files(nietzsche)
#   c2
#   qa<-c2
#   setwd(paste0(Sys.getenv("GIT_TOP"),"/SPUND-LX/play/quarto/start"))
# #source("getnotesql.R")
#mnew<-smdb(clist)
### copy glossar
  go<-paste0(Sys.getenv("OBS_TOP"),"/UNI/GLOSSAR")
  f<-list.files(go,full.names=T,pattern=".md")

  gc<-paste0(Sys.getenv("GIT_TOP"),"/SPUND-LX/play/quarto/start/_ul-md/GLOSSAR/")
  #file.copy(f,gc,overwrite=T)
  # NO: obs snc self.


return(clist)
}
smdb<-function(qa){
  ############################################
### get notes from sqlite
# qa<-list(litKI="Wiener_Einführung.pdf",
# nietzsche=c("nietzsche, kga 3-1, geburt d tragödie.pdf","nietzsche briefe ggl.pdf"),
# textur=c("2 - Behmenburg, Lena - Das Weben von Texten und Texturen.pdf","langlois-2019-distributed-intelligence-silk-weaving-and-the-jacquard-mechanism.pdf","07_Munk+Rosing.pdf")) # margin note studyset
source(paste0(Sys.getenv("GIT_TOP"),"/SPUND-LX/scripts/marginnotesdb.R"))
#margindb<-get.notes(qa)
  qa
  #qax
margincp<-get.margin(qa)
margin1<-margincp$dbsub  
qa<-margincp$qa
  qa
dbsub<-margincp$dbsub
#dbsub<-margindb[margindb$doc%in%unlist(qa),]
names(qa)
qa
#dbsub<-margindb[margindb$doc%in%names(qa),]
margin_sf<-margincp
md<-list.files(pattern="margindb.RData")
saveanyway<-T
  

if(length(md)==0){
  margindb<-margincp
  save(margindb,file="margindb.RData")
  saveanyway<-T

}
margindb<-list(qa=qa,dbsub=dbsub)
dbnew<-margindb
getwd()
load("margindb.RData")
fi<-file.info("margindb.RData")
#fi<-file.info("margin1.RData")
fs<-fi$size
fs
mt<-tempfile("mdb.RData")
save(dbnew,file=mt)
#save(dbnew,file="~/db/margindbnew.RData")
fit<-file.info(mt)
fst<-fit$size
notes.old<-margindb$dbsub$notes
com.old<-margindb$dbsub$comment
docs.old<-margindb$dbsub$doc
notes.new<-dbnew$dbsub$notes
com.new<-dbnew$dbsub$comment
docs.new<-dbnew$dbsub$doc
mn<-notes.new%in%notes.old
mc<-com.new%in%com.old
md<-docs.new%in%docs.old
mold.n<-unique(notes.old)
mold.c<-unique(com.old)
#mold.c<-unique(com.old)
mold.d<-unique(docs.old)
mnew.nu<-unique(notes.new)
mnew.cu<-unique(com.new)
mnew.du<-unique(docs.new)
mnew.n<-unique(notes.new[!mn])
mnew.c<-unique(com.new[!mc])
mnew.d<-unique(docs.new[c(which(!mn),which(!mc))])
l1<-length(mold.n)
l2<-length(mold.c)
l3<-length(mold.d)
l12<-length(mnew.n)
l22<-length(mnew.c)
l32<-length(mnew.d)
mn2<-sum(!mn)>0
mc2<-sum(!mc)>0
md2<-sum(!md)>0
#sum(F,F,T)
p<-(sum(mn2,mc2,md2)>0)|(fst>fs)
cat("---- DB size olde:",fs,", new:",fst,"\n")
cat("---- sum notes-com-docs new !in old db:",sum(sum(!mn),sum(!mc),sum(!md)),"\n")

  if(p|saveanyway){
  save(margindb,file="margindb_sf.RData")

  margindb<-dbnew
  save(margindb,file="margindb.RData")
  cat("---- saved new annotations...\n")
  }
list.new<-list(margin.new<-list(doc=mnew.d,notes=mnew.n,com=mnew.c))
print(list.new)
return(list.new)
# save(margindb,file="margindb.RData")

#"Library/Containers/QReader.MarginStudy.easy/Data/Library/Private Documents/MN4NotebookDatabase/0/MarginNotes.sqlite"
}

### with notes from ids expo sqlite db
idb<-function(){
  library(RSQLite)
  d<-dbDriver("SQLite")
  d
  library(DBI)
  con<-dbConnect(d)
  con
#  dbsrc<-"/Users/guhl/Documents/temp/MarginNoteBackup(2025-02-01-13-53-27).marginbackupall"
 # dbsrc<-paste(dbsrc,"MarginNotes.sqlite",sep = "/")
  dborigin<-"/Users/guhl/Library/Containers/QReader.MarginStudy.easy/Data/Library/Private Documents/MN4NotebookDatabase/0/MarginNotes.sqlite"
  dborigin<-"/Users/guhl/Library/Containers/QReader.MarginStudy.easy/Data/Library/Private Documents/MN4NotebookDatabase/0"
  dborigin<-paste0(Sys.getenv("GIT_TOP"),"/SPUND-LX/play/quarto/start/margindb.sqlite")
  # f<-list.files(dborigin,pattern="MarginNotes.sqlite*",full.names=T)
  # f
  # dbcopy<-"~/db/MarginNotes.sqlite"
  # dbcopy<-"~/db/marginnotes/"
  # dbcopy<-"~/db/marginnotes/"
  # #file.copy(dborigin,dbcopy)
  # file.copy(f,dbcopy,overwrite=T)
  # #dbsrc<-paste0(dbcopy,"margin_notes.sqlite")    
  dbsrc<-dborigin
  #dbListTables(con <- dbConnect(RSQLite::SQLite(), ":memory:"))
  con<-dbConnect(d,dbsrc)
  #con<-dbConnect(d,"/Users/guhl/boxHKW/21S/DH/local/AVL/2024/WIT/2025-01-21_FolioFF.sqlite")
  #con<-dbConnect(d,"/Users/guhl/Documents/GitHub/SPUND-LX/szondi/WITprose/2025-01-23_FolioFF.sqlite3")
  #highlights<-dbGetQuery(con, "SELECT * FROM highlights")
  #highlights<-highlights[highlights$document_id==2,]
  #highlight_tags<-dbGetQuery(con, "SELECT * FROM highlight_tags")
  #global.t<-dbGetQuery(con,".schema")
  all.t<-dbGetQuery(con, "SELECT name FROM sqlite_master WHERE type='table';")
  all.t
  library(abind)
  all.tg <<- all.t
  all.tables<-lapply(seq_along(1:length(all.t$name)),function(i){
    t<-dbGetQuery(con,paste0("SELECT * FROM ",all.t$name[i],";"))

                  
  })
  names(all.tables)<-c("dbsub","index","docs")
  margin1<-all.tables$dbsub
  studies<-unique(all.tables$docs$study)
  qax<-lapply(studies,function(x){
    m<-margin1$study==x
    m<-grepl(x,margin1$study)
    sum(m,na.rm=T)
    m[is.na(m)]<-F
    d<-unique(margin1$doc[m])
    d<-d[!is.na(d)]
    d2<-d
    
    if(length(d2)>0)
      names(d2)<-x
    r<-list(q=d)
    print(x)
    #names(r)<-x
    return(d)

  })
  names(qax)<-studies
  all.tables$studies<-qax
  qax
  
    dbDisconnect(con)
  return(all.tables)

}
######################

outputdir<-ifelse (s=="mini12","/var/www/html/play/pages","../output/pages/004")
qaz<-c(litKI=NA,nietzsche=NA,textur=NA,LXtech=NA,VSstr=NA,LFG=NA)# margin note studyset
#ifelse (s%in%c("lapsi","tapee"),bqa<-get.qa(),qa<-qaz)
ifelse (s%in%c("lapsi","tapee"),bqa<-idb(),qa<-qaz)
mnew<-"no new annotations..."
if(exists("bqa")){
  print("sqlite loaded, qa + mnew declared...")
  qa<-bqa$studies
  mnew<-bqa$dbsub
  margindb<-list(dbsub=mnew,qa=qa)
  save(margindb,file="margindb.RData")
  
}
### vars
docdir<-"."


qa
#bibyml<-c("lit-ki","textur","nietzsche") # zotero folders
bibyml<-qa
########
#qa
print("------ prerender fin, > fetch-zotero.R")
source("fetch-zotero.R")
#cat("------------ NEW ANNOTATIONS:")
#print(mnew)
#source("annotations.R")

# list.files('/Users/guhl/Library/Mobile Documents/iCloud~QReader~MarginStudy~easy/Documents/MN3/A_UNI/SZONDI/textur')
# system("ls '/Users/guhl/Library/Mobile Documents/iCloud~QReader~MarginStudy~easy/Documents/MN3/A_UNI/SZONDI/textur'")
