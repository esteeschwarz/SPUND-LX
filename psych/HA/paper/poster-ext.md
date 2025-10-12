---
title: "xtitle: coherence & presuppositions observations in :schizophrenia: threads"
author: "st. schwarz"
date: "2025-10-12"
output: 
    bookdown::html_document2:
      base_format: tufte::tufte_html
      keep_md: true
      self_contained: true
    #fig_path: "plots/"
  # md_document:
  #   variant: markdown_github
  #   pandoc_args: ["--wrap=none"]
  #keep_md: yes
bibliography: /Users/guhl/Documents/GitHub/SPUND-LX/psych/HA/paper/psych.bib
nocite: '@*'
#keep_md: true
---



<style type="text/css">
/*table {
  width: 100% !important;
  
}*/
pre {
border: 1px solid black;
border-radius: 0.25rem;
background-color: rgba(0, 0, 0, 0.04);

}
</style>




``` r
#dataset<-7
#poster-ext-top
render_child <- function(child_file, prefix) {
  # Read the child
  txt <- readLines(child_file)
  # Substitute <<prefix>> placeholders with actual prefix
  txt <- gsub("<<model>>", paste0("_M-",prefix), txt)
  
  # Write a temporary file
  tmpfile <- tempfile(fileext = ".Rmd")
  writeLines(txt, tmpfile)
  
  # Knit the child inline
  res <- knit_child(tmpfile)
  file.remove(tmpfile)
  #return(res)
  cat(res,sep = "\n")
}
```

























<style type="text/css">
/*table {
  width: 100% !important;
  
}*/
pre {
border: 1px solid black;
border-radius: 0.25rem;
background-color: rgba(0, 0, 0, 0.04);

}
</style>




``` r
#dataset<-7
#prelim
```








```
## token NA 0
```





``` r
render_child("child-poster-ext.Rmd", model.n)
```



```
## 
## 
## processing file: /var/folders/4d/3c55d5_d0sd8g2015lq4vpt40000gn/T//RtmpYyd6X6/file183ac71084120.Rmd
```

  |                                                         |                                                 |   0%  |                                                         |..                                               |   3%                       |                                                         |...                                              |   6% [unnamed-chunk-18]    |                                                         |.....                                            |  10%                       |                                                         |......                                           |  13% [unnamed-chunk-19]    |                                                         |........                                         |  16%                       |                                                         |.........                                        |  19% [unnamed-chunk-20]    |                                                         |...........                                      |  23%                       |                                                         |.............                                    |  26% [wcount_M-1]          |                                                         |..............                                   |  29%                       |                                                         |................                                 |  32% [modelexp_M-1]        |                                                         |.................                                |  35%                       |                                                         |...................                              |  39% [legend_M-1]          |                                                         |.....................                            |  42%                       |                                                         |......................                           |  45% [dfs1_M-1]            |                                                         |........................                         |  48%                       |                                                         |.........................                        |  52% [dfs2_M-1]            |                                                         |...........................                      |  55%                       |                                                         |............................                     |  58% [dfs3_M-1]            |                                                         |..............................                   |  61%                       |                                                         |................................                 |  65% [boxplot1_M-1]        |                                                         |.................................                |  68%                       |                                                         |...................................              |  71% [barplot-median_M-1]  |                                                         |....................................             |  74%                       |                                                         |......................................           |  77% [dfe-table_M-1]       |                                                         |........................................         |  81%                       |                                                         |.........................................        |  84% [barplot-mean_M-1]    |                                                         |...........................................      |  87%                       |                                                         |............................................     |  90% [lmeplot_M-1]         |                                                         |..............................................   |  94%                       |                                                         |...............................................  |  97% [gplot_M-1]           |                                                         |.................................................| 100%                                                                                                                                    






















<style type="text/css">
/*table {
  width: 100% !important;
  
}*/
pre {
border: 1px solid black;
border-radius: 0.25rem;
background-color: rgba(0, 0, 0, 0.04);

}
</style>




``` r
#dataset<-7
#poster-ext
print(model.n)
```



```
## [1] 1
```





# appendix
eval output data: 13, normalised to all, distance ceiling =  outliers removed, wordcount: 2599.

## eval method model: 1



```
##                value
## norm_target _rel_all
## det.t           TRUE
## limit           TRUE
## author          TRUE
## url             TRUE
## embed1          TRUE
## embed2             f
## range1          TRUE
## range2             f
## rel             TRUE
## lme            FALSE
## lemma          FALSE
```




## legende


Table: (\#tab:legend_M-1)model vars

|variable    |explanation                                |values                  |
|:-----------|:------------------------------------------|:-----------------------|
|target      |corpus                                     |obs,ref                 |
|q           |condition                                  |a,b,c,d,e,f             |
|det         |antecedent POS==DET                        |TRUE,FALSE              |
|aut_id      |author                                     |author hash             |
|lemma       |lemma                                      |noun lemma              |
|range       |url range of distance devised              |1..maxlength(urlthread) |
|embed.score |semantic similarity score lemma vs. thread |0..1                    |
|q:a         |query condition                            |.*                      |
|q:b         |query condition                            |this,that,those,these   |
|q:c         |query condition                            |the                     |
|q:d         |query condition                            |a,an,any,some           |
|q:e         |query condition                            |my                      |
|q:f         |query condition                            |his,her,their,your      |



## anova analysis
### anova plain
formula: [``` dist_rel_all ~ target*q*det ```]



```
##                  Df     Sum Sq    Mean Sq   F value    Pr(>F)    
## target            1 1.2830e+09 1283010757 7336.4625 < 2.2e-16 ***
## q                 5 3.4949e+07    6989793   39.9688 < 2.2e-16 ***
## det               1 4.6410e+06    4641007   26.5380 2.588e-07 ***
## target:q          5 7.7932e+06    1558646    8.9126 1.786e-08 ***
## target:det        1 7.1283e+05     712833    4.0761  0.043496 *  
## q:det             2 2.5680e+06    1283981    7.3420  0.000648 ***
## target:q:det      1 2.0345e+06    2034482   11.6335  0.000648 ***
## Residuals    126209 2.2072e+10     174881                        
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
```



### anova of linear regression model
[`anova(summary(lmer))`]



```
## Type III Analysis of Variance Table with Satterthwaite's method
##                 Sum Sq   Mean Sq NumDF  DenDF   F value    Pr(>F)    
## target         3245706   3245706     1   3519   23.4567 1.333e-06 ***
## q              2091953    418391     5 122421    3.0237 0.0098706 ** 
## det              34508     34508     1 118425    0.2494 0.6175055    
## range        142964301 142964301     1   1025 1033.2042 < 2.2e-16 ***
## embed.score   71204325  71204325     1 122690  514.5942 < 2.2e-16 ***
## target:q       2202162    440432     5 123486    3.1830 0.0070933 ** 
## target:det     1534830   1534830     1 123325   11.0922 0.0008672 ***
## q:det          1019818    509909     2 120804    3.6851 0.0250971 *  
## target:q:det    623611    623611     1 123315    4.5068 0.0337615 *  
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
```



### linear regression coefficients
formula: [``` dist_rel_all ~ target*q*det+(1|aut_id)+range+(embed.score)+(1|url_id) ```]



```
## Linear mixed model fit by REML. t-tests use Satterthwaite's method [
## lmerModLmerTest]
## Formula: eval(expr(lmeform))
##    Data: dfa
## 
## REML criterion at convergence: 1859224
## 
## Scaled residuals: 
##     Min      1Q  Median      3Q     Max 
## -2.8643 -0.5282 -0.1721  0.2469  6.9244 
## 
## Random effects:
##  Groups   Name        Variance Std.Dev.
##  aut_id   (Intercept)   8101    90.01  
##  url_id   (Intercept)  23223   152.39  
##  Residual             138370   371.98  
## Number of obs: 126226, groups:  aut_id, 8238; url_id, 2145
## 
## Fixed effects:
##                    Estimate Std. Error         df t value Pr(>|t|)    
## (Intercept)       7.789e+02  8.688e+00  8.969e+03  89.651  < 2e-16 ***
## targetref        -7.312e+01  1.061e+01  1.300e+03  -6.893 8.50e-12 ***
## qb               -3.390e+01  2.572e+01  1.218e+05  -1.318 0.187483    
## qc               -3.717e+01  9.261e+00  1.226e+05  -4.014 5.98e-05 ***
## qd               -5.353e+01  3.748e+02  1.184e+05  -0.143 0.886426    
## qe                4.198e+01  6.460e+00  1.247e+05   6.498 8.14e-11 ***
## qf               -3.185e+01  8.240e+00  1.244e+05  -3.866 0.000111 ***
## det               2.144e+01  8.041e+00  1.229e+05   2.667 0.007662 ** 
## range            -9.786e-02  3.044e-03  1.025e+03 -32.143  < 2e-16 ***
## embed.score      -3.080e+02  1.358e+01  1.227e+05 -22.685  < 2e-16 ***
## targetref:qb      3.136e+01  2.894e+01  1.225e+05   1.083 0.278599    
## targetref:qc      3.842e+01  2.154e+01  1.237e+05   1.784 0.074435 .  
## targetref:qd      7.432e-01  2.113e+01  1.238e+05   0.035 0.971935    
## targetref:qe     -3.910e+01  1.602e+01  1.239e+05  -2.441 0.014662 *  
## targetref:qf      3.033e+01  2.039e+01  1.238e+05   1.488 0.136766    
## targetref:det    -2.490e+01  1.826e+01  1.239e+05  -1.363 0.172784    
## qb:det            9.962e+01  2.826e+01  1.219e+05   3.526 0.000423 ***
## qd:det            6.144e+01  3.747e+02  1.184e+05   0.164 0.869736    
## targetref:qb:det -8.754e+01  4.124e+01  1.233e+05  -2.123 0.033761 *  
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## fit warnings:
## fixed-effect model matrix is rank deficient so dropping 7 columns / coefficients
## Some predictor variables are on very different scales: consider rescaling
```



## plots
<div class="figure">
<p class="caption">(\#fig:boxplot1_M-1)compare distances by corpus, normalised to all, distance ceiling =  outliers removed</p><img src="poster-ext_files/figure-html/boxplot1_M-1-1.png" alt="compare distances by corpus, normalised to all, distance ceiling =  outliers removed"  /></div>

<div class="figure">
<p class="caption">(\#fig:barplot-median_M-1)mean distances over query/corpus, normalised to all, distance ceiling =  outliers removed</p><img src="poster-ext_files/figure-html/barplot-median_M-1-1.png" alt="mean distances over query/corpus, normalised to all, distance ceiling =  outliers removed"  /></div>




Table: (\#tab:dfe-table_M-1)mean/median table for M13

|target |q  |     n| mean| median|
|:------|:--|-----:|----:|------:|
|obs    |a  | 42836|  395|    196|
|ref    |a  | 58615|  203|     79|
|obs    |b  |  2116|  481|    279|
|ref    |b  |  1130|  204|     75|
|obs    |c  |  5770|  388|    191|
|ref    |c  |  1274|  203|     80|
|obs    |d  |  5654|  437|    243|
|ref    |d  |  1525|  205|     83|
|obs    |e  |  3911|  473|    248|
|ref    |e  |   671|  211|     75|
|obs    |f  |  2311|  374|    224|
|ref    |f  |   413|  195|     79|




<div class="figure">
<p class="caption">(\#fig:barplot-mean_M-1)median distances over query/corpus, normalised to all, distance ceiling =  outliers removed</p><img src="poster-ext_files/figure-html/barplot-mean_M-1-1.png" alt="median distances over query/corpus, normalised to all, distance ceiling =  outliers removed"  /></div>

<div class="figure">
<p class="caption">(\#fig:lmeplot_M-1)distances relation, normalised to all, distance ceiling =  outliers removed</p><img src="poster-ext_files/figure-html/lmeplot_M-1-1.png" alt="distances relation, normalised to all, distance ceiling =  outliers removed"  /></div>

<div class="figure">
<p class="caption">(\#fig:gplot_M-1)distances normalised vs. raw</p><img src="poster-ext_files/figure-html/gplot_M-1-1.png" alt="distances normalised vs. raw"  /></div>

-----

## lit-ext
literature used and alii...   






```
## token NA 0
```




``` r
render_child("child-poster-ext.Rmd", model.n)
```



```
## 
## 
## processing file: /var/folders/4d/3c55d5_d0sd8g2015lq4vpt40000gn/T//RtmpYyd6X6/file183ac3bfd8b5b.Rmd
```

  |                                                         |                                                 |   0%  |                                                         |..                                               |   3%                       |                                                         |...                                              |   6% [unnamed-chunk-38]    |                                                         |.....                                            |  10%                       |                                                         |......                                           |  13% [unnamed-chunk-39]    |                                                         |........                                         |  16%                       |                                                         |.........                                        |  19% [unnamed-chunk-40]    |                                                         |...........                                      |  23%                       |                                                         |.............                                    |  26% [wcount_M-2]          |                                                         |..............                                   |  29%                       |                                                         |................                                 |  32% [modelexp_M-2]        |                                                         |.................                                |  35%                       |                                                         |...................                              |  39% [legend_M-2]          |                                                         |.....................                            |  42%                       |                                                         |......................                           |  45% [dfs1_M-2]            |                                                         |........................                         |  48%                       |                                                         |.........................                        |  52% [dfs2_M-2]            |                                                         |...........................                      |  55%                       |                                                         |............................                     |  58% [dfs3_M-2]            |                                                         |..............................                   |  61%                       |                                                         |................................                 |  65% [boxplot1_M-2]        |                                                         |.................................                |  68%                       |                                                         |...................................              |  71% [barplot-median_M-2]  |                                                         |....................................             |  74%                       |                                                         |......................................           |  77% [dfe-table_M-2]       |                                                         |........................................         |  81%                       |                                                         |.........................................        |  84% [barplot-mean_M-2]    |                                                         |...........................................      |  87%                       |                                                         |............................................     |  90% [lmeplot_M-2]         |                                                         |..............................................   |  94%                       |                                                         |...............................................  |  97% [gplot_M-2]           |                                                         |.................................................| 100%                                                                                                                                    






















<style type="text/css">
/*table {
  width: 100% !important;
  
}*/
pre {
border: 1px solid black;
border-radius: 0.25rem;
background-color: rgba(0, 0, 0, 0.04);

}
</style>




``` r
#dataset<-7
#poster-ext
print(model.n)
```



```
## [1] 2
```





# appendix
eval output data: 13, normalised to all, distance ceiling =  outliers removed, wordcount: 2599.

## eval method model: 2



```
##             value
## norm_target      
## det.t        TRUE
## limit       FALSE
## author       TRUE
## url          TRUE
## embed1       TRUE
## embed2          f
## range1       TRUE
## range2          f
## rel         FALSE
## lme         FALSE
## lemma       FALSE
```




## legende


Table: (\#tab:legend_M-2)model vars

|variable    |explanation                                |values                  |
|:-----------|:------------------------------------------|:-----------------------|
|target      |corpus                                     |obs,ref                 |
|q           |condition                                  |a,b,c,d,e,f             |
|det         |antecedent POS==DET                        |TRUE,FALSE              |
|aut_id      |author                                     |author hash             |
|lemma       |lemma                                      |noun lemma              |
|range       |url range of distance devised              |1..maxlength(urlthread) |
|embed.score |semantic similarity score lemma vs. thread |0..1                    |
|q:a         |query condition                            |.*                      |
|q:b         |query condition                            |this,that,those,these   |
|q:c         |query condition                            |the                     |
|q:d         |query condition                            |a,an,any,some           |
|q:e         |query condition                            |my                      |
|q:f         |query condition                            |his,her,their,your      |



## anova analysis
### anova plain
formula: [``` dist_rel_all ~ target*q*det ```]



```
##                  Df     Sum Sq    Mean Sq   F value    Pr(>F)    
## target            1 1.2830e+09 1283010757 7336.4625 < 2.2e-16 ***
## q                 5 3.4949e+07    6989793   39.9688 < 2.2e-16 ***
## det               1 4.6410e+06    4641007   26.5380 2.588e-07 ***
## target:q          5 7.7932e+06    1558646    8.9126 1.786e-08 ***
## target:det        1 7.1283e+05     712833    4.0761  0.043496 *  
## q:det             2 2.5680e+06    1283981    7.3420  0.000648 ***
## target:q:det      1 2.0345e+06    2034482   11.6335  0.000648 ***
## Residuals    126209 2.2072e+10     174881                        
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
```



### anova of linear regression model
[`anova(summary(lmer))`]



```
## Type III Analysis of Variance Table with Satterthwaite's method
##                 Sum Sq   Mean Sq NumDF  DenDF   F value    Pr(>F)    
## target         3245706   3245706     1   3519   23.4567 1.333e-06 ***
## q              2091953    418391     5 122421    3.0237 0.0098706 ** 
## det              34508     34508     1 118425    0.2494 0.6175055    
## range        142964301 142964301     1   1025 1033.2042 < 2.2e-16 ***
## embed.score   71204325  71204325     1 122690  514.5942 < 2.2e-16 ***
## target:q       2202162    440432     5 123486    3.1830 0.0070933 ** 
## target:det     1534830   1534830     1 123325   11.0922 0.0008672 ***
## q:det          1019818    509909     2 120804    3.6851 0.0250971 *  
## target:q:det    623611    623611     1 123315    4.5068 0.0337615 *  
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
```



### linear regression coefficients
formula: [``` dist_rel_all ~ target*q*det+(1|aut_id)+range+(embed.score)+(1|url_id) ```]



```
## Linear mixed model fit by REML. t-tests use Satterthwaite's method [
## lmerModLmerTest]
## Formula: eval(expr(lmeform))
##    Data: dfa
## 
## REML criterion at convergence: 1859224
## 
## Scaled residuals: 
##     Min      1Q  Median      3Q     Max 
## -2.8643 -0.5282 -0.1721  0.2469  6.9244 
## 
## Random effects:
##  Groups   Name        Variance Std.Dev.
##  aut_id   (Intercept)   8101    90.01  
##  url_id   (Intercept)  23223   152.39  
##  Residual             138370   371.98  
## Number of obs: 126226, groups:  aut_id, 8238; url_id, 2145
## 
## Fixed effects:
##                    Estimate Std. Error         df t value Pr(>|t|)    
## (Intercept)       7.789e+02  8.688e+00  8.969e+03  89.651  < 2e-16 ***
## targetref        -7.312e+01  1.061e+01  1.300e+03  -6.893 8.50e-12 ***
## qb               -3.390e+01  2.572e+01  1.218e+05  -1.318 0.187483    
## qc               -3.717e+01  9.261e+00  1.226e+05  -4.014 5.98e-05 ***
## qd               -5.353e+01  3.748e+02  1.184e+05  -0.143 0.886426    
## qe                4.198e+01  6.460e+00  1.247e+05   6.498 8.14e-11 ***
## qf               -3.185e+01  8.240e+00  1.244e+05  -3.866 0.000111 ***
## det               2.144e+01  8.041e+00  1.229e+05   2.667 0.007662 ** 
## range            -9.786e-02  3.044e-03  1.025e+03 -32.143  < 2e-16 ***
## embed.score      -3.080e+02  1.358e+01  1.227e+05 -22.685  < 2e-16 ***
## targetref:qb      3.136e+01  2.894e+01  1.225e+05   1.083 0.278599    
## targetref:qc      3.842e+01  2.154e+01  1.237e+05   1.784 0.074435 .  
## targetref:qd      7.432e-01  2.113e+01  1.238e+05   0.035 0.971935    
## targetref:qe     -3.910e+01  1.602e+01  1.239e+05  -2.441 0.014662 *  
## targetref:qf      3.033e+01  2.039e+01  1.238e+05   1.488 0.136766    
## targetref:det    -2.490e+01  1.826e+01  1.239e+05  -1.363 0.172784    
## qb:det            9.962e+01  2.826e+01  1.219e+05   3.526 0.000423 ***
## qd:det            6.144e+01  3.747e+02  1.184e+05   0.164 0.869736    
## targetref:qb:det -8.754e+01  4.124e+01  1.233e+05  -2.123 0.033761 *  
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## fit warnings:
## fixed-effect model matrix is rank deficient so dropping 7 columns / coefficients
## Some predictor variables are on very different scales: consider rescaling
```



## plots
<div class="figure">
<p class="caption">(\#fig:boxplot1_M-2)compare distances by corpus, normalised to all, distance ceiling =  outliers removed</p><img src="poster-ext_files/figure-html/boxplot1_M-2-1.png" alt="compare distances by corpus, normalised to all, distance ceiling =  outliers removed"  /></div>

<div class="figure">
<p class="caption">(\#fig:barplot-median_M-2)mean distances over query/corpus, normalised to all, distance ceiling =  outliers removed</p><img src="poster-ext_files/figure-html/barplot-median_M-2-1.png" alt="mean distances over query/corpus, normalised to all, distance ceiling =  outliers removed"  /></div>




Table: (\#tab:dfe-table_M-2)mean/median table for M13

|target |q  |     n| mean| median|
|:------|:--|-----:|----:|------:|
|obs    |a  | 42836|  395|    196|
|ref    |a  | 58615|  203|     79|
|obs    |b  |  2116|  481|    279|
|ref    |b  |  1130|  204|     75|
|obs    |c  |  5770|  388|    191|
|ref    |c  |  1274|  203|     80|
|obs    |d  |  5654|  437|    243|
|ref    |d  |  1525|  205|     83|
|obs    |e  |  3911|  473|    248|
|ref    |e  |   671|  211|     75|
|obs    |f  |  2311|  374|    224|
|ref    |f  |   413|  195|     79|




<div class="figure">
<p class="caption">(\#fig:barplot-mean_M-2)median distances over query/corpus, normalised to all, distance ceiling =  outliers removed</p><img src="poster-ext_files/figure-html/barplot-mean_M-2-1.png" alt="median distances over query/corpus, normalised to all, distance ceiling =  outliers removed"  /></div>

<div class="figure">
<p class="caption">(\#fig:lmeplot_M-2)distances relation, normalised to all, distance ceiling =  outliers removed</p><img src="poster-ext_files/figure-html/lmeplot_M-2-1.png" alt="distances relation, normalised to all, distance ceiling =  outliers removed"  /></div>

<div class="figure">
<p class="caption">(\#fig:gplot_M-2)distances normalised vs. raw</p><img src="poster-ext_files/figure-html/gplot_M-2-1.png" alt="distances normalised vs. raw"  /></div>

-----

## lit-ext
literature used and alii...   




