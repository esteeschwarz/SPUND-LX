---
title: "xtitle: coherence & presuppositions observations in :schizophrenia: threads"
author: "st. schwarz"
date: "2025-08-14"
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
bibliography: psych.bib
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
```



# top
eval output M12, normalised to obs, distance ceiling =  outliers removed.

## legende

```
## [1] ", normalised to obs, distance ceiling =  outliers removed"
```



Table: (\#tab:legend)model vars

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
### anova plain, formula: [``` dist_rel_obs ~ target*q*det ```]

```
##                   Df     Sum Sq    Mean Sq    F value Pr(>F)    
## target             1 6.5314e+09 6531359317 3.2559e+05 <2e-16 ***
## q                  5 3.5058e+08   70116374 3.4953e+03 <2e-16 ***
## det                1 1.5458e+07   15457530 7.7056e+02 <2e-16 ***
## target:q           5 1.8239e+06     364778 1.8184e+01 <2e-16 ***
## target:det         1 6.1232e+06    6123176 3.0524e+02 <2e-16 ***
## q:det              1 3.1197e+04      31197 1.5552e+00 0.2124    
## target:q:det       1 1.8157e+06    1815712 9.0514e+01 <2e-16 ***
## Residuals    2249061 4.5116e+10      20060                      
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
```

### anova of linear regression model: [`anova(summary(lmer))`]


```
## Type III Analysis of Variance Table with Satterthwaite's method
##                 Sum Sq   Mean Sq NumDF  DenDF    F value    Pr(>F)    
## target           82484     82484     1 155603     4.2727   0.03873 *  
## q              1614197    322839     5 155801    16.7235 < 2.2e-16 ***
## det              54104     54104     1 155344     2.8026   0.09411 .  
## range        250671788 250671788     1 151248 12985.0989 < 2.2e-16 ***
## embed.score    3797399   3797399     1 157460   196.7098 < 2.2e-16 ***
## target:q       1064174    212835     5 155772    11.0251 1.235e-10 ***
## target:det       30708     30708     1 156612     1.5907   0.20722    
## q:det           105369    105369     1 155289     5.4582   0.01948 *  
## target:q:det                                                          
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
```

### linear regression coefficients, formula: [``` dist_rel_obs ~ target*q*det+(1|aut_id)+range+embed.score ```]

```
## Linear mixed model fit by REML. t-tests use Satterthwaite's method ['lmerModLmerTest']
## Formula: eval(expr(lmeform))
##    Data: dfa
## 
## REML criterion at convergence: 2014129
## 
## Scaled residuals: 
##     Min      1Q  Median      3Q     Max 
## -6.5794 -0.3429 -0.0365  0.1456 15.9844 
## 
## Random effects:
##  Groups   Name        Variance Std.Dev.
##  aut_id   (Intercept) 41939    204.8   
##  Residual             19305    138.9   
## Number of obs: 157757, groups:  aut_id, 2512
## 
## Fixed effects:
##                     Estimate Std. Error         df  t value Pr(>|t|)    
## (Intercept)        3.386e+02  4.772e+00  3.367e+03   70.953  < 2e-16 ***
## targetref         -1.375e+01  4.211e+00  3.588e+04   -3.266 0.001093 ** 
## qb                 6.711e+01  1.328e+01  1.553e+05    5.055 4.31e-07 ***
## qc                 4.929e+01  2.865e+00  1.553e+05   17.204  < 2e-16 ***
## qd                 5.424e+01  2.903e+00  1.554e+05   18.686  < 2e-16 ***
## qe                 8.939e+01  4.512e+00  1.555e+05   19.811  < 2e-16 ***
## qf                 7.966e+01  5.550e+00  1.554e+05   14.352  < 2e-16 ***
## detTRUE            5.402e+00  1.346e+00  1.562e+05    4.012 6.01e-05 ***
## range             -3.799e-02  3.334e-04  1.512e+05 -113.952  < 2e-16 ***
## embed.score        6.208e+01  4.426e+00  1.575e+05   14.025  < 2e-16 ***
## targetref:qb      -7.595e+01  3.371e+01  1.563e+05   -2.253 0.024268 *  
## targetref:qc      -4.976e+01  1.388e+01  1.551e+05   -3.585 0.000337 ***
## targetref:qd      -4.986e+01  1.283e+01  1.550e+05   -3.886 0.000102 ***
## targetref:qe      -1.036e+02  3.677e+01  1.575e+05   -2.816 0.004856 ** 
## targetref:qf       2.261e+02  5.835e+01  1.550e+05    3.876 0.000106 ***
## targetref:detTRUE -3.762e+00  2.982e+00  1.566e+05   -1.261 0.207223    
## qb:detTRUE        -3.566e+01  1.527e+01  1.553e+05   -2.336 0.019478 *  
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## fit warnings:
## fixed-effect model matrix is rank deficient so dropping 9 columns / coefficients
## Some predictor variables are on very different scales: consider rescaling
```

## plots
<div class="figure">
<p class="caption">(\#fig:boxplot1)compare distances by corpus, normalised to obs, distance ceiling =  outliers removed</p><img src="poster-ext_files/figure-html/boxplot1-1.png" alt="compare distances by corpus, normalised to obs, distance ceiling =  outliers removed"  /></div>

<div class="figure">
<p class="caption">(\#fig:barplot-median)mean distances over query/corpus, normalised to obs, distance ceiling =  outliers removed</p><img src="poster-ext_files/figure-html/barplot-median-1.png" alt="mean distances over query/corpus, normalised to obs, distance ceiling =  outliers removed"  /></div>



Table: (\#tab:dfe-table)mean/median table for M12

|target |q  |       n| mean| median|
|:------|:--|-------:|----:|------:|
|obs    |a  |  541133|  158|     73|
|ref    |a  | 1609781|   45|     18|
|obs    |b  |    5540|  196|    108|
|ref    |b  |    2407|   94|     70|
|obs    |c  |   25564|  219|    125|
|ref    |c  |    4550|   90|     54|
|obs    |d  |   23803|  228|    132|
|ref    |d  |    4498|  114|     63|
|obs    |e  |   18067|  238|    131|
|ref    |e  |    1417|  123|     80|
|obs    |f  |   11464|  189|    104|
|ref    |f  |     853|   67|     55|


<div class="figure">
<p class="caption">(\#fig:barplot-mean)median distances over query/corpus, normalised to obs, distance ceiling =  outliers removed</p><img src="poster-ext_files/figure-html/barplot-mean-1.png" alt="median distances over query/corpus, normalised to obs, distance ceiling =  outliers removed"  /></div>

<div class="figure">
<p class="caption">(\#fig:lmeplot)distances relation, normalised to obs, distance ceiling =  outliers removed</p><img src="poster-ext_files/figure-html/lmeplot-1.png" alt="distances relation, normalised to obs, distance ceiling =  outliers removed"  /></div>

<div class="figure">
<p class="caption">(\#fig:gplot)distances normalised vs. raw</p><img src="poster-ext_files/figure-html/gplot-1.png" alt="distances normalised vs. raw"  /></div>
-----

# REF
literature used and alii...   


