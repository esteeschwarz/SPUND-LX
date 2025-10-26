# 20251025(19.40)
# 16441.huening germanic languages VLSG.tasks
# 1.

# library(xml2)
# xm<-read_xml("~/boxHKW/21S/DH/local/SPUND/2025/huening/yiwiki.xml")
# xml2::xml_ns_strip(xm)
# all.x<-xml_find_all(xm,"*")
# all.text<-xml_text(all.x)
# s<-list(c(1:5000),c(5001:10000),c(10001:15000),c(15001:20000),c(20001:25000),c(25001:30000),c(30001:37179))
# 
# k<-1
# #s
# for(k in 1:length(s)){
# t<-all.text[s[[k]]]
# writeLines(t,paste0("~/boxHKW/21S/DH/local/SPUND/2025/huening/wikiext/yiwiki-",k,".txt"))
# 
# }
# t1<-paste0(t[1:30],collapse = " ")
# library(stanza)
# library(reticulate)
# py_install("stanza")
# stanza_initialize()
# stanza_download("de")
# stanza_download()
# stanza::stanza_download_method_code()
# p <- stanza_pipeline()
# p <- stanza_pipeline(processors = "tokenize,pos,lemma")
# 
# library(purrr)
# 
# doc <- p('R is a programming language for statistical computing.')%>%as.character()%>%fromJSON(simplifyDataFrame = T)
# doc <- p(t1)%>%as.character()%>%fromJSON(simplifyDataFrame = T)
# library(abind)
# p1<-abind(data.frame(doc))
# library(jsonlite)
# doc
# p1<-fromJSON(entities(doc),simplifyDataFrame = T)
# print(entities(doc))
# 
# ###
# library(httr)
# r<-GET("https://archive.org/stream/nybc212177/nybc212177_djvu.txt")
# htm<-read_html(content(r,"text"))
# p<-xml_find_all(htm,"//pre")
# t1<-xml_text(p)
# writeLines(t1,paste0("~/boxHKW/21S/DH/local/SPUND/2025/huening/golem.txt"))

f<-list.files("~/boxHKW/21S/DH/local/SPUND/2025/huening/skeconcordances")
f
pr<-readLines(paste0("~/boxHKW/21S/DH/local/SPUND/2025/huening/skeconcordances/",f[length(f)]))
pr[1]<-pr[5]
pr<-writeLines(pr,paste0("~/boxHKW/21S/DH/local/SPUND/2025/huening/skeconcordances/",f[length(f)]))
df<-read.csv(paste0("~/boxHKW/21S/DH/local/SPUND/2025/huening/skeconcordances/",f[length(f)]))
# 20 NN, +genus, +article, +adj
kw<-df$KWIC
s1<-strsplit(kw," ")
get.kx<-function(kw,k){
#n1<-n2[!grepl("[0-9a-zA-Z:/\\.)(,;-]",n2$token),]
  
s1<-strsplit(kw," ")
  
n1<-lapply(s1, function(x){
  l<-unlist(x)[k]
})
#n1<-unique(unlist(n1))
n1<-data.frame(id=1:length(n1),token=unlist(n1))
#n1<-n1[!is.na(n1$token),]
#n1<-n1[n1$token!="",]
#n2<-n1[order(n1)]
n2<-n1
#n1<-n2[!grepl("[0-9a-zA-Z:/\\.)(,;-]",n2$token),]
m<-grepl("^[\u0590-\u05FF]+$",n2)
n2[m]<-NA
n2[n2==""]<-NA
n2
}
k3<-get.kx(kw,3)
k1<-get.kx(kw,1)
k2<-get.kx(kw,2)
m1<-k2$token%in%k3$token
sum(m1)
m2<-k3$token%in%k2$token
sum(m2)
k2<-k2[!m1,]
k3<-k3[!m2,]
#k2
k2d<-data.frame(id=k2$id,token=k2$token,pos="ADJ",check=1)
k3d<-data.frame(id=k3$id,token=k3$token,pos="NOUN",check=1)
k4<-rbind(k2d,k3d)
#######################
repl.fun<-function(k4){
k4<-k4[order(k4$token),]
k4<-k4[!is.na(k4$token),]
m<-duplicated(k4$token)
k4<-k4[!m,]
library(stringi)
regx1<-"עם\\b"
regx2<-"ע\\b"
regx3<-"[מפרטכנקסדגבז]"
#regx3<-paste0("ן","[",regx3,"]","\\b")
regx3<-paste0(regx3,"ן")
regx3
regx4<-"לען\\b"
regx5<-"לע\\b"
regx6<-"[מקפנטרכסדגבז]"
regx6<-paste0(regx6,"ל","\\b")
regx6
regx7<-"[מקפטרכסדגבז]"
regx7<-paste0(regx7,"ע","\\b")
regx7
m1<-grepl(regx1,k4$token)
sum(m1)
k4$paradigm_he<-NA
k4$paradigm_lat<-NA
#k4$paradigm_he<-unlist(stri_extract_all_regex(k4$token,regx1))
length(unlist(stri_extract_all_regex(k4$token,regx1)))
length(stri_extract_all_regex(k4$token,regx1))
#k4$paradigm_he<-unlist(stri_extract_all_regex(k4$token,regx1))
k4$paradigm_he<-stri_extract_all_regex(k4$token,regx1)
k4$paradigm_lat[m1]<-"-em"
sum(!is.na(k4$paradigm_he))
m3<-grepl(regx3,k4$token)
regx3
sum(m3)
#k4$paradigm_he[m3]<-unlist(stri_extract_all_regex(k4$token,regx3))[m3]
k4$paradigm_he[m3]<-stri_extract_all_regex(k4$token,regx3)[m3]
k4$paradigm_lat[m3]<-"-en"
##############################
m2<-grepl(regx2,k4$token)
regx2
sum(m2)
#m<-!is.na(unlist(stri_extract_all_regex(k4$token[is.na(k4$paradigm_lat)],"ע\\b")))
k4$paradigm_he[m2]<-stri_extract_all_regex(k4$token,regx2)[m2]
#k4$paradigm_he[m2]<-unlist(stri_extract_all_regex(k4$token,regx2))[m2]
k4$paradigm_lat[m2]<-"-e"
m7<-grepl(regx7,k4$token)
regx7
sum(m7)
k4$paradigm_he[m7]<-unlist(stri_extract_all_regex(k4$token,regx7))[m7]
k4$paradigm_lat[m7]<-"-e"
m4<-grepl(regx4,k4$token)
#k4$paradigm_he[m4]<-unlist(stri_extract_all_regex(k4$token,regx4))[m4]
k4$paradigm_he[m4]<-stri_extract_all_regex(k4$token,regx4)[m4]
k4$paradigm_lat[m4]<-"-len"
m5<-grepl(regx5,k4$token)
#k4$paradigm_he[m5]<-unlist(stri_extract_all_regex(k4$token,regx5))[m5]
k4$paradigm_he[m5]<-stri_extract_all_regex(k4$token,regx5)[m5]
k4$paradigm_lat[m5]<-"-le"
m6<-grepl(regx6,k4$token)
sum(m6)
#k4$paradigm_he[m6]<-unlist(stri_extract_all_regex(k4$token,regx6))[m6]
k4$paradigm_he[m6]<-stri_extract_all_regex(k4$token,regx6)[m6]
k4$paradigm_lat[m6]<-"-el"
k4$kwic<-NA
k4$kwic[!is.na(k4$paradigm_lat)]<-kw[k4$id[!is.na(k4$paradigm_lat)]]
k5<-k4[!is.na(k4$kwic),]
}
k5<-repl.fun(k4)
mode(k5$paradigm_he)<-"character"
k51<-get.kx(k5$kwic,1)
k52<-get.kx(k5$kwic,2)
k53<-get.kx(k5$kwic,3)
k5$art<-k51$token
k5$adj<-k52$token
k5$noun<-k53$token
#write.csv(k5,paste0(Sys.getenv("GIT_TOP"),"/SPUND-LX/germanic/kwic5.csv"))
k5<-k6
get.sample<-function(k5){
  # m<-k5$chk_ann=="1"
  # sum(m)
#  sum(k6$art=="der"&!is.na(k6$chk_ann))
get.d<-function(n,k5){
sub1<-k5[k5$pos=="NOUN"&!is.na(k5$chk_ann),]
sub3<-k5[k5$pos=="NOUN"&!is.na(k5$chk_ann)&k5$art=="der",]
#sub1<-rbind(sub3,sub1)
sa.N<-sub1[sample(1:length(sub1$id),15),]
ifelse(length(sub3$id)>2,sa.d<-sub3[sample(1:length(sub3$id),3),],sa.d<-sub3)
sa.N<-rbind(sa.N,sa.d)
sub2<-k5[k5$pos=="ADJ"&!is.na(k5$chk_ann),]
sa.A<-sub2[sample(1:length(sub2$id),20),]
sa.AN<-rbind(sa.A,sa.N)
}
sa.AN<-get.d(5,k5)
chk.d<-sa.AN$art=="der"
# while(sum(chk.d)<3)
#    sa.AN<-get.d(5,k5)
   
return(sa.AN)
}
sa.AN<-get.sample(k6)
#write.csv(sa.AN,paste0(Sys.getenv("GIT_TOP"),"/SPUND-LX/germanic/sample-ADJ-NOUN.csv"))
#write.csv(kw,paste0(Sys.getenv("GIT_TOP"),"/SPUND-LX/germanic/kwic-all.csv"))
#kw[869]
k6<-k5
transdf<-read.csv(paste0(Sys.getenv("GIT_TOP"),"/SPUND-LX/germanic/translit.csv"))
k6$latin<-k6$kwic
get.trans<-function(s,transdf){
for(k in 1:length(transdf$id)){
cat("\r",k)
# k6$latin<-gsub(transdf$ivrit[k],transdf$latin[k],k6$latin)  
  s<-gsub(transdf$ivrit[k],transdf$latin[k],s)  
}
return(s)
}
k6$latin<-get.trans(k6$latin,transdf)  
k6$art<-get.trans(k6$art,transdf)  
k6$adj<-get.trans(k6$adj,transdf)  
k6$noun<-get.trans(k6$noun,transdf)  
#write.csv(k6,paste0(Sys.getenv("GIT_TOP"),"/SPUND-LX/germanic/kwic5.csv"))
noun.u<-unique(k6$noun)
noun.u<-data.frame(noun=noun.u,check=1)
nouns.c<-read.csv(paste0(Sys.getenv("GIT_TOP"),"/SPUND-LX/germanic/nouns_cor.csv"))
nouns.c5<-read.csv(paste0(Sys.getenv("GIT_TOP"),"/SPUND-LX/germanic/kwic5_cor.csv"))
m<-nouns.c$check==1
sum(m)
k6$chk_ann<-NA
m2<-k6$noun%in%nouns.c$noun[m]
sum(m2)
k6$chk_ann[m2]<-1
m<-!is.na(nouns.c5$chk_ann)
sum(m)
k6$chk_ann[m]<-1
sa.AN<-get.sample(k6)
#write.csv(noun.u,paste0(Sys.getenv("GIT_TOP"),"/SPUND-LX/germanic/nouns.csv"))
#####################
write.csv(k6,paste0(Sys.getenv("GIT_TOP"),"/SPUND-LX/germanic/kwic5.csv"))
write.csv(sa.AN,paste0(Sys.getenv("GIT_TOP"),"/SPUND-LX/germanic/sample-ADJ-NOUN.csv"))


