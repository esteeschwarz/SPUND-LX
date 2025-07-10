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
> SPARQL abfrageergebnis
<https://w.wiki/CJz4>

> DDB # WD:looted qualifier
<https://www.deutsche-digitale-bibliothek.de/item/T3QD3SVT6Q4NZ2DUIBXLJSNR3NA667EP>
`id="accordion-wrapper-item-flex_mus_neu_460"`
<https://www.deutsche-digitale-bibliothek.de/item/T3QD3SVT6Q4NZ2DUIBXLJSNR3NA667EP#accordion-4>