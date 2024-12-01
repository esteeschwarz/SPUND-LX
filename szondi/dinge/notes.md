# 15492.notes
## hicks respondence

> [wikidata SPARQL query](https://w.wiki/CFqj) to Benin bronze context:

```sql
SELECT DISTINCT ?item ?itemLabel WHERE {
  SERVICE wikibase:label { bd:serviceParam wikibase:language "[AUTO_LANGUAGE]". }
  {
    SELECT DISTINCT ?item WHERE {
      ?item p:P1071 ?statement0.
      ?statement0 (ps:P1071/(wdt:P279*)) wd:Q320704.
    }
    LIMIT 100
  }
}
```

> Idia:
`wd:Q106983702`