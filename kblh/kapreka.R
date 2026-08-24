# 16336.kapreka magic number

d<-1235
d0<-d
d0<-sample(1000:9999,40)
#######

get.number<-function(d0){
d2<-unlist(strsplit(as.character(d0),""))
d21<-d2
if(length(unique(d2))<3){
  cat("---! not more than 2 doubles in number! ---\n")
  return(NA)
  }
dev<-function(d){
  d1<-as.character(d)

  
d2<-unlist(strsplit(d1,""))
d21<-d2
#if(length(unique(d2))<3)
  #return(NA)
#print(d2)
d2<-as.double(d2)
d3<-sort(d2,decreasing = T)
d3<-paste(d3,collapse="")
d3<-as.double(d3)
d5<-sort(d21,decreasing = F)
d5<-paste(d5,collapse="")
d5<-as.double(d5)
d4<-d3-d5
#print(d4)
return(d4)
}
d2<-dev(d)

# only showing a sample of forty 4-digit numbers

ndf<-data.frame(n=sample(1000:9999,40),loop=NA)
ndf<-data.frame(n=d0,loop=NA)
for (l in 1:length(ndf$n)){

  d<-ndf$n[l]
  d0<-l
  d1<-as.character(d)
  out<-F
  
  d2<-unlist(strsplit(d1,""))
  if(length(unique(d2))<3){
    cat("keine triples...\n")
    out<-T
    next
  }
for (k in 0:10){
  cat("loop:",k,", number:",d,"\n")
  dx<-d
  d<-dev(d)
  if(is.na(d))
    break
  if(dx==d&!is.na(d)){
    cat("--- looping finished at:",k,"---\n")
        ndf$loop[l]<-k

    break
  }
}
}
return(ndf)
}
run.magic<-function(){
#ndf<-ndf[!is.na(ndf$loop),]
ndf<-get.number(d0)
ndf<-ndf[!is.na(ndf$loop),]

cat("--- medium magic at:",median(ndf$loop,na.rm=T),"loops \n")
plot(ndf,type="h")
hist(ndf$loop)
boxplot(ndf$loop)

}