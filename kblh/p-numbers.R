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
run.1<-function(){
#csv<-paste0(Sys.getenv("GIT_TOP"),"/SPUND-LX/kblh/p-numbers.csv")
csv<-"/var/www/html/cloud/p-numbers.csv"
dur<-system.time(get.pn(100001,150000,"c",csv)) #v0.1: 1:1000 1.208
dur
write.table(data.frame(time=Sys.time(),elapsed=dur[3],row.names = "finished"),csv,append = T,quote = F,col.names = T)

# run: nohup Rscript p-numbers.R > output.log 2>&1 &
}


### 16501.claude
# Approche avec boucles et état mutable
diviseurs_imperatif <- function(n) {
  resultat <- list()
  
  for(i in 1:n) {
    divs <- c()  # état mutable
    for(j in 1:i) {
      if(i %% j == 0) {
        divs <- c(divs, j)  # modification d'état
      }
    }
    resultat[[i]] <- divs
  }
  
  return(resultat)
}

# Usage
div_imp <- diviseurs_imperatif(10)
div_imp[[10]]  # [1]  1  2  5 10
system.time(diviseurs_imperatif(1000))


# Approche avec fonctions, pas de boucles explicites
diviseurs_fonctionnel <- function(n) {
  lapply(1:n, function(i) {
    Filter(function(j) i %% j == 0, 1:i)
  })
}

# Encore plus fonctionnel avec composition
diviseurs_fonctionnel2 <- function(n) {
  lapply(1:n, \(i) (1:i)[i %% (1:i) == 0])
}

# Usage
div_func <- diviseurs_fonctionnel(10)
div_func[[10]]  # [1]  1  2  5 10
system.time(diviseurs_fonctionnel(1000))


# Exploite la vectorisation de R - le plus "R-idiomatique"
diviseurs_vectorise <- function(n) {
 x<- lapply(1:n, \(i) which(i %% (1:i) == 0))
 print(x)
}

# Ou avec outer() pour être encore plus vectorisé
diviseurs_matrix <- function(n) {
  nums <- 1:n
  # Crée une matrice de modulos
  mat <- outer(nums, nums, `%%`) == 0
  # Pour chaque ligne, trouve les diviseurs
  lapply(1:n, \(i) which(mat[i, 1:i]))
}

# Usage
div_vec <- diviseurs_vectorise(1000)
div_vec[[100]]  # [1]  1  2  4  5 10 20 25 50 100

system.time(diviseurs_vectorise(1000))
system.time(diviseurs_matrix(1000))


system.time(diviseurs_vectorise(1000))
#############################
p<-diviseurs_vectorise(10000)
pn<-lapply(p,function(i){
#  print(i)
  s<-sum(i[1:(length(i)-1)])
  t<-s==i[length(i)]
})
pt<-unlist(pn)
sum(pt)
#pu<-unlist(p)
px<-1:length(p)
px[pt]
#############################
#library(purrr)
l<-unlist(lapply(p,function(x){
  length(x)
}))
plot(l,type="l")
#histogram(l)
which.max(l)
w<-which(l==2)

d<-diff(w)
d
plot(d,type="h")
w[which.max(d):(which.max(d)+1)]


### 16504.daleth.L57
1*10^0
#
3^2
4^2
# 3 dreiheiten: länge-weite-tiefe, +1 qualität: substanz

x<-3
q<-x^2
y<-x+1
z<-y^2
# what is 9?
get.r<-function(s){
  basis<-3
  x<-basis+s
  
  
  i<-x-basis
  p<-i-1
  q<-x^i
  y<-x+p
  z<-y^i
  q<-z
  r1<-q/x
r2<-sqrt(q)
print(r1)
print(r2)
print(z)
print("---")
print(i<-z^r2)
print((b<-z*1/r1))
print(q<-(z*1/r1)*x)
#print(q)
print(r1<-sqrt(q))
}
get.r(0)
sqrt(9)
