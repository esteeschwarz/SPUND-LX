
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
