# 20251125(17.35)
# 16484.kblh
############
# Q: azriel, shor-ha-shoel, porat
# pythagoras vollkommene zahl
#############################
7+4+2+14+1
28/4
28/2
28/3

#x<-6
#k<-1
n<-1000
s<-1
i<-100
get.pn<-function(s,n,m,csv){
xl<-s:n
# 6,28,496,8128
#xl-10001:15000
#xl<-list(1:2000)
pa<-array()
#xlist<-list(1:10000)

df<-data.frame(start=s,lim=n,p.number=NA)
write.table(df,csv,quote = F)

xk<-lapply(xl,function(i){
  cat("\r",i)
  #p<-i-1
#   for (k in 1:i){
# #    cat("\r",k)
#     b<-i/k
# #    ifelse(ifelse(m=="c",ceiling(b)==b,typeof(b)=="int"),pa[k]<-b,pa[k]<-0) # bench time: 2.225
#     #ifelse(typeof(b)=="int",pa[k]<-b,pa[k]<-0) # bench time: 1.127 
#     ifelse(ceiling(b)==b,pa[k]<-b,pa[k]<-0) # bench time: 1.095
#     
#   }
  x2<-1:i
  pa<-lapply(x2, function(ii){
    #print(ii)
    b<-i/ii
    ifelse(ceiling(b)==b,b,0) # bench time: 1.095
  })
  #pa<-pa[!is.na(pa)]
  pa<-unlist(pa)
  m<-pa==i
  pa<-pa[!m]
 # pp<-sum(pa)==x
  pp<-sum(pa,na.rm = T)==i
  df<-data.frame(start=s,lim=n,p.number=i)
  if(pp)
    write.table(df,csv,append = T,quote = F,col.names = F)
  return(pa)
  return(pp)
})
xs<-lapply(xk, sum)
xo<-which(xs==s:n)
#sum(unlist(xk))
#xk2<-unlist(xk)
#pn<-which(xk2)
cat("\np-number range 1 to",n,"\n")
print(xo)

}
#csv<-paste0(Sys.getenv("GIT_TOP"),"/SPUND-LX/kblh/p-numbers.csv")
csv<-"/var/www/html/cloud/p-numbers.csv"
dur<-system.time(get.pn(100001,150000,"c",csv)) #v0.1: 1:1000 1.208
dur
write.table(data.frame(time=Sys.time(),elapsed=dur[3],row.names = "finished"),csv,append = T,quote = F,col.names = T)

# run: nohup Rscript p-numbers.R > output.log 2>&1 &



