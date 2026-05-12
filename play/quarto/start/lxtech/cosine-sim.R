# X = numeric matrix of token embeddings (rows = tokens, cols = features)
# Example:
# X <- as.matrix(df[, -1])
# rownames(X) <- df$t
# l1<-c(0.6,0.4,0) # milchzahn
# l2<-c(0.25,0.5,0.25) # zahn
# l3<-c(0,0,1) # löwenzahn
# ### test: löwenzahn::ziehen=1 occurence instead 0
# l4<-c(0,1,2)
# df<-data.frame(token=c("milchzahn","zahn","loewenzahnA","loewenzahnB"),NA,NA,NA)
# df[1,2:4]<-l1
# df[2,2:4]<-l2
# df[3,2:4]<-l3
# df[4,2:4]<-l4
# df

## ----cosine-sim

X<-as.matrix(df[,-1])
mode(X)<-"double"
#df
#X
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
rownames(cosine_sim) <- df$t
colnames(cosine_sim) <- df$t

# Example: similarity between "striker" and "goal"
cosine_sim
# cosine_sim["milchzahn", "zahn"]

# Example: top 5 nearest neighbors for "striker"
nearest_neighbors <- function(token, sim, k = 5) {
  s <- sim[token, ]
  s <- s[names(s) != token]           # remove self-similarity
  s <- sort(s, decreasing = TRUE)
  head(s, k)
}

cat("evaluate nearest neighbors to: -",q,"-\n")
nearest_neighbors(q, cosine_sim)


pl<-function(){
  # pca <- prcomp(X, scale. = TRUE)
#   pca<-prcomp(X)
#   X
# plot(pca$x[,1], pca$x[,2], type = "n")
# text(pca$x[,1], pca$x[,2], labels = df$t)
  d <- dist(X)
hc <- hclust(d)
plot(hc, labels = df$t)
}

## ----plot1

cat("NO syntax tree yet, but a simple similarity cluster according to categories...\n")
pl()

## ----plot2
cat("'shot' coded both as noun & verb\n")
pl()

## ----plot3
cat("'shot' coded twice each as noun resp. verb\n")
pl()