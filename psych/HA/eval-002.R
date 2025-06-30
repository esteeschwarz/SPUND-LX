#20250730(19.09)
#15273.reddit.stats.analysis
############################

df<-q.all.df
qn<-unique(df$q)
c<-letters[1:length(qn)]
for(k in 1:length(qn)){
  m<-df$q==qn[k]
  df$q[m]<-c[k]
}
unique(df$q)

Y <- df$dist           # Dependent variable
group <- df$target       # Assuming the second column is the grouping variable

group <- as.factor(group)
table(group)

anova_model <- aov(Y ~ group, data = df)
anova_model <- aov(Y ~ q, data = df)
summary(anova_model)
library(lmerTest)
lm1<-lmer(dist~target*q+(1|mf_rel)+(1|range)+(1|ld),df)
summary(lm1)
anova(lm1)
anova_model <- aov(dist ~ group + q + mf_rel , range, data = df)
summary(anova_model)
#not. wks