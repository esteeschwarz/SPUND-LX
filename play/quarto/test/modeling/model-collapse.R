library(torch)
library(stringr)
library(ggplot2)
library(dplyr)

set.seed(42)

# ============================================================
# PARAMETERS
# ============================================================

BATCH_SIZE <- 12 #32
EMBED_SIZE <- 64 #64
output.dir<-paste0(Sys.getenv("GIT_TOP"),"/SPUND-LX/data/models/collapse")
output.dir<-paste0(Sys.getenv("HKW_TOP"),"/SPUND/COMP/model/collapse")
tplus<-c(paste0(Sys.getenv("HKW_TOP"),"/AVL/2025/dokufiktion/mann_joseph.txt"),paste0(Sys.getenv("HKW_TOP"),"/AVL/2025/dokufiktion/musil_me.txt"),paste0(Sys.getenv("HKW_TOP"),"/AVL/2025/dokufiktion/sebald_austerlitz.txt"))
tp<-T
# SEQ_LEN <- 80
# HIDDEN_SIZE <- 128
# EPOCHS <- 3
# GENERATIONS <- 3
# GENERATED_CHARS <- 50000
SPLIT_c <- ""
SPLIT_t <- "\\s+"
SEQ_LEN <- 80
HIDDEN_SIZE <- 128
EPOCHS <- 2
GENERATED_CHARS <- 6000
gchar<-GENERATED_CHARS
GENERATIONS <- 1:3
# SEQ_LEN <- 40
# HIDDEN_SIZE <- 64
# EPOCHS <- 1
# GENERATED_CHARS <- 2000
GENS<-"7b"
# mini12 adapted to capacity
# minisams
TSTART<-"ich "
TEMPERATURE <- 0.8

###
split_by_token <- T

SYNTHETIC_RATIO <- seq(0.1, 0.95, length.out = length(GENERATIONS))

# ============================================================
# LOAD CORPUS
# ============================================================

#text <- readLines("corpus.txt", warn = FALSE)
#text <- paste(text, collapse = "\n")

library(readr)
#c<-read_delim("/Users/guhl/Documents/GitHub/benjaminfeldkraft/corpus/benjaminfeldkraft.vert",skip=2,delim="\t")
# c <- read_delim(paste0(Sys.getenv("GIT_TOP"),"/benjaminfeldkraft/corpus/benjaminfeldkraft.vert"), 
#     delim = "\t", escape_double = FALSE, 
#     col_names = FALSE, trim_ws = TRUE, skip = 4)
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

# ============================================================
# VOCABULARY
# ============================================================

ifelse(split_by_token,SPLIT<-SPLIT_t,SPLIT<-SPLIT_c)
ifelse(split_by_token,SPLIT_w<-" ",SPLIT_w<-"")
ifelse(split_by_token,GENERATED_CHARS<-GENERATED_CHARS/5,GENERATED_CHARS<-GENERATED_CHARS)

chars <- sort(c(SPLIT_w,unique(strsplit(text, SPLIT)[[1]])))
sum(" "%in%chars)
#chars<-c(" ",chars)
head(chars)
chars<-chars[chars!=""]
vocab_size <- length(chars)
vocab_size
char_to_int <- setNames(seq_along(chars), chars)
length(char_to_int)
int_to_char <- setNames(chars, seq_along(chars))
length(int_to_char)

encode_text <- function(txt) {
# chars <- sort(unique(strsplit(txt, "")[[1]]))

# vocab_size <- length(chars)
# char_to_int <- setNames(seq_along(chars), chars)
  sapply(strsplit(txt, SPLIT)[[1]], function(x) char_to_int[[x]])
}
#tu<-strsplit(current_text, "")[[1]]
#length(unique(tu))
# t1<-  sapply(strsplit(current_text, "")[[1]], function(x) {
#   print(x)
#   char_to_int[[x]]
# })
# setdiff(
#   unique(strsplit(current_text, "")[[1]]),
#   chars
# )
# #t1<-  sapply(strsplit(current_text, "")[[1]], function(x) char_to_int[[x]])
# t1<-encode_text(current_text)

### never called
decode_text <- function(ids) {
  paste0(sapply(ids, function(x) int_to_char[[as.character(x)]]), collapse = "")
}
###
encoded_original <- encode_text(text)

# ============================================================
# DATASET CREATION
# ============================================================

make_dataset <- function(encoded, seq_len = 80) {
  
  X <- list()
  Y <- list()
  
  n <- length(encoded)
  
  for(i in 1:(n - seq_len - 1)) {
    if(i %% 10000 == 0) {
      cat(
        "[DATASET] processed",
        i,
        "/",
        (n - seq_len - 1),
        "\n"
      )
    }
    X[[i]] <- encoded[i:(i+seq_len-1)]
    Y[[i]] <- encoded[(i+1):(i+seq_len)]
  }
  
  list(
    X = X,
    Y = Y
  )
}

# ============================================================
# MODEL
# ============================================================

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

net <- model(
  vocab_size = vocab_size,
  embed_size = EMBED_SIZE,
  hidden_size = HIDDEN_SIZE
)

optimizer <- optim_adam(net$parameters, lr = 0.003)

criterion <- nn_cross_entropy_loss()

# ============================================================
# TEXT GENERATION
# ============================================================

generate_text <- function(net,
                          # seed = "the ",
                          seed = TSTART,
                          n_chars = 1000,
                          temperature = 0.8) {
  
  net$eval()
  
  seed_encoded <- encode_text(seed)
  
  input <- torch_tensor(
    matrix(seed_encoded, nrow = 1),
    dtype = torch_long()
  )
  
  hidden <- NULL
  
  generated <- seed
  
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
    
    logits <- out[[1]]
    hidden <- out[[2]]
    
    last_logits <- logits[1, dim(logits)[2], ]
    
    probs <- nnf_softmax(last_logits / temperature,
                         dim = 1)
    
    next_id <- as.integer(
      torch_multinomial(probs, 1)$item()
    )
    
    next_char <- int_to_char[[as.character(next_id)]]
    
    generated <- paste0(generated, next_char)
    
    input <- torch_tensor(
      matrix(next_id, nrow = 1),
      dtype = torch_long()
    )
  }
  
  generated
}

# ============================================================
# SHANNON ENTROPY
# ============================================================

calculate_entropy <- function(text_string) {
  
  chars <- strsplit(text_string, SPLIT)[[1]]
  
  probs <- table(chars) / length(chars)
  
  probs <- as.numeric(probs)
  
  entropy <- -sum(probs * log2(probs))
  
  entropy
}

# ============================================================
# TRAINING FUNCTION
# ============================================================

train_model <- function(net,
                        encoded_data,
                        epochs = 3) {
  
  ds <- make_dataset(encoded_data, SEQ_LEN)
  
  n_batches <- floor(length(ds$X) / BATCH_SIZE)
  
  for(epoch in 1:epochs) {
    cat(
      "\n[TRAIN] Starting epoch",
      epoch,
      "/",
      epochs,
      "\n"
    )
    total_loss <- 0
    
    for(b in 1:n_batches) {
      if(b %% 50 == 0) {
        
        cat(
          "[TRAIN] epoch:",
          epoch,
          "| batch:",
          b,
          "/",
          n_batches,
          "| avg loss:",
          round(total_loss / b, 4),
          "\n"
        )
      }
      idx <- sample(1:length(ds$X), BATCH_SIZE)
      
      x_batch <- torch_tensor(
        do.call(rbind, ds$X[idx]),
        dtype = torch_long()
      )
      
      y_batch <- torch_tensor(
        do.call(rbind, ds$Y[idx]),
        dtype = torch_long()
      )
      
      optimizer$zero_grad()
      
      out <- net(x_batch)[[1]]
      
      loss <- criterion(
        out$view(c(-1, vocab_size)),
        y_batch$view(c(-1))
      )
      
      loss$backward()
      
      optimizer$step()
      
      total_loss <- total_loss + loss$item()
    }
    
    cat("Epoch:",
        epoch,
        "Loss:",
        total_loss / n_batches,
        "\n")
  }
}

# ============================================================
# COLLAPSE LOOP
# ============================================================
postprocess<-function(tt){
  t2<-readLines(tt)
  t3<-t2[t2!=""]
  t3<-t3[t3!=" "]
  t3<-gsub("^ ","",t3)
  t3<-gsub(" ([\\.\\)!?,;:-])","\\1",t3)
  t3
  t3<-gsub("([\\.\\(!?]) $","\\1",t3)
  t3<-gsub("\\( ","(",t3)
# t3
#  length(t3)
#   writeLines(t3[1:200],"temp/model/M1-pseudoL1.txt")
}
current_text <- text
#current_text
metrics <- data.frame()
lt<- length(unlist(strsplit(current_text, SPLIT)))

gen<-1
st<-2
st<-1
st
gen
for(gen in st:length(GENERATIONS)) {
lt<- length(unlist(strsplit(current_text, SPLIT)))
  # for(gen in 1:2) {
  if(tp)
    tt<-postprocess(tplus[gen])
#    tt<-readLines(tt)

  
  cat("\n=============================\n")
  cat("GENERATION:", gen, "\n")
  
  encoded_current <- encode_text(current_text)
  #encoded_current <- encode_text(text)
  
  # --------------------------------------
  # TRAIN
  # --------------------------------------
  
  train_model(
    net,
    encoded_current,
    epochs = EPOCHS
  )
  
  # --------------------------------------
  # GENERATE
  # --------------------------------------
  lt*0.95/100
  synthetic <- generate_text(
    net,
    # seed = "the ",
    seed = TSTART,
    # n_chars = GENERATED_CHARS,

    n_chars = floor((SYNTHETIC_RATIO[gen])*lt/100),
    temperature = TEMPERATURE
  )
  # if(tp)
  #   synthetic<-tt
  cat("\n--- GENERATED SAMPLE ---\n")
  cat(substr(synthetic, 1, 500))
  cat("\n\n")
  
  # --------------------------------------
  # ENTROPY
  # --------------------------------------
  
  entropy <- calculate_entropy(current_text)
  cat(
    "[METRICS] entropy:",
    round(entropy, 4),
    "\n"
  )
  e2 <- calculate_entropy(synthetic)
  cat(
    "[METRICS] entropy:",
    round(e2, 4),
    "\n"
  )
  vocab <- length(unique(strsplit(current_text, SPLIT)[[1]]))
  cat(
    "[METRICS] vocabulary size:",
    vocab,
    "\n"
  )
  #gen<-1
  metrics <- rbind(
    metrics,
    data.frame(
      m = GENS,
      timestamp = Sys.time(),
      word = split_by_token,
      embeddings = EMBED_SIZE,
      hidden = HIDDEN_SIZE,
      batch = BATCH_SIZE,
      chars = gchar,
      seq_l = SEQ_LEN,
      epoch = EPOCHS,
      temp = TEMPERATURE,
      generation = gen,
      entropy = entropy,
      vocab = vocab,
      synthetic_ratio = SYNTHETIC_RATIO[gen]
    )
  )
  
  cat("Entropy:", entropy, "\n")
  
  # --------------------------------------
  # BUILD NEXT CORPUS
  # --------------------------------------
gen  
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
  
  synth_chars <- sample(
    strsplit(synthetic, "")[[1]],
    size = floor(synth_ratio * nchar(text)),
    replace = TRUE
  )
  
  # current_text <- paste0(
  #   c(human_chars, synth_chars),
  #   collapse = ""
  # )
  # GENS<-"xx"
  # gen<-1
  #chars
  gens<-paste0(GENS,"-",gen)
  current_text <- 
    paste0(c(current_text, paste0("#### synthetic, m",gens),synthetic),collapse="\n")
  # tail(current_text)
  gens
  torch_save(
    net,
    paste0(output.dir,"/model_gen_", gens, ".pt")
  )
  torch_save(
    optimizer$state_dict(),
    paste0(output.dir,"/optimizer_gen_", gens, ".pt")
  )
  write.csv(
    metrics,
    paste0(output.dir,"/collapse_metrics-",gens,".csv"),
    row.names = FALSE
  )
  writeLines(
    synthetic,
    paste0(output.dir,"/synthetic_gen_", gens, ".txt")
  )
  writeLines(
    current_text,
    paste0(output.dir,"/training_corpus_gen_", gens, ".txt")
  )
}

# ============================================================
# ENTROPY PLOT
# ============================================================

ggplot(metrics,
       aes(generation, entropy)) +
  geom_line(size = 1.2) +
  geom_point(size = 3) +
  ggtitle("Entropy Across Recursive Self-Training") +
  theme_minimal()

# ============================================================
# VOCABULARY PLOT
# ============================================================

ggplot(metrics,
       aes(generation, vocab)) +
  geom_line(size = 1.2) +
  geom_point(size = 3) +
  ggtitle("Vocabulary Size Across Generations") +
  theme_minimal()

print(metrics)

netf<-paste0(Sys.getenv("HKW_TOP"),"/SPUND/COMP/model/model_gen_1.pt")
### visualize
vis1<-function(net.f){
  install.packages(c(
  "uwot",
  "viridis",
  "MASS"
))
  library(torch)
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