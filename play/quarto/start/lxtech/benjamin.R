## ----text2img

library(readr)
#c<-read_delim("/Users/guhl/Documents/GitHub/benjaminfeldkraft/corpus/benjaminfeldkraft.vert",skip=2,delim="\t")
# c <- read_delim(paste0(Sys.getenv("GIT_TOP"),"/benjaminfeldkraft/corpus/benjaminfeldkraft.vert"), 
#     delim = "\t", escape_double = FALSE, 
#     col_names = FALSE, trim_ws = TRUE, skip = 4)
c <- read_delim("https://raw.githubusercontent.com/esteeschwarz/benjaminfeldkraft/main/corpus/benjaminfeldkraft.vert", 
    delim = "\t", escape_double = FALSE, 
    col_names = FALSE, trim_ws = TRUE, skip = 4)

head(c)
colnames(c)<-c("token","pos","lemma")
c1<-c
c1$lemma<-gsub("-.*","",c1$lemma)
length(c1$token)
c1<-c1[!is.na(c1$pos),]
lu<-unique(c1$lemma)
length(lu)
#??img
v1<-grepl("VFIN",c1$pos)
n1<-grepl("N\\.",c1$pos)
sum(n1)
sum(v1)
v2<-matrix(ifelse(v1,4,3))
n2<-matrix(ifelse(n1,6,3))
s<-sqrt(length(v2))
v3<-matrix(0:length(v2))
n3<-matrix(0:length(n2))

#image(matrix(v2,s,s))
#image(matrix(n2,s,s))
#head(v2)
#length(n2)
#length(n3)



plot_logicals <- function(x, y,
                          col.x = "red",
                          col.y = "blue",
                          col.both = "purple") {
  stopifnot(length(x) == length(y))
  n <- length(x)

  X <- matrix(x, nrow = n, ncol = n)          # each column is x
  Y <- matrix(y, nrow = n, ncol = n, byrow=TRUE)  # each row is y

  # Encode colors:
  # 0 = blank
  # 1 = x[i] TRUE only
  # 2 = y[j] TRUE only
  # 3 = both TRUE
  z <- X + 2 * Y

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
y<-n1[1:1000]
plot_logicals(x, y)
