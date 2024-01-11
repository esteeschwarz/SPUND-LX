-   [1 term paper draft](#term-paper-draft)
    -   [1.1 init](#init)
    -   [1.2 method](#method)
        -   [1.2.1 corpus sample](#corpus-sample)
        -   [1.2.2 script used:](#script-used)
        -   [1.2.3 process:](#process)
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

### 1.2.1 corpus sample

|       | scb |   id | text                                      |   lfd | light | alt     |
|:-----|----:|-----:|:------------------------------------|-----:|-----:|:-------|
| 30651 |  26 |  577 | … making the application,                 | 30651 |    NA | make    |
| 68095 |  59 |  881 | 3And a3 lot of homemade cookies.          | 68095 |     0 | make    |
| 8072  |   6 | 1671 | Or makes whoever it is stop and think,    |  8072 |     1 | make    |
| 68129 |  59 |  915 | 5A=nd homemade fu5 dge.                   | 68129 |     0 | make    |
| 13300 |  12 |   78 | … I=f I make the statement which I di=d,  | 13300 |     1 | make    |
| 58447 |  51 |  426 | … I don’t like the new buildings.         | 58447 |     0 | build   |
| 18118 |  15 |  406 | it’s built during the –                   | 18118 |     0 | build   |
| 63702 |  56 |   82 | I build barns and,                        | 63702 |     0 | build   |
| 13466 |  12 |  244 | .. there’s a lot of coalition building.   | 13466 |     0 | build   |
| 34651 |  30 |  185 | H And they built … Python,                | 34651 |     0 | build   |
| 60524 |  52 |  822 | … TSK So,                                 | 60524 |    NA | a-other |
| 49065 |  43 |  472 | .. So he says,                            | 49065 |    NA | a-other |
| 4483  |   4 |  205 | 2are2 ,                                   |  4483 |    NA | a-other |
| 29267 |  24 |  792 | … Okay Hx .                               | 29267 |    NA | a-other |
| 61983 |  53 |  674 | … We have to really hone in on-,          | 61983 |    NA | a-other |
| 5840  |   5 |  265 | H … And she’s got,                        |  5840 |    NA | a-other |
| 28717 |  24 |  242 | Look at that.                             | 28717 |    NA | a-other |
| 40429 |  35 |  279 | 2 THROAT 2 =                              | 40429 |    NA | a-other |
| 768   |   1 |  767 | .. it sure does make a mess in the house. |   768 |     1 | make    |
| 32025 |  28 |  308 | 2@(**2?**) @                              | 32025 |    NA | a-other |

### 1.2.2 script used:

[14015.concrete-abstract_HA.R](14015.concrete-abstract_HA.R)

### 1.2.3 process:

#### 1.2.3.1 distribution analysis

cf. (Mehl 2021, 11–14)

|          | ICE.written | ICE.spoken | SBC.spoken |
|:---------|------------:|-----------:|-----------:|
| concrete |          68 |         96 |         89 |
| light    |         321 |        353 |        381 |

distribution of lemma /make/ over corpora

<figure>
<img src="README_files/figure-markdown_github/fig-01-dist-1.png"
alt="distribution of lemma /make/ over corpora. ICE data from study." />
<figcaption aria-hidden="true">distribution of lemma /make/ over
corpora. ICE data from study.</figcaption>
</figure>

#### 1.2.3.2 semantic alternatives to make

| Var1      | Freq |
|:----------|-----:|
| build     |  101 |
| construct |    1 |
| create    |   23 |
| generate  |    4 |
| make      |   89 |
| produce   |    5 |

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
