get.lm.df<-function(seed){
l.out<-1000
set.seed(seed)
dist<-sample(rep(sample(1000,500),l.out),l.out)
length(unique(dist))
aut_id<-sample(rep(letters,length.out=l.out),l.out)
url_id<-sample(rep(letters[1:10],length.out=l.out),l.out)
range<-sample(rep(10:20,length.out=l.out),l.out)
range.f<-sample(rep(c("small","large"),length.out=l.out),l.out)
embed.score<-sample(sample(rep(0:1000,length.out=l.out*2),l.out)/1000,1000)
length(unique(embed.score))<l.out
q<-sample(rep(letters[1:6],length.out=l.out),l.out)
det<-sample(rep(c("F","T"),length.out=l.out),l.out)
sample(det,20)
target<-sample(rep(c("obs","ref"),length.out=l.out),l.out)
df<-data.frame(id=1:l.out,dist,target,q,aut_id,url_id,range,embed.score,det,range.f)
head(df)

library(lme4)
library(lmerTest)

lm1<-lmer(dist~target*q+(1|aut_id),df)
summary(lm1)

m1<-mean(df$dist[df$target=="obs"])
m2<-mean(df$dist[df$target=="ref"&df$q=="a"])
md<-m1-m2
m1
m2
md
?lmer
lm0<-lmer(dist~(1|aut_id),df)
l0s<-summary(lm0)
print(md/2+m2-l0s$coefficients[1,1])

### if 0, ref/obs equal dist
sdf<-df
}
sdf<-get.lm.df(1115)


#save(sdf,file="/Users/guhl/Documents/GitHub/SPUND-LX/psych/HA/hu21-app/sdf.RData")

sdf2<-sdf
sdf2$target[sdf$target=="ref"]<-"Aref"
summary(lm1)
lmra<-lm(dist~range,sdf2)
sdf2$lmra<-lmra$residuals
lm2<-lmer(dist~target*q+(1|aut_id),sdf2,verbose = 1)
lm3<-lmer(dist~target+(1|aut_id),sdf2,verbose = 1)
lm4<-lmer(dist~target+range+(1|aut_id),sdf2,verbose = 1)
lm5<-lmer(dist~target*q+range+(1|aut_id),sdf2,verbose = 1)
lm0au<-lmer(dist~(1|aut_id),sdf2,verbose = 1)
lm00r<-lmer(dist~(1|range.f),sdf2,verbose = 1)
lm00ra<-lmer(dist~(1|range),sdf2,verbose = 1)
lm6<-lmer(dist~target+range+embed.score+(1|aut_id),sdf2,verbose = 1)
lm7<-lmer(dist~target+range+embed.score+(1|url_id),sdf2,verbose = 1)
lm8<-lmer(dist~target+range+embed.score+(1|url_id)+(1|q),sdf2,verbose = 1)
lm9<-lmer(dist~target+(1|aut_id)+(1|q),sdf2,verbose = 1)
lm10<-lmer(dist~target+(url_id|aut_id)+(1|q),sdf2,verbose = 1)
lm11<-lmer(dist~target+(1|range.f)+(1|aut_id)+(1|q),sdf2,verbose = 1)
lm12<-lmer(dist~lmra+(1|aut_id)+(1|q),sdf2,verbose = 1)
lm13<-lmer(dist~lmra*q+(1|aut_id),sdf2,verbose = 1)

summary(lm1)
summary(lm2)
summary(lm4)
head(sdf)
anova(lm0au,lm00r,lm00ra,lm2,lm3,lm4,lm5,lm6,lm7,lm8,lm9,lm10,lm11,lm12,lm13)
?anova

plot(xlab="Frequency (logged, base of 2)", x=jitter(x$FREQ),    
  ylab="Reaction time in ms", y=jitter(x$RT), pch=16,    col="#00000060"); 
grid() lines(x=ph$FREQ, y=ph$fit) polygon(x=c(ph$FREQ, rev(ph$FREQ)), 
  y=c(ph$lower, rev(ph$upper)),    
  col="#00000020", border=NA) abline(h=mean(x$RT), lty=3); 
abline(v=mean(x$FREQ), lty=3)


qltdn<-get.dist.norm(qltdf,T)
relem<-lm(dist~range,qltdn)
qltdn$relem<-relem$residuals
lm0a<-lmer(dist~(1|aut_id),qltdn)
lm0l<-lmer(relem~(1|aut_id),qltdn)
lm1d<-lmer(dist~target+(1|aut_id),qltdn) # range not in
lm1l<-lmer(relem~target+(1|aut_id),qltdn)
lm2r<-lmer(dist_rel_all~target+(1|aut_id),qltdn)
lm2s<-lmer(dist_rel_scaled~target+(1|aut_id),qltdn)
lm1dr<-lmer(dist~target+range+(1|aut_id),qltdn)
lm2dr<-lmer(dist~target+(1|range)+(1|aut_id),qltdn)
lm3l<-lmer(relem~target*q+(1|aut_id),qltdn) # range via relem residuals
lm3d<-lmer(dist_rel_all~target*q+(1|aut_id),qltdn) # range via rel_all normalisation
lm3s<-lmer(dist_rel_scaled~target*q+(1|aut_id),qltdn) # range via dist/range
anova(lm0a,lm0l,lm1d,lm1l,lm2r,lm2s,lm1dr,lm2dr,lm3l,lm3d,lm3s)
