# xTitle
# proposition & coherence in :schizophrenia: threads
### stephan schwarz / a. stefanowitsch:16827_25S:sprache und psychose
## subject
Investigate reference marking, coherence and information structure in schizophrenia language by measuring distance of similar nouns within range of comment thread preceded by certain determinants.[^1]
## background
Inspired by Zimmerer et alii (#REF) we are interested in observations concerning coherence and propositional conditions in schizophrenia language, as these linguistic markers appear underinvestigated in research while they seem to play a crucial role within target group language. (As such seen as asset of thinking or world building capacity which might suffer from linguistic deficits within the range of positive symptoms.)
## method
To compute distances we queried a corpus for matching conditions where certain (assumed) determiners appear before similar nouns. This distance should give us information structural evidence of how strong these noun occurences are connected, i.e. if a noun appears out of the blue mostly or if it somewhere before has been introduced to the audience. In information structure definitions this would be termed with **given and new information** Prince (1981#REF).
----
## questions
Measuring the referent-reference distance which we here assume as indicator of coherence we hope to find empirical evidence for disturbed or not world building capabilities within schizophrenia language. Premising that a large noun distance indicates a low reference-referent association we hypothesise that in a language/TOM setting where the speakers estimation of the audiences context understanding capacities is disturbed we will find higer medium scores for the distance under matching conditions.
## daten
We built a corpus of the reddit r/schizophrenia thread (```n=747089 ``` tokens) and a reference corpus of r/unpopularopinion (```n=265670 ```). The corpus has been pos-tagged using the R udpipe:: package #REF which tags according to the universal dependencies tagset maintained by #REF. Still the 747089 tokens can only, with the workflow of growing the corpus and devising the noun distances developed be just a starting point from where with more datapoints statistical evaluation becomes relevant first.   
The dataframe used for modeling consists of ``` 17794 ``` distance datapoints derived from the postagged corpus.


```
##       dist q target url         lemma range mf_rel     ld
## 107     31 a    obs   3      Disorder   566 0.0035 0.4311
## 7010   445 b    ref  18        people  2941 0.0071 0.3230
## 11715   36 d    obs 464      director  1104 0.0063 0.3958
## 14860   21 e    obs 498       country  5112 0.0100 0.2344
## 1617    23 a    obs 532      disorder  2149 0.0088 0.2694
## 12153   64 d    obs 650            mg  1975 0.0197 0.3058
## 16886   14 f    ref  11        dialog  3469 0.0026 0.2730
## 3128    15 a    obs 829         voice  1795 0.0117 0.3142
## 1530    16 a    obs 514         voice   300 0.0400 0.4900
## 4933    92 a    ref  53          game  8169 0.0191 0.1893
## 17208    3 f    ref  34            ad  1519 0.0237 0.3726
## 15081  125 e    obs 611 antipsychotic  1815 0.0066 0.3548
## 10021  680 c    ref   1          case  1846 0.0011 0.3380
## 16305   70 f    obs 140          life   447 0.0112 0.4765
## 3010    34 a    obs 805            iq  5703 0.0126 0.2465
```
----
## results




![](https://github.com/esteeschwarz/SPUND-LX/raw/main/psych/HA/poster/index_files/figure-html/df1-vis-1.png)

```
## ## conditions:
```



|q  |precedent             |pos  |
|:--|:---------------------|:----|
|a  |ALL (.*)              |NOUN |
|b  |this,that,these,those |NOUN |
|c  |the                   |NOUN |
|d  |a,an,some,any         |NOUN |
|e  |my                    |NOUN |
|f  |your,their,his,her    |NOUN |



----
## conclusion
In condition **B** (``` this, that, these, those ```) which we hold for the most speaking determinants illustrating the speakers idea, that the information about a reference is already **given** we find significantly higher distance scores in the target corpus which proves our hypothesis. An ANOVA analysis of the linear regression model which posited a main effect of corpus\*q and random effects of url range width, match frequency of the query and type/token-ratio within the range (`lme4::lmer(dist ~ corp*q +(1|range) + (1|mf_rel) + (1|ld))`) gets a p-value of p=0.02277 for targetcorp:q.   
So even if the median distance of nouns, preceded by one of our queries, is just ``` 47 ``` tokens wide for the target corpus and ``` 46 ``` in the reference corpus, it's still with respect to the covariates significantly (p<0.05) higher and yet to be tested on a larger corpus.
## B. REF:
[^1]:snc.1:h2.pb.1000char/pg.queries
