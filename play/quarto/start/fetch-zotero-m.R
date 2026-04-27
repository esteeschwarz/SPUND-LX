#fetch zotero .bib online
library(httr)
library(bib2df)
#tag<-"dcl"
# bibyml<-c("lit-ki","textur","nietzsche")

#setwd(".")
getwd()
share <- runif(1)
offset<-function(){
  qa<-list(IDS=NA)
  bibyml<-names(qa[1])
}
#response<-GET("https://api.zotero.org/groups/4713246/collections/9LNRRJQN/items/top?format=bibtex")
#response<-GET("https://api.zotero.org/groups/4713246/items?format=bibtex&limit=499")
#response<-GET("https://api.zotero.org/groups/4713246/items?format=json&limit=499")
response<-GET("https://api.zotero.org/groups/6526786/collections?format=json&limit=499")
# bib<-httr::content(response,"text")
bibjs<-httr::content(response,"text")
y<-tempfile("ref",fileext = ".bib")
#y<-"zotero.bib"
###################
writeLines(bibjs,y)
# bibt<-readLines(y)
####################
# t<-Sys.time()
# #tf<-format(t,"%a %b %d %Y (%H.%M)")
# tf<-format(t,"%Y%m%d(%H.%M)")
#print(parameters$bibliography)
library(jsonlite)
bibdf<-fromJSON(y,flatten=T)
##########################
get.bib<-function(bibyml){
bibkey<-bibdf$key[grep(bibyml,bibdf$data.name)]

bibyml<-paste0(bibyml,".bib")
#################################################
response<-GET(paste0("https://api.zotero.org/groups/6526786/collections/",bibkey,"/items?format=json&limit=499"))
#response<-GET(paste0("https://api.zotero.org/groups/6526786/collections/",bibkey,"/collections?format=json&limit=499"))
#response
  response.bib<-GET(paste0("https://api.zotero.org/groups/6526786/collections/",bibkey,"/items?format=bibtex&limit=499"))
# bib<-httr::content(response,"text")
bibjs<-httr::content(response,"text")
writeLines(bibjs,y)
bib.col.df<-fromJSON(y,flatten=T)
bibdf<-fromJSON(y,flatten=T)
bibkeys<-bibdf$key
bibdf$data.name
bib.items<-lapply(bibkeys,function(x){
print(x)
response<-GET(paste0("https://api.zotero.org/groups/6526786/collections/",x,"/items?format=json&limit=499"))
bibjs<-httr::content(response,"text")
writeLines(bibjs,y)
bib.col.df<-fromJSON(y,flatten=T)
bibdf<-fromJSON(y,flatten=T)
})

il<-list()
x1<-bib.items[[7]]
x2<-bib.items[[8]]
co<-colnames(x1)[!colnames(x1)%in%colnames(x2)]
co<-c("data.blogTitle","data.ISSN")
  l.items<-lapply(bib.items,function(x){
print(dim(x))
if(is.null(dim(x)))
    return(NA)
 df<-data.frame(x)   
#print(df)
m<-colnames(df)%in%co
cm<-which(!m)
print(cm)
cm<-c(cm)
#print(colnames(df)[cm])
df<-df[,cm]
apply(x1,MARGIN=2,FUN=mode)
typeof(x1[,1:2])
#print(colnames(df))
  print(typeof(df$data.tags))
  m<-typeof(df[,1:length(df)])=="list"
  print(sum(m))
  print(length(m))
    print(apply(df,MARGIN=2,FUN=mode))

df[,m] <- lapply(df[,m], function(x) {
  paste0(as.character(unlist(x)), collapse = ",")
})
    return(df)
  
lr<-data.frame(abind(l.items[!is.na(l.items)],along=1))
m<-which(is.na(x$parentItem))
print(length(m))
ifelse(length(m)==0,return(F),T)
u<-x[m,]
urls<-lapply(1:length(m),function(i){
u$data.url[i]
})
title<-lapply(m,function(i){
u$data.title[i]
})

name<-lapply(m,function(i){
u$data.websiteTitle[i]
})
abstract<-lapply(m,function(i){
u$data.abstractNote[i]
})
mdate<-lapply(m,function(i){
u$data.dateAdded[i]
})
idate<-lapply(m,function(i){
u$data.date[i]
})
extra<-lapply(m,function(i){
u$data.extra[i]
})
return(list(urls,name,title,abstract,mdate,idate,extra))  
  })
  
library(abind)
df.items<-abind(l.items,along=0)
response<-GET(paste0("https://api.zotero.org/groups/6526786/collections/",bibkey,"/collections?format=json&limit=499"))
#bibtx.cpt<-httr::content(response.bib,"text")
#bibtx.cpt
#y<-tempfile("ref",fileext = ".bib")
#y<-"zotero.bib"
###################
writeLines(bibjs,y)
# bibt<-readLines(y)
####################
# t<-Sys.time()
# #tf<-format(t,"%a %b %d %Y (%H.%M)")
# tf<-format(t,"%Y%m%d(%H.%M)")
#print(parameters$bibliography)
#library(jsonlite)
bibdf<-fromJSON(y,flatten=T)
#library(bib2df)
#bibdf<-bib2df(y)
#print(bibdf[[1]])
# m<-bibdf$KEYWORDS=="dcl"
# m<-tag%in%bibdf$data.tags
# m
# m<-m[!is.na(m)]
# dcl<-bibdf[which(m),]
# #dcl<-list(dcl)
# dcl<-data.frame(dcl)
# dcl
m<-grep("^data\\.",colnames(bibdf))
names(bibdf)[m]
#library(abind)
#bdf<-data.frame(abind(bibdf[m],along=0))
bdf<-bibdf[,m]
bdf$data.note
m2<-which(!is.na(bdf$data.note))
bdf$anno<-NA
#m2
for (k in m2){
  ak<-bdf$data.parentItem[k]
 # print(ak)
  note<-bdf$data.note[k]
  m<-bdf$data.key==ak
  if(note!="")
    bdf$anno[m]<-bdf$data.note[k]
}
m3<-which(!is.na(bdf$data.archive))
bdf$archive<-NA
k<-1
for (k in m3){
  ak<-bdf$data.archive[k]
  print(ak)
  arc<-bdf$data.archive[k]
  #m<-bdf$data.key==ak
  if(arc!="")
    bdf$archive[k]<-bdf$data.archive[k]
}
  
#print(bdf$data.title)
# bdf$anno
#print(bdf$data.tags)
tag<-"ai"
front<-F
if(front){
m<-lapply(bdf$data.tags,function(x){tag%in%unlist(x)&"front"%in%unlist(x)})
sum(unlist(m))
which(unlist(m))
m<-which(unlist(m))
# bdf$data.title[m]
#cat(as.character(bdf$anno[m]))
# bdf
bdf.tag<-bdf[m,]
colnames(bdf.tag)<-gsub("^data\\.","",colnames(bdf.tag))
#b<-bibdf
colnames(bdf.tag)
x<-bdf.tag[4,]
x
itemkeys<-bdf.tag$key
# bdf.tag$anno
library(xml2)
i<-2
##################################################
dclbib<-lapply(1:length(bdf.tag$key),function(i){
anno.t<-""
key<-bdf.tag$key[i]
# print(bdf.tag$title[i])
   anno<-bdf.tag$anno[i]
if(!is.na(anno)){
   htm<-read_html(anno)
  t<-xml_text(htm)
  t<-gsub("\n(.+?)\n","<li>\\1</li>",t)
  t<-gsub("\n","",t)
  # t

anno.t<-paste0("<ul>",t,"</ul>")
}
if(bdf$archive!="")
  
# anno.t
  response<-GET(paste0("https://api.zotero.org/groups/4713246/items/",key,"?format=bibtex"))
#t<-content(response,"text")
bibtx<-httr::content(response,"text")
#y<-tempfile("ref",fileext = ".bib")
#y<-"zotero.bib"
###################
writeLines(bibtx,y)
bibitem<-bib2df(y)
x<-bibitem
rref <- bibentry(
   bibtype = x$CATEGORY,
   key = x$BIBTEXKEY,
   title = x$TITLE,
   author = x$AUTHOR,
   organization = x$ORGANISATION,
   address = x$ADRESS,
   year = x$YEAR,
   url = x$URL,
    annote = anno.t,
  archive = x$ARCHIVE)
})


# setwd(paste0(Sys.getenv("GIT_TOP"),"/SPUND-LX/lx-public/HA/"))
## Different printing styles
#print(dclbib)
# print(dclbib, style = "bibtex")
#print(format(dclbib, "R", collapse = TRUE))
# writeLines(print(dclbib,style="bibtex"),"dcl.bib")
# writeLines(format(dclbib, "bibtex", collapse = TRUE))
# writeLines(paste(format(dclbib, "R"), collapse = "\n\n"))
#bref<-toBibtex(unlist(dclbib))
dcl2<-unlist(lapply(dclbib,function(x){toBibtex(x)}))
#dcl3<-toBibtex(dcl2)
#dcl2
#writeLines(dcl2,"front.bib")
writeLines(dcl2,y)
} # end front==T conditioner
writeLines(bibtx.cpt,bibyml)
#bibtx.cpt
getwd()
bibq<-bib2df(y)
}
###<get.bib()
#############################
lapply(names(qa),function(x){
  print(x)
  get.bib(x)
})