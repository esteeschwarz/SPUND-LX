ftx<-list.files("/Users/guhl/boxHKW/UNIhkw/21S/DH/local/SPUND/2025/huening/audio_transcripts",pattern=".txt$",recursive=T,full.names=T)
fmp<-list.files("/Users/guhl/boxHKW/UNIhkw/21S/DH/local/SPUND/2025/huening/audio_transcripts",pattern=".mp3$",recursive=T,full.names=T)
df<-data.frame(audio=fmp,text=NA,language=NA)
df$text[seq_along(ftx)]<-ftx
write.csv(df,paste0(Sys.getenv("GIT_TOP"),"/SPUND-LX/germanic/HA/drafts/audioDF.csv"))
ftx2<-list.files("/Users/guhl/boxHKW/UNIhkw/21S/DH/local/SPUND/2025/huening/audio_transcripts/Hertie_School",pattern=".txt$",recursive=T,full.names=T)
length(ftx2)
file.copy(ftx2,"/Users/guhl/Documents/GitHub/SPUND-LX/germanic/HA/utube-audio/transcripts/2/")
