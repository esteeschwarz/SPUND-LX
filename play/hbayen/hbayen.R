#14065.
R1<-"http://www.sfs.uni-tuebingen.de/~hbaayen/software.html"

download.file("http://www.sfs.uni-tuebingen.de/~hbaayen/software/CBO.R",paste0(getwd(),"/CBO.R"))

download.file("http://www.sfs.uni-tuebingen.de/~hbaayen/software/CBO.csv",paste0(getwd(),"/CBO.csv"))

###
source("CBO.R")
install.packages("graph")
install.packages("RBGL")
install.packages("languageR")
install.packages("Rgraphviz")
library(languageR)

mOrig= loadData.fnc()
plotmat.fnc(mOrig)
res=analysis.fnc()
m=as.matrix(res$m)
mG=as(m,"graphNL")
print(mG)
### no.
install.packages("ndl")
install.packages("AcousticNDLCodeR")
