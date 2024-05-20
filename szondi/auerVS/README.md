VS Auer distant reading
================

contains distant reading essais VS Michael Auer/FUB-SoSe24

#### 1.droste-hülshoff: judenbuche

- get book from gutenberg.org
- extract named entities
- plot named entity occurences over text

``` r
load("ner.plot.RData")
plot(ner.plot,type="h",main="named entities over text",xlab="characters")
```

## ![named entities](README_files/figure-gfm/plot-ner-1.png)

#### references

script: [droste-essai.R](droste-essai.R)
