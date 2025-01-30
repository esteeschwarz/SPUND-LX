# 20250127(17.11)
# 15053.wolf.handout.functions
##############################
# calculates posgram statistics of textcorpus
############################################
src.tp<-"~/boxHKW/21S/DH/local/AVL/2024/WIT/ff.txt"
t1<-readLines(src.tp)
library(quanteda)
library(udpipe)
library(collostructions)
library(tidytext)
###############

### create vertical corpus
model<-udpipe::udpipe_load_model("~/Documents/GitHub/SPUND-LX/intLX/createcorp/modeldir/german-gsd-ud-2.5-191206.udpipe")
get.ann.df<-function(x){
  cor.tok<-udpipe::udpipe_annotate(model,x)
  return(as.data.frame(cor.tok))
}
i<-1
tdf<-lapply(seq_along(1:length(t1)),function(i){
  com.vrt.s<-tokenize_sentence(t1[i])
ts<-unlist(com.vrt.s)
com.vrt.t<-udpipe::udpipe_annotate(model,ts)
tok<-unlist(head(com.vrt.t$conllu,20))
df<-as.data.frame(com.vrt.t)
})
tdf2<-data.frame(abind(tdf,along = 1))
# wks.
##########################
get.ngrams<-function(text,n){
  #text<-tdf2$token
  #text<-t1[1]
#  print(text)
 # print("get.ngrams...")
  text_df <- data.frame(line = 1:length(text), text = text, stringsAsFactors = FALSE)
  ngrams_df.2 <- text_df %>%
    unnest_tokens(ngram, text, token = "ngrams", to_lower=F,n=n)
}
t.ngrams.3<-lapply(seq_along(1:length(t1)),function(i,n){
  t<-t1[i]
#  print(head(t))
  ng<-get.ngrams(t,n=3)
})
ng3<-data.frame(abind(t.ngrams.3,along = 1))
t.ng3<-table(ng3$ngram)
nf3<-freq.list(ng3$ngram)
length(ng3$ngram)==length(nf3$FREQ)
# no double 3-grams
###################
t.ngrams.2<-lapply(seq_along(1:length(t1)),function(i,n){
  t<-t1[i]
 # print(head(t))
  ng<-get.ngrams(t,n=2)
})
ng2<-data.frame(abind(t.ngrams.2,along = 1))
t.ng2<-table(ng2$ngram)
nf2<-freq.list(ng2$ngram)
length(ng2$ngram)-length(nf2$FREQ)
print(head(nf2,10))
# F: 48 multiple 2-grams
########################
# posgrams
  tdf2$upos[tdf2$token=="it"]<-NA
  upna<-tdf2[!is.na(tdf2$upos),]
  m<-grepl("[,;:]|it",upna$token)
  sum(m)
  upna<-upna$upos[!m]
ann<-paste0(upna,collapse = " ")
  posg3<-get.ngrams(ann,n=3)
nf.p3<-freq.list(posg3$ngram)
posg4<-get.ngrams(ann,n=4)
nf.p4<-freq.list(posg4$ngram)
posg5<-get.ngrams(ann,n=5)
nf.p5<-freq.list(posg5$ngram)
nf3.e<-head(nf.p3,10)
nf3.e
nf3.sam<-strsplit(as.character(nf3.e$WORD),split = " ")
nf3.2<-lapply(nf3.sam,toupper)
nf3.2
nfu<-unique(unlist(nf3.2))
nf3.ex<-lapply(seq_along(1:length(nfu)), function(i){
  t<-tdf2$token[tdf2$upos==nfu[i]]
  tf<-freq.list(t)
#  tf<-tf[tf$WORD!="it",]
  tout<-tf$WORD[1]
})
print(nf3.e)
pos.sample<-data.frame(pos=nfu,bsp=unlist(nf3.ex))
pos.sample
#print()
handlist<-list(grams=head(nf2,10),posgrams=head(nf3.e,10),possample=pos.sample)
handlist
ps2<-lapply(seq_along(1:length(pos.sample$pos)), function(i){
sam<-gsub(pos.sample$pos[i],pos.sample$bsp[i],unlist(nf3.2))  
})
i<-1
ps2<-lapply(seq_along(1:length(nf3.2)), function(i){
  sam<-nf3.2[[i]]
  for(k in 1:length(pos.sample$pos)){
    sam<-gsub(pos.sample$pos[k],pos.sample$bsp[k],sam)
   # print(sam)
  }
  return(sam)
})
ps2
#sam
nf3.e$BEISPIEL<-ps2
nf3.e<-nf3.e[,c(1,3,2)]
nf3.e
colnames(nf3.e)<-c("POS-gram","BEISPIEL","FREQ")
colnames(nf2)<-c("2-gram","FREQ")

handlist<-list(grams=head(nf2,10),posgrams=head(nf3.e,10))
handlist
#?stderr
#?

######## keyword analysis
#########################
# Q reference corpus frequencies: <https://www.ids-mannheim.de/digspra/kl/projekte/methoden/derewo/>
# load into workspace:
# fr.ref<-load("/Users/guhl/boxHKW/21S/DH/local/SPUND/corpuslx/DeReKo.freq.ref.RData")
lemmalist<-tdf2$lemma
get.key.data<-function(){
  library(tm)
  library(dplyr)

  # corpus to analyse as text vector
  # k2<-read.csv("~/Documents/static/server/ada/es/r/knitessai/db/wolfdb003.csv")
  # k2<-k2$content[k2$book=="FF"]  
  k2<-paste0(lemmalist,collapse = " ")
  
#####
# k1 (reference corpus loaded from saved dataframe)
load("/Users/guhl/boxHKW/21S/DH/local/SPUND/corpuslx/DeReKo.freq.ref.RData")
  return(list(k1=k1,k2=k2))
}
get.keys<-function(run){
  if(run)
    corpora<-get.key.data()
  # Sample given text
  given_text <- "This is a sample text. This text is for keyword analysis. We do not change anything important in the text but only ugly words."
  #library(readtext)
  #text<-readtext()
  # Sample reference corpus
  #reference_corpus <- "This is a reference corpus. It contains many words. This corpus is used for comparison."
  
  # Create a Corpus object for both texts
  # given_corpus <- Corpus(VectorSource(given_text))
  #reference_corpus <- Corpus(VectorSource(reference_corpus))
  k1<-corpora$k1
  #g2<-Corpus(VectorSource(k2$token))
  g2<-Corpus(VectorSource(corpora$k2))
  given_corpus<-g2
  # Tokenize and clean the text
  clean_corpus <- function(corpus) {
    # corpus <- tm_map(corpus, content_transformer(tolower)) # no difference: wolf text wo capital letters
    corpus <- tm_map(corpus, removePunctuation)
    corpus <- tm_map(corpus, removeNumbers)
    corpus <- tm_map(corpus, removeWords, stopwords("en"))
    corpus <- tm_map(corpus, stripWhitespace)
    return(corpus)
  }
  
  #c2<-tm_map(k2)
  given_corpus <- clean_corpus(given_corpus)
  #reference_corpus <- clean_corpus(reference_corpus)
  #given_corpus <- clean_corpus(given_corpus)
  
  # Create a Document-Term Matrix
  given_dtm <- DocumentTermMatrix(given_corpus)
  #reference_dtm <- DocumentTermMatrix(reference_corpus)
  
  # Convert to data frames
  given_freq <- as.data.frame(as.matrix(given_dtm))
  # no
  #library(collostructions)
  #given_corpus
  #given_freq<-freq.list(k2$token)
  #reference_freq <- as.data.frame(as.matrix(reference_dtm))
  
  # Sum the frequencies of each token
  given_freq <- colSums(given_freq)
  #reference_freq <- colSums(reference_freq)
  #reference_freq<-k1
  reference_freq<-k1[,c(1,4)]
  ### tolower tokens:
  lowcaps<-lapply(reference_freq$token, tolower)
  reference_freq$token_lc<-lowcaps
  reference_freq.dp<-duplicated(lowcaps)
  sum(reference_freq.dp)
  # Sample dataframe
  df <- data.frame(
    token = c("a", "b", "a", "c", "b", "d"),
    frequency = c(1, 2, 3, 4, 5, 6)
  )
  
  # Merge duplicated tokens by summing their frequencies
  merged_df <- df %>%
    group_by(token) %>%
    summarise(frequency = sum(frequency))
  
  #print(merged_df)
  ref_freq_merged<- reference_freq %>%
    group_by(token_lc) %>%
    summarise(frequency =sum(freq))
  
  head(given_freq)
  head(ref_freq_merged)
  colnames(ref_freq_merged)<-c("token","freq")
  #colnames(reference_freq)<-c("token","freq")
  given_freq <- data.frame(token = names(given_freq), freq = given_freq)
  m<-given_freq$token%in%ref_freq_merged$token
  sum(m)
  tok.out<-given_freq$token[!m]
  tok.out.df<-data.frame(token=tok.out,freq=1)
  colnames(tok.out.df)==colnames(ref_freq_merged)
  ref_freq_plus<-rbind(ref_freq_merged,tok.out.df)
  #jfreq<-join.freqs(given_freq,reference_freq,all = T)
  #c1<-collex.dist(jfreq)
  #c1%>%arrange(desc(COLL.STR.LOGL))
  # Convert to data frames
  #reference_freq <- data.frame(token = names(reference_freq), freq = reference_freq)
  # Merge the frequency data frames
  #  freq_comparison <- merge(given_freq, reference_freq, by = "token", all = F)
  freq_comparison <- merge(given_freq, ref_freq_plus, by = "token", all = F)
  colnames(freq_comparison) <- c("token", "given_freq", "reference_freq")
  freq_comparison$token[52]==freq_comparison$token[75]
  # Replace NA values with 0
  freq_comparison[is.na(freq_comparison[,2:3]),2:3] <- 0
  
  # Calculate the keyword score (e.g., log-likelihood ratio)
  freq_comparison <- freq_comparison %>%
    mutate(keyword_score = (given_freq + 1) / (reference_freq + 1))
  
  # Sort by keyword score
  freq_comparison <- freq_comparison %>%
    arrange(desc(keyword_score))
  length(freq_comparison$token)
  length(unique(freq_comparison$token))
  
  # Print the top keywords
  print(freq_comparison)
  return(list(freq_comparison=freq_comparison,ntypes=c(lq=length(given_freq$freq),lref=length(reference_freq$freq))))
}

get.m.dif<-function(){
###15056.apps.2-3pgs

witfolder<-"/Users/guhl/Library/Mobile Documents/iCloud~QReader~MarginStudy~easy/Documents/MN3/A_UNI/SZONDI/wittlerProsePoem"
f<-list.files(witfolder)
fns<-paste(witfolder,f,sep = "/")
m<-grep("Handout",f)
#sum(m)
#library(pdftools)
t1<-pdf_text(fns[m][1])
t1
fns[1]
th<-lapply(seq_along(1:length(fns[m])), function(i){
  t1<-pdf_text(fns[m][i])
  #  tl<-unlist(strsplit(t1," "))
  # to<-list(text=t1,lengt=length(tl))
})
tl<-lapply(seq_along(1:length(th)), function(i){
  #t1<-pdf_text(fns[i])
  tl<-unlist(strsplit(th[[i]]," "))
  to<-list(lengt=length(tl))
})

tm<-"~/Documents/GitHub/SPUND-LX/szondi/WITprose/handout/14-wolf_handout.pdf"
tmt<-pdf_text(tm)
tml<-unlist(strsplit(tmt[[1]]," "))
tml<-length(tml)
thl<-unlist(tl)
hons<-pdf_info(fns[m][1])
library(tools)
mbase<-basename(tm)
thdf<-data.frame(ho=c(f[m],mbase),length=c(thl,tml))
thdf$ho<-gsub("Handout|.pdf","",thdf$ho)
#par(las=3,pty="m")
barplot_heights <- barplot(thdf$length, names.arg = NULL, col = "grey", ylim = c(0, max(thdf$length) + 2))
# text(x = barplot_heights, y = thdf$length - 0.5, labels = thdf$ho, srt = 90, adj = 1, col = 1)
text(x = barplot_heights, y = 1, labels = thdf$ho, adj=c(0,1),srt = 90, col = 1)
#barplot(thdf$length~thdf$ho,ylab = "wds",xlab = "")
hom<-mean(c(thl,tml))
dif<-tml-hom
return(list(thdf,dif))
}
