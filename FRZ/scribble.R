  t<-c("random text containing Musk, Musk ,Elon,Twitter and Twitter","and other random like muskles and Twittern or","twittern eg", "or Muskles and nothing")
  keywords=c("Musk","Elon","Twitter")
matches <- sapply(t, function(x) all(sapply(keywords, function(k) grepl(k, x, ignore.case = TRUE))))
result <- t[matches]
print(result)