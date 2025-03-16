# 20250316(15.41)
# 15122.get idioms via LLM training set
#######################################
# try get reddit german idioms/metaphors
################################
install.packages("huggingfaceR")
library(huggingfaceR)

# Load a pre-trained model
model <- hf_load_model("dbmdz/bert-base-german-cased")

# Use the model for inference
results <- hf_infer(model, sample_text)
cred<-read.csv("~/boxHKW/21S/DH/local/R/cred_gener.csv")
m<-grep("hugging",cred$q)

api_token<-hugtoken
api_token<-cred$key[m]
library(httr)
library(jsonlite)
hugurl<-"https://api-inference.huggingface.co/models/cardiffnlp/twitter-roberta-base-sentiment-latest"
hugbase<-"https://api-inference.huggingface.co/models/"

hf_inference <- function(text, model_name, api_token) {
  url <- paste0(hugbase, model_name)
  headers <- add_headers(Authorization = paste0("Bearer ", api_token))
  body <- list(inputs = text)
  payload <- list(
    inputs = text,
    parameters = list(
      candidate_labels = list("idiom", "metaphor", "literal")
    )
  )
  
  response <- POST(
    url,
    headers,
    body = toJSON(payload, auto_unbox = TRUE),
    content_type("application/json")
  )
  
  result <- fromJSON(content(response, "text"))
  return(result)
}

api_token <- api_token
model_name <- "dbmdz/bert-base-german-cased"  # Example model
model_name<-"cardiffnlp/twitter-roberta-base-sentiment-latest"
model_name<-"joeddav/xlm-roberta-large-xnli"
model_name<-"papluca/xlm-roberta-base-language-detection"
text <- unlist(strsplit("Das ist ein Katzensprung."," "))
text <- "Today is a great day"
text<-"Das ist ein Katzensprung."
# payload <- list(
#   inputs = text,
#   parameters = list(
#     candidate_labels = list("idiom", "metaphor", "literal")
#   )
# )

result <- hf_inference(text, model_name, api_token)
print(result)

#############
library(httr)
library(jsonlite)

# Define the API endpoint and model
api_url <- "https://api.huggingface.co/models/joeddav/xlm-roberta-large-xnli"
api_token <- "your_hugging_face_api_token"

# Define the input text
text <- "Das ist ein Katzensprung."

# Construct the payload
payload <- list(
  inputs = text,
  parameters = list(
    candidate_labels = list("idiom", "metaphor", "literal")
  )
)

# Send the request
response <- POST(
  api_url,
  add_headers(Authorization = paste("Bearer", api_token)),
  body = toJSON(payload, auto_unbox = TRUE),
  content_type("application/json")
)

# Parse the response
result <- fromJSON(content(response, "text"))
print(result)

#############
library(reticulate)
reticulate::py_version()
reticulate::py_install("datasets")
reticulate::py_config()
#reticulate::use_python("/Users/guhl/Library/r-miniconda/envs/nlp-env/bin/python")
# Load the datasets library
datasets <- import("datasets")

# Load the IdiomsInCtx-MT dataset
dataset <- datasets$load_dataset("davidstap/IdiomsInCtx-MT","de-en")

# Inspect the dataset
print(dataset$test[0])  # View the first example
dlist<-dataset$test$to_list()
df<-matrix(unlist(dlist),ncol = 2)
df1<-abind(dlist)
df <- do.call(rbind, dlist)
df <- as.data.frame(df)
df$de[465]
save(df,file = "~/boxHKW/21S/DH/local/SPUND/intLX/data/idiomsdf.RData")
