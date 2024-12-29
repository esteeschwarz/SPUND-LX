library(udpipe)
get.ann.df<-function(model.dir,input,output){
t<-input
#t<-readLines(text)
#model.dir<-"./modeldir"
#dir.create(model.dir)
#udpipe::udpipe_download_model("german-gsd",model_dir = model.dir)
model<-list.files(model.dir)
model<-paste(model.dir,model[1],sep = "/")
#print(model)
model<-udpipe::udpipe_load_model(model)
pos1<-udpipe_annotate(model,t)
pos.df<-as.data.frame(pos1)
return(pos.df)
}
cat("function(model.dir,input(character),output(F))\n")
#get.ann.df
# library(readr)
# write_tsv(pos.df,output)
#?write_tsv
#}