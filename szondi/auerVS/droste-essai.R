# install.packages("gutenberg_works")
# library(gutenbergr)
# csvlist = "https://docs.google.com/spreadsheets/d/e/2PACX-1vT87reVxrWeaYiRL6hP-fnPB9MX6Rq4eZHdEURjbzY5MbY7Q5Y59MWZYc309CqIqLxBmdaRog5BhbWn/pub?gid=0&single=true&output=csv"
# 
# booklist <- read.csv(csvlist, header = TRUE, stringsAsFactors=FALSE)
# path2 <- "/Users/djw12/Desktop/stylo/corpus/"
# 
# for (row in 1:nrow(booklist)){
#   bookname <- booklist[row,4]
#   stylotext <- gutenberg_download(booklist[row,1])
#   stylotext <- select(stylotext, text)
#   write.table(stylotext, file = paste0(path2, bookname), sep="", row.names = FALSE)
# }
# 
# dta <- gutenberg_download(6698)
# a1<- gutenberg_authors()
# library(gutenberg_works)
# works<-gutenberg_works(languages = "de")
# m<-grep("Droste",works$author)
# works$title[m]
#####################################
### droste judenbuche fetch gutenberg
dr1<-readLines("https://www.gutenberg.org/ebooks/45798.txt.utf-8")
##################################################################
dr1
m<-grep(1738,dr1)
m2<-grep("End of Project Gutenberg's Die Judenbuche, by Annette von Droste-Hülshoff",dr1)
m
dr1[m]
dr2<-dr1[m:m2] 
stext<-dr1[11:m2]
head(stext)
writeLines(stext,"~/Documents/GitHub/SPUND-LX/szondi/auerVS/judenbuche.txt")
#library(quanteda)
#library(collostructions)
t1<-tokenize_word1(dr2)
frf<-function(x)freq.list(x)
fr1<-lapply(t1, frf)
f1<-freq.list(unlist(t1))
#stopl<-read.csv("/Users/guhl/boxHKW/21S/DH/local/R/rmdessais/corpus/wolf_LE_stopwords.csv",sep = ";")
#stop2<-readLines("/Users/guhl/Documents/GitHub/ETCRA5_dd23/R/data/stopword_list_de.txt")
stopx<-stopl[stopl$stop==T,]
stop3<-c(stop2,stopx$word)
m<-f1$WORD%in%stop3
sum(m)
f2<-f1[!m,]
f2
m<-grep("holz",f2$WORD)
m<-grep("jud",f2$WORD)
m<-grep("jud|Jud",dr2)
#f2[m,]
dr2[m]
### topic: holz
# frame holz, word field analysis

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
# annotations <- annotate(text, list(Maxent_Sent_Token_Annotator(language = "de"), 
#                                    Maxent_Word_Token_Annotator(language = "de"), 
#                                    entity_annotator))

# Extract the named entities
named_entities <- subset(annotations, type == "entity")

# Print the named entities
print(named_entities[[1]])
annotations[[1]]

entity_annotator(s,a2)
nes<-s[entity_annotator(s,a2)]
nes<-gsub("\n"," ",nes)
write.csv(nes,"named-entities.csv")
###################################
head(named_entities)
x<-named_entities
x.df<-data.frame(x)
x<-x.df
length(x[[1]])
type(x[[1]])
library(stringi)
s
text.ch<-stri_split_boundaries(s,type="character")
l.text<-length(text.ch[[1]])
?stri_split_boundaries
eplot<-data.frame(point=1:l.text,ner=0)
#put.ner<-function(x)e<-eplot[x[["start"]]:x[["end"]]]<-1
e<-eplot
put.ner<-function(x.df,eplot){
k<-1
ner.df<-eplot

    for(k in 1:length(x.df$id)){
    ne.array<-c(x.df$start[k]:x.df$end[k])
    ner.df$ner[ne.array]<-1
  }
  return(ner.df)
}
ner.plot<-put.ner(x.df,eplot)
save(ner.plot,file = "ner.plot.RData")
barplot(ner.plot)
plot(ner.plot,type="h",main="named entities over text",xlab="characters")
?plot
scatter.smooth(ner.plot)
hist(ner.plot$ner)
max(ner.plot$ner)
put.ner<-function(x)e$ner[x["start"]:x["end"]]<-1
lapply(x.df, put.ner)
