
# Ollama configuration
OLLAMA_BASE_URL <- Sys.getenv("OLLAMA_URL", "http://localhost:11434")
DEFAULT_MODEL <- Sys.getenv("OLLAMA_MODEL", "llama3.2")
model<-"lauchacarro/qwen2.5-translator"
DEFAULT_MODEL <- Sys.getenv("OLLAMA_MODEL", model)

# Cache for Ollama status to avoid repeated checks
#ollama_cache <- reactiveVal(list(last_check = NULL, status = NULL))
#x<-models_info$models
#x$name
#x
# Ollama functions (optimized for Shiny)
check_ollama_status_async <- function() {
  future({
    tryCatch({
      response <- GET(paste0(OLLAMA_BASE_URL, "/api/tags"), timeout(5))
      if (status_code(response) == 200) {
        models_info <- fromJSON(content(response, "text", encoding = "UTF-8"))
        models <- sapply(models_info, function(x) x$name)
        list(running = TRUE, models = models, error = NULL)
      } else {
        list(running = FALSE, models = character(0), error = "Not responding")
      }
    }, error = function(e) {
      list(running = FALSE, models = character(0), error = e$message)
    })
  })
}
#library(readtext)
prompt<-"Translate the following into english and return as json response. Important: no preamble, no extra text. Return only the translation as response in as json data. Text: _text_"
###############################
get.trans<-function(tr){
#  print(tr)
  p.text<-gsub("_text_",tr,prompt)
  print(p.text)
#  p.text<-gsub("_target_",t,p.text)
 # desc<-videos_df$description[t]
  p.text
  analyze_with_ollama_async <- function(p.text,model = DEFAULT_MODEL) {
    prompt<-p.text
    request_body <- list(
      model = model,
      prompt = prompt,
      stream = FALSE,
      options = list(temperature = 0.1, num_predict = 500)
    )
    print(prompt)
    tryCatch({
      response <- POST(
        url = paste0(OLLAMA_BASE_URL, "/api/generate"),
        body = toJSON(request_body, auto_unbox = TRUE),
        add_headers("Content-Type" = "application/json"),
        encode = "raw",
        timeout(100)  # 30 second timeout
      )
      # content(GET(paste0(OLLAMA_BASE_URL,"/api/info")),"text")
      print(content(response,"text"))
      
      if (status_code(response) == 200) {
        result <- fromJSON(content(response, "text", encoding = "UTF-8"))
        response_text <- result$response
        print(response_text)
        return(response_text)
        # print(response_text)
        #  response_text<-'{"Algernon": ["ALGERNON"], "Lane": ["LANE"], "Jack": ["JACK"]}'
        # Extract JSON
        json_pattern <- "\\{[^}]*(?:\"[^\"]*\"\\s*:\\s*\\[[^\\]]*\\][^}]*)*\\}"
        json_match <- str_extract(response_text, json_pattern)
        json_match
        #json<-fromJSON(response_text)
        if (!is.na(json_match)) {
          json_match <- str_replace_all(json_match, "\\\\\\\\", "\\\\")
          return(unique(unlist(fromJSON(json_match))))
        }
      }
      print("not 200")
      return(NULL)
    }, error = function(e) {
      print("error...")
      print(content(response,"text"))
      return(NULL)
    })
    
  }
  r1<-analyze_with_ollama_async(p.text)
  
}
  #}
s<-"~/Documents/GitHub/SPUND-LX/szondi/auerVS/judenbuche.txt"
tx<-readLines(s)
tx<-tx[tx!=""]
i<-45
trans1<-lapply(40:45, function(i){
  cat("line no.",i,"\r")
  t<-tx[i]
  r1<-get.trans(t)
r1  
})
p.text<-readtext("yakura-prompt.md")$text
  # v.list<-videos_df$channelTitle
  # v.list<-unique(v.list)
  # v.list<-paste0(v.list,collapse = "#")
  # p.text<-gsub("_list_",v.list,p.text)
  # p.text
  