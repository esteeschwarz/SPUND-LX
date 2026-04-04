# check system, adapt output
s<-Sys.getenv("SYS")
outputdir<-ifelse (s=="mini12","/var/www/html/play/pages","../output/pages/004")