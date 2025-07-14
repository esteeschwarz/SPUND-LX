plain:target:q  4.797e-05   0.0004797
an:lme  0.003563
0.15 1.5e-01
0.0035 3.5-03
0.00004.797-05

write.csv(dfa[sample(length(dfa$q),100),],paste0(Sys.getenv("GIT_TOP"),"/SPUND-LX/psych/HA/sampledist.df.csv"))
contrasts(dfa$target)
levels(dfa$target)
levels(dfa$q)
data<-dfa
data$q<-factor(data$q)
data$target<-factor(data$target)
levels(data$target)
levels(data$q)
contrasts(data$target)
data$target <- relevel(data$target, ref = "obs")  # Now intercept = "ref" baseline
data$q <- relevel(data$q, ref = "a")  # Optional: set another reference
lm1<-lmer(lme.form.t,data)
summary(lm1)
lm2<-lmer(dist~target*q+(1|det),data)
summary(lm2)
#length(unique(dfa$pos))
dup<-duplicated(data$pos)
dfa2<-data[!dup,]
data<-dfa2
unique(data$det)
