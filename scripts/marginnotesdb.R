get.clist<-function(){
  mn4<-Sys.getenv("MN4")

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
  f<-list.files(dborigin,pattern="MarginNotes.sqlite*",full.names=T)
  f
  dbcopy<-"~/db/MarginNotes.sqlite"
  dbcopy<-"~/db/marginnotes/"
  #file.copy(dborigin,dbcopy)
  file.copy(f,dbcopy,overwrite=T)
  dbsrc<-paste0(dbcopy,"MarginNotes.sqlite")    
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
#########################
### 16274.still messy, includes complete pdf annotations if pdf in study
### 16297.wks: notes on pdf in multiple studies

get.margin<-function(qa){
  #clist<-get.clist()
  all.tables<-idb()
  #clist
  clist<-qa
  qa
  all.t<-all.tg
  library(dplyr)
  tabc<-lapply(seq_along(all.tables),function(i){
    print(i)
    x<-all.tables[[i]]
    head(x)
    if(length(x[,1])>0)
      x$table<-all.t$name[i]
    return(x)
  })
  tabd<-bind_rows(tabc)
  m<-colnames(tabd)=="table"
  tabd<-tabd[,c(which(m),which(!m))]


#h1<-head(tabd[!is.na(tabd$ZHIGHLIGHT_TEXT),],10)
h1<-tabd[!is.na(tabd$ZHIGHLIGHT_TEXT),]
#h2<-h1[!is.na(h1[,1:length(h1)]),]
mn<-!is.na(h1[,1:length(h1)])
sum(mn)
h3<-t(mn)
#mn
#m1<-h3[,1:length(h3)]==T
rowSums(mn)
s<-apply(mn,2,sum)
h4<-t(h1)
s2<-t(s)
s2
length(h1)
h5<-h1[,c(which(s2==length(h1[,1])))]
#View(h5)
t1<-h5$ZTOPICID
length(unique(t1)) # 853 topics
########################################
  #s3<-tabd[t1%in%tabd[,1:length(tabd)]]
t1
unique(tabd$table)
zbook<-tabd[tabd$table=="ZBOOK",]
colnames(zbook)
ztitle<-tabd[!is.na(tabd$ZTITLE),]
ztitles<-unique(ztitle$ZTITLE)
length(ztitles) # 4780
m<-ztitle$ZTITLE%in%names(clist)
sum(m)
cnote<-ztitle[m,]
  cnote
studies<-ztitle$ZTITLE[m]
studies
ctopicid<-cnote$ZTOPICID
  dim(tabd)
typeof(tabd)
#tabl<-lapply(tabd,unlist)
l1<-apply(tabd,2,function(i){length(unlist(i))})
m<-l1==dim(tabd)[1]
  sum(m)
td<-data.frame(tabd[,which(m)])
#mx<-ctopicid%in%td[,1:length(td)]
#dim(tm)
ctopicid
# mt<-lapply(ctopicid,function(x){

# mx<-apply(td,2,function(i){
#   m<-grep(x,i)
#   ifelse(length(m)!=0,m,F)
#   })
#   m<-unlist(mx)
#   ifelse(length(m)!=0,m,F)
# })
#dim(mx)
#mx
#mx[mx!=0]
#ts<-td[c(mx[mx!=0]),]
#tu<-unique(td$ZTITLE)
#tu
t5<-td[td$ZTOPICID%in%ctopicid,]
t5b<-td[td$ZCURRENTTOPICID%in%ctopicid,]
t5c<-tabd[td$ZTOPICID%in%ctopicid,]
t5d<-tabd[td$ZCURRENTTOPICID%in%ctopicid,]
  colnames(t5)
t6<-t5[!is.na(t5$ZHIGHLIGHT_TEXT)|!is.na(t5$ZNOTES_TEXT),]
t9<-t5[t5$table=="ZBOOKNOTE",]
books<-t5$ZBOOKMD5
length(unique(books))
t6<-td[td$ZBOOKMD5%in%unique(books)&td$ZTOPICID%in%ctopicid,]
t6<-td[td$ZBOOKMD5%in%unique(books),]

t6$study<-NA
# for (k in 1:length(cnote$ZTITLE)){
#   sid<-cnote$ZTOPICID[k]
#   m<-t6$ZTOPICID==sid
#   m[is.na(m)]<-F
#   t6$study[m]<-cnote$ZTITLE
# }
t6<-t6[!is.na(t6$ZBOOKMD),]
unique(t6$table)
  colnames(t6)
#t7<-td[td$table=="ZBOOK",]
t8<-td[td$ZBOOKMD5%in%unique(books)|td$Z%in%unique(books),]
colnames(t8)
m1<-lapply(td[,1:length(td)],function(x){
  m1<-grep(".pdf",x)
  #print(colnames(x))
#  print(m1)
  ifelse(length(m1)>0,p<-m1,p<-NA)
  return(p)
})
  ### wks.
# m2<-lapply(t6[,1:length(td)],function(x){
#   m1<-grep(".pdf",x)
#   #print(colnames(x))
#   print(m1)
#   ifelse(length(m1)>0,p<-m1,p<-NA)
#   return(p)
# })
m3<-!is.na(m1)
sum(m3)
m2<-m1[m3]
  m2
m4<-unique(unlist(m2))
length(m4)
t8<-td[m4,]
  unique(t8$table)
t9<-bind_rows(t6,t8)
cn<-colnames(t9)
sum(is.na(t9$study))==length(t9$study)
t9$study<-NA
cn<-colnames(t9)
k<-3 #litKI
for (k in 1:length(cnote$ZTITLE)){
  sid<-cnote$ZTOPICID[k]
  m<-t9$ZTOPICID==sid
  sum(m,na.rm=T)
  m[is.na(m)]<-F
  cnote$ZTITLE[k]
  t9$study[m]<-cnote$ZTITLE[k]
}
  colnames(cnote)
  cn
  cg<-grep("NOTE|HIGHLIGH|MD5|FILE|PATH|URL|TEXT|COMMENT|PAGE|TITLE|TAG|TOPIC|TIMESTAMP|table|study",cn)
  cg<-unique(cg)
  t10<-t9[,cg]
  sum(t10$study=="litKI",na.rm=T)
  ##########################################################
  t11<-t10[order(t10$ZTOPICID,t10$ZBOOKMD5,t10$ZSTARTPAGE),]
  s<-unique(t11$study)
  s<-s[!is.na(s)]
  s
  t11md5<-t11$ZBOOKMD5
  t11md5l<-t11$ZMD5LONG
  u1<-unique(t11md5l)
  u1
  md5u<-unique(t11md5)
  length(md5u)
  #x
#  t11<-t11[!is.na(t11$ZNOTEID),]
  pns<-lapply(md5u,function(x){

  mc<-lapply(t11[,1:length(t11)],function(c){
    #x%in%c
    m<-c%in%x
    #t11$ZBOOKMD5&t11$table=="ZBOOK"
    m[is.na(m)]<-F
    ifelse(sum(m)>0,p<-which(m),p<-NA)
    return(p)
    
  })
    mcc<-mc[!is.na(mc)]
#    mcc<-mc[unlist(mc)]
    mcc
  })
  colnames(t11)
  pns
  t11$doc<-NA
  k<-1
  #########################
  for (k in 1:length(pns)){
    md5<-pns[[k]]$ZMD5LONG
    d<-t11$ZFILE[md5]
    if(is.null(d))
      d<-""
    if(length(d)==0)
      d<-""
    # if(length(d)>1)
    #   print(d)
    d<-d[(!is.na(d))]
#    d<-unique(d)
    p<-pns[[k]]$ZBOOKMD5
    #m<-t11$ZBOOKMD5%in%p
    d
    if(length(p)>0&length(d)>0)
      t11$doc[p]<-d
  }
  ### wks.
  s<-studies
  s
  k<-s[3]
  k
  s
  colnames(t11)
  sum(t11$study=="litKI",na.rm=T)
  ##############
  ### debug stop
  ##############
  s
  k<-"litKI"
  k<-"textur"
  #################################################
  for(k in s){
    m<-t11$study==k
    m<-grepl(k,t11$study)
    sum(m,na.rm=T)
    m[is.na(m)]<-F
    d1<-unique(t11$doc[m])
    d1
    # all notes in all docs that appear in study
    m2<-t11$doc%in%d1
    sum(m2)
    # m3<-is.na(t11$study[m2])
    # sum(m3)
    # sum(!m3)
########################
    ### ensure book is in study
    t11b<-t11[m,]
    unique(t11b$doc)
    m4<-grepl("#notebook_",t11b$ZNOTES_TEXT)
    m5<-grep("#notebook_",t11b$ZNOTES_TEXT)

    length(m5)
    # if > 0 then theres a doc in study which has notes outside study
    #m4<-grepl("kook",t11$doc)
    #s1<-t11[m4,]
    m4[is.na(m4)]<-F
    sum(m4)
    t11b[m5,]
    doc.out<-unique(t11b$doc[m5])
    m6<-t11b$doc==doc.out
    sum(m6,na.rm=T)
    # kook: 4, meaning 4 relevant notes, rest to discard
    #t11[which(m4),]
    #if(sum(m4)==0){
   # s1
    m7<-which(m2)
    m7 # all notes
    da<-t11b$doc
    
    unique(da) # only docs in study
    dm<-da%in%doc.out
    sum(dm)
    da[dm]
    do<-which(dm)
    do
    do1<-do # position of relevant notes in study subset
    da<-t11$doc
    #da
    dm<-da%in%doc.out
    sum(dm)
    da[dm]
    do
    do2<-which(dm)
    do2 # all notes of doc including irrelevant
    length(do2)
    #do3<-do2%in%do1 # bullshit, cannot map from 2 diff indexes

    #sum(do3)
    m1<-is.na(t11$study)
    m2<-grepl(k,t11$study)
    d1
    sum(m1,m2)
    m1d<-unique(t11$doc[m1])
    m1d<-unique(t11$doc[c(which(m1),which(m2))])
    m1d
    d1
    m1e<-m1d%in%d1
    #m1e<-d1%in%m1d
    sum(m1e)
    m1f<-m1d[m1e]
    m1f<-m1f[m1f!=""]
    m1f<-m1f[!is.na(m1f)]
    m1f
    m1g<-m1f[!m1f%in%doc.out]
    m1g
    m1h<-t11$doc%in%m1g
    sum(m1h)
    # sum(m2c)
    m8<-which(m1h)
    m8

    #m9<-
    length(m8)
    #sum(m8)
    ### glitch
    unique(t11$study[m8])
    t12<-t11[m8,]
    t12$ZHIGHLIGHT_TEXT
    t12$doc
#    dsx<-t12[t12]
    #t11[m8,]
    m1i<-is.na(t12$study)
    m12<-!is.na(t12$study)
    m13<-t12$study[m12]!=k
    #m1i<-is.na(t12$study)
    sum(m1i)
    sum(m12)
    sum(m13)

    cat("--- reapplied",sum(m1i),"changes to study -",k,"- names according to books ---\n")
    t11$ZHIGHLIGHT_TEXT[m8][m1i]
    t11$doc[m8][m1i]
    t11$doc[m8][m12][m13]
    ps<-paste0(t11$study[m8][m12][m13],"|",k)
    ps
    ps2<-paste0(t11$study[m8][m1i],"|",k)
    ps2
    ps3<-t11$study[m8][m12][m13]
    ps3
    ps4<-unique(t11$study[m8][m1i])
    ps3<-paste(unique(ps3),collapse="|")
    ps3
    ps4<-unique(t11$study[m8][m1i])
    ps4[is.na(ps4)]<-ps3
    ps4
    ps4<-paste0(ps4,"|",k,"|",ps3)
    ps4
    ps
    # t11$study[m8][m1i]<-k
    t11$study[m8][m12][m13]<-ps
    t11$study[m8][m1i]<-k
    
     sum(t11$study==k,na.rm=T) #391
    length(grep("litKI",t11$study))
    k
    dsx<-t11[grep(k,t11$study),]
    dst<-dsx[grep("Calvino",dsx$doc),]
    dst<-dst[order(dst$ZNOTEID),]
    3+2
    #}
  }#x<-t11[,1]
  ######################################################################
    sum(t11$study=="litKI",na.rm=T) #355 after looping whole studies!
    length(grep("litKI",t11$study))
    length(grep("textur",t11$study)) #765
  debug<-T
  if(!debug){
    dsx<-t11[grep("litKI|textur",t11$study),]
    dsx[duplicated(dsx$ZHIGHLIGHT_DATE),]
    dst<-t11[grep("textur",t11$study),]
id<-"CCAA6353-3A42-4D28-93A8-DF035DD1539A"
    m<-dsx$ZNOTEID==id
    sum(m)

  }
  s
  cg
  cns<-colnames(t11)
  cns
  #c<-cns[1]
  t11l<-lapply(cns,function(c){
    x<-t11[,c]

    e<-x==""
    x[e]<-NA
    t<-sum(is.na(x))==length(x)
    ifelse(t,r<-NA,r<-data.frame(c=x))
   # print(c)
    if(!t)
      colnames(r)<-c
    return(r)
  })
  cat("--- t12 ---\n")
  t12<-t11l[!is.na(t11l)]
  t13<-data.frame(abind(t12,along=2))
  t14<-t13[!is.na(t13$doc),]
  mode(t14$ZSTARTPAGE)<-"numeric"
  mode(t14$ZENDPAGE)<-"numeric"
  t14<-t14[order(t14$doc,t14$ZSTARTPAGE,t14$ZENDPAGE),]
  sum(is.na(t14$ZNOTEID))
  sum(is.na(t14$study))
#  t14$study[is.na(t14$study)]<-""
  colnames(t14)
  cn<-c(27,28,15,14,21,22,23,24,1,2,3)
  margin1<-t14[,cn]
  cns<-c("study","doc","spage","epage","notes","comment","title","ocr","table","nid","tid")
  colnames(margin1)<-cns
  #docs<-unique(margin1$doc)
  #docs<-docs[!is.na(docs)]
  studies
  x<-studies[3]
  x
  unique(margin1$study)
  unique(margin1$doc[margin1$study=="litKI"])
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
  qax
  xx<-"litKI"
  length(grep(xx,margin1$study))
  sum(is.na(margin1$study))
  unique(margin1$doc[is.na(margin1$study)])
  margin2<-margin1[!is.na(margin1$study),]
  unique(margin2$doc[is.na(margin2$study)])
  #margin1$study[is.na(margin1$study)]<-""
  m<-margin2$study=="litKI"
  unique(margin2$doc[m])
  margindb<-list(qa=qax,dbsub=margin2)
  return(margindb)
#################
  qa<-get.clist()
  qa
  qax
  marginx<-get.margin(qa)
margin1<-ds
  ds<-marginx$dbsub
  sum(is.na(ds$study))
  d1<-ds[grep("litKI",ds$study),]
  ds[ds$nid=="0DD212B7-EF16-4242-809E-766305ED590D",]
  ds[grepl("Calvino",ds$doc)&ds$spage=="3",]
  unique(margin2$doc[margin2$study=="litKI"])
  unique(d1$doc)
  t11$ZMD5LONG[is.na(t11$ZMD5LONG)]<-F
  px<-t11[mcc$ZMD5LONG,]
  x<-md5u[3]
  x<-c("a","b","c")
  xa<-list(names=x)
  names(xa)<-"to"
  xa
  m<-x==t11$ZBOOKMD5
  m[is.na(m)]<-F
  tm5<-t11[m,]
  sum(m)
  pns
t9$ZBOOK
pdfs<-unique(t6$ZBOOKURL)
pdfs
  m<-tu=="LFG"
which(m)
t3<-ts[!is.na(ts$ZTITLE),]
t3<-t3[,!is.na(t3[,1:length(t3)])]
t3
qa<-get.clist()
margin1<-get.margin(qa)
  getwd()
#margin2<-margin1
save(margin1,file="margin1.RData")
load("margindb.RData")
names(margindb)
  dbsub<-margindb$dbsub
m<-grep("kook",dbsub$doc)
  dbsub$notes[m]
length(m)
}
