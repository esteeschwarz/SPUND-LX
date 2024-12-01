# 20241201(06.25)
# 15481.hicks.response
######################
#http://www.r-bloggers.com/sparql-with-r-in-less-than-5-minutes/

library(SPARQL) # SPARQL querying package
library(ggplot2)

endpoint <- "https://query.wikidata.org/sparql"
query <- 'SELECT DISTINCT ?item ?itemLabel WHERE {\n  ?item ?property wd:Q106983702.\n  SERVICE wikibase:label { bd:serviceParam wikibase:language "[AUTO_LANGUAGE],en". }\n}\nLIMIT 100'
useragent <- paste("WDQS-Example", R.version.string) # TODO adjust this; see https://w.wiki/CX6
query<-'SELECT ?property ?propertyLabel ?value ?valueLabel WHERE {
  wd:Q106983702 ?property ?value.
  SERVICE wikibase:label { bd:serviceParam wikibase:language "[AUTO_LANGUAGE],en". }
}'
query<-'#All statements of an item containing another item (direct / first-degree connections)
#defaultView:Graph
#TEMPLATE={ "template": { "en": "All statements of ?item containing another item" }, "variables": { "?item": {} } }
SELECT ?item ?itemLabel ?itemImage ?value ?valueLabel ?valueImage ?edgeLabel WHERE {
  BIND(wd:Q106983702 AS ?item)
  ?item ?wdt ?value.
  ?edge a wikibase:Property;
        wikibase:propertyType wikibase:WikibaseItem; # <span lang="en" dir="ltr" class="mw-content-ltr">note: to show all statements, removing this is not enough, the graph view only shows entities</span>
        wikibase:directClaim ?wdt.
  OPTIONAL { ?item wdt:P18 ?itemImage. }
  OPTIONAL { ?value wdt:P18 ?valueImage. }
  SERVICE wikibase:label { bd:serviceParam wikibase:language "[AUTO_LANGUAGE],mul,en". }
}'
qd <- SPARQL(endpoint,query,curl_args=list(useragent=useragent))
df <- qd$results
df2<-df[,c(2,3,5,7)]
gs<-function(x){
  gsub('(@en|")',"",x)
  #gsub('"',"",x)
}
  
df2[,1:4]<-lapply(df2[,1:4],gs)
#df2[,1:4]<-gsub('"',"",df2[,1:4])
df2[,2]<-gsub('.+Afrika.+',"Dahlem",df2[,2])
df2[,2]<-gsub('.+Bode.+',"Bode-Museum",df2[,2])
df3<-cbind(id=1:length(df2$itemLabel),df2[,1:4])
colnames(df3)[4]<-"Target"
colnames(df3)[3]<-"Source"
df3<-cbind(df3[,1:5],Label=df3[,5])
write_csv(df3[,1:4],"query-idia_sans-edges.csv")
write_csv(df3[,c(1,2,5,6)],"query-idia_edges.csv")
write_csv(df3[,1:6],"query-idia_sans_cpt.csv")
### > import to gephi, export graphml



