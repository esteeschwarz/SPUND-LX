#20250730(19.09)
#15273.reddit.stats.analysis
############################
dfa<-read.csv(paste0(Sys.getenv("GIT_TOP"),"/SPUND-LX/psych/HA/eval-002.csv"))
#df<-q.all.df
qn<-unique(dfa$q)
c<-letters[1:length(qn)]
for(k in 1:length(qn)){
  m<-dfa$q==qn[k]
  dfa$q[m]<-c[k]
}
unique(dfa$q)

Y <- dfa$dist           # Dependent variable
group <- dfa$target       # Assuming the second column is the grouping variable

group <- as.factor(group)
table(group)

anova_model <- aov(Y ~ group, data = dfa)
anova_model <- aov(Y ~ group*q, data = dfa)
summary(anova_model)
library(lmerTest)
lm1<-lmer(dist~target*q+(1|mf_rel)+(1|range)+(1|ld),dfa)
lm.summ<-summary(lm1)
an.summ<-anova(lm1)
lm.summ
an.summ
#anova_model <- aov(dist ~ group + q + mf_rel , range, data = df)
#summary(anova_model)
#not. wks