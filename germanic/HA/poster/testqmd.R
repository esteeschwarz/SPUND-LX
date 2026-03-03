# testqmd
setwd("~/Documents/GitHub/SPUND-LX/germanic/HA/poster")
load("../drafts/plist.RData")
list.files()
knitr::kable(plist$sdf)
plist$ptx
prompt<-plist$ptx
prompt<-paste(prompt,collapse = "\n")
prompt
plist$boxdesc
