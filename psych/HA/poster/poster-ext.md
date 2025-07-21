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






```r
#dataset<-7
```



# top
eval output M8, normalised to obs, distance ceiling =  outliers removed.

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
##                 Df     Sum Sq   Mean Sq   F value  Pr(>F)    
## target           1  188198255 188198255 2623.7365 < 2e-16 ***
## q                5   12386302   2477260   34.5363 < 2e-16 ***
## det              1     331841    331841    4.6263 0.03149 *  
## target:q         5     238670     47734    0.6655 0.64965    
## target:det       1      76742     76742    1.0699 0.30098    
## q:det            1       7767      7767    0.1083 0.74210    
## target:q:det     1         49        49    0.0007 0.97912    
## Residuals    53589 3843890727     71729                      
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
```

### anova of linear regression model: [`anova(summary(lmer))`]


```
## Type III Analysis of Variance Table with Satterthwaite's method
##               Sum Sq Mean Sq NumDF DenDF F value    Pr(>F)    
## target        942002  942002     1 53142 13.7725 0.0002065 ***
## q            1715931  343186     5 52610  5.0175 0.0001343 ***
## det             1744    1744     1 52047  0.0255 0.8731412    
## target:q      274352   54870     5 52617  0.8022 0.5478174    
## target:det      8778    8778     1 52044  0.1283 0.7201598    
## q:det            434     434     1 52029  0.0063 0.9365173    
## target:q:det    8861    8861     1 52029  0.1296 0.7188976    
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
```

### linear regression coefficients, formula: [``` dist_rel_obs ~ target*q*det+(1|lemma) ```]

```
## Linear mixed model fit by REML. t-tests use Satterthwaite's method [
## lmerModLmerTest]
## Formula: eval(expr(lmeform))
##    Data: dfa
## 
## REML criterion at convergence: 750046.5
## 
## Scaled residuals: 
##     Min      1Q  Median      3Q     Max 
## -1.6964 -0.6103 -0.2730  0.2116  6.2846 
## 
## Random effects:
##    Groups        Name Variance Std.Dev.
##     lemma (Intercept)     4886     69.9
##  Residual                68397    261.5
## Number of obs: 53605, groups:  lemma, 3140
## 
## Fixed effects:
##                        Estimate Std. Error         df t value Pr(>|t|)    
## (Intercept)            243.7965     2.9796  2119.2426  81.823  < 2e-16 ***
## targetref             -107.4277     3.2635 22754.8007 -32.918  < 2e-16 ***
## qb                     112.6641    58.6455 51418.0759   1.921   0.0547 .  
## qc                      51.6152     8.2179 53428.9384   6.281 3.39e-10 ***
## qd                      50.8464     8.0236 53556.5368   6.337 2.36e-10 ***
## qe                      44.5199     8.8245 53549.6599   5.045 4.55e-07 ***
## qf                      28.3428    12.6225 53477.5464   2.245   0.0247 *  
## detTRUE                 -2.8252     3.6081 53094.1405  -0.783   0.4336    
## targetref:qb           -87.2954    81.2112 52049.3097  -1.075   0.2824    
## targetref:qc            29.9092    55.1123 52625.6411   0.543   0.5873    
## targetref:qd            30.7563    42.7856 52604.2796   0.719   0.4722    
## targetref:qe            91.8214    66.5296 52591.0522   1.380   0.1675    
## targetref:qf          -115.0325   153.2120 53277.1126  -0.751   0.4528    
## targetref:detTRUE       -0.1167     9.5973 53507.1658  -0.012   0.9903    
## qb:detTRUE             -31.6643    60.7276 51491.0100  -0.521   0.6021    
## targetref:qb:detTRUE    51.8534   144.0633 52029.2131   0.360   0.7189    
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



|target |q  |     n| mean| median|
|:------|:--|-----:|----:|------:|
|obs    |a  | 31824|  241|    122|
|ref    |a  | 17295|  120|     50|
|obs    |b  |   313|  325|    174|
|ref    |b  |    27|  127|    110|
|obs    |c  |  1226|  291|    156|
|ref    |c  |    24|  168|     99|
|obs    |d  |  1369|  307|    209|
|ref    |d  |    41|  180|    173|
|obs    |e  |  1005|  287|    154|
|ref    |e  |    16|  238|    145|
|obs    |f  |   462|  258|    146|
|ref    |f  |     3|   46|     62|


<div class="figure">
<p class="caption">(\#fig:barplot-mean)median distances over query/corpus, normalised to obs, distance ceiling =  outliers removed</p><img src="poster-ext_files/figure-html/barplot-mean-1.png" alt="median distances over query/corpus, normalised to obs, distance ceiling =  outliers removed"  /></div>

<div class="figure">
<p class="caption">(\#fig:lmeplot)distances relation, normalised to obs, distance ceiling =  outliers removed</p><img src="poster-ext_files/figure-html/lmeplot-1.png" alt="distances relation, normalised to obs, distance ceiling =  outliers removed"  /></div>

<div class="figure">
<p class="caption">(\#fig:gplot)distances normalised vs. raw</p><img src="poster-ext_files/figure-html/gplot-1.png" alt="distances normalised vs. raw"  /></div>
-----

# REF
literature used and alii...   


