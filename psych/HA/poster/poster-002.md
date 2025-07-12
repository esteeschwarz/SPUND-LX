# xTitle

# proposition & coherence in :schizophrenia: threads

### stephan schwarz / a. stefanowitsch:16827_25S:sprache und psychose

## subject

Investigate reference marking, coherence and information structure in schizophrenia language by measuring distance of similar nouns within range of comment thread preceded by certain determinants.[^1]

## background

Inspired by Zimmerer et al. ([2017](#ref-zimmerer_deictic_2017)) we are interested in observations concerning coherence and propositional conditions in schizophrenia language, as these linguistic markers appear underinvestigated in research while they seem to play a crucial role within target group language. (As such seen as asset of thinking or world building capacity which might suffer from linguistic deficits within the range of positive symptoms.)

## method (M2)

To compute distances we queried a corpus for matching conditions where certain (assumed) determiners appear before similar nouns. In M2 no restrictions concerning the matching antecedents to be tagged “DET” were accounted for.  
This distance should give us information structural evidence of how strong these noun occurences are connected, i.e. if a noun appears out of the blue mostly or if it somewhere before has been introduced to the audience. In information structure definitions this would be termed with **given and new information** ([Prince 1981](#ref-prince_toward_1981)).

------------------------------------------------------------------------

## questions

Measuring the referent-reference distance which we here assume as indicator of coherence we hope to find empirical evidence for disturbed or not world building capabilities within schizophrenia language. Premising that a large noun distance indicates a low reference-referent association we hypothesise that in a language/ToM setting where the speakers estimation of the audiences context understanding capacities is disturbed we will find higer medium scores for the distance under matching conditions.

## daten

We built a corpus of the reddit r/schizophrenia thread (`n=` tokens) and a reference corpus of r/unpopularopinion (`n=`). Both were pos-tagged using the R udpipe:: package ([Wijffels 2023](#ref-wijffels_udpipe_2023)) which tags according to the universal dependencies tagset maintained by De Marneffe et al. ([2021](#ref-de_marneffe_universal_2021)). Still the tokens can only, within the workflow of growing the corpus and devising the noun distances developed be just a starting point from where with more datapoints statistical evaluation becomes relevant first.  
The dataframe used for modeling consists of `17794` distance datapoints (sample below) derived from the postagged corpus.

|       | dist | q   | target | url | lemma   | range |    mf_rel |        ld | q_long                |
|:-----|----:|:---|:------|----:|:-------|-----:|--------:|--------:|:-----------------|
| 13763 |   89 | d   | ref    |  52 | people  |  3469 | 0.0089363 | 0.2729893 | a,an,some,any         |
| 11071 |  157 | d   | obs    |  52 | life    |  2256 | 0.0031028 | 0.2872340 | a,an,some,any         |
| 10443 |  137 | c   | ref    |  36 | pyramid |  8785 | 0.0085373 | 0.1694935 | the                   |
| 7693  |   21 | b   | ref    |  54 | game    |  1163 | 0.0283749 | 0.4118659 | this,that,these,those |
| 16970 |    5 | f   | ref    |  19 | drink   |  5000 | 0.0130000 | 0.2480000 | your,their,his,her    |
| 7755  |   58 | b   | ref    |  73 | college |  6064 | 0.0031332 | 0.2214710 | this,that,these,those |
| 7869  |   50 | b   | ref    |  83 | check   |  2817 | 0.0273340 | 0.3028044 | this,that,these,those |
| 4862  |  278 | a   | ref    |  50 | speed   |  4210 | 0.0149644 | 0.2498812 | #intercept            |
| 10280 |   12 | c   | ref    |  28 | car     |  3264 | 0.0067402 | 0.2490809 | the                   |
| 16010 |    6 | e   | ref    |  28 | space   |  3264 | 0.0058211 | 0.2490809 | my                    |

------------------------------------------------------------------------

## results

![](https://github.com/esteeschwarz/SPUND-LX/raw/main/psych/HA/poster/plots/distance-distribution-df2-viz1-1.png)

    ## ## conditions:

| q   | precedent | pos  |
|:----|:----------|:-----|
| a   | ALL (.\*) | NOUN |
| b   | b         | NOUN |
| c   | c         | NOUN |
| d   | d         | NOUN |
| e   | e         | NOUN |
| f   | f         | NOUN |

![](https://github.com/esteeschwarz/SPUND-LX/raw/main/psych/HA/poster/plots/lmer-plot-df2-lmeplot-1.png)

------------------------------------------------------------------------

## conclusion

Over all conditions <!--**B** (``` this, that, these, those, DET ```)-->we find significantly higher distance scores in the target corpus which proves our hypothesis. An ANOVA analysis of the linear regression model (cf. [Bates et al. 2015](#ref-bates_fitting_2015)) which posited a main effect of corpus\*q+range and random effects of lemma (`lme4::lmer(dist~target*q+range+(1|lemma),df)`) gets a p-value of `p=0.0553629` for the mean difference of `12` tokens (targetref) compared to the target.  
So the medium distance of nouns, preceded by one of our queries, is with `47` tokens width for the target corpus vs. `46` in the reference corpus also with respect to the covariables significantly (`p<0.1`) higher but still to be tested with growing the corpus.

## B. REF

Bates, Douglas, Martin Mächler, Ben Bolker, and Steve Walker. 2015. “Fitting Linear Mixed-Effects Models Using Lme4.” *Journal of Statistical Software* 67 (1): 1–48. <https://doi.org/10.18637/jss.v067.i01>.

De Marneffe, Marie-Catherine, Christopher D. Manning, Joakim Nivre, and Daniel Zeman. 2021. “Universal Dependencies.” *Computational Linguistics*, May, 1–54. <https://doi.org/10.1162/coli_a_00402>.

Prince, Ellen F. 1981. “Toward a Taxonomy of Given-New Information.” In *Syntax and Semantics: Vol. 14. Radical Pragmatics*, edited by P. Cole, 223–55. New York: Academic Press.

Wijffels, Jan. 2023. *Udpipe: Tokenization, Parts of Speech Tagging, Lemmatization and Dependency Parsing with the ’UDPipe’ ’NLP’ Toolkit*. <https://CRAN.R-project.org/package=udpipe>.

Zimmerer, Vitor C., Stuart Watson, Douglas Turkington, I. Nicol Ferrier, and Wolfram Hinzen. 2017. “Deictic and Propositional Meaning—New Perspectives on Language in Schizophrenia.” *Frontiers in Psychiatry* 8 (February). <https://doi.org/10.3389/fpsyt.2017.00017>.

[^1]: snc.1:h2.pb.1000char/pg.queries.cites
