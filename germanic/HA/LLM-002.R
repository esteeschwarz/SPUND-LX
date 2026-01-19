ftx<-list.files("/Users/guhl/boxHKW/UNIhkw/21S/DH/local/SPUND/2025/huening/audio_transcripts",pattern=".txt$",recursive=T,full.names=T)
fmp<-list.files("/Users/guhl/boxHKW/UNIhkw/21S/DH/local/SPUND/2025/huening/audio_transcripts",pattern=".mp3$",recursive=T,full.names=T)
df<-data.frame(audio=fmp,text=NA,language=NA)
df$text[seq_along(ftx)]<-ftx
write.csv(df,paste0(Sys.getenv("GIT_TOP"),"/SPUND-LX/germanic/HA/drafts/audioDF.csv"))
ftx2<-list.files("/Users/guhl/boxHKW/UNIhkw/21S/DH/local/SPUND/2025/huening/audio_transcripts/Hertie_School",pattern=".txt$",recursive=T,full.names=T)
length(ftx2)
file.copy(ftx2,"/Users/guhl/Documents/GitHub/SPUND-LX/germanic/HA/utube-audio/transcripts/2/")
tdir<-list.dirs("/Users/guhl/Documents/GitHub/SPUND-LX/germanic/HA/utube-audio/transcripts")
library(abind)
tfns<-lapply(tdir[2:length(tdir)], function(x){
  fs<-list.files(x,full.names = T)
  tx<-lapply(fs,function(f){
    t<-readLines(f)
    m1<-grepl("-messy",t)
    m2<-"@false"%in%t
    m3<-sum(m1+m2)>0
    if(!m3)
      tdf<-data.frame(text=t)
  })
  tdf<-data.frame(abind(tx,along = 1)
})
tfns[[1]]
