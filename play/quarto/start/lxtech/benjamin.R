## ----setup-plot

library(readr)
#c<-read_delim("/Users/guhl/Documents/GitHub/benjaminfeldkraft/corpus/benjaminfeldkraft.vert",skip=2,delim="\t")
# c <- read_delim(paste0(Sys.getenv("GIT_TOP"),"/benjaminfeldkraft/corpus/benjaminfeldkraft.vert"), 
#     delim = "\t", escape_double = FALSE, 
#     col_names = FALSE, trim_ws = TRUE, skip = 4)
c <- read_delim("https://raw.githubusercontent.com/esteeschwarz/benjaminfeldkraft/main/corpus/benjaminfeldkraft.vert", 
    delim = "\t", escape_double = FALSE, 
    col_names = FALSE, trim_ws = TRUE, skip = 4)

#head(c)
colnames(c)<-c("token","pos","lemma")
c1<-c
c1$lemma<-gsub("-.*","",c1$lemma)
#length(c1$token)
c1<-c1[!is.na(c1$pos),]
lu<-unique(c1$lemma)
#length(lu)
#??img
pu<-unique(c1$pos)
#pu
#c1$token[c1$pos==pu[9]]
v1<-grepl("VFIN",c1$pos)
v2<-grepl("N\\.",c1$pos)
v3<-grepl("ADJ",c1$pos)
v4<-grepl("ADV",c1$pos)

#sum(n1)
#sum(v1)
# v2<-matrix(ifelse(v1,4,3))
# n2<-matrix(ifelse(n1,6,3))
# s<-sqrt(length(v2))
# v3<-matrix(0:length(v2))
# n3<-matrix(0:length(n2))

#image(matrix(v2,s,s))
#image(matrix(n2,s,s))
#head(v2)
#length(n2)
#length(n3)



plot_logicals <- function(x, y,br,
                          col.x = "red",
                          col.y = "blue",
                          col.both = "purple") {
  stopifnot(length(x) == length(y))
  n <- length(x)
  l<-length(x)
 # sqrt(l)
  #100*100
  #32*32
  nr<-l/10
  nc<-l/nr
  nr<-l
  nc<-l
  X <- matrix(x, nrow = nr, ncol = nc)          # each column is x
  Y <- matrix(y, nrow = nr, ncol = nc, byrow=TRUE)  # each row is y
  Y <- matrix(y, nrow = nr, ncol = nc, byrow=br)  # each row is y

  # Encode colors:
  # 0 = blank
  # 1 = x[i] TRUE only
  # 2 = y[j] TRUE only
  # 3 = both TRUE
  z <- X + 2 * Y
#length(Y)
  image(
    1:n, 1:n, z,
    col = c("white", col.x, col.y, col.both),
    breaks = c(-0.5, 0.5, 1.5, 2.5, 3.5),
    xlab = "",
    ylab = "",
    asp = 1,
    axes =F
  )
  
}

x<-v1[1:1000]
y<-v2[1:1000]
br<-T
#plot_logicals(x, y,T)

fun.dep<-function(){
## x and y are logical vectors of the same length.
## They are reshaped into the same matrix dimensions and merged cell-by-cell:
##   0 = both FALSE  -> white
##   1 = x TRUE only -> red
##   2 = y TRUE only -> blue
##   3 = both TRUE   -> purple

plot_merge_logicals <- function(x, y,
                                nrow = NULL,
                                ncol = NULL,
                                col.x = "red",
                                col.y = "blue",
                                col.both = "purple") {
  stopifnot(length(x) == length(y))
  n <- length(x)

  ## Choose matrix dimensions automatically if not supplied
  if (is.null(nrow) || is.null(ncol)) {
    side <- ceiling(sqrt(n))
    nrow <- side
    ncol <- side
  }

  ## Total number of cells
  m <- nrow * ncol

  ## Pad with FALSE if needed
  if (n < m) {
    x <- c(x, rep(FALSE, m - n))
    y <- c(y, rep(FALSE, m - n))
  } else if (n > m) {
    stop("nrow * ncol is too small for the vectors.")
  }

  ## Reshape vectors into matrices (same linear order)
  X <- matrix(as.integer(x), nrow = nrow, ncol = ncol)
  Y <- matrix(as.integer(y), nrow = nrow, ncol = ncol)

  ## Merge matrices cell-wise
  Z <- X + 2 * Y

  ## Plot as plain image without axes or labels
  image(
    t(Z[nrow:1, ]),  # orient like a normal matrix
    col = c("white", col.x, col.y, col.both),
    breaks = c(-0.5, 0.5, 1.5, 2.5, 3.5),
    axes = FALSE,
    xlab = "",
    ylab = "",
    asp = 1,
    useRaster = TRUE
  )
}

## Example
set.seed(1)
#x <- sample(c(TRUE, FALSE), 100, replace = TRUE, prob = c(0.15, 0.85))
#y <- sample(c(TRUE, FALSE), 100, replace = TRUE, prob = c(0.15, 0.85))

#plot_merge_logicals(x, y, nrow = 10, ncol = 10)
#plot_merge_logicals(x, y)
## Merge any number of logical vectors into one matrix and plot it.
##
## Each vector is assigned its own color.
## For each cell:
##   - 0 = all FALSE  -> white
##   - 1..k = exactly one vector TRUE
##   - combinations of multiple TRUE values get unique colors
##
## All vectors must have the same length.

}
plot_merge_logicals_n <- function(...,
                                  nrow = NULL,
                                  ncol = NULL,
                                  cols = NULL,
                                  bg = "white") {
  L <- list(...)
  k <- length(L)

  if (k < 1)
    stop("Provide at least one logical vector.")

  n <- length(L[[1]])
  stopifnot(all(vapply(L, length, integer(1)) == n))
  stopifnot(all(vapply(L, is.logical, logical(1))))

  ## Choose matrix dimensions automatically
  if (is.null(nrow) || is.null(ncol)) {
    side <- ceiling(sqrt(n))
    nrow <- side
    ncol <- side
  }

  m <- nrow * ncol

  ## Pad all vectors with FALSE
  L <- lapply(L, function(v) {
    c(v, rep(FALSE, m - length(v)))
  })

  ## Convert each logical vector to integer matrix
  M <- lapply(seq_along(L), function(i) {
    matrix(as.integer(L[[i]]), nrow = nrow, ncol = ncol)
  })

  ## Encode each combination as a binary number:
  ## vector 1 -> 1
  ## vector 2 -> 2
  ## vector 3 -> 4
  ## vector 4 -> 8
  ## ...
  Z <- Reduce(`+`, Map(`*`, M, 2^(seq_len(k) - 1)))

  ## Number of possible combinations
  ncomb <- 2^k

  ## Colors
  if (is.null(cols)) {
    ## First color is background; remaining colors for all combinations
    cols <- c(bg, grDevices::rainbow(ncomb - 1))
  } else {
    if (length(cols) < ncomb - 1)
      stop("Need at least ", ncomb - 1, " colors.")
    cols <- c(bg, cols[seq_len(ncomb - 1)])
  }

  ## Plot
  image(
    t(Z[nrow:1, ]),
    col = cols,
    breaks = seq(-0.5, ncomb - 0.5, by = 1),
    axes = FALSE,
    xlab = "",
    ylab = "",
    asp = 1,
    useRaster = TRUE
  )

  invisible(Z)
}

## Example with 5 logical vectors
set.seed(1)
n <- 400
# v1 <- sample(c(TRUE, FALSE), n, TRUE, c(0.10, 0.90))
# v2 <- sample(c(TRUE, FALSE), n, TRUE, c(0.10, 0.90))
# v3 <- sample(c(TRUE, FALSE), n, TRUE, c(0.10, 0.90))
# v4 <- sample(c(TRUE, FALSE), n, TRUE, c(0.10, 0.90))
# v5 <- sample(c(TRUE, FALSE), n, TRUE, c(0.10, 0.90))

x1<-v1[1:1000]
x2<-v2[1:1000]
x3<-v3[1:1000]
x4<-v4[1:1000]


## ----v2img
plot_merge_logicals_n(v1, v2, v3, v4)
#plot_merge_logicals_n(x1, x2, x3, x4)
 
## ----v2strips
plot_logicals(x, y,T)
