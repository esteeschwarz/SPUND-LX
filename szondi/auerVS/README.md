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

<figure>
<img src="README_files/figure-gfm/plot-ner-1.png"
alt="named entities" />
<figcaption aria-hidden="true">named entities</figcaption>
</figure>

![](ner-dist.png)

``` r
#load("ner.table.RData")
#par(las=3)
#barplot(ner.t,horiz = F,log = "y",xpd = T,beside = T)
```

------------------------------------------------------------------------

#### references

script: [droste-essai.R](droste-essai.R)
