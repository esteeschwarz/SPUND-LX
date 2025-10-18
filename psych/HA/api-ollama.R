library(jsonlite)
library(httr)
get.embeds<-function(text){
api<-"http://localhost:11434/api/embeddings"
#params<-c(
  model="nomic-embed-text"
  prompt="The sky is blue because of Rayleigh scattering"
  prompt="die strafe folgt auf dem fusze"
  prompt<-c("die strafe folgt auf dem fusze")
  prompt<-"drei katzen im ofen"
  prompt<-text
body <- list(
  model = model,
  prompt = prompt,
  stream = FALSE,
  options = list(temperature = 0.1, num_predict = 500)
)

r<-POST(
  url = api,
  body = toJSON(body, auto_unbox = TRUE),
  # body = toJSON(body),
  add_headers("Content-Type" = "application/json"),
  encode = "raw",
  timeout(100)  # 30 second timeout
)
t<-content(r,"text")
t
result <- fromJSON(content(r, "text", encoding = "UTF-8"))
#target <- result$embedding

embeds <- result$embedding
}
# Function to calculate cosine similarity between two vectors
get.score <- function(vec1, vec2) {
  dot_product <- sum(vec1 * vec2)
  norm1 <- sqrt(sum(vec1^2))
  norm2 <- sqrt(sum(vec2^2))
  return(dot_product / (norm1 * norm2))
}

# Function to map target word embedding to corpus embeddings
# Returns similarity scores for all corpus items
map_word_to_corpus <- function(target_embedding, corpus_embeddings) {
  # target_embedding: numeric vector of length n (single embedding)
  # corpus_embeddings: matrix with embeddings in rows (m x n matrix)
  
  # Ensure corpus_embeddings is a matrix
  if (is.vector(corpus_embeddings)) {
    corpus_embeddings <- matrix(corpus_embeddings, nrow = 1)
  }
  
  # Calculate cosine similarity with each corpus embedding
  similarities <- apply(corpus_embeddings, 1, function(corpus_vec) {
    cosine_similarity(target_embedding, corpus_vec)
  })
  
  return(similarities)
}
#map_word_to_corpus(target,embeds)
# -d '{
#   "model": "nomic-embed-text",
#   "prompt": "The sky is blue because of Rayleigh scattering"
# }'
