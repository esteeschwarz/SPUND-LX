netns<-paste0(Sys.getenv("HKW_TOP"),"/SPUND/COMP/model/collapse")
model<-"3-1"
netf<-paste0(netns,"/model_gen_",model,".pt")
nett<-paste0(netns,"/training_corpus_gen_",model,".txt")
### visualize
#vis1<-function(model){
netns<-paste0(Sys.getenv("HKW_TOP"),"/SPUND/COMP/model/collapse")
model<-"7d-1"
modeldf<-paste0(unlist(strsplit(model,"-"))[1],"-3")
netf<-paste0(netns,"/model_gen_",model,".pt")
nett<-paste0(netns,"/training_corpus_gen_",model,".txt")
mdf<-paste0(netns,"/collapse_metrics-",modeldf,".csv")
#mdf<-mdf[1]
#   install.packages(c(
#   "uwot",
#   "viridis",
#   "MASS"
# ))
  library(readr)
#c<-read_delim("/Users/guhl/Documents/GitHub/benjaminfeldkraft/corpus/benjaminfeldkraft.vert",skip=2,delim="\t")
# c <- read_delim(paste0(Sys.getenv("GIT_TOP"),"/benjaminfeldkraft/corpus/benjaminfeldkraft.vert"), 
#     delim = "\t", escape_double = FALSE, 
#     col_names = FALSE, trim_ws = TRUE, skip = 4)
get.text<-function(){
  library(stringr)
  c <- read_delim("https://raw.githubusercontent.com/esteeschwarz/benjaminfeldkraft/main/corpus/benjaminfeldkraft.vert", 
                delim = "\t", escape_double = FALSE, 
                col_names = FALSE, trim_ws = TRUE, skip = 4,show_col_types = FALSE)

colnames(c)<-c("token","pos","lemma")
head(c,100)
print(c,n=100)
c1<-c
c1$lemma<-gsub("-.*","",c1$lemma)
c1$token<-gsub("</s>|<s>","\n",c1$token)
#length(c1$token)
c1<-c1[c1$token!="<g/>",]
lu<-unique(c1$lemma)
text <- paste(c1$token, collapse = " ")

# minimal cleaning
text <- str_replace_all(text, "\r", "")
text <- str_to_lower(text)

cat("Corpus characters:", nchar(text), "\n")
  return(text)
}
nett
    library(torch)
  netf
  netw<-paste0(netns,"/weights_",model,".pt")
  net <- torch_load(netf)
  netm<-net
  torch_save(
  net$state_dict(),
  netw
)
df<-read.csv(mdf)
#df<-read.csv(mdf)
df1<-df[1,]
dfa<-df
df<-df1
  EMBED_SIZE <- 64
  HIDDEN_SIZE <- 128
  vocab_size <- 89
 EMBED_SIZE <- df$embeddings
  HIDDEN_SIZE <- df$hidden
  vocab_size <- df$vocab

create_model <- function(vocab_size,
                         embed_size,
                         hidden_size) {

  model <- nn_module(

    initialize = function(vocab_size,
                          embed_size,
                          hidden_size) {

      self$embedding <- nn_embedding(
        num_embeddings = vocab_size,
        embedding_dim = embed_size
      )

      self$gru <- nn_gru(
        input_size = embed_size,
        hidden_size = hidden_size,
        batch_first = TRUE
      )

      self$fc <- nn_linear(
        hidden_size,
        vocab_size
      )
    },

    forward = function(x, hidden = NULL) {

      x <- self$embedding(x)

      gru_out <- self$gru(x, hidden)

      out <- gru_out[[1]]

      out <- self$fc(out)

      list(out, gru_out[[2]])
    }
  )

  model(
    vocab_size,
    embed_size,
    hidden_size
  )
}
    net <- create_model(
  vocab_size = vocab_size,
  embed_size = EMBED_SIZE,
  hidden_size = HIDDEN_SIZE
)
  net$load_state_dict(
  torch_load(netw)
)
#current_text<-readLines(nett)
##############################
#   text <- paste(
#   readLines("corpus.txt", warn = FALSE),
#   collapse = "\n"
# )
 corpus<-get.text()
  text <- paste(
  readLines(nett),
  collapse = "\n"
)
# head(corpus) 
text<-corpus
  chars <- sort(unique(strsplit(text, "")[[1]]))
  length(chars)
  chars
chars <- sort(unique(strsplit(text, "\\s+")[[1]]))
  length(chars)
  #chars
char_to_int <- setNames(
  seq_along(chars),
  chars
)

int_to_char <- setNames(
  chars,
  seq_along(chars)
)
  encode_text <- function(txt) {

  sapply(
    strsplit(txt, "\\s+")[[1]],
    function(x) char_to_int[[x]]
  )
}
  extract_hidden_state <- function(net, text_seq) {

  encoded <- encode_text(text_seq)

  input <- torch_tensor(
    matrix(encoded, nrow = 1),
    dtype = torch_long()
  )

  out <- net(input)

  hidden <- out[[2]]

  as.numeric(
    hidden$squeeze()$detach()
  )
}
  sample_sequences <- function(text,
                             n_sequences = 50,
                             seq_len = 80) {

  sequences <- c()
  
  t2<- unlist(strsplit(text, "\\s+")[[1]])
    lt2<-length(t2)
  max_start <- nchar(text) - seq_len
  max_start <-   lt2 - seq_len

  for(i in 1:n_sequences) {

    start <- sample(1:max_start, 1)

    # seq <- substr(
    #   t2,
    #   start,
    #   start + seq_len
    # )
    start
    print(start)
   seq <- t2[start:(start + seq_len)]
    

    sequences <- c(sequences, seq)
  }

  sequences
  }

seqs <- sample_sequences(text)
  head(seqs)
  length(seqs)
  latent_matrix <- lapply(
  seqs,
  function(x)
    extract_hidden_state(net, x)
)

latent_matrix <- do.call(
  rbind,
  latent_matrix
)
  dim(latent_matrix)
  library(uwot)

umap_proj <- umap(
  latent_matrix,
  n_neighbors = 20,
  min_dist = 0.05,
  metric = "cosine"
)
  library(ggplot2)

plot_df <- data.frame(
  x = umap_proj[,1],
  y = umap_proj[,2]
)

ggplot(plot_df,
       aes(x, y)) +

  geom_point(
    alpha = 0.7,
    size = 2
  ) +

  theme_void() +

  ggtitle(
    "Latent Geometry"
  )
#}
  generate_text <- function(netm,
                          # seed = "the ",
                          seed = TSTART,
                          n_chars = 1000,
                          temperature = 0.8) {
  
  netm$eval()
  ##############
   # seed<-"ich "
    #n_chars<-6000
    #temperature<-0.8
  seed_encoded <- encode_text(seed)
  #seed_encoded <- encode_text("ich ")
  
  input <- torch_tensor(
    matrix(seed_encoded, nrow = 1),
    dtype = torch_long()
  )
  
  hidden <- NULL
  
  generated <- seed
  i<-2
  for(i in 1:n_chars) {
    if(i %% 500 == 0) {
      
      cat(
        "[GENERATE]",
        i,
        "/",
        n_chars,
        "chars generated\n"
      )
    }
    out <- net(input, hidden)
    out
    logits <- out[[1]]
    hidden <- out[[2]]
    
    last_logits <- logits[1, dim(logits)[2], ]
    
    probs <- nnf_softmax(last_logits / temperature,
                         dim = 1)
    
    next_id <- as.integer(
      torch_multinomial(probs, 1)$item()
    )
    cat("\r",next_id)
    length(int_to_char)
    #[[88]]
    next_char <- int_to_char[[as.character(next_id)]]
    
    generated <- paste0(generated, " ",next_char)
    
    input <- torch_tensor(
      matrix(next_id, nrow = 1),
      dtype = torch_long()
    )
  }
  
  generated
  }
#  library(torch)
synthetic <- generate_text(
  net = netm,
    # seed = "the ",
    seed = "ich ",
    n_chars = floor(lt2/df$chars),
    temperature = 0.8
  )
  
  cat("\n--- GENERATED SAMPLE ---\n")
  cat(substr(synthetic, 1, 100))
  cat("\n\n")
  
#################
  vis_dep<-function(){
library(readtext)
current_text<-readtext(nett)$text
text<-current_text
text<-get.text()
  current_text<-text
chars <- sort(unique(strsplit(text, "")[[1]]))

vocab_size <- length(chars)

char_to_int <- setNames(seq_along(chars), chars)
int_to_char <- setNames(chars, seq_along(chars))

encode_text <- function(txt) {
  sapply(strsplit(txt, "")[[1]], function(x) char_to_int[[x]])
}

decode_text <- function(ids) {
  paste0(sapply(ids, function(x) int_to_char[[as.character(x)]]), collapse = "")
}


  library(torch)
  netf
  net <- torch_load(netf)
  extract_hidden_state <- function(net, text_seq) {

  encoded <- encode_text(text_seq)

  input <- torch_tensor(
    matrix(encoded, nrow = 1),
    dtype = torch_long()
  )

  out <- net(input)

  hidden <- out[[2]]

  as.numeric(hidden$squeeze()$detach())
}
  sample_sequences <- function(text,
                             n_sequences = 500,
                             seq_len = 80) {

  sequences <- c()

  max_start <- nchar(text) - seq_len

  for(i in 1:n_sequences) {

    start <- sample(1:max_start, 1)

    seq <- substr(
      text,
      start,
      start + seq_len
    )

    sequences <- c(sequences, seq)
  }

  sequences
}
  library(dplyr)

seqs <- sample_sequences(
  current_text,
  n_sequences = 500,
  seq_len = 80
)

  head(seqs)
latent_matrix <- lapply(
  seqs,
  function(x)
    extract_hidden_state(net, x)
)

latent_matrix <- do.call(
  rbind,
  latent_matrix
)

dim(latent_matrix)
  
  library(uwot)

umap_proj <- umap(
  latent_matrix,
  n_neighbors = 20,
  min_dist = 0.05,
  metric = "cosine"
)
  
  library(ggplot2)

plot_df <- data.frame(
  x = umap_proj[,1],
  y = umap_proj[,2]
)

ggplot(plot_df,
       aes(x, y)) +

  geom_point(
    alpha = 0.7,
    size = 2
  ) +

  theme_void() +

  ggtitle(
    "Latent Geometry of Corpus"
  )

  plot(dfa$entropy,type="l")
    
    library(MASS)

kde <- kde2d(
  plot_df$x,
  plot_df$y,
  n = 400
)
  
  filled.contour(
  kde,
  color.palette = viridis::viridis,
  axes = FALSE,
  frame.plot = FALSE
)
  
    t1 <- generate_text(
    net,
    # seed = "the ",
    seed = TSTART,
    n_chars = 1000,
    temperature = TEMPERATURE
  )
head(t1)
  gen<-1
  synth_ratio <- SYNTHETIC_RATIO[gen]
  cat(
    "[CORPUS] synthetic ratio:",
    round(synth_ratio, 3),
    "\n"
  )
  human_chars <- sample(
    strsplit(text, "")[[1]],
    size = floor((1 - synth_ratio) * nchar(text)),
    replace = TRUE
  )
  human_chars
    synth_chars <- sample(
    strsplit(t1, "")[[1]],
    size = floor(synth_ratio * nchar(text)),
    replace = TRUE
  )
  synth_chars

  }

vis1(model)
postprocess<-function(){
  t2<-readLines(paste0(Sys.getenv("GIT_TOP"),"/temp/model/unknown-1-01.txt"))
  t3<-t2[t2!=""]
  t3<-t3[t3!=" "]
  t3<-gsub("^ ","",t3)
  t3<-gsub(" ([\\.\\)!?,;:-])","\\1",t3)
  t3
  t3<-gsub("([\\.\\(!?]) $","\\1",t3)
  t3<-gsub("\\( ","(",t3)
 t3
 length(t3)
  writeLines(t3[1:200],"temp/model/M1-pseudoL1.txt")
}