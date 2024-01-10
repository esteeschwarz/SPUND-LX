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

|       | scb |   id | text                                                                         |   lfd | light | alt     |
|:----|---:|---:|:--------------------------------------------|----:|----:|:-----|
| 4315  |   4 |   37 | 2Just .. makes me feel like I2 ate a candy bar.                              |  4315 |     1 | make    |
| 60039 |  52 |  337 | H makes me mad,                                                              | 60039 |     1 | make    |
| 28160 |  23 | 1203 | %= They 7talked7 about what makes 8a8 classic.                               | 28160 |     1 | make    |
| 13671 |  12 |  449 | .. You made a statement.                                                     | 13671 |     0 | make    |
| 12049 |  10 |  930 | needs to be more involved than just making decisions on what we publish.     | 12049 |     1 | make    |
| 21401 |  17 |  187 | and building on top of those.                                                | 21401 |     0 | build   |
| 56378 |  49 |  589 | 2house that Joe built2 .                                                     | 56378 |     0 | build   |
| 44298 |  38 |   18 | H In order to build a dam here,                                              | 44298 |     0 | build   |
| 39945 |  34 |  534 | with .. built-in tables,                                                     | 39945 |     0 | build   |
| 16949 |  14 |  425 | 2Separate2 building.                                                         | 16949 |     0 | build   |
| 25020 |  20 |  805 | .. and his heart rejoiced.                                                   | 25020 |     0 | a-other |
| 74    |   1 |   73 | you know,                                                                    |    74 |     0 | a-other |
| 46922 |  41 |   37 | .. You probably \<@ aren’t burning much more @\> than like eighteen hundred, | 46922 |     0 | a-other |
| 24790 |  20 |  575 | H whether it’s the left .. part or,                                          | 24790 |     0 | a-other |
| 14368 |  13 |  103 | Hx                                                                           | 14368 |     0 | a-other |
| 4171  |   3 | 1439 | Yeah.                                                                        |  4171 |     0 | a-other |
| 2583  |   2 | 1270 | .. <X If X> I was going out dancing?                                         |  2583 |     0 | a-other |
| 16209 |  13 | 1944 | 6@(**6?**) 7\<@ Goo=d7 .                                                     | 16209 |     0 | a-other |
| 51842 |  45 |  321 | H uh,                                                                        | 51842 |     0 | a-other |
| 31323 |  27 |  345 | .. Having a good time together.                                              | 31323 |     0 | a-other |

### 1.2.2 script used:

[14015.concrete-abstract_HA.R](14015.concrete-abstract_HA.R)

### 1.2.3 process:

-   distribution analysis, cf. (Mehl 2021, 11–14)

<!-- -->

    ## [1] 323

    ##          ICE.written ICE.spoken SBC.spoken
    ## concrete          68         96        148
    ## light            321        353        323

|          | ICE.written | ICE.spoken | SBC.spoken |
|:---------|------------:|-----------:|-----------:|
| concrete |          68 |         96 |        148 |
| light    |         321 |        353 |        323 |

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
