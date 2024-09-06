install.packages("epubr")
# Load the package
library(epubr)

# Read the EPUB file
epub_data <- epub("sample.epub")

# Extract and print metadata
metadata <- epub_data$metadata
print(metadata)

# Extract and print text content
text_content <- epub_data$data
print(text_content)

f<-list.files()
m<-grep(".epub",f)
f.m<-f[m]
ep<-epub(f.m[1])
print(ep$date)
date.array<-array()
text.df<-data.frame(id=1:length(f.m),date=NA,text=NA)
for (k in 1:length(f.m)){
  ep<-epub(f.m[k])
  text.df$id[k]=k
  text.df$date[k]<-ep$date
  text.df$text[k]<-ep$data
  
  
}
save(text.df,file="../text.df.Rdata")
m<-grep("afd|AfD|AFD",)
text.df$text[[1]]$text[6]
grep.af<-function(x)m<-grep("afd|AfD|AFD",x["text"])
m.af<-lapply(text.df$text, grep.af)
m.na<-sum(m.af)>0
unlist(m.af)
