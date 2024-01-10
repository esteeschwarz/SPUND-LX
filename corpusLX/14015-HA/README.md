-   [1 term paper draft](#term-paper-draft)
    -   [1.1 init](#init)
    -   [1.2 method](#method)
        -   [1.2.1 script used:](#script-used)
        -   [1.2.2 process:](#process)
-   [2 B: references](#b-references)

# 1 term paper draft

topic #6, polysemous verbs with light and concrete senses, replication
study of [Mehl (2021)](https://doi.org/10.1515/cllt-2017-0039), further
used: [Gilquin
(2008)](https://dial.uclouvain.be/pr/boreal/object/boreal:75833)

## 1.1 init

“If onomasiological frequency measurements do indeed correlate with
elicitation tests, potential impact would be immense. Researchers would
be able to examine onomasiological frequencies in spoken corpora rather
than performing elicitation tests. That possibility would facilitate
cognitive research into languages and varieties around the world,
without the necessity of in situ psycholinguistic testing, and would
also encourage the creation of more spoken corpora.” ([Mehl (2021)
p.23](https://doi.org/10.1515/cllt-2017-0039))

## 1.2 method

following corpus was used to determine frequencies:

Q.1: Santa Barbara corpus of spoken American English, ([UCSB et al.
(2005)](https://www.linguistics.ucsb.edu/research/santa-barbara-corpus))

the corpus data was downloaded from:
<https://www.linguistics.ucsb.edu/sites/secure.lsit.ucsb.edu.ling.d7/files/sitefiles/research/SBC/SBCorpus.zip>

### 1.2.1 script used:

[14015.concrete-abstract_HA.R](14015.concrete-abstract_HA.R)

### 1.2.2 process:

-   distribution analysis, cf. (Mehl 2021, 11–14)

<!-- -->

    ## [1] 321

    ##          ICE.written ICE.spoken SBC.spoken
    ## concrete          68         96        200
    ## light            321        353        321

|          | ICE.written | ICE.spoken | SBC.spoken |
|:---------|------------:|-----------:|-----------:|
| concrete |          68 |         96 |        200 |
| light    |         321 |        353 |        321 |

distribution of lemma /make/ over corpora

<figure>
<img src="README_files/figure-markdown_github/fig-01-dist-1.png"
alt="distribution of lemma /make/ over corpora. ICE data from study." />
<figcaption aria-hidden="true">distribution of lemma /make/ over
corpora. ICE data from study.</figcaption>
</figure>

| Var1      |  Freq |
|:----------|------:|
| a-other   | 69390 |
| build     |   101 |
| construct |     1 |
| create    |    23 |
| generate  |     4 |
| make      |   199 |
| produce   |     5 |

semantic alternatives

<figure>
<img src="README_files/figure-markdown_github/fig-02-alt-1.png"
alt="proportion of semantic alternatives to concrete /make/ in SBC" />
<figcaption aria-hidden="true">proportion of semantic alternatives to
concrete /make/ in SBC</figcaption>
</figure>

------------------------------------------------------------------------

# 2 B: references

Gilquin, Gaëtanelle. 2008. “What You Think Ain’t What You Get: Highly
Polysemous Verbs in Mind and Language.”
<https://dial.uclouvain.be/pr/boreal/object/boreal:75833>.

Mehl, Seth. 2021. “What We Talk about When We Talk about Corpus
Frequency: The Example of Polysemous Verbs with Light and Concrete
Senses.” *Corpus Linguistics and Linguistic Theory* 17 (1): 223–47.
<https://doi.org/10.1515/cllt-2017-0039>.

UCSB, John W. DuBois, L. Chafe Wallace, Charles Meyer, Sandra A.
Thompson, Robert Englebretson, and Nii Martey. 2005. “Santa Barbara
Corpus of Spoken American English Department of Linguistics - UC Santa
Barbara.” *SBC*.
<https://www.linguistics.ucsb.edu/research/santa-barbara-corpus>.
