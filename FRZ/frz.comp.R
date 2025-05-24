
frd<-read.csv("frz.comp.csv")
frd
s<-sum(frd$n)
spr<-sum(frd$n[frd$t=="pr"])
spub<-sum(frd$n[frd$t=="pub"])
frd$p<-50
frd$vh<-frd$n/frd$p
sum(frd$vh)
spr<-sum(frd$vh[frd$t=="pr"])
spub<-sum(frd$vh[frd$t=="pub"])
(spub-spr)*100
sum(frd$prix)
smin<-min(frd$prix)
smax<-max(frd$prix)
smax-smin
