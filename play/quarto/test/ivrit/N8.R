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
dna<-lapply(d31,function(x){
  na<-is.na(x[[4]])
  tchar<-x[[1]]%in%nc
  l<-length(x[[2]][[1]])
  dx<-data.frame(x[[2]][[1]])
  dx<-data.frame(t(dx))
  dx
  dx$l<-unlist(x[[4]])
  dx
  #dx[,3]<-x[[4]]
  if(tchar&na){
  ca<-lapply(seq_along(1:l),function(i){
 # d4<-data.frame(l=x[[2]][[1]][[i]][1],i=x[[2]][[1]][[i]][2])
 # d4
  b<-x[[1]]
  cat("Buchstabe > ",b," < \ndrücke --- J --- für -ja- \noder --- N --- für -nein-\n")
  # a<-as.character(paste0("--- > ",b," < ",i,'. ausgesprochen wie in: "',dx[i,1],'"\n'))
  a<-as.character(paste0(i,'. --- > ausgesprochen wie in: "',dx[i,1],'"\n'))
  cat (a)
  v<-readline(prompt="wähle option aus: ")

  # })
  #ca2
  })
  ca
  library(abind)
#ca2<-data.frame(abind(ca))
  ca<-unlist(ca)
  ca
}
  if(!na&tchar){
    o<-paste0("für > ",x[[1]]," < schreiben wir auf hebräisch: > ",x[[4]]," <")
   return(data.frame(na,o))
  }
  if(na){
    # paste0("--- >",x[[1]],"< ausgesprochen wie:",ca)
    return(data.frame(na,ca))
  }
  
  })
dna
library(abind)
dna2<-data.frame(abind(dna,along=1))
dna2
??input
