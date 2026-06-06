# 2026-06-06(08.57)
# 16241.ivrit.transliterate
# lange nacht der wissenschaften, hebräische schreibwerkstatt prep
###
ns<-"/Users/guhl/Documents/GitHub/SPUND-LX/play/quarto/test/ivrit/trans.csv"
d<-read.csv(ns)
d
t<-readLines(ns)
s<-strsplit(t,",")
s
l<-lapply(s,function(x)length(unlist(x)))
l
d3<-d$var
i<-1
d31<-lapply(seq_along(1:length(d3)),function(i){
  x<-d3[i]
  z<-d$name[i]
  bi<-d$ivrit[i]
  bl<-d$latin[i]
  s1<-strsplit(x,"\\.")
  s1
  s2<-lapply(s1,function(s){strsplit(s,"-")})
  s3<-strsplit(z,"\\.")
  if(bi=="")
    bi<-NA
  return(list(bl,s2,s3,bi))
})
x<-d31[[26]]
i<-1
x
name<-readline("bitte gib deinen Namen ein: > ")
nc<-unlist(strsplit(name,""))
nc<-tolower(nc)
nc
d
nc
m<-d$latin%in%nc
sum(m)
which(m)
d32<-d31[which(m)]
d32
x1<-d31[[1]]
x1
nc
c<-"s"
all.c<-unlist(lapply(d31,function(x){x[[1]]}))
dna<-lapply(nc,function(c){
  # for(k in length(d31)){
  #   c1<-d31[[k]][1]

  # }
  b<-all.c==c
  bp<-which(b)
  x<-d31[[bp]]
  na<-is.na(x[[4]])
  tchar<-x[[1]]%in%nc
  l<-length(x[[2]][[1]])
  dx<-data.frame(x[[2]][[1]])
  dx<-data.frame(t(dx))
  dx
  x
  x[[4]]
  dx$l<-unlist(x[[1]])
  dx
  #dx[,3]<-x[[4]]
  tchar
  na
  if(tchar&na){
  ca<-array()
  l
  ip<-1
  for(i in 1:l){
    if(ip<(l+1)){

  
  #ca<-lapply(seq_along(1:l),function(i){
 # d4<-data.frame(l=x[[2]][[1]][[i]][1],i=x[[2]][[1]][[i]][2])
 # d4
    dx
  b<-x[[1]]
    b
  cat("Buchstabe > ",b," < \ndrücke --- J --- für -ja- \noder --- N --- für -nein-\n")
  # a<-as.character(paste0("--- > ",b," < ",i,'. ausgesprochen wie in: "',dx[i,1],'"\n'))
  a<-as.character(paste0(i,'. --- > ausgesprochen wie in: "',dx[i,1],'"\n'))
  cat (a)
  v<-readline(prompt="wähle option aus: ")
  print(v)
  if(v=="j"|v=="ja"){
    ca[i]<-dx$X2[i]
    ip<-l+1
  }

  # })
  #ca2
  }
}
  ca<-ca[!is.na(ca)]
    ca
  library(abind)
#ca2<-data.frame(abind(ca))
 # ca<-unlist(ca)
  ca
  }
  if(!na&tchar){
    o<-paste0("für > ",x[[1]]," < schreiben wir auf hebräisch: > ",x[[4]]," <")
   return(data.frame(na,x[[4]]))
  }
  if(na){
    # paste0("--- >",x[[1]],"< ausgesprochen wie:",ca)
    return(data.frame(na,ca))
  }
  
})
dna
library(abind)
dna2<-data.frame(abind(dna,along=1))
dna2<-data.frame(dna2)
dna3<-dna2[,2]
dna3
dna2
nc
if("h"%in%dna$ca)
  dna3<-dna2[dna2[,2]!="h"]
dna3<-paste0(dna3,collapse="")
dna3
cat("dein name in hebräischen buchstaben: > ",dna3," <\n")
md<-readLines("/Users/guhl/Documents/GitHub/SPUND-LX/play/quarto/test/ivrit/16241.N8.md")
md<-gsub("\\{dt\\}",name,md)
md<-gsub("\\{ivrit\\}",dna3,md)
md
writeLines(md,"/Users/guhl/Documents/GitHub/SPUND-LX/play/quarto/test/ivrit/output.md")
