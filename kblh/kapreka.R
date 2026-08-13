# 16336.caprici

d<-1235
d0<-d
#######
dev<-function(d){
  d1<-as.character(d)
  
  
d2<-unlist(strsplit(d1,""))
d21<-d2
if(length(unique(d2))<3)
  return(NA)
print(d2)
d2<-as.double(d2)
d3<-sort(d2,decreasing = T)
d3<-paste(d3,collapse="")
d3<-as.double(d3)
d5<-sort(d21,decreasing = F)
d5<-paste(d5,collapse="")
d5<-as.double(d5)
d4<-d3-d5
print(d4)
return(d4)
}
d2<-dev(d)
for (l in sample(1000:9999,40)){
  d<-l
  d0<-l
  d1<-as.character(d)
  
  
  d2<-unlist(strsplit(d1,""))
  if(length(unique(d2))!=4){
    cat("keine doubles...\n")
    next
  }
for (k in 1:10){
  cat("loop:",k,"\n")
  
  d<-dev(d)
}
}



