f<-paste0(Sys.getenv("GIT_TOP"),"/SPUND-LX/play/quarto")
fc2<-list.files(f,recursive=T)
cat("check filecount mess > ",length(fc2),"files...")
save(fc,file=paste0(f,"fc2.RData"))
