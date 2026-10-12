setwd(paste0(Sys.getenv("GIT_TOP"),"/SPUND-LX/play/quarto/start"))
source("prerender02.R")


dep1<-function(){
  dborigin<-"/Users/guhl/Library/Containers/QReader.MarginStudy.easy/Data/Library/Private Documents/MN4NotebookDatabase/0"
  f<-list.files(dborigin,pattern="MarginNotes.sqlite*",full.names=T)
  f
  dbcopy<-"~/db/MarginNotes.sqlite"
  dbcopy<-"~/db/idsdb/"
  dir.create(dbcopy)
  #file.copy(dborigin,dbcopy)
  f
  file.copy(f,dbcopy,overwrite=T)
  
  getwd()
  
  setwd("~/Documents/GitHub/SPUND-LX/play/quarto/start/")
  load("margindb.RData")
  q<-"LFG"
  unique(margindb$dbsub$study)
  ds<-margindb$dbsub
  #ds<-margin1
  unique(ds$study)
  ds2<-ds[grepl("litKI",ds$study),]
  sum(is.na(ds2$study))
  unique(ds2$doc)
  #?open
  #?edit
  # open(file=paste0(Sys.getenv("GIT_TOP"),"/R-essais/scripts/marginnotesdb.R"))
  #unique(cnote$ZCURRENTTOPICID)
   #length(unique(tabd$ZTOPICID))
  #length(unique(tabd$ZCURRENTTOPICID))
  dx<-ds2[grep("Calvino",ds2$doc),]

  dbsub<-read.csv(paste0(Sys.getenv("GIT_TOP"),"/temp/margin_notes.csv"))
  ds3<-dbsub
  dx2<-ds3[grep("Calvino",ds3$doc),]

  ### random walk
  rw<-lapply(td,function(x){
    m<-is.na(x)
    print(sum(m),na.rm=T)
    d<-x[!m]
    cat("--- length ---\n")
    print(l<-length(d))
    sl<-20
    if(l<sl)
      return(NA)
    s<-sample(length(d),sl)
    s<-d[s]
  })
  library(abind)
  rw<-rw[!is.na(rw)]
  d<-data.frame(abind(rw,along=2))
  length(unique(td$ZEVERNOTEID))
  length(unique(td$ZTOPICID))
 length(unique(td$ZCURRENTTOPICID))
length(unique(td$ZTITLE))
  tid<-unique(td$ZTOPICID)
  z<-unique(td$ZTITLE)
ss<-margindb$dbsub[margindb$dbsub$study=="nietzsche",]
  ss$notes[!is.na(ss$notes)]
  unique(ss$doc)
  ss$notes[ss$doc[grep("genealogie",ss$doc)]]
  m<-grepl("genealogie",ss$doc)
  sum(m)
  ss$notes[m]
  margindb$qa
}

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
  dborigin<-paste0(Sys.getenv("GIT_TOP"),"/temp/margin_notes.sqlite")
  f<-list.files(dborigin,pattern="MarginNotes.sqlite*",full.names=T)
  f
  dbcopy<-"~/db/MarginNotes.sqlite"
  dbcopy<-"~/db/marginnotes/"
  dbcopy<-"~/db/marginnotes/"
  #file.copy(dborigin,dbcopy)
  file.copy(f,dbcopy,overwrite=T)
  #dbsrc<-paste0(dbcopy,"margin_notes.sqlite")    
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
    dbDisconnect(con)
  return(all.tables)

}