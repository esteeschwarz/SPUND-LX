# 20240907(10.56)
# 14371.zeit.epub-corpus.grep.afd.occurences
############################################

library(epubr)
library(stringi)
library(quanteda)

f<-list.files()
m<-grep(".epub",f)
f.m<-f[m]
text.list<-list()
k<-"2012-03-15"
k<-3
for (k in 1:length(f.m)){
  ep<-epub(f.m[k])
  k.ns<-ep$date
  text.list[[k.ns]][["content"]]<-ep$data
print(k)  
}
text.list.s<-text.list[order(names(text.list))]
#save(text.list.s,file="../text.list.Rdata")
text.list<-text.list.s

grep.af.c<-grep.af<-function(x){
  regx<-"AfD|AFD"
  m.1<-grep(regx,x$content[[1]]$text)
  m.2<-stri_count_regex(x$content[[1]]$text[m.1],regx)
 # m.3<-x$content[[1]]$text[m.1]
  c.af<-corpus(x$content[[1]]$text[m.1])
  c.af.t<-tokens(c.af)
  m.af.kwic<-kwic(c.af.t,regx,valuetype = "regex",25)
}
m.af.corpus.kwic<-lapply(text.list, grep.af.c)
m.true<-function(x)x$keyword!=""
af.corpus.kwic.t<-lapply(m.af.corpus.kwic, m.true)
af.corpus.exc<-m.af.corpus.kwic[unlist(af.corpus.kwic.t)]
#save(m.af.corpus.kwic,file="../af.corpus.kwic.Rdata")
# outputs list with texts including keyword-in-25tokens-window-context

library(clipr)
library(knitr)
output<-lapply(m.af.corpus.kwic,kable)
write_clip(unlist(output))
