#20250730(19.09)
#15273.reddit.stats.analysis
############################
dfa<-read.csv(paste0(Sys.getenv("GIT_TOP"),"/SPUND-LX/psych/HA/eval-002.csv"))
queries<-unique(dfa$q)
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
#wks.
# #get mean:
# m.target<-median(dfa$dist[dfa$target=="obs"])
# m.ref<-median(dfa$dist[dfa$target=="ref"])
k<-1
c<-1
get.m.df<-function(dfa){
  q.u<-unique(dfa$q) 
  ql<-unlist(lapply(seq_along(q.u),function(i){
    rep(q.u[i],2)
  }))
  ql
  c.u<-unique(dfa$target)
  df.m<-data.frame(target=rep(c.u,6),q=ql,n=NA,mean=NA,median=NA)
  for(k in 1:length(q.u)){
    qx<-q.u[k]
    m.q<-dfa$q==qx
    sum(m.q)
    for(c in 1:length(c.u)){
      cx<-c.u[c]
      m.c<-dfa$target[m.q]==cx
      l<-sum(m.c)
      df.m$n[df.m$target==cx&df.m$q==qx]<-l
      df.m$mean[df.m$target==cx&df.m$q==qx]<-mean(dfa$dist[m.q][m.c])
      df.m$median[df.m$target==cx&df.m$q==qx]<-median(dfa$dist[m.q][m.c])
    }
  }
  return(df.m)
}


# Read the data
#df <- read.csv("eval-001.csv")
df.eval<-get.m.df(dfa)
sum(df.eval$mean[df.eval$target=="obs"])
sum(df.eval$mean[df.eval$target=="ref"])
dfe<-df.eval

# Ensure q is ordered a-f
dfe$q <- factor(dfe$q, levels = c("a", "b", "c", "d", "e", "f"))

# Reshape data: rows = q, columns = corp, values = dist
# bar_mat <- tapply(dfe$median, list(dfe$q, dfe$target), identity)
# bar_mat <- t(bar_mat)  # barplot expects groups in columns
# 
# # Make grouped barplot
# df.plot<-barplot(bar_mat,
#         beside = TRUE,
#         col = c("black", "red"),
#         names.arg = levels(dfe$q),
#         legend.text = rownames(bar_mat),
#         args.legend = list(x = "right"),
#         ylab = "median distance",
#         main = "Grouped barplot of distance by query and corp")
# df.eval$mean==mdf$mean
# df.eval$median==mdf$median
# df.eval$mean<-mdf$mean
# df.eval$median<-mdf$median
# # Set colors: black for obs, red for ref
# bar_colors <- ifelse(df.eval$target == "obs", "black", "red")
# 
# # Set bar names: combine condition and corpus for clarity
# bar_names <- paste0(df.eval$q)
# 
# barplot(
#   height = as.numeric(df.eval$mean),
#   names.arg = bar_names,
#   col = bar_colors,
#   las = 1,
#   cex.names = 0.7,
#   main = "Distances distribution of corpus/reference corpus over conditions",
#   ylab = "token distance",
#   beside = TRUE
# )
# legend("topright", legend = c("obs", "ref"), fill = c("black", "red"))
# bar_matrix <- t(as.matrix(df.eval$median[df.eval$target%in%c("obs", "ref")]))
# t.sum<-rowSums(df1_wide[,3:length(df1_wide)],na.rm = T)
# t.sum<-rowSums(df1_wide,na.rm = T)
# t.sum
#bar_matrix <- t.sum
# Plot grouped barplot
# barplot(
#   bar_matrix,
#   beside = TRUE,
#   #  names.arg = c("0",levels(df1_wide$q)[2:6]),
#   col = c("black", "red"),
#   las = 1,
#   cex.names = 0.7,
#   main = "Distances distribution over conditions",
#   ylab = "same-noun distance"
# )
# legend("topright", legend = c("obs", "ref"), fill = c("black", "red"))
#anova_model <- aov(dist ~ group + q + mf_rel , range, data = df)
#summary(anova_model)
#not. wks




