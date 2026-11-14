run<-15303 # db identifier
dataset<-12 # last essai
dataset<-13 # new distancer & embed approach

#reload<-T
#reload<-F
target<-c("obs","ref")
#ref_target<-"obs"
cond.fix<-letters[1:6]
mod.i<-T

# det.t=c(T,F)
# source("prepare-model.R")
cat("--- prelim.R preparemodel skipped..., next initvars...\n")
source("eval-init-vars.R")
cat("init vars sourced...\n")
source("eval-003.R")
cat("--- eval3 sourced...\n")

A.dbg.prelim<-"ttt"
build.q<-function(){
  q0<-list(a=list(q="!{b,c,d,e,f}",det="DET"))
  q1<-list(b=list(q=c("this","that","these","those"),det="DET")) # mean distance: 76
  q2<-list(c=list(q=c("the"),det="DET")) # mean distance: 81
  q3<-list(d=list(q=c("a","an","some","any"),det="DET")) # mean distance: 63, lower
  q4<-list(e=list(q=c("my"),det=F)) # mean distance: 55, lower
  q5<-list(f=list(q=c("your","their","his","her"),det=F)) # mean distance: 100, higher
  
  return(list(q0,q1,q2,q3,q4,q5))
}
qs<-build.q()
