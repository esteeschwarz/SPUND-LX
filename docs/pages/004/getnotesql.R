############################################
### get notes from sqlite
# qa<-list(litKI="Wiener_Einführung.pdf",
# nietzsche=c("nietzsche, kga 3-1, geburt d tragödie.pdf","nietzsche briefe ggl.pdf"),
# textur=c("2 - Behmenburg, Lena - Das Weben von Texten und Texturen.pdf","langlois-2019-distributed-intelligence-silk-weaving-and-the-jacquard-mechanism.pdf","07_Munk+Rosing.pdf")) # margin note studyset
source(paste0(Sys.getenv("GIT_TOP"),"/R-essais/scripts/marginnotesdb.R"))
margindb<-get.notes()
qa
dbsub<-margindb[margindb$doc%in%unlist(qa),]
names(qa)
qa
#dbsub<-margindb[margindb$doc%in%names(qa),]
margin_sf<-margindb
margindb<-list(qa=qa,dbsub=dbsub)
fi<-file.info("margindb.RData")
fs<-fi$size
fs
mt<-tempfile("mdb.RData")
save(margindb,file=mt)
fit<-file.info(mt)
fst<-fit$size
if(fst>fs)
  save(margindb,file="margindb.RData")

