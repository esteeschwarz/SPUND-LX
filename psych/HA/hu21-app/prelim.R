run<-15303 # db identifier
dataset<-12 # last essai
dataset<-13 # new distancer & embed approach

#reload<-T
#reload<-F
target<-c("obs","ref")
#ref_target<-"obs"
con<-letters[1:6]
# det.t=c(T,F)
source("prepare-model.R")
cat("--- prelim.R preparemodel sourced..., next initvars, eval003...\n")
source("eval-init-vars.R")
cat("init vars sourced...\n")
source("eval-003.R")
cat("--- eval3 sourced...\n")

A.dbg.prelim<-"ttt"
