---
title: "xtitle: coherence & presuppositions observations in :schizophrenia: threads"
author: "st. schwarz"
date: "2025-07-21"
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






``` r
#dataset<-7
```



# top
eval output M12, normalised to obs, distance ceiling =  outliers removed.

## legende

Table: (\#tab:legend)model vars

|variable |explanation         |values                |
|:--------|:-------------------|:---------------------|
|target   |corpus              |obs,ref               |
|q        |condition           |a,b,c,d,e,f           |
|det      |antecedent POS==DET |TRUE,FALSE            |
|q:a      |query condition     |.*                    |
|q:b      |query condition     |this,that,those,these |
|q:c      |query condition     |the                   |
|q:d      |query condition     |a,an,any,some         |
|q:e      |query condition     |my                    |
|q:f      |query condition     |his,her,their,your    |

## anova analysis
### anova plain, formula: [``` dist_rel_obs ~ target*q*det ```]

```
##                   Df     Sum Sq    Mean Sq    F value Pr(>F)    
## target             1 6.5211e+09 6521055101 3.2504e+05 <2e-16 ***
## q                  5 3.5037e+08   70073425 3.4927e+03 <2e-16 ***
## det                1 1.5794e+07   15794286 7.8725e+02 <2e-16 ***
## target:q           5 1.8048e+06     360954 1.7991e+01 <2e-16 ***
## target:det         1 6.1306e+06    6130639 3.0558e+02 <2e-16 ***
## q:det              1 3.0206e+04      30206 1.5056e+00 0.2198    
## target:q:det       1 1.8137e+06    1813711 9.0403e+01 <2e-16 ***
## Residuals    2252827 4.5198e+10      20063                      
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
```

### anova of linear regression model: [`anova(summary(lmer))`]


```
## Type III Analysis of Variance Table with Satterthwaite's method
##                Sum Sq  Mean Sq NumDF   DenDF   F value Pr(>F)    
## target       46297852 46297852     1 1374850 3133.7552 <2e-16 ***
## q            98144581 19628916     5 2239856 1328.6193 <2e-16 ***
## det              5799     5799     1 2240157    0.3925 0.5310    
## target:q      2279753   455951     5 2239857   30.8619 <2e-16 ***
## target:det        943      943     1 2240144    0.0638 0.8006    
## q:det            4436     4436     1 2240039    0.3003 0.5837    
## target:q:det     9728     9728     1 2240025    0.6584 0.4171    
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
```

### linear regression coefficients, formula: [``` dist_rel_obs ~ target*q*det+(1|lemma)+(1|aut_id) ```]

```
## Linear mixed model fit by REML. t-tests use Satterthwaite's method ['lmerModLmerTest']
## Formula: eval(expr(lmeform))
##    Data: dfa
## 
## REML criterion at convergence: 28080885
## 
## Scaled residuals: 
##     Min      1Q  Median      3Q     Max 
## -9.6846 -0.2934 -0.0518  0.0900 18.6074 
## 
## Random effects:
##  Groups   Name        Variance Std.Dev.
##  aut_id   (Intercept) 30320    174.1   
##  lemma    (Intercept) 32250    179.6   
##  Residual             14774    121.5   
## Number of obs: 2252843, groups:  aut_id, 8258; lemma, 4960
## 
## Fixed effects:
##                        Estimate Std. Error         df t value Pr(>|t|)    
## (Intercept)           2.679e+02  3.403e+00  9.795e+03  78.724  < 2e-16 ***
## targetref            -1.074e+02  1.318e+00  6.558e+05 -81.533  < 2e-16 ***
## qb                    4.310e+01  4.961e+00  2.239e+06   8.689  < 2e-16 ***
## qc                    6.066e+01  8.682e-01  2.241e+06  69.872  < 2e-16 ***
## qd                    4.504e+01  9.086e-01  2.241e+06  49.565  < 2e-16 ***
## qe                    6.712e+01  9.939e-01  2.241e+06  67.530  < 2e-16 ***
## qf                    4.862e+01  1.230e+00  2.240e+06  39.545  < 2e-16 ***
## detTRUE               3.356e+00  4.218e-01  2.246e+06   7.956 1.78e-15 ***
## targetref:qb          1.171e+01  6.176e+00  2.240e+06   1.896 0.057951 .  
## targetref:qc         -3.269e+00  2.146e+00  2.240e+06  -1.523 0.127709    
## targetref:qd          2.637e+01  2.170e+00  2.240e+06  12.156  < 2e-16 ***
## targetref:qe          1.309e+01  3.678e+00  2.240e+06   3.559 0.000373 ***
## targetref:qf         -8.009e+00  4.575e+00  2.239e+06  -1.751 0.080001 .  
## targetref:detTRUE    -2.159e+00  6.220e-01  2.245e+06  -3.471 0.000519 ***
## qb:detTRUE           -5.260e+00  5.287e+00  2.239e+06  -0.995 0.319768    
## targetref:qb:detTRUE  6.279e+00  7.738e+00  2.240e+06   0.811 0.417115    
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## fit warnings:
## fixed-effect model matrix is rank deficient so dropping 8 columns / coefficients
```

## plots
<div class="figure">
<p class="caption">(\#fig:boxplot1)compare distances by corpus, normalised to obs, distance ceiling =  outliers removed</p><img src="poster-ext_files/figure-html/boxplot1-1.png" alt="compare distances by corpus, normalised to obs, distance ceiling =  outliers removed"  /></div>

<div class="figure">
<p class="caption">(\#fig:barplot-median)mean distances over query/corpus, normalised to obs, distance ceiling =  outliers removed</p><img src="poster-ext_files/figure-html/barplot-median-1.png" alt="mean distances over query/corpus, normalised to obs, distance ceiling =  outliers removed"  /></div>



|target |q  |       n| mean| median|
|:------|:--|-------:|----:|------:|
|obs    |a  |  542364|  157|     73|
|ref    |a  | 1612261|   45|     18|
|obs    |b  |    5544|  196|    109|
|ref    |b  |    2407|   94|     70|
|obs    |c  |   25581|  219|    125|
|ref    |c  |    4550|   90|     54|
|obs    |d  |   23817|  228|    132|
|ref    |d  |    4514|  115|     63|
|obs    |e  |   18071|  237|    131|
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


