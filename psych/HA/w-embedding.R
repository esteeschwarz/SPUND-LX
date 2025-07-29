# 20250729(16.03)
# 15314.word embeddings essai
# add token-corpus similarity covar to distance df
##################################################
library(text)
library(dplyr)
#library(tibble)
#install.packages("RSpectra") # text fail from source
# Initialize text package (this will install Python dependencies if needed)
#text::textrpp_install()
#text::textrpp_initialize()

# Example corpus
corpus <- c(
  "The dog ran quickly through the park",
  "A canine sprinted rapidly across the field", 
  "The cat walked slowly down the street",
  "Birds fly high in the sky",
  "The puppy played energetically in the yard",
  "Felines move gracefully through gardens",
  "Animals need water and food to survive",
  "The veterinarian examined the sick animal"
)
corpus <- c(
  "The dog ran quickly through the park",
  "A canine sprinted rapidly across the field", 
  "The cat walked slowly down the street",
  "Birds fly high in the sky",
  "The puppy played energetically in the yard",
  "Felines move gracefully through gardens",
  "Animals need water and food to survive",
  "The veterinarian examined the sick animal",
  "The windows of the van were very dirty",
  "and the author also writes books about Gustav Mahler.",
  "but mainly cats do eat mouse."
)
tx.dir<-paste0(Sys.getenv("HKW_TOP"),"/SPUND/2025/stef_psych/data/txt/15303/")
f<-list.files(tx.dir)
fns<-paste0(tx.dir,f)
fns<-fns[grep("\\.txt",fns)]
# load corpus db complete, annotated
#load(paste0(Sys.getenv("HKW_TOP"),"/SPUND/2025/stef_psych/dcorpus.df.cpt-012.RData"))
#load(paste0(Sys.getenv("HKW_TOP"),"/SPUND/2025/stef_psych/eval-012.RData"))

### notes:
# we want to get a similarity score for determined nouns in corpus, per condition. the conditions are already
# available as covar in the df. so for each noun with matching condition:
# 1. get url range
# 2. get sim score for that noun vs. the range: expresses if a noun more or less fits semantically
# within the range=corpus or if its out-of-context.
# 3. in the mixed model add covar as random factor or somehow scale as continuos var

#######################################
#corpus<-paste0(corpus,collapse = ". ")
corpus<-readLines(fns[1])
# Create embeddings for the entire corpus
get.embed<-function(corpus,m){
  corpus<-paste0(corpus[m],collapse = ". ")
  corpus
  
embeddings <- textEmbed(corpus, 
                       model = "sentence-transformers/all-MiniLM-L6-v2")
}
target_word<-"dog"
get.score<-function(target_word,embeddings){
  
  # corpus<-paste0(corpus[m],collapse = ". ")
  # corpus
  # Create embeddings for the entire corpus
  # embeddings <- textEmbed(corpus, 
  #                         model = "sentence-transformers/all-MiniLM-L6-v2")
  # Function to find semantic references of a target word
find_semantic_references <- function(target_word, embeddings) {
  
  # Create embedding for target word
  target_embedding <- textEmbed(target_word, 
                               model = "sentence-transformers/all-MiniLM-L6-v2")
  
  # Calculate cosine similarity between target and corpus
 similarities <- textSimilarity(target_embedding$texts$texts, embeddings$texts$texts)
}
return(find_semantic_references(target_word,embeddings))
}
corpus
m<-1:length(corpus)
#m<-c(1:9,11)

#similarities<-get.score("car",embeddings,m)
corpus
tokens<-unique(unlist(strsplit(corpus[m]," "))) # for within-corpus consistency
tokens
#tokens<-unique(unlist(strsplit(corpus," ")))
#tokens<-unique(unlist(strsplit(corpus[10]," ")))
library(pbapply)
tokens<-c("cats","dogs","food") # for single token score
#tokens<-c("hare")
embeddings<-get.embed(corpus,m)
###############################
tokens<-c("depression")
tokens<-c("schizophrenia","depression","book","car","dog")
t.score<-pblapply(tokens, function(x){
  s<-get.score(x,embeddings)
})
get.m.score<-function(t.score,tokens){
sim.df<-data.frame(token=tokens,score=unlist(t.score))
sim.df<-sim.df[order(sim.df$score,decreasing = T),]
eval1<-mean(sim.df$score)
return(sim.df)
}
eval3<-get.m.score(t.score,tokens)
#wks
### now realtime
mdf<-data.frame(qid=1:10,target=NA,condition=NA,upos=NA,det=F,m=NA)
mdf[1,]<-c(1,"obs","b","NOUN",T,1)
m<-1
get.text<-function(qltdf,tdba.1,mdf,m){
mdf1<-mdf[m,]
mdf1
um<-qltdf$q==mdf1$condition&qltdf$target==mdf1$target&qltdf$det==mdf1$det&qltdf$upos==mdf1$upos
u<-qltdf$url[um]
u<-unique(u)
i<-as.double(mdf1$m)
ux<-u[i]
r1<-tdba.1$url_t==ux
t1<-paste0(tdba.1$token[r1],collapse = " ")
l<-qltdf$lemma[um]
l<-unique(l)
return(list(t=t1,lemmas=l))
}
t1<-get.text(qltdf,tdba.1,mdf,1)
###wks
embeddings<-get.embed(t1$t,1)
tokens<-t1$lemmas
t.score<-pblapply(tokens, function(x){
  s<-get.score(x,embeddings)
})
get.m.score<-function(t.score,tokens){
  sim.df<-data.frame(token=tokens,score=unlist(t.score))
  sim.df<-sim.df[order(sim.df$score,decreasing = T),]
  eval1<-mean(sim.df$score)
  return(sim.df)
}
evalt1<-get.m.score(t.score,tokens)

fun.dep<-function(){
 x<-embeddings$texts$texts[[1]] 
 similarities <- lapply(embeddings$texts$texts,function(x){
    s<-textSimilarity(target_embedding$texts$texts, x)
  })
  # Create results dataframe
  results <- tibble(
    sentence = corpus,
    # similarity = as.numeric(similarities[1, ])
    similarity = as.numeric(similarities)
  ) %>%
    arrange(desc(similarity)) %>%
#    slice_head(n = top_n)
  
  return(results)

get.score("male")
#embeddings
# Find sentences most similar to "dog"
dog_references <- find_semantic_references("dog", corpus, embeddings)
print("Most similar sentences to 'dog':")
print(dog_references)

# Find sentences most similar to "fast movement"
speed_references <- find_semantic_references("fast movement", corpus, embeddings)
print("Most similar sentences to 'fast movement':")
print(speed_references)

# -------------------------------------------------------------------
# Approach 2: Using reticulate to access Python transformers directly
# -------------------------------------------------------------------

#library(reticulate)

# Install Python packages (run once)
# py_install(c("transformers", "torch", "sentence-transformers", "numpy", "sklearn"))

# Python code executed in R
# py_run_string("
# import numpy as np
# from sentence_transformers import SentenceTransformer
# from sklearn.metrics.pairwise import cosine_similarity
# 
# # Load a pre-trained sentence transformer model
# model = SentenceTransformer('all-MiniLM-L6-v2')
# 
# def get_embeddings(texts):
#     return model.encode(texts)
# 
# def find_similar_sentences(target, corpus, top_k=3):
#     # Get embeddings
#     target_embedding = model.encode([target])
#     corpus_embeddings = model.encode(corpus)
#     
#     # Calculate similarities
#     similarities = cosine_similarity(target_embedding, corpus_embeddings)[0]
#     
#     # Get top k most similar
#     top_indices = np.argsort(similarities)[::-1][:top_k]
#     
#     results = []
#     for idx in top_indices:
#         results.append({
#             'sentence': corpus[idx],
#             'similarity': similarities[idx]
#         })
#     
#     return results
# ")

# Use the Python functions from R
corpus_r <- c(
  "The dog ran quickly through the park",
  "A canine sprinted rapidly across the field", 
  "The cat walked slowly down the street",
  "Birds fly high in the sky",
  "The puppy played energetically in the yard",
  "Felines move gracefully through gardens",
  "Animals need water and food to survive",
  "The veterinarian examined the sick animal"
)

# Find similar sentences using Python backend
# similar_to_dog <- py$find_similar_sentences("dog", corpus_r, 3L)
# print("Using reticulate approach - similar to 'dog':")
# for(i in seq_along(similar_to_dog)) {
#   cat(sprintf("%.3f: %s\n", 
#               similar_to_dog[[i]]$similarity, 
#               similar_to_dog[[i]]$sentence))
# }

# -------------------------------------------------------------------
# Approach 3: Word-level semantic search within documents
# -------------------------------------------------------------------

# Function to find semantically similar words/phrases in a document
find_word_references <- function(target_word, document, window_size = 5) {
  
  # Split document into overlapping windows
  words <- unlist(strsplit(document, "\\s+"))
  
  if(length(words) < window_size) {
    windows <- list(paste(words, collapse = " "))
  } else {
    windows <- list()
    for(i in 1:(length(words) - window_size + 1)) {
      window <- paste(words[i:(i + window_size - 1)], collapse = " ")
      windows <- append(windows, window)
    }
  }
  
  # Get embeddings for target and windows
  target_emb <- textEmbed(target_word)
  window_embs <- textEmbed(unlist(windows))
  
  # Calculate similarities
  sims <- textSimilarity(target_emb, window_embs)
  
  # Return top matches
  results <- tibble(
    text_window = unlist(windows),
    similarity = as.numeric(sims[1, ])
  ) %>%
    arrange(desc(similarity)) %>%
    slice_head(n = 5)
  
  return(results)
}

# Example with a longer document
long_document <- "The domestic dog is a domesticated descendant of the wolf. 
Dogs were the first species to be domesticated by humans. The canine family 
includes wolves, foxes, and domestic dogs. Puppies are young dogs that require 
special care. Many people consider their pet dog to be part of their family. 
Veterinarians specialize in animal health care, treating both cats and dogs."

word_refs <- find_word_references("dog", long_document)
print("Word references in document:")
print(word_refs)

# -------------------------------------------------------------------
# Helper function for batch processing
# -------------------------------------------------------------------

batch_semantic_search <- function(target_words, corpus, top_n = 2) {
  
  results <- list()
  
  for(word in target_words) {
    matches <- find_semantic_references(word, corpus, embeddings, top_n)
    results[[word]] <- matches
  }
  
  return(results)
}

# Example batch search
target_words <- c("dog", "movement", "care")
batch_results <- batch_semantic_search(target_words, corpus)

for(word in names(batch_results)) {
  cat(sprintf("\nSemantic references for '%s':\n", word))
  print(batch_results[[word]])
}
}


