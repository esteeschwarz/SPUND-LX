Q<-"https://db.mocoda2.de/search"

d<-c(0.144003291503806,
0.262291709524789,
0.0437152849207982,
0.167146677638346,
0.154289240896935)
barplot(d)
d2<-38888
d1<-c(56,
102,
17,
65,
60)
query<-"https://db.mocoda2.de/results?meta.messages.text_pseudo=%7B%22$regex%22:%22XD%22,%22$options%22:%22i%22%7D"
d3<-d1/d2*100
n<-c("XD",
     "nix",
     "öö",
     "omg|wtf",
     "!!!")
df<-data.frame(d1,d3,n)
barplot(df$d3~df$n,xlab = "token",ylab = "%",main="mocoda2 query")

d1<-read.csv("mastodon_results.csv")
d1$Post[1]
m<-grep("AFD",d1$Post)
d1$Post[m]
