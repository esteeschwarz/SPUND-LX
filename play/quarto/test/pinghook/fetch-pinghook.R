#fetch zotero .bib online
library(httr)
library(bib2df)
#tag<-"dcl"
# bibyml<-c("lit-ki","textur","nietzsche")

setwd(paste0(Sys.getenv("GIT_TOP"),"/SPUND-LX/play/quarto/test/pinghook"))
getwd()
share <- runif(1)
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
bibtop<-bibdf
##########################
offset<-function(qaz){
  qa<-list(arkkiv=NA,frameworks=NA,LX=NA,play=NA,read=NA,szondie=NA,tech=NA,wiki=NA)
  #qa<-qaz
 # bibyml<-names(qa[1])
}
qa<-offset(NA)
#qa
get.pings<-function(bibyml){
bibkey<-bibdf$key[grep(bibyml,bibdf$data.name)]

bibyml<-paste0(bibyml,".bib")
#################################################
#response<-GET(paste0("https://api.zotero.org/groups/4713246/collections/",bibkey,"/items?format=json&limit=499"))
#response.bib<-GET(paste0("https://api.zotero.org/groups/4713246/collections/",bibkey,"/items?format=bibtex&limit=499"))
response<-GET(paste0("https://api.zotero.org/groups/6526786/collections/",bibkey,"/items?format=json&limit=499"))
response.bib<-GET(paste0("https://api.zotero.org/groups/6526786/collections/",bibkey,"/items?format=bibtex&limit=499"))
# bib<-httr::content(response,"text")
bibjs<-httr::content(response,"text")
bibtx.cpt<-httr::content(response.bib,"text")
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
n<-print(names(bibdf)[m])
#print(bibdf)
#library(abind)
#bdf<-data.frame(abind(bibdf[m],along=0))
ifelse(length(n)>0,bibdf<-bibdf[!is.na(bibdf$data.accessDate),],return(NA))
#print(bibdf)
bdf<-bibdf[,m]
print(length(bdf))
#bdf$data.note
m2<-which(!is.na(bdf$data.note))
print(m2)
#print(bdf)
  bdf$anno<-NA

for (k in m2){
  print(k)
  ak<-bdf$data.parentItem[k]
 # print(ak)
  note<-bdf$data.note[k]
  m<-bdf$data.key==ak
  if(note!="")
    bdf$anno[m]<-bdf$data.note[k]
}
#print(bdf$data.title)
# bdf$anno
#print(bdf$data.tags)
#tag<-"ai"
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
print(colnames(bdf.tag))
x<-bdf.tag[4,]
itemkeys<-bdf.tag$key
# bdf.tag$anno
library(xml2)
i<-2
##################################################
dclbib<-lapply(1:length(bdf.tag$key),function(i){
anno.t<-""
key<-bdf.tag$key[i]
# print(bdf.tag$title[i])
  # print(anno<-bdf.tag$anno[i])
if(!is.na(anno)){
   htm<-read_html(anno)
  t<-xml_text(htm)
  t<-gsub("\n(.+?)\n","<li>\\1</li>",t)
  t<-gsub("\n","",t)
  # t

anno.t<-paste0("<ul>",t,"</ul>")
}
# anno.t
  response<-GET(paste0("https://api.zotero.org/groups/6526786/items/",key,"?format=bibtex"))
#t<-content(response,"text")
bibtx<-httr::content(response,"text")
#y<-tempfile("ref",fileext = ".bib")
#y<-"zotero.bib"
###################
writeLines(bibtx,y)
bibitem<-bib2df(y)
x<-bibitem
  print(x)
rref <- bibentry(
   bibtype = x$CATEGORY,
   key = x$BIBTEXKEY,
   title = x$TITLE,
   author = x$AUTHOR,
   organization = x$ORGANISATION,
   address = x$ADRESS,
   year = x$YEAR,
   url = x$URL,
   pdf = x$ARCHIVE,
    annote = anno.t,
  pdf=x$EXTRA)
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
  #print(dclbib)
dcl2<-unlist(lapply(dclbib,function(x){toBibtex(x)}))
#dcl3<-toBibtex(dcl2)
print(dcl2)
#writeLines(dcl2,"front.bib")
writeLines(dcl2,y)
} # end front==T conditioner
#writeLines(bibtx.cpt,bibyml)
#bibtx.cpt
getwd()
bibq<-bib2df(y)
cat("fin\n")
print(bibq)
bibdf$cat<-gsub("\\.bib","",bibyml)
return(bibdf)
}
###<get.bib()
#############################
create.html<-function(){

}

#qa<-list(arkkiv=NA)
load("pingtest.RData")
pingdf<-df[1,]
pingdf[1,]<-NA
df1<-pingdf
  #lapply(names(qa),function(x){
  #print(x)
  for(k in 1:length(qa)){
      
#  pingd<-data.frame(title=NA,url=NA,cat=NA,comment=NA,tags=NA)
  dfp<-get.pings(names(qa[k]))
    dfp<-as.data.frame(dfp)
  print(dfp)
    print(typeof(dfp))
    library(dplyr)
  df1<-bind_rows(df1,dfp)
  # if(length(df[,1])>0)
  #   save(df,file="pingtest.RData")
  }
df0<-read.csv
df1<-df1[!is.na(df1$cat),]
save(df1,file="pingdb.RData")