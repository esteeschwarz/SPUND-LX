f<-list.files("/Users/guhl/Documents/GitHub/DC-LX/essais/coherence",pattern = ".html",full.names = T)
library(xml2)
credcsv<-Sys.getenv("CRED_GEN") # !VIP dont put directly into read.csv()
cred<-read.csv(credcsv) 
e<-parse(text=cred$q[1])
e
# q<-"transkribus"
m<-grep("gemini",cred$q)
q<-cred$q[m]
eval(e)
library(readtext)
ptdf<-data.frame(id=1:length(f),text=NA)
for(k in 1:length(f)){
  t<-readtext(f[k])$text
  ptdf$text[k]<-t
  
}
ptdf$text[2]
get.sum<-function(ptdf){

    ptdf$summary<-NA
  #k<-1
  tprompt<-readLines("g-prompt01.txt")
  library(jsonlite)
  body <- fromJSON("bodytemplate.json", simplifyVector = FALSE)
  k<-1
  ?read_html
  tx<-paste(ptdf$text,collapse = "--- part ---")
  #for(k in 1:length(ptdf$date)){
    #ptext<-ptdf$text[k]
    #p<-read_html(ptext)
    #p
    ptext<-tx
    tbody<-c(tprompt,ptext)
    #tbody<-readLines("textprompt.txt")
    tbody<-paste0(tbody,collapse = "\n")
    #body <- fromJSON("textprompt.json", simplifyVector = FALSE)
    body$contents[[1]]$parts[[1]]$text<-tbody
    #body<-gg.json
    url
    body
    api_key<-key
    library(httr)
    res <- POST(
      url = url,
      query = list(key = api_key),
      add_headers(`Content-Type` = "application/json"),
      body = body,
      encode = "json"
    )
    t<-content(res,"text")
    t
    tlist<-fromJSON(t,simplifyVector = T)
    tx<-tlist$candidates$content$parts[[1]]$text
    tx
    ptdf$summary[k]<-tx
    writeLines(tx,"testoutput.txt")
    s<-10
    cat("processed:",k,"... waiting -",s,"-seconds\n")
    Sys.sleep(s)
  # }
  return(ptdf)
}
