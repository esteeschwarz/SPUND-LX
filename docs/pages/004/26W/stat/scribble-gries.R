# 20261114
# 17471.gries linear regression essais
Q<-"https://doi.org/10.1111%2Flang.12448"

library(DHARMa)  # residual diagnostics
library(effects) # effects plots of (final) model predictions
library(lme4)    # main mixed-effects modeling function
library(MuMIn)   # AICc
library(party)   # conditional inference trees, here used as a factorization tool

source("helpers/C.score.r")                     # check for collinearity
source("helpers/vif.mer.r")                     # check for collinearity
source("helpers/kappa.mer.r")                   # check for collinearity
source("helpers/overdisp.mer.r")                # check for overdispersion
source("helpers/dispersion_glmer.r")            # check for overdispersion
source("helpers/random.effects.distribution.r") # explore ranef level distribution
source("helpers/nested.r")                      # check whether one variable is nested into another
source("helpers/change.plotty.r")               # check how values change over (modeling) time
source("helpers/explorer.cat.r")                # explore categorical variables
source("helpers/explorer.num.r")                # explore numeric variables
source("helpers/betweeny.r")                    # check whether x is between y and z

summary(x <- read.table(          # show the summary of loading into x
   "01b_thatcomplementation.csv", # this tab-delimited file, which (or <2021_STG_MEM-MSA_LL.csv>)
   header=TRUE,                   # has a header in row 1
   sep="\t",                      # has tab-delimited columns
   quote="",                      # no quote are used
   comment.char="",               # no comments are used
   stringsAsFactors=TRUE)) 

explorer.cat(x$MATCHLEMMA)
random.effects.distribution(x$MATCHLEMMA)

x$MATCHLEMMAFREQ <- as.numeric(table(x$MATCHLEMMA)[x$MATCHLEMMA])
summary(xx <- droplevels(x[x$MATCHLEMMAFREQ>=10,]))

qwe <- prop.table(asd <- table(xx$MATCHLEMMA,xx$COMPLEMENTIZER), 1)
# plot for all verbs their overall frequency and their % of 'present'
plot(type="n",
   xlab="MATCHLEMMA frequency (logged)",           xlim=c(0, 8), x=log(rowSums(asd)),
   ylab="Proportion of COMPLEMENTIZER: 'present'", ylim=c(0, 1), y=qwe[,2])
   grid(); abline(h=mean(xx$COMPLEMENTIZER=="absent"), lty=3)
   # text(log(rowSums(asd)), qwe[,2], rownames(asd),
   #      cex=0.8, srt=45, font=2)
# cross-tabulate complenmentizer use per L1 and plot those accordingly
qwe <- table(xx$MATCHLEMMA,xx$COMPLEMENTIZER, xx$L1)
for (i in 1:3) {
   asd <- qwe[,,i]
   text(log(rowSums(asd)), prop.table(asd, 1)[,2], rownames(asd),
        cex=0.8, col=c(rainbow(3))[i], srt=45)
   abline(h=colSums(asd)/sum(asd),
          lty=3, col=c(rainbow(3))[i])
}
# add a legend
legend(x=7, y=0.9, xjust=0.5, yjust=0.5, ncol=1, bty="n",
       fill=rainbow(3), legend=levels(xx$L1))

xx$FILEFREQ <- as.numeric(table(xx$FILE)[xx$FILE])
summary(xx <- droplevels(xx[xx$FILEFREQ>=4,]))

nonnat_v_nat       <- c(2/3, -1/3,  -1/3)
   nnspok_v_nnwrit <- c(  0, +0.5,  -0.5)
   (contrasts(xx$CORPUS) <- cbind(nonnat_v_nat, nnspok_v_nnwrit))

plot(xx$COMPLEMENTIZER ~ xx$CORPUS)

### sdf
plot(factor(sdf$target) ~ factor(sdf$q))

load("~/Documents/GitHub/SPUND-LX/psych/HA/hu21-app/qltdf.RData")

### range mod

