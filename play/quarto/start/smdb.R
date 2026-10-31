
### to run on srv after copy sqlite backup
# t1: wks.
smdb<-function(){
  ############################################
### get notes from sqlite
# qa<-list(litKI="Wiener_Einführung.pdf",
# nietzsche=c("nietzsche, kga 3-1, geburt d tragödie.pdf","nietzsche briefe ggl.pdf"),
# textur=c("2 - Behmenburg, Lena - Das Weben von Texten und Texturen.pdf","langlois-2019-distributed-intelligence-silk-weaving-and-the-jacquard-mechanism.pdf","07_Munk+Rosing.pdf")) # margin note studyset
  setwd(paste0(Sys.getenv("GIT_TOP"),"/SPUND-LX/play/quarto/start"))
source(paste0(Sys.getenv("GIT_TOP"),"/SPUND-LX/scripts/marginnotesdb.R"))
#margindb<-get.notes(qa)
  qa<-get.clist()
#margin1<-get.margin(qa)
#save(margin1,file="margindb.RData")

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
#print(list.new)
return(list.new)
# save(margindb,file="margindb.RData")

#"Library/Containers/QReader.MarginStudy.easy/Data/Library/Private Documents/MN4NotebookDatabase/0/MarginNotes.sqlite"
}

getwd()
smdb()
