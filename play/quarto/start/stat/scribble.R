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


## KW44

### 3.1

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
