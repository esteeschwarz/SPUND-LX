# 20261012(14.40)
# 17423.lx.statistics
# scribble
#####################

library(modeest)
library(Rling)

data(ldt)
attach(ldt)
mean(Length)
hist(Mean_RT)
plot(density(Mean_RT))
qqnorm(Mean_RT)
qqline(Mean_RT)
