# library(gutenbergr)
# works<-gutenberg_works(languages = "de")
# m<-grep("Droste",works$author)
# works$title[m]
# doesnt exist in database, get id from page
#####################################
### droste judenbuche fetch gutenberg
dr1<-readLines("https://www.gutenberg.org/ebooks/45798.txt.utf-8")
##################################################################
#dr1
m<-grep(1738,dr1)
m2<-grep("End of Project Gutenberg's Die Judenbuche, by Annette von Droste-Hülshoff",dr1)
m
dr1[m]
dr2<-dr1[m:m2] 
stext<-dr1[11:m2]
head(stext)
#writeLines(stext,"~/Documents/GitHub/SPUND-LX/szondi/auerVS/judenbuche.txt")
library(quanteda)
library(collostructions)
topic.func<-function(){
t1<-tokenize_word1(stext)
frf<-function(x)freq.list(x)
fr1<-lapply(t1, frf)
f1<-freq.list(unlist(t1))
#stopl<-read.csv("/Users/guhl/boxHKW/21S/DH/local/R/rmdessais/corpus/wolf_LE_stopwords.csv",sep = ";")
#stop2<-readLines("/Users/guhl/Documents/GitHub/ETCRA5_dd23/R/data/stopword_list_de.txt")
#stopx<-stopl[stopl$stop==T,]
#stop3<-c(stop2,stopx$word)
#m<-f1$WORD%in%stop3
#sum(m)
#f2<-f1[!m,]
f2<-f1
#m<-grep("holz",f2$WORD)
#dr2[m]
### topic: holz
# frame holz, word field analysis
return(f1)
}
flist<-topic.func()
head(flist)
m<-grep("Axt",flist$WORD)
m<-grep("Axt|Äxte",stext)
#sum(m)
stext[1000]
m1<-paste(m-1,m,m+1)
m1
writeLines(paste("LINE:",m,stext[m-1],stext[m],stext[m+1]),"~/Documents/GitHub/SPUND-LX/szondi/auerVS/axt.txt")

m<-grep("Kuh|Kühe",stext)
sum(m)
m2<-paste(m-1,m,m+1)
m2
paste(stext[m-1],stext[m],stext[m+1])
writeLines(paste("LINE:",m,stext[m-1],stext[m],stext[m+1]),"~/Documents/GitHub/SPUND-LX/szondi/auerVS/kuehe.txt")

m<-grepl("Blaukittel",stext)
sum(m)

flist[m,]
#################################
# sitzung 22.05. latour actor-network

#install.packages(c("NLP", "openNLP", "openNLPmodels.de"))
#install.packages("openNLPmodels.de",repos = "https://datacube.wu.ac.at")
#install.packages("openNLPmodels.en")
#install.packages("openNLPmodels.en",repos = "https://datacube.wu.ac.at")

library(NLP)
library(openNLP)
library(openNLPmodels.de)
library(openNLPmodels.en)

text<-stext
text <- as.String(text)
s<-text
sent_token_annotator<-Maxent_Sent_Token_Annotator(language = "de")
word_token_annotator<-Maxent_Word_Token_Annotator(language = "de")
entity_annotator<-Maxent_Entity_Annotator()
a2<-annotate(s,list(sent_token_annotator,word_token_annotator))
# Annotate the text to find the words, numbers, punctuation, sentences, and named entities
annotations <- annotate(text, list(Maxent_Sent_Token_Annotator(language = "de"), 
                                    Maxent_Word_Token_Annotator(language = "de"), 
                                    entity_annotator))

# Extract the named entities
named_entities <- subset(annotations, type == "entity")

# Print the named entities
print(named_entities[[1]])
annotations[[1]]

#entity_annotator(s,a2)
nes<-s[entity_annotator(s,a2)]
nes<-gsub("\n"," ",nes)
#write.csv(nes,"named-entities.csv")
head(nes)
###################################
head(named_entities)
ent.edit<-read.csv("named-entities.edited.csv")
x<-named_entities
x.df<-data.frame(x)
x<-x.df
x.df$entity<-ent.edit$X.1
length(x[[1]])
type(x[[1]])
library(stringi)
#s
text.ch<-stri_split_boundaries(s,type="character")
l.text<-length(text.ch[[1]])
#?stri_split_boundaries
eplot<-data.frame(point=1:l.text,ner=0)
#put.ner<-function(x)e<-eplot[x[["start"]]:x[["end"]]]<-1
e<-eplot
put.ner<-function(x.df,eplot){
k<-1
ner.df<-eplot
m<-x.df$entity!=""
sum(m)
x.df<-x.df[m,]

    for(k in 1:length(x.df$id)){
    ne.array<-c(x.df$start[k]:x.df$end[k])
    ner.df$ner[ne.array]<-1
  }
  return(ner.df)
}
ner.plot<-put.ner(x.df,eplot)
#save(ner.plot,file = "ner.plot.RData")
plot(ner.plot,type="h",main="named entities over text",xlab="characters")
ner.t<-table(x.df$entity)
m<-names(ner.t)==""
ner.t<-ner.t[!m]
par(las=3)
?barplot
barplot(ner.t,horiz = F,log = "y",xpd = T,beside = T)
save(ner.t,file = "ner.table.RData")
####################################
### todo: blaukittel, network split text

length (stext)
head(stext,50)
stext[100:120]
##############

library(quanteda)

sent<-quanteda::tokenize_sentence(text)
sent[[1]][9] # start text
m<-grep("Axt",sent[[1]])
sent[[1]][m]
writeLines(paste(m,":",sent[[1]][m]),"~/Documents/GitHub/SPUND-LX/szondi/auerVS/axt.txt")
m<-grep("Kuh|Kühe",sent[[1]])
sent[[1]][m]
writeLines(paste(m,":",sent[[1]][m]),"~/Documents/GitHub/SPUND-LX/szondi/auerVS/kuehe.txt")
#####
sent.l<-unlist(sent)
sent.l<-sent.l[9:length(sent.l)]
### split model
### 777 sentences
### distance of tokens!

 tok.l<-tokenize_word1(text)
 tok.m<-matrix(unlist(tok.l))

t1<-c(letters[1:10],"d","e","a")
#dist(t1["a"],t1["d"])
m<-grep("a",t1)[1]
m2<-grep("d",t1)
d1<-m2-m
d1
m<-grep("b",t1)[1]
m2<-grep("d",t1)
d1<-m2-m
d1
load("ner.table.RData")
ent.array<-names(ner.t)
get.tok.dist<-function(toklist){
dist.m<-matrix(ncol = length(ent.array),nrow = length(ent.array))
k<-1
q<-1
o<-c(1:length(ent.array))
o1<-c(2,3:length(ent.array),1)
ent.q.array<-ent.array[o1]
    for (k in 1:length(ent.array)){
    ent<-ent.array[k]
    m1<-grep(ent,tok.m)[1]
    for (q in 1:length(ent.q.array)){
      cat(k,q,"\n")
    ent.q<-ent.q.array[q]
    m2<-grep(ent.q,tok.m)
    dist.m[k,q]<-mean(m2-m1)
    }
  }
}
