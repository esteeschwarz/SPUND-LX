# 20261012(14.40)
# 17423.lx.statistics
# scribble
#####################
# Q1: https://benjamins.com/sites/z.195/content/
# Q2: https://benjamins.com/sites/z.195/download/r_package/Rling_1.0.tar.gz


library(modeest)

#f<-"~/Downloads/Rling_1.0.tar"
#install.packages(pkgs = f, repos = NULL, type = "source")

library(Rling)

data(ldt)
str(ldt)
attach(ldt)
mean(Length)
hist(Mean_RT)
plot(density(Mean_RT))
qqnorm(Mean_RT)
qqline(Mean_RT)
summary(Length)

## KW44

### Q1, ex 3.1

#s<-Subj1,Subj2,Subj3,Subj4,Subj5,Subj6,Subj7,Subj8,Subj9,Subj10

s1<-"Subj 1	Subj 2	Subj 3	Subj 4	Subj 5	Subj 6	Subj 7	Subj 8	Subj 9	Subj 10"
s2<-"Reaction time, ms	583	667	1149	827	488	452	NA	739	455	572"

s11<-strsplit(s1,"\t")
s11<-gsub(" ","",unlist(s11))
s11
s21<-unlist(strsplit(s2,"\t"))
s21<-s21[2:length(s21)]
df<-data.frame(id=s11,rt=as.double(s21))
df
attach(df)
mean(rt,na.rm=T)
median(rt,na.rm=T)
b1<-boxplot(rt)
b1

###
head(ldt)
library(xml2)
library(lmerTest)
lm1<-lmer(Mean_RT~Length+(1|Freq),ldt)
summary(lm1)
lm2<-lmer(Mean_RT~Freq+(1|Length),ldt)
summary(lm2)
# lm7<-lmer(Mean_RT~Length+(1|Freq),ldt)
# summary(lm7)
# lm8<-lmer(Mean_RT~Freq+(1|Length),ldt)
# summary(lm2)
lm3<-lm(Mean_RT~Length+Freq,ldt)
summary(lm3)
lm4<-lm(Mean_RT~Freq+Length,ldt)
summary(lm4)
lm5<-lm(Mean_RT~Freq*Length,ldt)
summary(lm5)
ldt2<-ldt[order(ldt$Freq),]
head(ldt2)
lm6<-lm(Mean_RT~Freq+Length,ldt2)
summary(lm6)
# > intercept estimate: general mean: no matter how df is sorted! probably only if predictor is continuos
############

var(Length)
sd(Length)
b1
IQR(Length)
summary(ldt)
summary(df)
b2<-boxplot(Length)
b2
IQR(rt,na.rm=T)
mad(rt,na.rm = T)
attach(ldt)
head(ldt)
m<-ldt$Length==8|ldt$Length==10
#ldt[Freq==10,]
mean(ldt$Freq[m])
max(ldt$Freq[m])
min(ldt$Freq[m])
ldt[m,]
summary(ldt)
mean(Length)

# summe der q. abweichungen durch n-1
a<-lapply(ldt$Length,function(x){
  a<-(x-mean(ldt$Length))^2
  #a<-a/(length(Length)
  #a<-sqrt(a)
})

#a3<-apply(Length)
a2<-sum(unlist(a))/(length(Length)-1)
a2<-sqrt(a2)
a2
sd(Length)
var(ldt$Length)
a3<-lapply(ldt$Length,function(x){
  a<-(x-median(ldt$Length))^2
  a<-sqrt(a)
})
a4<-sum(unlist(a3))/(length(Length)-1)
a4<-sqrt(a4)
a4
ldt$Length[50]<-5

library(lme4)
?clmm
??clmm


### KW45
### chapter 4
#############

library(Rling)
data(colreg)
freqreg<-apply(colreg,2,sum)
freqreg
freqreg <- c(95385672, 90344134, 91044778, 187245672)
exp_prop <- prop.table(freqreg)
exp_prop

black_obs <- prop.table(colreg[1,])
black_obs
obs_prop<-lapply(1:length(colreg[,1]),function(x){
  black_obs <- prop.table(colreg[x,])
})
obs_prop
library(abind)
obs_prop_df<-data.frame(abind(obs_prop,along=1))
data.frame(obs_prop)
abind(obs_prop)
obs_prop_df
prop_df<-obs_prop_df
prop_df$DP<-apply(prop_df,1,function(x){
  sum(abs(x-exp_prop)/2)
})
prop_df
prop_df$DP_norm<-prop_df$DP/(1-min(exp_prop))

primcol <- colreg[c(1, 2, 5, 9:11),]
seccol <- colreg[-c(1, 2, 5, 9:11),]

primcol_sums <- colSums(primcol)
seccol_sums <- colSums(seccol)

primcol_obs <- prop.table(primcol_sums)
seccol_obs <- prop.table(seccol_sums)

DP_primcol <- sum(abs(primcol_obs - exp_prop))/2
DP_seccol <- sum(abs(seccol_obs - exp_prop))/2

DP_primcol_norm <- DP_primcol/(1 - min(exp_prop))
DP_seccol_norm <- DP_seccol/(1 - min(exp_prop))

prop_df$prime[c(1, 2, 5, 9:11)]<-T
prop_df$prime[-c(1, 2, 5, 9:11)]<-F
seccol <- colreg[-c(1, 2, 5, 9:11),]

colreg$prime[c(1, 2, 5, 9:11)]<-T
colreg$prime[-c(1, 2, 5, 9:11)]<-F


library(lme4)
library(lmerTest)
prop_df

df<-"      spoken   fiction   academic     press        DP   DP_norm prime
black  0.12597181 0.2547189 0.16659130 0.4527180 0.1092091 0.1356127  TRUE
blue   0.09094785 0.4281506 0.06986299 0.4110385 0.2409614 0.2992189  TRUE
brown  0.04770723 0.4393897 0.04835138 0.4645517 0.3057136 0.3796264 FALSE
gray   0.05520892 0.5738325 0.06092834 0.3100303 0.3791338 0.4707974 FALSE
green  0.07786654 0.2904462 0.09031308 0.5413742 0.2335926 0.2900686  TRUE
orange 0.08727852 0.3277398 0.04443611 0.5405456 0.2700576 0.3353497 FALSE
pink   0.06323123 0.4806100 0.03838570 0.4177731 0.3001553 0.3727242 FALSE
purple 0.07847907 0.4309307 0.05492255 0.4356676 0.2683706 0.3332549 FALSE
red    0.09964442 0.3460818 0.07746906 0.4768048 0.2246587 0.2789748  TRUE
white  0.10608482 0.2986338 0.19302540 0.4022560 0.1039351 0.1290636  TRUE
yellow 0.05588467 0.4371764 0.07684660 0.4300924 0.2690410 0.3340873  TRUE
"

library(tidyr)
library(tibble)

df_long <- prop_df |>
  rownames_to_column("color") |>
  pivot_longer(
    cols = c(spoken, fiction, academic, press),
    names_to = "category",
    values_to = "value"
  ) |>
  select(color, category, value, DP, DP_norm, prime)

col_long <- colreg |>
  rownames_to_column("color") |>
  pivot_longer(
    cols = c(spoken, fiction, academic, press),
    names_to = "category",
    values_to = "value"
  ) |>
  select(color, category, value, prime)

lm1<-lmer(value~prime+category+(1|color),df_long)
summary(lm1)
lm2<-lmer(value~prime+category+(1|color),df_long)
summary(lm2)
#anova(lm1,lm2)

lm3<-lmer(value~prime+category+(1|color),col_long)
summary(lm3)
lm4<-lmer(value~category+prime+(1|color),col_long)
summary(lm4)
#anova(lm2,lm4)
