#20240526(10.03)
#14222.DA
#NER
srcfolder<-"/Users/guhl/Library/Mobile Documents/iCloud~QReader~MarginStudy/Documents/A_UNI/COMP/16822 discourse, stefanowitsch/"
files<-list.files(srcfolder)
filens<-paste0(srcfolder,files)
###############################
library(tesseract)
library(pdftools)
# prerequisites ocr engine
if(is.na(match("deu", tesseract_info()$available)))
  tesseract_download("deu")
# text <- ocr("https://jeroen.github.io/images/french_text.png", engine = french)
texts<-list()
k<-1
for (k in 1:length(filens)){
  cat(k,"\n")
  f<-filens[k]
  m<-grepl("#DA2",f)
f
    if(m){
    t1<-pdf_ocr_text(f,dpi=600,language  = "deu")
    texts[[k]]<-t1
  }
}
t1
m<-grep("#DA2",filens)
texts.nom.pass<-list()
texts.nom.pass[["texts"]]<-texts[m]
texts.nom.pass<-texts[m]
save(texts.nom.pass,file="~/Documents/GitHub/SPUND-LX/DA/nom-pass/texts.nom.pass.RData")

#######
# named entity extraction
library(NLP)
library(openNLP)
library(openNLPmodels.de)
library(openNLPmodels.en)

k<-2
for(k in 1:length(texts.nom.pass$texts)){
cat(k,"\n")  

text<-texts.nom.pass$texts[[k]]
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
print(named_entities)
annotations[[1]]

#entity_annotator(s,a2)
nes<-s[entity_annotator(s,a2)]
nes
nes<-gsub("\n"," ",nes)
#write.csv(nes,"named-entities.csv")
head(nes)
###################################
head(named_entities)
texts.nom.pass[["NER"]][[k]]<-nes
}
#save(texts.nom.pass,file="~/Documents/GitHub/SPUND-LX/DA/nom-pass/texts.nom.pass.RData")


