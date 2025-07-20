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
eval output M8

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
##                 Df     Sum Sq   Mean Sq  F value    Pr(>F)    
## target           1  134571933 134571933 965.0767 < 2.2e-16 ***
## q                5   50410956  10082191  72.3040 < 2.2e-16 ***
## det              1     775655    775655   5.5626   0.01835 *  
## target:q         5    4951167    990233   7.1014 1.197e-06 ***
## target:det       1     369351    369351   2.6488   0.10363    
## q:det            2     156766     78383   0.5621   0.57000    
## target:q:det     1     173939    173939   1.2474   0.26405    
## Residuals    59808 8339728732    139442                       
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
```

### anova of linear regression model: [`anova(summary(lmer))`]


```
## Type III Analysis of Variance Table with Satterthwaite's method
##                Sum Sq Mean Sq NumDF DenDF F value    Pr(>F)    
## target         713851  713851     1 58029  5.4780   0.01926 *  
## q            14670061 2934012     5 57673 22.5153 < 2.2e-16 ***
## det              8118    8118     1 57697  0.0623   0.80290    
## target:q      6942650 1388530     5 57673 10.6554 2.983e-10 ***
## target:det      47466   47466     1 57040  0.3642   0.54616    
## q:det          312526  156263     2 57366  1.1991   0.30146    
## target:q:det    36385   36385     1 57027  0.2792   0.59722    
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
```

### linear regression coefficients, formula: [``` dist_rel_obs ~ target*q*det+(1|lemma) ```]

```
##                        Estimate Std. Error        df      t value     Pr(>|t|)
## (Intercept)          346.965858   4.360175  2327.528  79.57613649 0.000000e+00
## targetref            -66.743997   4.300651 35395.338 -15.51951149 3.862251e-54
## qb                   226.255322  69.678442 56608.487   3.24713522 1.166408e-03
## qc                   101.492911  10.580420 59089.326   9.59252213 8.915839e-22
## qd                   -20.431795 367.777039 57721.144  -0.05555484 9.556966e-01
## qe                    79.652779  11.413635 59023.726   6.97873892 3.009701e-12
## qf                    52.971173  16.530957 59038.137   3.20436212 1.354340e-03
## detTRUE               -3.070543   4.788899 59797.616  -0.64117945 5.214086e-01
## targetref:qb          44.944230  90.817521 57003.818   0.49488502 6.206832e-01
## targetref:qc         278.234999  55.866005 57843.382   4.98039909 6.363562e-07
## targetref:qd         268.808789  45.473394 58002.878   5.91134213 3.412228e-09
## targetref:qe         196.635538  75.338078 58162.680   2.61004187 9.055434e-03
## targetref:qf         232.916808 149.492104 57622.939   1.55805424 1.192259e-01
## targetref:detTRUE     -6.592305  12.391475 59520.634  -0.53200324 5.947257e-01
## qb:detTRUE           -87.726489  72.444560 56694.413  -1.21094655 2.259209e-01
## qd:detTRUE           108.264281 367.629493 57719.427   0.29449291 7.683823e-01
## targetref:qb:detTRUE -92.570710 175.189092 57026.531  -0.52840453 5.972207e-01
```
## plots
<div class="figure">
<p class="caption">(\#fig:boxplot1)compare raw distances by corpus</p><img src="poster-ext_files/figure-html/boxplot1-1.png" alt="compare raw distances by corpus"  /></div>

<div class="figure">
<p class="caption">(\#fig:barplot-median)median distances over query/corpus</p><img src="poster-ext_files/figure-html/barplot-median-1.png" alt="median distances over query/corpus"  /></div>

<div class="figure">
<p class="caption">(\#fig:barplot-mean)mean distances over query/corpus</p><img src="poster-ext_files/figure-html/barplot-mean-1.png" alt="mean distances over query/corpus"  /></div>

<div class="figure">
<p class="caption">(\#fig:lmeplot)distances relation</p><img src="poster-ext_files/figure-html/lmeplot-1.png" alt="distances relation"  /></div>

<div class="figure">
<p class="caption">(\#fig:gplot)distances normalised</p><img src="poster-ext_files/figure-html/gplot-1.png" alt="distances normalised"  /></div>
-----

# REF
literature used and alii...   


