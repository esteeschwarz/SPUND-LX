# Exploite la vectorisation de R - le plus "R-idiomatique"
diviseurs_vectorise <- function(n) {
  x<- lapply(1:n, \(i) which(i %% (1:i) == 0))
 # print(x)
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

# system.time(diviseurs_vectorise(1000))
# system.time(diviseurs_matrix(1000))
# 
# 
# system.time(diviseurs_vectorise(1000))
#############################
get.pn.vec<-function(range){
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
pnx<-px[pt]
print(pnx)
}
#############################
#library(purrr)
plot.vec<-function(){
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
}

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

#####################
pn<-get.pn.vec(10000)
#####################



