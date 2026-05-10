# 20260508(20.05)
# 16197.lx-tech.zinsmeister
###########################

## ----skew

# computing skew divergence score for noun-noun compound vectors
# Q: zinsmeister(2013)


# D(p||q) = Sig^i p^i x log(p^i/q^i)
l1<-c(0.6,0.4,0) # milchzahn
l2<-c(0.25,0.5,0.25) # zahn
l3<-c(0,0,1) # löwenzahn
### test: löwenzahn::ziehen=1 occurence instead 0
l4<-c(0,1,2)
l5<-unlist(lapply(l4,function(x){
x/sum(l4)
}))
########################
# l2 is the reference p
# l1,l3 are the target q probabilities which are projected on /smoothed by reference p
#############################################
lx<-list(list(l2,l1),list(l2,l3),list(l2,l5))
#f<-sum(pi*(log(pi/qi)))
w<-0.9
s1<-lapply(lx,function(l){
  print(l)
#  lapply(l,function(p){
 #   cat("p:",p,"\n")
    s<-array()
    for(i in 1:length(l[[1]])){
      p1<-l[[1]][i]
      q1<-l[[2]][i]
      qi<-(w*q1)+((1-w)*p1) # qi smoothed
      cat("qi:",qi,"\n")
      # s[i]<-sum(pi*log((pi/qi)))
      s[i]<-p1*log(p1/qi)
      cat("s:",s[i],"\n")
    }
    spq<-sum(s)
    cat("skew div:",spq,"\n")
  return(s)
})
names(s1)<-c("milchzahn","löwenzahnA","löwenzahnB")
lapply(s1,sum) #chk.
par(las=2)
boxplot(s1,main="skew divergence scores, reference: zahn")

## ----cosine-sim


# X = numeric matrix of token embeddings (rows = tokens, cols = features)
# Example:
# X <- as.matrix(df[, -1])
# rownames(X) <- df$t
# l1<-c(0.6,0.4,0) # milchzahn
# l2<-c(0.25,0.5,0.25) # zahn
# l3<-c(0,0,1) # löwenzahn
# ### test: löwenzahn::ziehen=1 occurence instead 0
# l4<-c(0,1,2)
df<-data.frame(token=c("milchzahn","zahn","loewenzahnA","loewenzahnB"),NA,NA,NA)
df[1,2:4]<-l1
df[2,2:4]<-l2
df[3,2:4]<-l3
df[4,2:4]<-l4
#df
X<-as.matrix(df[,-1])
# 1. Row norms (Euclidean length of each token vector)
row_norms <- sqrt(rowSums(X^2))

# 2. Dot-product matrix
#    tcrossprod(X) == X %*% t(X)
dot_products <- tcrossprod(X)

# 3. Outer product of norms
#    Gives all pairwise ||x_i|| * ||x_j||
norm_matrix <- outer(row_norms, row_norms)

# 4. Cosine similarity matrix
cosine_sim <- dot_products / norm_matrix

# 5. Handle rows with zero norm (if any)
cosine_sim[!is.finite(cosine_sim)] <- 0

# 6. Add row/column names
rownames(cosine_sim) <- df$token
colnames(cosine_sim) <- df$token

# Example: similarity between "striker" and "goal"
print(cosine_sim)
cosine_sim["milchzahn", "zahn"]

# Example: top 5 nearest neighbors for "striker"
nearest_neighbors <- function(token, sim, k = 5) {
  s <- sim[token, ]
  s <- s[names(s) != token]           # remove self-similarity
  s <- sort(s, decreasing = TRUE)
  head(s, k)
}

nearest_neighbors("zahn", cosine_sim)
