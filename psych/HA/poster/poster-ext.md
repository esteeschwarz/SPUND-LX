---
title: "xtitle: coherence & presuppositions observations in :schizophrenia: threads"
author: "st. schwarz"
date: "2025-07-20"
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
eval output M8, normalised to all.

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
### anova plain, formula: [``` dist_rel_all ~ target*q*det ```]

```
##                 Df     Sum Sq   Mean Sq  F value    Pr(>F)    
## target           1 2.2692e+08 226922100 965.0767 < 2.2e-16 ***
## q                5 8.5006e+07  17001108  72.3040 < 2.2e-16 ***
## det              1 1.3080e+06   1307950   5.5626   0.01835 *  
## target:q         5 8.3489e+06   1669783   7.1014 1.197e-06 ***
## target:det       1 6.2282e+05    622818   2.6488   0.10363    
## q:det            2 2.6435e+05    132173   0.5621   0.57000    
## target:q:det     1 2.9330e+05    293305   1.2474   0.26405    
## Residuals    59808 1.4063e+10    235134                       
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
```

### anova of linear regression model: [`anova(summary(lmer))`]


```
## Type III Analysis of Variance Table with Satterthwaite's method
##                Sum Sq Mean Sq NumDF DenDF F value    Pr(>F)    
## target        1203733 1203733     1 58029  5.4780   0.01926 *  
## q            24737410 4947482     5 57673 22.5153 < 2.2e-16 ***
## det             13689   13689     1 57697  0.0623   0.80290    
## target:q     11707053 2341411     5 57673 10.6554 2.983e-10 ***
## target:det      80039   80039     1 57040  0.3642   0.54616    
## q:det          526997  263498     2 57366  1.1991   0.30146    
## target:q:det    61354   61354     1 57027  0.2792   0.59722    
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
```

### linear regression coefficients, formula: [``` dist_rel_all ~ target*q*det+(1|lemma) ```]

```
##                         Estimate Std. Error        df      t value     Pr(>|t|)
## (Intercept)           450.555082   5.661937  2327.528  79.57613668 0.000000e+00
## targetref             -86.670911   5.584642 35395.338 -15.51951151 3.862249e-54
## qb                    293.805522  90.481456 56608.487   3.24713522 1.166408e-03
## qc                    131.794371  13.739282 59089.326   9.59252213 8.915839e-22
## qd                    -26.531859 477.579596 57721.140  -0.05555484 9.556966e-01
## qe                    103.433706  14.821260 59023.726   6.97873892 3.009701e-12
## qf                     68.786108  21.466397 59038.137   3.20436211 1.354340e-03
## detTRUE                -3.987277   6.218660 59797.616  -0.64117945 5.214086e-01
## targetref:qb           58.362663 117.931764 57003.818   0.49488502 6.206832e-01
## targetref:qc          361.304116  72.545214 57843.382   4.98039908 6.363563e-07
## targetref:qd          349.063642  59.049812 58002.878   5.91134213 3.412228e-09
## targetref:qe          255.342533  97.830819 58162.680   2.61004187 9.055434e-03
## targetref:qf          302.455844 194.124078 57622.939   1.55805424 1.192259e-01
## targetref:detTRUE      -8.560486  16.091041 59520.634  -0.53200324 5.947257e-01
## qb:detTRUE           -113.917882  94.073419 56694.413  -1.21094654 2.259209e-01
## qd:detTRUE            140.587383 477.387999 57719.423   0.29449291 7.683823e-01
## targetref:qb:detTRUE -120.208380 227.493092 57026.531  -0.52840453 5.972207e-01
```
## plots
<div class="figure">
<p class="caption">(\#fig:boxplot1)compare distances by corpus, normalised to all</p><img src="poster-ext_files/figure-html/boxplot1-1.png" alt="compare distances by corpus, normalised to all"  /></div>

<div class="figure">
<p class="caption">(\#fig:barplot-median)median distances over query/corpus, normalised to all</p><img src="poster-ext_files/figure-html/barplot-median-1.png" alt="median distances over query/corpus, normalised to all"  /></div>

<div class="figure">
<p class="caption">(\#fig:barplot-mean)mean distances over query/corpus, normalised to all</p><img src="poster-ext_files/figure-html/barplot-mean-1.png" alt="mean distances over query/corpus, normalised to all"  /></div>

<div class="figure">
<p class="caption">(\#fig:lmeplot)distances relation, normalised to all</p><img src="poster-ext_files/figure-html/lmeplot-1.png" alt="distances relation, normalised to all"  /></div>

<div class="figure">
<p class="caption">(\#fig:gplot)distances normalised vs. raw</p><img src="poster-ext_files/figure-html/gplot-1.png" alt="distances normalised vs. raw"  /></div>
-----

# REF
literature used and alii...   


