library(torch)
library(stringr)
library(ggplot2)
library(dplyr)

set.seed(42)

# ============================================================
# PARAMETERS
# ============================================================

BATCH_SIZE <- 32
EMBED_SIZE <- 64

SEQ_LEN <- 80
HIDDEN_SIZE <- 128
EPOCHS <- 3
GENERATIONS <- 3
GENERATED_CHARS <- 50000

# SEQ_LEN <- 40
# HIDDEN_SIZE <- 64
# EPOCHS <- 1
# GENERATED_CHARS <- 2000
# GENERATIONS <- 2

TSTART<-"ich "
TEMPERATURE <- 0.8

SYNTHETIC_RATIO <- seq(0.1, 0.95, length.out = GENERATIONS)

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
                          seed = "the ",
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
  
  chars <- strsplit(text_string, "")[[1]]
  
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

current_text <- text

metrics <- data.frame()

for(gen in 1:GENERATIONS) {
  # for(gen in 1:2) {
    
  cat("\n=============================\n")
  cat("GENERATION:", gen, "\n")
  
  encoded_current <- encode_text(current_text)
  
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
  
  synthetic <- generate_text(
    net,
    # seed = "the ",
    seed = TSTART,
    n_chars = GENERATED_CHARS,
    temperature = TEMPERATURE
  )
  
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
  vocab <- length(unique(strsplit(current_text, "")[[1]]))
  cat(
    "[METRICS] vocabulary size:",
    vocab,
    "\n"
  )
  metrics <- rbind(
    metrics,
    data.frame(
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
  
  current_text <- paste0(
    c(human_chars, synth_chars),
    collapse = ""
  )
  torch_save(
    net,
    paste0("model_gen_", gen, ".pt")
  )
  torch_save(
    optimizer$state_dict(),
    paste0("optimizer_gen_", gen, ".pt")
  )
  write.csv(
    metrics,
    "collapse_metrics.csv",
    row.names = FALSE
  )
  writeLines(
    synthetic,
    paste0("synthetic_gen_", gen, ".txt")
  )
  writeLines(
    current_text,
    paste0("training_corpus_gen_", gen, ".txt")
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