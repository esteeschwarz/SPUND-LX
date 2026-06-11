# p-value
Chi-Square Test:

The chi-square test is used to determine whether there is a significant association between categorical variables.
It compares the observed frequencies in a contingency table (cross-tabulation) with the expected frequencies under the null hypothesis.
The null hypothesis states that there is no association between the variables.
P-Value:

The p-value represents the probability of observing a test statistic (such as the chi-square statistic) as extreme as the one obtained, assuming the null hypothesis is true.
In other words, it tells us how likely it is to get the observed results purely by chance.
Smaller p-values indicate stronger evidence against the null hypothesis.

|     |  0|   1|
|:----|--:|---:|
|give | 31| 236|
|make | 42| 374|
|take | 47| 391|

# chisq.test() output object
```r 
xt6 \<-
structure(list(statistic = c(`X-squared` = 0.39064505113720882), 
parameter = c(df = 2L), p.value = 0.82256931563221969, method = "Pearson's Chi-squared test", 
data.name = "t6", observed = structure(c(31L, 42L, 47L, 236L, 
374L, 391L), dim = 3:2, dimnames = structure(list(c("give", 
"make", "take"), c("0", "1")), names = c("", "")), class = "table"), 
expected = structure(c(28.581623550401428, 44.531668153434431, 
46.886708296164137, 238.41837644959858, 371.46833184656555, 
391.11329170383584), dim = 3:2, dimnames = structure(list(
c("give", "make", "take"), c("0", "1")), names = c("", 
""))), residuals = structure(c(0.45235610671276288, -0.37937813434494172, 
0.016545246289906376, -0.1566224603259733, 0.13135477981446289, 
-0.0057285778663518283), dim = 3:2, class = "table", dimnames = structure(list(
c("give", "make", "take"), c("0", "1")), names = c("", 
""))), stdres = structure(c(0.54845385836836913, -0.50625148697591205, 
0.022431145808000777, -0.54845385836837157, 0.50625148697591638, 
-0.022431145807996558), dim = 3:2, class = "table", dimnames = structure(list(
c("give", "make", "take"), c("0", "1")), names = c("", 
"")))), class = "htest")
```