# ============================================================
# SHANNON ENTROPY
# ============================================================

calculate_entropy <- function(text_string,SPLIT) {
  
  chars <- unlist(strsplit(text_string, SPLIT))
  length(chars)
  probs <- table(chars) / length(chars)
  
  probs <- as.numeric(probs)
  
  entropy <- -sum(probs * log2(probs))
  
  entropy
}
notrun<-function(){
SPLIT<-""
e<-calculate_entropy(t,"")
e<-calculate_entropy(t,"\\s+")
e
t2<-sample(chars,length(chars))
head(t2)
t3<-gsub("f","g",t2)
calculate_entropy(t3,"")
}