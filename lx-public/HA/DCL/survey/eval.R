library(httr)
library(jsonlite)
p<-c("&infoVariables&","infoValues&", "infoQuestionText")
p<-paste0(p,collapse = "")
p
credcsv<-Sys.getenv("CRED_GEN") # !VIP dont put directly into read.csv()
cred<-read.csv(credcsv) 
e<-parse(text=cred$q[1])
e
# q<-"transkribus"
m<-grep("sosci-dclx",cred$q)
q<-cred$q[m]
eval(e)

surl<-paste0(url,p,collapse = "?")
surl
r<-GET(surl)
t<-content(r,"text")
df<-fromJSON(t)
library(abind)
library(dplyr)
df$data$C12
df2<-data.frame(df$data$C12)
x<-df
#df3<-lapply(df, function(x){
  d<-x$data
  v<-x$variables
  q<-x$variables
  d1<-lapply(d,function(x1){
    data.frame(x1)
  })
  d2<-bind_rows(d1)
  df3<-list(data=d2,vars=v,q=q)
  text<-lapply(v,function(x){
    unlist(x$label)
  })
  label<-unlist(text)
  
  head(label,20)
  text<-lapply(v,function(x){
    unlist(x$question)
  })
  questions<-unlist(text)
  #})
dim(d2)
df3$data
df4<-data.frame(q=questions,text=NA,value=NA)
k<-2
for (k in 1:length(df3$data$CASE)){
  ds<-df3$data[k,]
#  ds<-ds[is.na(ds[1,]),]
  colnames(ds)
  r<-1
  for (r in 1:length(ds)){
  m<-rownames(df4)==colnames(ds)[r]
  sum(m)
  m<-which(m)
  df4$value[m]<-ds[1,r]
  # m<-names(labels)==colnames(ds)[r]
  # sum(m)
  # m<-which(m)
  # df4$text[m]<-names(labels)[1,r]
}
}
for(l in names(label)){
m<-l==rownames(df4)
sum(m)
m<-which(m)
df4$text[m]<-label[l]
}

