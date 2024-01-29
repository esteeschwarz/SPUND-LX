-   [1 term paper draft](#term-paper-draft){#toc-term-paper-draft}
    -   [1.1 init](#init){#toc-init}
    -   [1.2 method](#method){#toc-method}
        -   [1.2.1 corpus sample](#corpus-sample){#toc-corpus-sample}
        -   [1.2.2 script used:](#script-used){#toc-script-used}
        -   [1.2.3 process:](#process){#toc-process}
-   [2 B: references](#b-references){#toc-b-references}

# 1 term paper draft {#term-paper-draft}

topic \#6, polysemous verbs with light and concrete senses, replication study of [Mehl (2021)](https://doi.org/10.1515/cllt-2017-0039), further used [Gilquin (2008)](https://dial.uclouvain.be/pr/boreal/object/boreal:75833)

meta.snc.rmd&gt;md&gt;wp&gt;pkg&gt;toc

## 1.1 init {#init}

“If onomasiological frequency measurements do indeed correlate with elicitation tests, potential impact would be immense. Researchers would be able to examine onomasiological frequencies in spoken corpora rather than performing elicitation tests. That possibility would facilitate cognitive research into languages and varieties around the world, without the necessity of in situ psycholinguistic testing, and would also encourage the creation of more spoken corpora.” ([Mehl (2021) p.23](https://doi.org/10.1515/cllt-2017-0039))

## 1.2 method {#method}

following corpus was used to determine frequencies:

Q.1: Santa Barbara corpus of spoken American English, ([UCSB et al. (2005)](https://www.linguistics.ucsb.edu/research/santa-barbara-corpus))

the corpus data was downloaded from: <https://www.linguistics.ucsb.edu/sites/secure.lsit.ucsb.edu.ling.d7/files/sitefiles/research/SBC/SBCorpus.zip>

### 1.2.1 corpus sample {#corpus-sample}

|       | scb |  id | text                                              |   lfd | light | alt     |
|:-----|----:|----:|:---------------------------------------|-----:|-----:|:-------|
| 2974  |   3 | 242 | % I wanted it to be home made Q .                 |  2974 |     0 | make    |
| 65343 |  57 | 123 | … It’s gonna get messed up.                       | 65343 |    NA | a-other |
| 9465  |   8 | 567 | and then I didn’t and I .. kept making like,      |  9465 |     1 | make    |
| 67928 |  59 | 714 | And he’s really good at making out .. the budget. | 67928 |     1 | make    |
| 35078 |  30 | 612 | … God is continually .. building character.       | 35078 |     0 | build   |
| 61913 |  53 | 604 | and make the payroll,                             | 61913 |     1 | make    |
| 28500 |  24 |  25 | .. Yeah.                                          | 28500 |    NA | a-other |

### 1.2.2 script used: {#script-used}

[14015.concrete-abstract_HA.R](https://github.com/esteeschwarz/SPUND-LX/blob/main/corpusLX/14015-HA/14015.concrete-abstract_HA.R)

### 1.2.3 process: {#process}

#### 1.2.3.1 distribution analysis {#distribution-analysis}

cf. (Mehl 2021, 11–14)

|          | ICE.written | ICE.spoken | SBC.spoken |
|:---------|------------:|-----------:|-----------:|
| concrete |          68 |         96 |         89 |
| light    |         321 |        353 |        381 |

<figure>
<img src="README_files/figure-markdown_phpextra/fig-01-dist-1.png" alt="distribution of lemma /make/ over corpora. ICE data from study." />
<figcaption aria-hidden="true">distribution of lemma /make/ over corpora. ICE data from study.</figcaption>
</figure>

#### 1.2.3.2 semantic alternatives to make {#semantic-alternatives-to-make}

this contrast includes made up alternatives to /make/ that Mehl defined in his study. we do not account for the context of these alternatives in the corpus texts, i.e. all occurences are counted. Mehl contrasted only these alternate occurences which “are defined as those verbs that occur in the corpus with the same concrete direct objects as make, (take, and give,) and with a roughly equivalent meaning.” Mehl puts these under “onomasiological alternates”. (cf. Mehl (2021) p.13)

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
<img src="README_files/figure-markdown_phpextra/fig-02-alt-1.png" alt="proportion of semantic alternatives to concrete /make/ in SBC" />
<figcaption aria-hidden="true">proportion of semantic alternatives to concrete /make/ in SBC</figcaption>
</figure>

<figure>
<img src="README_files/figure-markdown_phpextra/fig-03-alt-1.png" alt="proportion of semantic alternatives, only equivalent meaning of alternates" />
<figcaption aria-hidden="true">proportion of semantic alternatives, only equivalent meaning of alternates</figcaption>
</figure>

|      | SLOT1     | SLOT2     | fS1 | fS2 | OBS | EXP | ASSOC | COLL.STR.LOGL | SIGNIF     |
|:-----|:---------|:---------|----:|----:|----:|----:|:------|-------------:|:-------|
| 137  | finish    | afghan    |  13 |   2 |   2 |   0 | attr  |      28.51461 | \*\*\*\*\* |
| 654  | Filled    | cookie    |   1 |   6 |   1 |   0 | attr  |      15.81813 | \*\*\*\*   |
| 924  | create    | Adam      |  13 |   1 |   1 |   0 | attr  |      14.17394 | \*\*\*     |
| 928  | create    | rift      |  13 |   1 |   1 |   0 | attr  |      14.17394 | \*\*\*     |
| 930  | record    | Simpsons  |  13 |   1 |   1 |   0 | attr  |      14.17394 | \*\*\*     |
| 1337 | shovel    | food      |   1 |  34 |   1 |   0 | attr  |      12.20185 | \*\*\*     |
| 1338 | Unsweeten | food      |   1 |  34 |   1 |   0 | attr  |      12.20185 | \*\*\*     |
| 1476 | filling   | stuff     |   1 |  46 |   1 |   0 | attr  |      11.58948 | \*\*\*     |
| 1518 | create    | cause     |  13 |   2 |   1 |   0 | attr  |      11.40296 | \*\*\*     |
| 1519 | create    | committee |  13 |   2 |   1 |   0 | attr  |      11.40296 | \*\*\*     |
| 1520 | create    | condition |  13 |   2 |   1 |   0 | attr  |      11.40296 | \*\*\*     |
| 1784 | bake      | bread     |   5 |   7 |   1 |   0 | attr  |      10.48243 | \*\*       |
| 1862 | roll      | tamale    |   8 |   5 |   1 |   0 | attr  |      10.19627 | \*\*       |
| 2626 | record    | trip      |  13 |   8 |   1 |   0 | attr  |       8.15687 | \*\*       |
| 3307 | record    | game      |  13 |  16 |   1 |   0 | attr  |       6.71671 | \*\*       |

<figure>
<img src="README_files/figure-markdown_phpextra/fig-04-sema-1.png" alt="semasiological log.like of near synonymes to make" />
<figcaption aria-hidden="true">semasiological log.like of near synonymes to make</figcaption>
</figure>

#### 1.2.3.3 2nd approach collexeme evaluation {#nd-approach-collexeme-evaluation}

    ##       head_lemma        lemma light OBS   EXP      T
    ## 18          make        money     1  14 0.084  3.719
    ## 30          make     decision     1  10 0.011  3.159
    ## 31          make   difference     1  10 0.020  3.156
    ## 48          make        sense     1   8 0.017  2.822
    ## 83          make        fudge     0   6 0.003  2.448
    ## 115         make         copy  n.a.   6 0.246  2.349
    ## 144         make          fun     1   5 0.015  2.229
    ## 192         make        thing     1   5 0.318  2.094
    ## 224         make       budget     1   4 0.006  1.997
    ## 235         make       report     1   4 0.010  1.995
    ## 237         make        noise     1   4 0.011  1.994
    ## 265         make         kind     1   4 0.065  1.968
    ## 376         make       tamale     0   3 0.002  1.731
    ## 417         make   connection     1   3 0.008  1.728
    ## 427         make    statement     1   3 0.009  1.727
    ## 446         make       choice     1   3 0.014  1.724
    ## 521         make        point     1   3 0.070  1.692
    ## 531         make         life     1   3 0.081  1.685
    ## 536         make       dollar     1   3 0.085  1.683
    ## 540         make        house     1   3 0.088  1.681
    ## 548         make        horse     1   3 0.102  1.673
    ## 675         make      picture  n.a.   3 0.390  1.507
    ## 807         make    horseshoe     0   2 0.001  1.414
    ## 835         make    cartilage     0   2 0.001  1.414
    ## 868         make         atom     0   2 0.001  1.413
    ## 883         make      ceviche     0   2 0.001  1.413
    ## 891         make     progress     1   2 0.002  1.413
    ## 943         make         gold     0   2 0.002  1.413
    ## 944         make       rubber     0   2 0.002  1.413
    ## 947         make      mistake     1   2 0.002  1.413
    ## 991         make  arrangement     1   2 0.003  1.412
    ## 992         make        pasta     0   2 0.003  1.412
    ## 1015        make      comment     1   2 0.004  1.412
    ## 1045        make   friendship     1   2 0.005  1.411
    ## 1046        make         mess     1   2 0.005  1.411
    ## 1059        make        pizza     0   2 0.005  1.411
    ## 1104        make         clue     1   2 0.007  1.409
    ## 1120        make         turn     1   2 0.008  1.409
    ## 1171        make        judge     1   2 0.011  1.407
    ## 1172        make         mile     1   2 0.011  1.407
    ## 1183        make      seventy     1   2 0.011  1.406
    ## 1197        make         trip     1   2 0.013  1.405
    ## 1244        make       living     1   2 0.017  1.403
    ## 1258        make         mind     1   2 0.017  1.402
    ## 1279        make         deal     1   2 0.019  1.401
    ## 1384        make        water     0   2 0.032  1.391
    ## 1467        make       friend     1   2 0.045  1.382
    ## 1518        make         work     1   2 0.056  1.375
    ## 1552        make            q     1   2 0.066  1.367
    ## 1659        make        sound  n.a.   2 0.101  1.343
    ## 1693        make        thing     0   2 0.116  1.332
    ## 1823        make          lot     1   2 0.172  1.293
    ## 1905        make         year     1   2 0.213  1.264
    ## 1973        make         half  n.a.   3 0.867  1.231
    ## 3533        make  boilerplate     0   1 0.000  1.000
    ## 3534        make        decaf     0   1 0.000  1.000
    ## 3535        make        gravy     0   1 0.000  1.000
    ## 3536        make     leftover     0   1 0.000  1.000
    ## 3537        make         loaf     0   1 0.000  1.000
    ## 3538        make           sw     0   1 0.000  1.000
    ## 3539        make         tart     0   1 0.000  1.000
    ## 4237        make        dingo     0   1 0.001  0.999
    ## 4238        make        quilt     0   1 0.001  0.999
    ## 4239        make      spatula     0   1 0.001  0.999
    ## 4644        make   appearance     1   1 0.001  0.999
    ## 4645        make   assumption     1   1 0.001  0.999
    ## 4646        make        attra     1   1 0.001  0.999
    ## 4647        make         dime     1   1 0.001  0.999
    ## 4648        make    discovery     1   1 0.001  0.999
    ## 4649        make         fuss     1   1 0.001  0.999
    ## 4650        make         gasp     1   1 0.001  0.999
    ## 4651        make   generality     1   1 0.001  0.999
    ## 4652        make  guesstimate     1   1 0.001  0.999
    ## 4653        make        habit     1   1 0.001  0.999
    ## 4654        make   individual     1   1 0.001  0.999
    ## 4655        make intercession     1   1 0.001  0.999
    ## 4656        make      laborer     1   1 0.001  0.999
    ## 4657        make    mandatory     1   1 0.001  0.999
    ## 4658        make       remake     1   1 0.001  0.999
    ## 4659        make      richest     1   1 0.001  0.999
    ## 4660        make       steady     1   1 0.001  0.999
    ## 4661        make     swelling     1   1 0.001  0.999
    ## 4662        make        thous     1   1 0.001  0.999
    ## 4663        make         todo     1   1 0.001  0.999
    ## 4796        make        grape     0   1 0.001  0.999
    ## 5219        make       outfit     0   1 0.001  0.999
    ## 5537        make        kebab     0   1 0.001  0.999
    ## 5538        make        steel     0   1 0.001  0.999
    ## 5691        make       bitter     1   1 0.002  0.998
    ## 5692        make      classic     1   1 0.002  0.998
    ## 5693        make   comparison     1   1 0.002  0.998
    ## 5694        make      fifteen     1   1 0.002  0.998
    ## 5695        make         gods     1   1 0.002  0.998
    ## 5696        make    lakefront     1   1 0.002  0.998
    ## 5697        make         lame     1   1 0.002  0.998
    ## 5698        make          low     1   1 0.002  0.998
    ## 5699        make       motion     1   1 0.002  0.998
    ## 5700        make       nation     1   1 0.002  0.998
    ## 5701        make        races     1   1 0.002  0.998
    ## 5702        make       threat     1   1 0.002  0.998
    ## 5703        make          use     1   1 0.002  0.998
    ## 5832        make       basket     0   1 0.002  0.998
    ## 5833        make       pillow     0   1 0.002  0.998
    ## 6104        make       square     0   1 0.002  0.998
    ## 6344        make     ornament     0   1 0.002  0.998
    ## 6345        make        plate     0   1 0.002  0.998
    ## 6346        make        wiper     0   1 0.002  0.998
    ## 6392        make       Hebrew     1   1 0.002  0.998
    ## 6393        make  measurement     1   1 0.002  0.998
    ## 6394        make       statue     1   1 0.002  0.998
    ## 6395        make       string     1   1 0.002  0.998
    ## 6396        make        teach     1   1 0.002  0.998
    ## 6573        make       market     0   1 0.002  0.998
    ## 6792        make    beginning     0   1 0.003  0.997
    ## 6793        make         loan     0   1 0.003  0.997
    ## 6794        make        sauce     0   1 0.003  0.997
    ## 6981        make          lie     1   1 0.003  0.997
    ## 6982        make     musician     1   1 0.003  0.997
    ## 6983        make    provision     1   1 0.003  0.997
    ## 7151        make        juice     0   1 0.003  0.997
    ## 7152        make         meat     0   1 0.003  0.997
    ## 7272        make         masa     0   1 0.004  0.996
    ## 7374        make    deduction     1   1 0.004  0.996
    ## 7375        make        goody     1   1 0.004  0.996
    ## 7376        make    racetrack     1   1 0.004  0.996
    ## 7377        make        scene     1   1 0.004  0.996
    ## 7378        make    selection     1   1 0.004  0.996
    ## 7430        make          ton     0   1 0.004  0.996
    ## 7534        make      clothes     0   1 0.004  0.996
    ## 7748        make        humor     1   1 0.005  0.995
    ## 7799        make         copy     0   1 0.005  0.995
    ## 7800        make          hay     0   1 0.005  0.995
    ## 7801        make       sister     0   1 0.005  0.995
    ## 7933        make          bed     0   1 0.005  0.995
    ## 7934        make        break     0   1 0.005  0.995
    ## 7935        make         tail     0   1 0.005  0.995
    ## 8035        make        shirt     0   1 0.005  0.995
    ## 8077        make         cent     1   1 0.005  0.995
    ## 8078        make      payroll     1   1 0.005  0.995
    ## 8079        make         ride     1   1 0.005  0.995
    ## 8080        make        sound     1   1 0.005  0.995
    ## 8151        make       cookie     0   1 0.005  0.995
    ## 8270        make        salad     0   1 0.006  0.994
    ## 8340        make        issue     1   1 0.006  0.994
    ## 8341        make     marriage     1   1 0.006  0.994
    ## 8342        make          pan     1   1 0.006  0.994
    ## 8343        make       papers     1   1 0.006  0.994
    ## 8344        make        throw     1   1 0.006  0.994
    ## 8417        make         hair     0   1 0.006  0.994
    ## 8543        make          gay     1   1 0.007  0.993
    ## 8588        make        stone     0   1 0.007  0.993
    ## 8796        make fourthgrader     1   1 0.008  0.992
    ## 8797        make         loan     1   1 0.008  0.992
    ## 8798        make     schedule     1   1 0.008  0.992
    ## 8980        make         call     1   1 0.008  0.992
    ## 9183        make        court     1   1 0.009  0.991
    ## 9184        make          law     1   1 0.009  0.991
    ## 9294        make     tomorrow     0   1 0.009  0.991
    ## 9560        make       center     1   1 0.011  0.989
    ## 9707        make        kinda     1   1 0.011  0.989
    ## 9708        make         note     1   1 0.011  0.989
    ## 9792        make         case     0   1 0.012  0.988
    ## 9793        make       dinner     0   1 0.012  0.988
    ## 9855        make       change     1   1 0.012  0.988
    ## 9856        make          Mrc     1   1 0.012  0.988
    ## 9857        make          tap     1   1 0.012  0.988
    ## 9997        make         buck     1   1 0.013  0.987
    ## 9998        make      fractal     1   1 0.013  0.987
    ## 10091       make        pizza     1   1 0.014  0.986
    ## 10121       make          dad     0   1 0.014  0.986
    ## 10210       make         sign     1   1 0.014  0.986
    ## 10246       make       camper  n.a.   1 0.014  0.986
    ## 10247       make     database  n.a.   1 0.014  0.986
    ## 10248       make          hei  n.a.   1 0.014  0.986
    ## 10249       make         leap  n.a.   1 0.014  0.986
    ## 10816       make         food     0   1 0.019  0.981
    ## 10927       make     concrete     1   1 0.020  0.980
    ## 10928       make         home     1   1 0.020  0.980
    ## 11209       make          eye     1   1 0.023  0.977
    ## 11277       make          dam     1   1 0.024  0.976
    ## 11310       make        today     0   1 0.025  0.975
    ## 11440       make         line     1   1 0.026  0.974
    ## 11441       make        paper     1   1 0.026  0.974
    ## 11596       make      percent     1   1 0.028  0.972
    ## 11605       make        night     0   1 0.028  0.972
    ## 11687       make        dingo  n.a.   1 0.029  0.971
    ## 11689       make           lo  n.a.   1 0.029  0.971
    ## 11691       make         move  n.a.   1 0.029  0.971
    ## 11692       make         noun  n.a.   1 0.029  0.971
    ## 11693       make        quilt  n.a.   1 0.029  0.971
    ## 11713       make        story     1   1 0.029  0.971
    ## 11761       make      balloon     1   1 0.030  0.970
    ## 11771       make        money     0   1 0.030  0.970
    ## 11910       make          man     0   1 0.032  0.968
    ## 12039       make         hour     1   1 0.035  0.965
    ## 12185       make       person     1   1 0.037  0.963
    ## 12233       make        class     1   1 0.038  0.962
    ## 12302       make          job     1   1 0.038  0.962
    ## 12303       make        light     1   1 0.038  0.962
    ## 12529       make         tape     1   1 0.042  0.958
    ## 12579       make        arena  n.a.   1 0.043  0.957
    ## 12580       make  improvement  n.a.   1 0.043  0.957
    ## 12744       make            h     0   1 0.047  0.953
    ## 12886       make            X     1   1 0.051  0.949
    ## 13007       make         foot     1   1 0.054  0.946
    ## 13181       make      regular  n.a.   1 0.058  0.942
    ## 13233       make          car     1   1 0.061  0.939
    ## 13234       make        world     1   1 0.061  0.939
    ## 13769       make          bit     1   1 0.077  0.923
    ## 13825       make       people     0   1 0.079  0.921
    ## 14009       make        humor  n.a.   1 0.087  0.913
    ## 14243       make        block  n.a.   1 0.101  0.899
    ## 14244       make            P  n.a.   1 0.101  0.899
    ## 14245       make     servants  n.a.   1 0.101  0.899
    ## 14452       make          pan  n.a.   1 0.116  0.884
    ## 14453       make         pass  n.a.   1 0.116  0.884
    ## 14481       make         time     0   1 0.118  0.882
    ## 14688       make  application  n.a.   1 0.130  0.870
    ## 14689       make     sandwich  n.a.   1 0.130  0.870
    ## 14690       make            h     1   1 0.130  0.870
    ## 14847       make        stuff     1   1 0.136  0.864
    ## 14928       make     employer  n.a.   1 0.145  0.855
    ## 14929       make        sauce  n.a.   1 0.145  0.855
    ## 14970       make           uh     1   1 0.149  0.851
    ## 15095       make     employee  n.a.   1 0.159  0.841
    ## 15102       make          way     1   1 0.160  0.840
    ## 15228       make            s  n.a.   1 0.173  0.827
    ## 15341       make      section  n.a.   1 0.188  0.812
    ## 15574       make        noise  n.a.   1 0.217  0.783
    ## 15575       make      seventy  n.a.   1 0.217  0.783
    ## 15576       make          sky  n.a.   1 0.217  0.783
    ## 15577       make          Vox  n.a.   1 0.217  0.783
    ## 15744       make        color  n.a.   1 0.246  0.754
    ## 15746       make       recipe  n.a.   1 0.246  0.754
    ## 16139       make         time     1   1 0.325  0.675
    ## 16350       make            f  n.a.   1 0.390  0.610
    ## 17110       make            p  n.a.   1 0.867  0.133
    ## 17190       make         food  n.a.   1 0.998  0.002
    ## 17405       make         life  n.a.   1 1.561 -0.561
    ## 17533       make           uh  n.a.   1 2.863 -1.863
    ## 17543       make          one  n.a.   1 3.181 -2.181
    ## 17566       make         year  n.a.   1 4.092 -3.092

    ##       head_lemma       lemma light OBS   EXP     T
    ## 83          make       fudge     0   6 0.003 2.448
    ## 376         make      tamale     0   3 0.002 1.731
    ## 807         make   horseshoe     0   2 0.001 1.414
    ## 835         make   cartilage     0   2 0.001 1.414
    ## 868         make        atom     0   2 0.001 1.413
    ## 883         make     ceviche     0   2 0.001 1.413
    ## 943         make        gold     0   2 0.002 1.413
    ## 944         make      rubber     0   2 0.002 1.413
    ## 992         make       pasta     0   2 0.003 1.412
    ## 1059        make       pizza     0   2 0.005 1.411
    ## 1384        make       water     0   2 0.032 1.391
    ## 1693        make       thing     0   2 0.116 1.332
    ## 3533        make boilerplate     0   1 0.000 1.000
    ## 3534        make       decaf     0   1 0.000 1.000
    ## 3535        make       gravy     0   1 0.000 1.000
    ## 3536        make    leftover     0   1 0.000 1.000
    ## 3537        make        loaf     0   1 0.000 1.000
    ## 3538        make          sw     0   1 0.000 1.000
    ## 3539        make        tart     0   1 0.000 1.000
    ## 4237        make       dingo     0   1 0.001 0.999
    ## 4238        make       quilt     0   1 0.001 0.999
    ## 4239        make     spatula     0   1 0.001 0.999
    ## 4796        make       grape     0   1 0.001 0.999
    ## 5219        make      outfit     0   1 0.001 0.999
    ## 5537        make       kebab     0   1 0.001 0.999
    ## 5538        make       steel     0   1 0.001 0.999
    ## 5832        make      basket     0   1 0.002 0.998
    ## 5833        make      pillow     0   1 0.002 0.998
    ## 6104        make      square     0   1 0.002 0.998
    ## 6344        make    ornament     0   1 0.002 0.998
    ## 6345        make       plate     0   1 0.002 0.998
    ## 6346        make       wiper     0   1 0.002 0.998
    ## 6573        make      market     0   1 0.002 0.998
    ## 6792        make   beginning     0   1 0.003 0.997
    ## 6793        make        loan     0   1 0.003 0.997
    ## 6794        make       sauce     0   1 0.003 0.997
    ## 7151        make       juice     0   1 0.003 0.997
    ## 7152        make        meat     0   1 0.003 0.997
    ## 7272        make        masa     0   1 0.004 0.996
    ## 7430        make         ton     0   1 0.004 0.996
    ## 7534        make     clothes     0   1 0.004 0.996
    ## 7799        make        copy     0   1 0.005 0.995
    ## 7800        make         hay     0   1 0.005 0.995
    ## 7801        make      sister     0   1 0.005 0.995
    ## 7933        make         bed     0   1 0.005 0.995
    ## 7934        make       break     0   1 0.005 0.995
    ## 7935        make        tail     0   1 0.005 0.995
    ## 8035        make       shirt     0   1 0.005 0.995
    ## 8151        make      cookie     0   1 0.005 0.995
    ## 8270        make       salad     0   1 0.006 0.994
    ## 8417        make        hair     0   1 0.006 0.994
    ## 8588        make       stone     0   1 0.007 0.993
    ## 9294        make    tomorrow     0   1 0.009 0.991
    ## 9792        make        case     0   1 0.012 0.988
    ## 9793        make      dinner     0   1 0.012 0.988
    ## 10121       make         dad     0   1 0.014 0.986
    ## 10816       make        food     0   1 0.019 0.981
    ## 11310       make       today     0   1 0.025 0.975
    ## 11605       make       night     0   1 0.028 0.972
    ## 11771       make       money     0   1 0.030 0.970
    ## 11910       make         man     0   1 0.032 0.968
    ## 12744       make           h     0   1 0.047 0.953
    ## 13825       make      people     0   1 0.079 0.921
    ## 14481       make        time     0   1 0.118 0.882

    ##       head_lemma        lemma light OBS   EXP      T
    ## 18          make        money     1  14 0.084  3.719
    ## 30          make     decision     1  10 0.011  3.159
    ## 31          make   difference     1  10 0.020  3.156
    ## 48          make        sense     1   8 0.017  2.822
    ## 83          make        fudge     0   6 0.003  2.448
    ## 115         make         copy  n.a.   6 0.246  2.349
    ## 144         make          fun     1   5 0.015  2.229
    ## 192         make        thing     1   5 0.318  2.094
    ## 224         make       budget     1   4 0.006  1.997
    ## 235         make       report     1   4 0.010  1.995
    ## 237         make        noise     1   4 0.011  1.994
    ## 265         make         kind     1   4 0.065  1.968
    ## 376         make       tamale     0   3 0.002  1.731
    ## 417         make   connection     1   3 0.008  1.728
    ## 427         make    statement     1   3 0.009  1.727
    ## 446         make       choice     1   3 0.014  1.724
    ## 521         make        point     1   3 0.070  1.692
    ## 531         make         life     1   3 0.081  1.685
    ## 536         make       dollar     1   3 0.085  1.683
    ## 540         make        house     1   3 0.088  1.681
    ## 548         make        horse     1   3 0.102  1.673
    ## 675         make      picture  n.a.   3 0.390  1.507
    ## 807         make    horseshoe     0   2 0.001  1.414
    ## 835         make    cartilage     0   2 0.001  1.414
    ## 868         make         atom     0   2 0.001  1.413
    ## 883         make      ceviche     0   2 0.001  1.413
    ## 891         make     progress     1   2 0.002  1.413
    ## 943         make         gold     0   2 0.002  1.413
    ## 944         make       rubber     0   2 0.002  1.413
    ## 947         make      mistake     1   2 0.002  1.413
    ## 991         make  arrangement     1   2 0.003  1.412
    ## 992         make        pasta     0   2 0.003  1.412
    ## 1015        make      comment     1   2 0.004  1.412
    ## 1045        make   friendship     1   2 0.005  1.411
    ## 1046        make         mess     1   2 0.005  1.411
    ## 1059        make        pizza     0   2 0.005  1.411
    ## 1104        make         clue     1   2 0.007  1.409
    ## 1120        make         turn     1   2 0.008  1.409
    ## 1171        make        judge     1   2 0.011  1.407
    ## 1172        make         mile     1   2 0.011  1.407
    ## 1183        make      seventy     1   2 0.011  1.406
    ## 1197        make         trip     1   2 0.013  1.405
    ## 1244        make       living     1   2 0.017  1.403
    ## 1258        make         mind     1   2 0.017  1.402
    ## 1279        make         deal     1   2 0.019  1.401
    ## 1384        make        water     0   2 0.032  1.391
    ## 1467        make       friend     1   2 0.045  1.382
    ## 1518        make         work     1   2 0.056  1.375
    ## 1552        make            q     1   2 0.066  1.367
    ## 1659        make        sound  n.a.   2 0.101  1.343
    ## 1693        make        thing     0   2 0.116  1.332
    ## 1823        make          lot     1   2 0.172  1.293
    ## 1905        make         year     1   2 0.213  1.264
    ## 1973        make         half  n.a.   3 0.867  1.231
    ## 3533        make  boilerplate     0   1 0.000  1.000
    ## 3534        make        decaf     0   1 0.000  1.000
    ## 3535        make        gravy     0   1 0.000  1.000
    ## 3536        make     leftover     0   1 0.000  1.000
    ## 3537        make         loaf     0   1 0.000  1.000
    ## 3538        make           sw     0   1 0.000  1.000
    ## 3539        make         tart     0   1 0.000  1.000
    ## 4237        make        dingo     0   1 0.001  0.999
    ## 4238        make        quilt     0   1 0.001  0.999
    ## 4239        make      spatula     0   1 0.001  0.999
    ## 4644        make   appearance     1   1 0.001  0.999
    ## 4645        make   assumption     1   1 0.001  0.999
    ## 4646        make        attra     1   1 0.001  0.999
    ## 4647        make         dime     1   1 0.001  0.999
    ## 4648        make    discovery     1   1 0.001  0.999
    ## 4649        make         fuss     1   1 0.001  0.999
    ## 4650        make         gasp     1   1 0.001  0.999
    ## 4651        make   generality     1   1 0.001  0.999
    ## 4652        make  guesstimate     1   1 0.001  0.999
    ## 4653        make        habit     1   1 0.001  0.999
    ## 4654        make   individual     1   1 0.001  0.999
    ## 4655        make intercession     1   1 0.001  0.999
    ## 4656        make      laborer     1   1 0.001  0.999
    ## 4657        make    mandatory     1   1 0.001  0.999
    ## 4658        make       remake     1   1 0.001  0.999
    ## 4659        make      richest     1   1 0.001  0.999
    ## 4660        make       steady     1   1 0.001  0.999
    ## 4661        make     swelling     1   1 0.001  0.999
    ## 4662        make        thous     1   1 0.001  0.999
    ## 4663        make         todo     1   1 0.001  0.999
    ## 4796        make        grape     0   1 0.001  0.999
    ## 5219        make       outfit     0   1 0.001  0.999
    ## 5537        make        kebab     0   1 0.001  0.999
    ## 5538        make        steel     0   1 0.001  0.999
    ## 5691        make       bitter     1   1 0.002  0.998
    ## 5692        make      classic     1   1 0.002  0.998
    ## 5693        make   comparison     1   1 0.002  0.998
    ## 5694        make      fifteen     1   1 0.002  0.998
    ## 5695        make         gods     1   1 0.002  0.998
    ## 5696        make    lakefront     1   1 0.002  0.998
    ## 5697        make         lame     1   1 0.002  0.998
    ## 5698        make          low     1   1 0.002  0.998
    ## 5699        make       motion     1   1 0.002  0.998
    ## 5700        make       nation     1   1 0.002  0.998
    ## 5701        make        races     1   1 0.002  0.998
    ## 5702        make       threat     1   1 0.002  0.998
    ## 5703        make          use     1   1 0.002  0.998
    ## 5832        make       basket     0   1 0.002  0.998
    ## 5833        make       pillow     0   1 0.002  0.998
    ## 6104        make       square     0   1 0.002  0.998
    ## 6344        make     ornament     0   1 0.002  0.998
    ## 6345        make        plate     0   1 0.002  0.998
    ## 6346        make        wiper     0   1 0.002  0.998
    ## 6392        make       Hebrew     1   1 0.002  0.998
    ## 6393        make  measurement     1   1 0.002  0.998
    ## 6394        make       statue     1   1 0.002  0.998
    ## 6395        make       string     1   1 0.002  0.998
    ## 6396        make        teach     1   1 0.002  0.998
    ## 6573        make       market     0   1 0.002  0.998
    ## 6792        make    beginning     0   1 0.003  0.997
    ## 6793        make         loan     0   1 0.003  0.997
    ## 6794        make        sauce     0   1 0.003  0.997
    ## 6981        make          lie     1   1 0.003  0.997
    ## 6982        make     musician     1   1 0.003  0.997
    ## 6983        make    provision     1   1 0.003  0.997
    ## 7151        make        juice     0   1 0.003  0.997
    ## 7152        make         meat     0   1 0.003  0.997
    ## 7272        make         masa     0   1 0.004  0.996
    ## 7374        make    deduction     1   1 0.004  0.996
    ## 7375        make        goody     1   1 0.004  0.996
    ## 7376        make    racetrack     1   1 0.004  0.996
    ## 7377        make        scene     1   1 0.004  0.996
    ## 7378        make    selection     1   1 0.004  0.996
    ## 7430        make          ton     0   1 0.004  0.996
    ## 7534        make      clothes     0   1 0.004  0.996
    ## 7748        make        humor     1   1 0.005  0.995
    ## 7799        make         copy     0   1 0.005  0.995
    ## 7800        make          hay     0   1 0.005  0.995
    ## 7801        make       sister     0   1 0.005  0.995
    ## 7933        make          bed     0   1 0.005  0.995
    ## 7934        make        break     0   1 0.005  0.995
    ## 7935        make         tail     0   1 0.005  0.995
    ## 8035        make        shirt     0   1 0.005  0.995
    ## 8077        make         cent     1   1 0.005  0.995
    ## 8078        make      payroll     1   1 0.005  0.995
    ## 8079        make         ride     1   1 0.005  0.995
    ## 8080        make        sound     1   1 0.005  0.995
    ## 8151        make       cookie     0   1 0.005  0.995
    ## 8270        make        salad     0   1 0.006  0.994
    ## 8340        make        issue     1   1 0.006  0.994
    ## 8341        make     marriage     1   1 0.006  0.994
    ## 8342        make          pan     1   1 0.006  0.994
    ## 8343        make       papers     1   1 0.006  0.994
    ## 8344        make        throw     1   1 0.006  0.994
    ## 8417        make         hair     0   1 0.006  0.994
    ## 8543        make          gay     1   1 0.007  0.993
    ## 8588        make        stone     0   1 0.007  0.993
    ## 8796        make fourthgrader     1   1 0.008  0.992
    ## 8797        make         loan     1   1 0.008  0.992
    ## 8798        make     schedule     1   1 0.008  0.992
    ## 8980        make         call     1   1 0.008  0.992
    ## 9183        make        court     1   1 0.009  0.991
    ## 9184        make          law     1   1 0.009  0.991
    ## 9294        make     tomorrow     0   1 0.009  0.991
    ## 9560        make       center     1   1 0.011  0.989
    ## 9707        make        kinda     1   1 0.011  0.989
    ## 9708        make         note     1   1 0.011  0.989
    ## 9792        make         case     0   1 0.012  0.988
    ## 9793        make       dinner     0   1 0.012  0.988
    ## 9855        make       change     1   1 0.012  0.988
    ## 9856        make          Mrc     1   1 0.012  0.988
    ## 9857        make          tap     1   1 0.012  0.988
    ## 9997        make         buck     1   1 0.013  0.987
    ## 9998        make      fractal     1   1 0.013  0.987
    ## 10091       make        pizza     1   1 0.014  0.986
    ## 10121       make          dad     0   1 0.014  0.986
    ## 10210       make         sign     1   1 0.014  0.986
    ## 10246       make       camper  n.a.   1 0.014  0.986
    ## 10247       make     database  n.a.   1 0.014  0.986
    ## 10248       make          hei  n.a.   1 0.014  0.986
    ## 10249       make         leap  n.a.   1 0.014  0.986
    ## 10816       make         food     0   1 0.019  0.981
    ## 10927       make     concrete     1   1 0.020  0.980
    ## 10928       make         home     1   1 0.020  0.980
    ## 11209       make          eye     1   1 0.023  0.977
    ## 11277       make          dam     1   1 0.024  0.976
    ## 11310       make        today     0   1 0.025  0.975
    ## 11440       make         line     1   1 0.026  0.974
    ## 11441       make        paper     1   1 0.026  0.974
    ## 11596       make      percent     1   1 0.028  0.972
    ## 11605       make        night     0   1 0.028  0.972
    ## 11687       make        dingo  n.a.   1 0.029  0.971
    ## 11689       make           lo  n.a.   1 0.029  0.971
    ## 11691       make         move  n.a.   1 0.029  0.971
    ## 11692       make         noun  n.a.   1 0.029  0.971
    ## 11693       make        quilt  n.a.   1 0.029  0.971
    ## 11713       make        story     1   1 0.029  0.971
    ## 11761       make      balloon     1   1 0.030  0.970
    ## 11771       make        money     0   1 0.030  0.970
    ## 11910       make          man     0   1 0.032  0.968
    ## 12039       make         hour     1   1 0.035  0.965
    ## 12185       make       person     1   1 0.037  0.963
    ## 12233       make        class     1   1 0.038  0.962
    ## 12302       make          job     1   1 0.038  0.962
    ## 12303       make        light     1   1 0.038  0.962
    ## 12529       make         tape     1   1 0.042  0.958
    ## 12579       make        arena  n.a.   1 0.043  0.957
    ## 12580       make  improvement  n.a.   1 0.043  0.957
    ## 12744       make            h     0   1 0.047  0.953
    ## 12886       make            X     1   1 0.051  0.949
    ## 13007       make         foot     1   1 0.054  0.946
    ## 13181       make      regular  n.a.   1 0.058  0.942
    ## 13233       make          car     1   1 0.061  0.939
    ## 13234       make        world     1   1 0.061  0.939
    ## 13769       make          bit     1   1 0.077  0.923
    ## 13825       make       people     0   1 0.079  0.921
    ## 14009       make        humor  n.a.   1 0.087  0.913
    ## 14243       make        block  n.a.   1 0.101  0.899
    ## 14244       make            P  n.a.   1 0.101  0.899
    ## 14245       make     servants  n.a.   1 0.101  0.899
    ## 14452       make          pan  n.a.   1 0.116  0.884
    ## 14453       make         pass  n.a.   1 0.116  0.884
    ## 14481       make         time     0   1 0.118  0.882
    ## 14688       make  application  n.a.   1 0.130  0.870
    ## 14689       make     sandwich  n.a.   1 0.130  0.870
    ## 14690       make            h     1   1 0.130  0.870
    ## 14847       make        stuff     1   1 0.136  0.864
    ## 14928       make     employer  n.a.   1 0.145  0.855
    ## 14929       make        sauce  n.a.   1 0.145  0.855
    ## 14970       make           uh     1   1 0.149  0.851
    ## 15095       make     employee  n.a.   1 0.159  0.841
    ## 15102       make          way     1   1 0.160  0.840
    ## 15228       make            s  n.a.   1 0.173  0.827
    ## 15341       make      section  n.a.   1 0.188  0.812
    ## 15574       make        noise  n.a.   1 0.217  0.783
    ## 15575       make      seventy  n.a.   1 0.217  0.783
    ## 15576       make          sky  n.a.   1 0.217  0.783
    ## 15577       make          Vox  n.a.   1 0.217  0.783
    ## 15744       make        color  n.a.   1 0.246  0.754
    ## 15746       make       recipe  n.a.   1 0.246  0.754
    ## 16139       make         time     1   1 0.325  0.675
    ## 16350       make            f  n.a.   1 0.390  0.610
    ## 17110       make            p  n.a.   1 0.867  0.133
    ## 17190       make         food  n.a.   1 0.998  0.002
    ## 17405       make         life  n.a.   1 1.561 -0.561
    ## 17533       make           uh  n.a.   1 2.863 -1.863
    ## 17543       make          one  n.a.   1 3.181 -2.181
    ## 17566       make         year  n.a.   1 4.092 -3.092

    ##       head_lemma        lemma light OBS   EXP     T
    ## 18          make        money     1  14 0.084 3.719
    ## 30          make     decision     1  10 0.011 3.159
    ## 31          make   difference     1  10 0.020 3.156
    ## 48          make        sense     1   8 0.017 2.822
    ## 144         make          fun     1   5 0.015 2.229
    ## 192         make        thing     1   5 0.318 2.094
    ## 224         make       budget     1   4 0.006 1.997
    ## 235         make       report     1   4 0.010 1.995
    ## 237         make        noise     1   4 0.011 1.994
    ## 265         make         kind     1   4 0.065 1.968
    ## 417         make   connection     1   3 0.008 1.728
    ## 427         make    statement     1   3 0.009 1.727
    ## 446         make       choice     1   3 0.014 1.724
    ## 521         make        point     1   3 0.070 1.692
    ## 531         make         life     1   3 0.081 1.685
    ## 536         make       dollar     1   3 0.085 1.683
    ## 540         make        house     1   3 0.088 1.681
    ## 548         make        horse     1   3 0.102 1.673
    ## 891         make     progress     1   2 0.002 1.413
    ## 947         make      mistake     1   2 0.002 1.413
    ## 991         make  arrangement     1   2 0.003 1.412
    ## 1015        make      comment     1   2 0.004 1.412
    ## 1045        make   friendship     1   2 0.005 1.411
    ## 1046        make         mess     1   2 0.005 1.411
    ## 1104        make         clue     1   2 0.007 1.409
    ## 1120        make         turn     1   2 0.008 1.409
    ## 1171        make        judge     1   2 0.011 1.407
    ## 1172        make         mile     1   2 0.011 1.407
    ## 1183        make      seventy     1   2 0.011 1.406
    ## 1197        make         trip     1   2 0.013 1.405
    ## 1244        make       living     1   2 0.017 1.403
    ## 1258        make         mind     1   2 0.017 1.402
    ## 1279        make         deal     1   2 0.019 1.401
    ## 1467        make       friend     1   2 0.045 1.382
    ## 1518        make         work     1   2 0.056 1.375
    ## 1552        make            q     1   2 0.066 1.367
    ## 1823        make          lot     1   2 0.172 1.293
    ## 1905        make         year     1   2 0.213 1.264
    ## 4644        make   appearance     1   1 0.001 0.999
    ## 4645        make   assumption     1   1 0.001 0.999
    ## 4646        make        attra     1   1 0.001 0.999
    ## 4647        make         dime     1   1 0.001 0.999
    ## 4648        make    discovery     1   1 0.001 0.999
    ## 4649        make         fuss     1   1 0.001 0.999
    ## 4650        make         gasp     1   1 0.001 0.999
    ## 4651        make   generality     1   1 0.001 0.999
    ## 4652        make  guesstimate     1   1 0.001 0.999
    ## 4653        make        habit     1   1 0.001 0.999
    ## 4654        make   individual     1   1 0.001 0.999
    ## 4655        make intercession     1   1 0.001 0.999
    ## 4656        make      laborer     1   1 0.001 0.999
    ## 4657        make    mandatory     1   1 0.001 0.999
    ## 4658        make       remake     1   1 0.001 0.999
    ## 4659        make      richest     1   1 0.001 0.999
    ## 4660        make       steady     1   1 0.001 0.999
    ## 4661        make     swelling     1   1 0.001 0.999
    ## 4662        make        thous     1   1 0.001 0.999
    ## 4663        make         todo     1   1 0.001 0.999
    ## 5691        make       bitter     1   1 0.002 0.998
    ## 5692        make      classic     1   1 0.002 0.998
    ## 5693        make   comparison     1   1 0.002 0.998
    ## 5694        make      fifteen     1   1 0.002 0.998
    ## 5695        make         gods     1   1 0.002 0.998
    ## 5696        make    lakefront     1   1 0.002 0.998
    ## 5697        make         lame     1   1 0.002 0.998
    ## 5698        make          low     1   1 0.002 0.998
    ## 5699        make       motion     1   1 0.002 0.998
    ## 5700        make       nation     1   1 0.002 0.998
    ## 5701        make        races     1   1 0.002 0.998
    ## 5702        make       threat     1   1 0.002 0.998
    ## 5703        make          use     1   1 0.002 0.998
    ## 6392        make       Hebrew     1   1 0.002 0.998
    ## 6393        make  measurement     1   1 0.002 0.998
    ## 6394        make       statue     1   1 0.002 0.998
    ## 6395        make       string     1   1 0.002 0.998
    ## 6396        make        teach     1   1 0.002 0.998
    ## 6981        make          lie     1   1 0.003 0.997
    ## 6982        make     musician     1   1 0.003 0.997
    ## 6983        make    provision     1   1 0.003 0.997
    ## 7374        make    deduction     1   1 0.004 0.996
    ## 7375        make        goody     1   1 0.004 0.996
    ## 7376        make    racetrack     1   1 0.004 0.996
    ## 7377        make        scene     1   1 0.004 0.996
    ## 7378        make    selection     1   1 0.004 0.996
    ## 7748        make        humor     1   1 0.005 0.995
    ## 8077        make         cent     1   1 0.005 0.995
    ## 8078        make      payroll     1   1 0.005 0.995
    ## 8079        make         ride     1   1 0.005 0.995
    ## 8080        make        sound     1   1 0.005 0.995
    ## 8340        make        issue     1   1 0.006 0.994
    ## 8341        make     marriage     1   1 0.006 0.994
    ## 8342        make          pan     1   1 0.006 0.994
    ## 8343        make       papers     1   1 0.006 0.994
    ## 8344        make        throw     1   1 0.006 0.994
    ## 8543        make          gay     1   1 0.007 0.993
    ## 8796        make fourthgrader     1   1 0.008 0.992
    ## 8797        make         loan     1   1 0.008 0.992
    ## 8798        make     schedule     1   1 0.008 0.992
    ## 8980        make         call     1   1 0.008 0.992
    ## 9183        make        court     1   1 0.009 0.991
    ## 9184        make          law     1   1 0.009 0.991
    ## 9560        make       center     1   1 0.011 0.989
    ## 9707        make        kinda     1   1 0.011 0.989
    ## 9708        make         note     1   1 0.011 0.989
    ## 9855        make       change     1   1 0.012 0.988
    ## 9856        make          Mrc     1   1 0.012 0.988
    ## 9857        make          tap     1   1 0.012 0.988
    ## 9997        make         buck     1   1 0.013 0.987
    ## 9998        make      fractal     1   1 0.013 0.987
    ## 10091       make        pizza     1   1 0.014 0.986
    ## 10210       make         sign     1   1 0.014 0.986
    ## 10927       make     concrete     1   1 0.020 0.980
    ## 10928       make         home     1   1 0.020 0.980
    ## 11209       make          eye     1   1 0.023 0.977
    ## 11277       make          dam     1   1 0.024 0.976
    ## 11440       make         line     1   1 0.026 0.974
    ## 11441       make        paper     1   1 0.026 0.974
    ## 11596       make      percent     1   1 0.028 0.972
    ## 11713       make        story     1   1 0.029 0.971
    ## 11761       make      balloon     1   1 0.030 0.970
    ## 12039       make         hour     1   1 0.035 0.965
    ## 12185       make       person     1   1 0.037 0.963
    ## 12233       make        class     1   1 0.038 0.962
    ## 12302       make          job     1   1 0.038 0.962
    ## 12303       make        light     1   1 0.038 0.962
    ## 12529       make         tape     1   1 0.042 0.958
    ## 12886       make            X     1   1 0.051 0.949
    ## 13007       make         foot     1   1 0.054 0.946
    ## 13233       make          car     1   1 0.061 0.939
    ## 13234       make        world     1   1 0.061 0.939
    ## 13769       make          bit     1   1 0.077 0.923
    ## 14690       make            h     1   1 0.130 0.870
    ## 14847       make        stuff     1   1 0.136 0.864
    ## 14970       make           uh     1   1 0.149 0.851
    ## 15102       make          way     1   1 0.160 0.840
    ## 16139       make         time     1   1 0.325 0.675

    ##       head_lemma        lemma light OBS   EXP      T
    ## 18          make        money     1  14 0.084  3.719
    ## 30          make     decision     1  10 0.011  3.159
    ## 31          make   difference     1  10 0.020  3.156
    ## 48          make        sense     1   8 0.017  2.822
    ## 83          make        fudge     0   6 0.003  2.448
    ## 115         make         copy  n.a.   6 0.246  2.349
    ## 144         make          fun     1   5 0.015  2.229
    ## 192         make        thing     1   5 0.318  2.094
    ## 224         make       budget     1   4 0.006  1.997
    ## 235         make       report     1   4 0.010  1.995
    ## 237         make        noise     1   4 0.011  1.994
    ## 265         make         kind     1   4 0.065  1.968
    ## 376         make       tamale     0   3 0.002  1.731
    ## 417         make   connection     1   3 0.008  1.728
    ## 427         make    statement     1   3 0.009  1.727
    ## 446         make       choice     1   3 0.014  1.724
    ## 521         make        point     1   3 0.070  1.692
    ## 531         make         life     1   3 0.081  1.685
    ## 536         make       dollar     1   3 0.085  1.683
    ## 540         make        house     1   3 0.088  1.681
    ## 548         make        horse     1   3 0.102  1.673
    ## 675         make      picture  n.a.   3 0.390  1.507
    ## 807         make    horseshoe     0   2 0.001  1.414
    ## 835         make    cartilage     0   2 0.001  1.414
    ## 868         make         atom     0   2 0.001  1.413
    ## 883         make      ceviche     0   2 0.001  1.413
    ## 891         make     progress     1   2 0.002  1.413
    ## 943         make         gold     0   2 0.002  1.413
    ## 944         make       rubber     0   2 0.002  1.413
    ## 947         make      mistake     1   2 0.002  1.413
    ## 991         make  arrangement     1   2 0.003  1.412
    ## 992         make        pasta     0   2 0.003  1.412
    ## 1015        make      comment     1   2 0.004  1.412
    ## 1045        make   friendship     1   2 0.005  1.411
    ## 1046        make         mess     1   2 0.005  1.411
    ## 1059        make        pizza     0   2 0.005  1.411
    ## 1104        make         clue     1   2 0.007  1.409
    ## 1120        make         turn     1   2 0.008  1.409
    ## 1171        make        judge     1   2 0.011  1.407
    ## 1172        make         mile     1   2 0.011  1.407
    ## 1183        make      seventy     1   2 0.011  1.406
    ## 1197        make         trip     1   2 0.013  1.405
    ## 1244        make       living     1   2 0.017  1.403
    ## 1258        make         mind     1   2 0.017  1.402
    ## 1279        make         deal     1   2 0.019  1.401
    ## 1384        make        water     0   2 0.032  1.391
    ## 1467        make       friend     1   2 0.045  1.382
    ## 1518        make         work     1   2 0.056  1.375
    ## 1552        make            q     1   2 0.066  1.367
    ## 1659        make        sound  n.a.   2 0.101  1.343
    ## 1693        make        thing     0   2 0.116  1.332
    ## 1823        make          lot     1   2 0.172  1.293
    ## 1905        make         year     1   2 0.213  1.264
    ## 1973        make         half  n.a.   3 0.867  1.231
    ## 3533        make  boilerplate     0   1 0.000  1.000
    ## 3534        make        decaf     0   1 0.000  1.000
    ## 3535        make        gravy     0   1 0.000  1.000
    ## 3536        make     leftover     0   1 0.000  1.000
    ## 3537        make         loaf     0   1 0.000  1.000
    ## 3538        make           sw     0   1 0.000  1.000
    ## 3539        make         tart     0   1 0.000  1.000
    ## 4237        make        dingo     0   1 0.001  0.999
    ## 4238        make        quilt     0   1 0.001  0.999
    ## 4239        make      spatula     0   1 0.001  0.999
    ## 4644        make   appearance     1   1 0.001  0.999
    ## 4645        make   assumption     1   1 0.001  0.999
    ## 4646        make        attra     1   1 0.001  0.999
    ## 4647        make         dime     1   1 0.001  0.999
    ## 4648        make    discovery     1   1 0.001  0.999
    ## 4649        make         fuss     1   1 0.001  0.999
    ## 4650        make         gasp     1   1 0.001  0.999
    ## 4651        make   generality     1   1 0.001  0.999
    ## 4652        make  guesstimate     1   1 0.001  0.999
    ## 4653        make        habit     1   1 0.001  0.999
    ## 4654        make   individual     1   1 0.001  0.999
    ## 4655        make intercession     1   1 0.001  0.999
    ## 4656        make      laborer     1   1 0.001  0.999
    ## 4657        make    mandatory     1   1 0.001  0.999
    ## 4658        make       remake     1   1 0.001  0.999
    ## 4659        make      richest     1   1 0.001  0.999
    ## 4660        make       steady     1   1 0.001  0.999
    ## 4661        make     swelling     1   1 0.001  0.999
    ## 4662        make        thous     1   1 0.001  0.999
    ## 4663        make         todo     1   1 0.001  0.999
    ## 4796        make        grape     0   1 0.001  0.999
    ## 5219        make       outfit     0   1 0.001  0.999
    ## 5537        make        kebab     0   1 0.001  0.999
    ## 5538        make        steel     0   1 0.001  0.999
    ## 5691        make       bitter     1   1 0.002  0.998
    ## 5692        make      classic     1   1 0.002  0.998
    ## 5693        make   comparison     1   1 0.002  0.998
    ## 5694        make      fifteen     1   1 0.002  0.998
    ## 5695        make         gods     1   1 0.002  0.998
    ## 5696        make    lakefront     1   1 0.002  0.998
    ## 5697        make         lame     1   1 0.002  0.998
    ## 5698        make          low     1   1 0.002  0.998
    ## 5699        make       motion     1   1 0.002  0.998
    ## 5700        make       nation     1   1 0.002  0.998
    ## 5701        make        races     1   1 0.002  0.998
    ## 5702        make       threat     1   1 0.002  0.998
    ## 5703        make          use     1   1 0.002  0.998
    ## 5832        make       basket     0   1 0.002  0.998
    ## 5833        make       pillow     0   1 0.002  0.998
    ## 6104        make       square     0   1 0.002  0.998
    ## 6344        make     ornament     0   1 0.002  0.998
    ## 6345        make        plate     0   1 0.002  0.998
    ## 6346        make        wiper     0   1 0.002  0.998
    ## 6392        make       Hebrew     1   1 0.002  0.998
    ## 6393        make  measurement     1   1 0.002  0.998
    ## 6394        make       statue     1   1 0.002  0.998
    ## 6395        make       string     1   1 0.002  0.998
    ## 6396        make        teach     1   1 0.002  0.998
    ## 6573        make       market     0   1 0.002  0.998
    ## 6792        make    beginning     0   1 0.003  0.997
    ## 6793        make         loan     0   1 0.003  0.997
    ## 6794        make        sauce     0   1 0.003  0.997
    ## 6981        make          lie     1   1 0.003  0.997
    ## 6982        make     musician     1   1 0.003  0.997
    ## 6983        make    provision     1   1 0.003  0.997
    ## 7151        make        juice     0   1 0.003  0.997
    ## 7152        make         meat     0   1 0.003  0.997
    ## 7272        make         masa     0   1 0.004  0.996
    ## 7374        make    deduction     1   1 0.004  0.996
    ## 7375        make        goody     1   1 0.004  0.996
    ## 7376        make    racetrack     1   1 0.004  0.996
    ## 7377        make        scene     1   1 0.004  0.996
    ## 7378        make    selection     1   1 0.004  0.996
    ## 7430        make          ton     0   1 0.004  0.996
    ## 7534        make      clothes     0   1 0.004  0.996
    ## 7748        make        humor     1   1 0.005  0.995
    ## 7799        make         copy     0   1 0.005  0.995
    ## 7800        make          hay     0   1 0.005  0.995
    ## 7801        make       sister     0   1 0.005  0.995
    ## 7933        make          bed     0   1 0.005  0.995
    ## 7934        make        break     0   1 0.005  0.995
    ## 7935        make         tail     0   1 0.005  0.995
    ## 8035        make        shirt     0   1 0.005  0.995
    ## 8077        make         cent     1   1 0.005  0.995
    ## 8078        make      payroll     1   1 0.005  0.995
    ## 8079        make         ride     1   1 0.005  0.995
    ## 8080        make        sound     1   1 0.005  0.995
    ## 8151        make       cookie     0   1 0.005  0.995
    ## 8270        make        salad     0   1 0.006  0.994
    ## 8340        make        issue     1   1 0.006  0.994
    ## 8341        make     marriage     1   1 0.006  0.994
    ## 8342        make          pan     1   1 0.006  0.994
    ## 8343        make       papers     1   1 0.006  0.994
    ## 8344        make        throw     1   1 0.006  0.994
    ## 8417        make         hair     0   1 0.006  0.994
    ## 8543        make          gay     1   1 0.007  0.993
    ## 8588        make        stone     0   1 0.007  0.993
    ## 8796        make fourthgrader     1   1 0.008  0.992
    ## 8797        make         loan     1   1 0.008  0.992
    ## 8798        make     schedule     1   1 0.008  0.992
    ## 8980        make         call     1   1 0.008  0.992
    ## 9183        make        court     1   1 0.009  0.991
    ## 9184        make          law     1   1 0.009  0.991
    ## 9294        make     tomorrow     0   1 0.009  0.991
    ## 9560        make       center     1   1 0.011  0.989
    ## 9707        make        kinda     1   1 0.011  0.989
    ## 9708        make         note     1   1 0.011  0.989
    ## 9792        make         case     0   1 0.012  0.988
    ## 9793        make       dinner     0   1 0.012  0.988
    ## 9855        make       change     1   1 0.012  0.988
    ## 9856        make          Mrc     1   1 0.012  0.988
    ## 9857        make          tap     1   1 0.012  0.988
    ## 9997        make         buck     1   1 0.013  0.987
    ## 9998        make      fractal     1   1 0.013  0.987
    ## 10091       make        pizza     1   1 0.014  0.986
    ## 10121       make          dad     0   1 0.014  0.986
    ## 10210       make         sign     1   1 0.014  0.986
    ## 10246       make       camper  n.a.   1 0.014  0.986
    ## 10247       make     database  n.a.   1 0.014  0.986
    ## 10248       make          hei  n.a.   1 0.014  0.986
    ## 10249       make         leap  n.a.   1 0.014  0.986
    ## 10816       make         food     0   1 0.019  0.981
    ## 10927       make     concrete     1   1 0.020  0.980
    ## 10928       make         home     1   1 0.020  0.980
    ## 11209       make          eye     1   1 0.023  0.977
    ## 11277       make          dam     1   1 0.024  0.976
    ## 11310       make        today     0   1 0.025  0.975
    ## 11440       make         line     1   1 0.026  0.974
    ## 11441       make        paper     1   1 0.026  0.974
    ## 11596       make      percent     1   1 0.028  0.972
    ## 11605       make        night     0   1 0.028  0.972
    ## 11687       make        dingo  n.a.   1 0.029  0.971
    ## 11689       make           lo  n.a.   1 0.029  0.971
    ## 11691       make         move  n.a.   1 0.029  0.971
    ## 11692       make         noun  n.a.   1 0.029  0.971
    ## 11693       make        quilt  n.a.   1 0.029  0.971
    ## 11713       make        story     1   1 0.029  0.971
    ## 11761       make      balloon     1   1 0.030  0.970
    ## 11771       make        money     0   1 0.030  0.970
    ## 11910       make          man     0   1 0.032  0.968
    ## 12039       make         hour     1   1 0.035  0.965
    ## 12185       make       person     1   1 0.037  0.963
    ## 12233       make        class     1   1 0.038  0.962
    ## 12302       make          job     1   1 0.038  0.962
    ## 12303       make        light     1   1 0.038  0.962
    ## 12529       make         tape     1   1 0.042  0.958
    ## 12579       make        arena  n.a.   1 0.043  0.957
    ## 12580       make  improvement  n.a.   1 0.043  0.957
    ## 12744       make            h     0   1 0.047  0.953
    ## 12886       make            X     1   1 0.051  0.949
    ## 13007       make         foot     1   1 0.054  0.946
    ## 13181       make      regular  n.a.   1 0.058  0.942
    ## 13233       make          car     1   1 0.061  0.939
    ## 13234       make        world     1   1 0.061  0.939
    ## 13769       make          bit     1   1 0.077  0.923
    ## 13825       make       people     0   1 0.079  0.921
    ## 14009       make        humor  n.a.   1 0.087  0.913
    ## 14243       make        block  n.a.   1 0.101  0.899
    ## 14244       make            P  n.a.   1 0.101  0.899
    ## 14245       make     servants  n.a.   1 0.101  0.899
    ## 14452       make          pan  n.a.   1 0.116  0.884
    ## 14453       make         pass  n.a.   1 0.116  0.884
    ## 14481       make         time     0   1 0.118  0.882
    ## 14688       make  application  n.a.   1 0.130  0.870
    ## 14689       make     sandwich  n.a.   1 0.130  0.870
    ## 14690       make            h     1   1 0.130  0.870
    ## 14847       make        stuff     1   1 0.136  0.864
    ## 14928       make     employer  n.a.   1 0.145  0.855
    ## 14929       make        sauce  n.a.   1 0.145  0.855
    ## 14970       make           uh     1   1 0.149  0.851
    ## 15095       make     employee  n.a.   1 0.159  0.841
    ## 15102       make          way     1   1 0.160  0.840
    ## 15228       make            s  n.a.   1 0.173  0.827
    ## 15341       make      section  n.a.   1 0.188  0.812
    ## 15574       make        noise  n.a.   1 0.217  0.783
    ## 15575       make      seventy  n.a.   1 0.217  0.783
    ## 15576       make          sky  n.a.   1 0.217  0.783
    ## 15577       make          Vox  n.a.   1 0.217  0.783
    ## 15744       make        color  n.a.   1 0.246  0.754
    ## 15746       make       recipe  n.a.   1 0.246  0.754
    ## 16139       make         time     1   1 0.325  0.675
    ## 16350       make            f  n.a.   1 0.390  0.610
    ## 17110       make            p  n.a.   1 0.867  0.133
    ## 17190       make         food  n.a.   1 0.998  0.002
    ## 17405       make         life  n.a.   1 1.561 -0.561
    ## 17533       make           uh  n.a.   1 2.863 -1.863
    ## 17543       make          one  n.a.   1 3.181 -2.181
    ## 17566       make         year  n.a.   1 4.092 -3.092

    ##       head_lemma        lemma light OBS   EXP      T
    ## 18          make        money     1  14 0.084  3.719
    ## 30          make     decision     1  10 0.011  3.159
    ## 31          make   difference     1  10 0.020  3.156
    ## 48          make        sense     1   8 0.017  2.822
    ## 83          make        fudge     0   6 0.003  2.448
    ## 115         make         copy  n.a.   6 0.246  2.349
    ## 144         make          fun     1   5 0.015  2.229
    ## 192         make        thing     1   5 0.318  2.094
    ## 224         make       budget     1   4 0.006  1.997
    ## 235         make       report     1   4 0.010  1.995
    ## 237         make        noise     1   4 0.011  1.994
    ## 265         make         kind     1   4 0.065  1.968
    ## 376         make       tamale     0   3 0.002  1.731
    ## 417         make   connection     1   3 0.008  1.728
    ## 427         make    statement     1   3 0.009  1.727
    ## 446         make       choice     1   3 0.014  1.724
    ## 521         make        point     1   3 0.070  1.692
    ## 531         make         life     1   3 0.081  1.685
    ## 536         make       dollar     1   3 0.085  1.683
    ## 540         make        house     1   3 0.088  1.681
    ## 548         make        horse     1   3 0.102  1.673
    ## 675         make      picture  n.a.   3 0.390  1.507
    ## 807         make    horseshoe     0   2 0.001  1.414
    ## 835         make    cartilage     0   2 0.001  1.414
    ## 868         make         atom     0   2 0.001  1.413
    ## 883         make      ceviche     0   2 0.001  1.413
    ## 891         make     progress     1   2 0.002  1.413
    ## 943         make         gold     0   2 0.002  1.413
    ## 944         make       rubber     0   2 0.002  1.413
    ## 947         make      mistake     1   2 0.002  1.413
    ## 991         make  arrangement     1   2 0.003  1.412
    ## 992         make        pasta     0   2 0.003  1.412
    ## 1015        make      comment     1   2 0.004  1.412
    ## 1045        make   friendship     1   2 0.005  1.411
    ## 1046        make         mess     1   2 0.005  1.411
    ## 1059        make        pizza     0   2 0.005  1.411
    ## 1104        make         clue     1   2 0.007  1.409
    ## 1120        make         turn     1   2 0.008  1.409
    ## 1171        make        judge     1   2 0.011  1.407
    ## 1172        make         mile     1   2 0.011  1.407
    ## 1183        make      seventy     1   2 0.011  1.406
    ## 1197        make         trip     1   2 0.013  1.405
    ## 1244        make       living     1   2 0.017  1.403
    ## 1258        make         mind     1   2 0.017  1.402
    ## 1279        make         deal     1   2 0.019  1.401
    ## 1384        make        water     0   2 0.032  1.391
    ## 1467        make       friend     1   2 0.045  1.382
    ## 1518        make         work     1   2 0.056  1.375
    ## 1552        make            q     1   2 0.066  1.367
    ## 1659        make        sound  n.a.   2 0.101  1.343
    ## 1693        make        thing     0   2 0.116  1.332
    ## 1823        make          lot     1   2 0.172  1.293
    ## 1905        make         year     1   2 0.213  1.264
    ## 1973        make         half  n.a.   3 0.867  1.231
    ## 3533        make  boilerplate     0   1 0.000  1.000
    ## 3534        make        decaf     0   1 0.000  1.000
    ## 3535        make        gravy     0   1 0.000  1.000
    ## 3536        make     leftover     0   1 0.000  1.000
    ## 3537        make         loaf     0   1 0.000  1.000
    ## 3538        make           sw     0   1 0.000  1.000
    ## 3539        make         tart     0   1 0.000  1.000
    ## 4237        make        dingo     0   1 0.001  0.999
    ## 4238        make        quilt     0   1 0.001  0.999
    ## 4239        make      spatula     0   1 0.001  0.999
    ## 4644        make   appearance     1   1 0.001  0.999
    ## 4645        make   assumption     1   1 0.001  0.999
    ## 4646        make        attra     1   1 0.001  0.999
    ## 4647        make         dime     1   1 0.001  0.999
    ## 4648        make    discovery     1   1 0.001  0.999
    ## 4649        make         fuss     1   1 0.001  0.999
    ## 4650        make         gasp     1   1 0.001  0.999
    ## 4651        make   generality     1   1 0.001  0.999
    ## 4652        make  guesstimate     1   1 0.001  0.999
    ## 4653        make        habit     1   1 0.001  0.999
    ## 4654        make   individual     1   1 0.001  0.999
    ## 4655        make intercession     1   1 0.001  0.999
    ## 4656        make      laborer     1   1 0.001  0.999
    ## 4657        make    mandatory     1   1 0.001  0.999
    ## 4658        make       remake     1   1 0.001  0.999
    ## 4659        make      richest     1   1 0.001  0.999
    ## 4660        make       steady     1   1 0.001  0.999
    ## 4661        make     swelling     1   1 0.001  0.999
    ## 4662        make        thous     1   1 0.001  0.999
    ## 4663        make         todo     1   1 0.001  0.999
    ## 4796        make        grape     0   1 0.001  0.999
    ## 5219        make       outfit     0   1 0.001  0.999
    ## 5537        make        kebab     0   1 0.001  0.999
    ## 5538        make        steel     0   1 0.001  0.999
    ## 5691        make       bitter     1   1 0.002  0.998
    ## 5692        make      classic     1   1 0.002  0.998
    ## 5693        make   comparison     1   1 0.002  0.998
    ## 5694        make      fifteen     1   1 0.002  0.998
    ## 5695        make         gods     1   1 0.002  0.998
    ## 5696        make    lakefront     1   1 0.002  0.998
    ## 5697        make         lame     1   1 0.002  0.998
    ## 5698        make          low     1   1 0.002  0.998
    ## 5699        make       motion     1   1 0.002  0.998
    ## 5700        make       nation     1   1 0.002  0.998
    ## 5701        make        races     1   1 0.002  0.998
    ## 5702        make       threat     1   1 0.002  0.998
    ## 5703        make          use     1   1 0.002  0.998
    ## 5832        make       basket     0   1 0.002  0.998
    ## 5833        make       pillow     0   1 0.002  0.998
    ## 6104        make       square     0   1 0.002  0.998
    ## 6344        make     ornament     0   1 0.002  0.998
    ## 6345        make        plate     0   1 0.002  0.998
    ## 6346        make        wiper     0   1 0.002  0.998
    ## 6392        make       Hebrew     1   1 0.002  0.998
    ## 6393        make  measurement     1   1 0.002  0.998
    ## 6394        make       statue     1   1 0.002  0.998
    ## 6395        make       string     1   1 0.002  0.998
    ## 6396        make        teach     1   1 0.002  0.998
    ## 6573        make       market     0   1 0.002  0.998
    ## 6792        make    beginning     0   1 0.003  0.997
    ## 6793        make         loan     0   1 0.003  0.997
    ## 6794        make        sauce     0   1 0.003  0.997
    ## 6981        make          lie     1   1 0.003  0.997
    ## 6982        make     musician     1   1 0.003  0.997
    ## 6983        make    provision     1   1 0.003  0.997
    ## 7151        make        juice     0   1 0.003  0.997
    ## 7152        make         meat     0   1 0.003  0.997
    ## 7272        make         masa     0   1 0.004  0.996
    ## 7374        make    deduction     1   1 0.004  0.996
    ## 7375        make        goody     1   1 0.004  0.996
    ## 7376        make    racetrack     1   1 0.004  0.996
    ## 7377        make        scene     1   1 0.004  0.996
    ## 7378        make    selection     1   1 0.004  0.996
    ## 7430        make          ton     0   1 0.004  0.996
    ## 7534        make      clothes     0   1 0.004  0.996
    ## 7748        make        humor     1   1 0.005  0.995
    ## 7799        make         copy     0   1 0.005  0.995
    ## 7800        make          hay     0   1 0.005  0.995
    ## 7801        make       sister     0   1 0.005  0.995
    ## 7933        make          bed     0   1 0.005  0.995
    ## 7934        make        break     0   1 0.005  0.995
    ## 7935        make         tail     0   1 0.005  0.995
    ## 8035        make        shirt     0   1 0.005  0.995
    ## 8077        make         cent     1   1 0.005  0.995
    ## 8078        make      payroll     1   1 0.005  0.995
    ## 8079        make         ride     1   1 0.005  0.995
    ## 8080        make        sound     1   1 0.005  0.995
    ## 8151        make       cookie     0   1 0.005  0.995
    ## 8270        make        salad     0   1 0.006  0.994
    ## 8340        make        issue     1   1 0.006  0.994
    ## 8341        make     marriage     1   1 0.006  0.994
    ## 8342        make          pan     1   1 0.006  0.994
    ## 8343        make       papers     1   1 0.006  0.994
    ## 8344        make        throw     1   1 0.006  0.994
    ## 8417        make         hair     0   1 0.006  0.994
    ## 8543        make          gay     1   1 0.007  0.993
    ## 8588        make        stone     0   1 0.007  0.993
    ## 8796        make fourthgrader     1   1 0.008  0.992
    ## 8797        make         loan     1   1 0.008  0.992
    ## 8798        make     schedule     1   1 0.008  0.992
    ## 8980        make         call     1   1 0.008  0.992
    ## 9183        make        court     1   1 0.009  0.991
    ## 9184        make          law     1   1 0.009  0.991
    ## 9294        make     tomorrow     0   1 0.009  0.991
    ## 9560        make       center     1   1 0.011  0.989
    ## 9707        make        kinda     1   1 0.011  0.989
    ## 9708        make         note     1   1 0.011  0.989
    ## 9792        make         case     0   1 0.012  0.988
    ## 9793        make       dinner     0   1 0.012  0.988
    ## 9855        make       change     1   1 0.012  0.988
    ## 9856        make          Mrc     1   1 0.012  0.988
    ## 9857        make          tap     1   1 0.012  0.988
    ## 9997        make         buck     1   1 0.013  0.987
    ## 9998        make      fractal     1   1 0.013  0.987
    ## 10091       make        pizza     1   1 0.014  0.986
    ## 10121       make          dad     0   1 0.014  0.986
    ## 10210       make         sign     1   1 0.014  0.986
    ## 10246       make       camper  n.a.   1 0.014  0.986
    ## 10247       make     database  n.a.   1 0.014  0.986
    ## 10248       make          hei  n.a.   1 0.014  0.986
    ## 10249       make         leap  n.a.   1 0.014  0.986
    ## 10816       make         food     0   1 0.019  0.981
    ## 10927       make     concrete     1   1 0.020  0.980
    ## 10928       make         home     1   1 0.020  0.980
    ## 11209       make          eye     1   1 0.023  0.977
    ## 11277       make          dam     1   1 0.024  0.976
    ## 11310       make        today     0   1 0.025  0.975
    ## 11440       make         line     1   1 0.026  0.974
    ## 11441       make        paper     1   1 0.026  0.974
    ## 11596       make      percent     1   1 0.028  0.972
    ## 11605       make        night     0   1 0.028  0.972
    ## 11687       make        dingo  n.a.   1 0.029  0.971
    ## 11689       make           lo  n.a.   1 0.029  0.971
    ## 11691       make         move  n.a.   1 0.029  0.971
    ## 11692       make         noun  n.a.   1 0.029  0.971
    ## 11693       make        quilt  n.a.   1 0.029  0.971
    ## 11713       make        story     1   1 0.029  0.971
    ## 11761       make      balloon     1   1 0.030  0.970
    ## 11771       make        money     0   1 0.030  0.970
    ## 11910       make          man     0   1 0.032  0.968
    ## 12039       make         hour     1   1 0.035  0.965
    ## 12185       make       person     1   1 0.037  0.963
    ## 12233       make        class     1   1 0.038  0.962
    ## 12302       make          job     1   1 0.038  0.962
    ## 12303       make        light     1   1 0.038  0.962
    ## 12529       make         tape     1   1 0.042  0.958
    ## 12579       make        arena  n.a.   1 0.043  0.957
    ## 12580       make  improvement  n.a.   1 0.043  0.957
    ## 12744       make            h     0   1 0.047  0.953
    ## 12886       make            X     1   1 0.051  0.949
    ## 13007       make         foot     1   1 0.054  0.946
    ## 13181       make      regular  n.a.   1 0.058  0.942
    ## 13233       make          car     1   1 0.061  0.939
    ## 13234       make        world     1   1 0.061  0.939
    ## 13769       make          bit     1   1 0.077  0.923
    ## 13825       make       people     0   1 0.079  0.921
    ## 14009       make        humor  n.a.   1 0.087  0.913
    ## 14243       make        block  n.a.   1 0.101  0.899
    ## 14244       make            P  n.a.   1 0.101  0.899
    ## 14245       make     servants  n.a.   1 0.101  0.899
    ## 14452       make          pan  n.a.   1 0.116  0.884
    ## 14453       make         pass  n.a.   1 0.116  0.884
    ## 14481       make         time     0   1 0.118  0.882
    ## 14688       make  application  n.a.   1 0.130  0.870
    ## 14689       make     sandwich  n.a.   1 0.130  0.870
    ## 14690       make            h     1   1 0.130  0.870
    ## 14847       make        stuff     1   1 0.136  0.864
    ## 14928       make     employer  n.a.   1 0.145  0.855
    ## 14929       make        sauce  n.a.   1 0.145  0.855
    ## 14970       make           uh     1   1 0.149  0.851
    ## 15095       make     employee  n.a.   1 0.159  0.841
    ## 15102       make          way     1   1 0.160  0.840
    ## 15228       make            s  n.a.   1 0.173  0.827
    ## 15341       make      section  n.a.   1 0.188  0.812
    ## 15574       make        noise  n.a.   1 0.217  0.783
    ## 15575       make      seventy  n.a.   1 0.217  0.783
    ## 15576       make          sky  n.a.   1 0.217  0.783
    ## 15577       make          Vox  n.a.   1 0.217  0.783
    ## 15744       make        color  n.a.   1 0.246  0.754
    ## 15746       make       recipe  n.a.   1 0.246  0.754
    ## 16139       make         time     1   1 0.325  0.675
    ## 16350       make            f  n.a.   1 0.390  0.610
    ## 17110       make            p  n.a.   1 0.867  0.133
    ## 17190       make         food  n.a.   1 0.998  0.002
    ## 17405       make         life  n.a.   1 1.561 -0.561
    ## 17533       make           uh  n.a.   1 2.863 -1.863
    ## 17543       make          one  n.a.   1 3.181 -2.181
    ## 17566       make         year  n.a.   1 4.092 -3.092

    ##       head_lemma       lemma light OBS   EXP     T
    ## 83          make       fudge     0   6 0.003 2.448
    ## 376         make      tamale     0   3 0.002 1.731
    ## 807         make   horseshoe     0   2 0.001 1.414
    ## 835         make   cartilage     0   2 0.001 1.414
    ## 868         make        atom     0   2 0.001 1.413
    ## 883         make     ceviche     0   2 0.001 1.413
    ## 943         make        gold     0   2 0.002 1.413
    ## 944         make      rubber     0   2 0.002 1.413
    ## 992         make       pasta     0   2 0.003 1.412
    ## 1059        make       pizza     0   2 0.005 1.411
    ## 1384        make       water     0   2 0.032 1.391
    ## 1693        make       thing     0   2 0.116 1.332
    ## 3533        make boilerplate     0   1 0.000 1.000
    ## 3534        make       decaf     0   1 0.000 1.000
    ## 3535        make       gravy     0   1 0.000 1.000
    ## 3536        make    leftover     0   1 0.000 1.000
    ## 3537        make        loaf     0   1 0.000 1.000
    ## 3538        make          sw     0   1 0.000 1.000
    ## 3539        make        tart     0   1 0.000 1.000
    ## 4237        make       dingo     0   1 0.001 0.999
    ## 4238        make       quilt     0   1 0.001 0.999
    ## 4239        make     spatula     0   1 0.001 0.999
    ## 4796        make       grape     0   1 0.001 0.999
    ## 5219        make      outfit     0   1 0.001 0.999
    ## 5537        make       kebab     0   1 0.001 0.999
    ## 5538        make       steel     0   1 0.001 0.999
    ## 5832        make      basket     0   1 0.002 0.998
    ## 5833        make      pillow     0   1 0.002 0.998
    ## 6104        make      square     0   1 0.002 0.998
    ## 6344        make    ornament     0   1 0.002 0.998
    ## 6345        make       plate     0   1 0.002 0.998
    ## 6346        make       wiper     0   1 0.002 0.998
    ## 6573        make      market     0   1 0.002 0.998
    ## 6792        make   beginning     0   1 0.003 0.997
    ## 6793        make        loan     0   1 0.003 0.997
    ## 6794        make       sauce     0   1 0.003 0.997
    ## 7151        make       juice     0   1 0.003 0.997
    ## 7152        make        meat     0   1 0.003 0.997
    ## 7272        make        masa     0   1 0.004 0.996
    ## 7430        make         ton     0   1 0.004 0.996
    ## 7534        make     clothes     0   1 0.004 0.996
    ## 7799        make        copy     0   1 0.005 0.995
    ## 7800        make         hay     0   1 0.005 0.995
    ## 7801        make      sister     0   1 0.005 0.995
    ## 7933        make         bed     0   1 0.005 0.995
    ## 7934        make       break     0   1 0.005 0.995
    ## 7935        make        tail     0   1 0.005 0.995
    ## 8035        make       shirt     0   1 0.005 0.995
    ## 8151        make      cookie     0   1 0.005 0.995
    ## 8270        make       salad     0   1 0.006 0.994
    ## 8417        make        hair     0   1 0.006 0.994
    ## 8588        make       stone     0   1 0.007 0.993
    ## 9294        make    tomorrow     0   1 0.009 0.991
    ## 9792        make        case     0   1 0.012 0.988
    ## 9793        make      dinner     0   1 0.012 0.988
    ## 10121       make         dad     0   1 0.014 0.986
    ## 10816       make        food     0   1 0.019 0.981
    ## 11310       make       today     0   1 0.025 0.975
    ## 11605       make       night     0   1 0.028 0.972
    ## 11771       make       money     0   1 0.030 0.970
    ## 11910       make         man     0   1 0.032 0.968
    ## 12744       make           h     0   1 0.047 0.953
    ## 13825       make      people     0   1 0.079 0.921
    ## 14481       make        time     0   1 0.118 0.882

    ##       head_lemma       lemma light OBS   EXP     T
    ## 83          make       fudge     0   6 0.003 2.448
    ## 210        build         dam     0   4 0.001 1.999
    ## 343        build      garage     0   3 0.000 1.732
    ## 357        build    building     0   3 0.001 1.731
    ## 376         make      tamale     0   3 0.002 1.731
    ## 743       create     purpose     0   2 0.000 1.414
    ## 745        build        nest     0   2 0.000 1.414
    ## 795        build   character     0   2 0.000 1.414
    ## 796        build       plant     0   2 0.000 1.414
    ## 807         make   horseshoe     0   2 0.001 1.414
    ## 835         make   cartilage     0   2 0.001 1.414
    ## 868         make        atom     0   2 0.001 1.413
    ## 883         make     ceviche     0   2 0.001 1.413
    ## 912        build        area     0   2 0.002 1.413
    ## 943         make        gold     0   2 0.002 1.413
    ## 944         make      rubber     0   2 0.002 1.413
    ## 992         make       pasta     0   2 0.003 1.412
    ## 1059        make       pizza     0   2 0.005 1.411
    ## 1119       build          uh     0   2 0.007 1.409
    ## 1384        make       water     0   2 0.032 1.391
    ## 1693        make       thing     0   2 0.116 1.332
    ## 2315      create        rift     0   1 0.000 1.000
    ## 2332     produce    champion     0   1 0.000 1.000
    ## 2340      create      stress     0   1 0.000 1.000
    ## 2373     produce      report     0   1 0.000 1.000
    ## 2375      create      garden     0   1 0.000 1.000
    ## 2390       build  depression     0   1 0.000 1.000
    ## 2391       build  floodplain     0   1 0.000 1.000
    ## 2392       build      podium     0   1 0.000 1.000
    ## 2608      create   condition     0   1 0.000 1.000
    ## 2615      create   committee     0   1 0.000 1.000
    ## 2616    generate       power     0   1 0.000 1.000
    ## 2621     produce        heat     0   1 0.000 1.000
    ## 2638       build  attraction     0   1 0.000 1.000
    ## 2858       build   cofferdam     0   1 0.000 1.000
    ## 3025      create       cause     0   1 0.000 1.000
    ## 3026       build   consensus     0   1 0.000 1.000
    ## 3027       build     library     0   1 0.000 1.000
    ## 3533        make boilerplate     0   1 0.000 1.000
    ## 3534        make       decaf     0   1 0.000 1.000
    ## 3535        make       gravy     0   1 0.000 1.000
    ## 3536        make    leftover     0   1 0.000 1.000
    ## 3537        make        loaf     0   1 0.000 1.000
    ## 3538        make          sw     0   1 0.000 1.000
    ## 3539        make        tart     0   1 0.000 1.000
    ## 3768       build        step     0   1 0.000 1.000
    ## 3769       build     thought     0   1 0.000 1.000
    ## 4037       build       river     0   1 0.000 1.000
    ## 4038       build    spillway     0   1 0.000 1.000
    ## 4237        make       dingo     0   1 0.001 0.999
    ## 4238        make       quilt     0   1 0.001 0.999
    ## 4239        make     spatula     0   1 0.001 0.999
    ## 4396       build       fence     0   1 0.001 0.999
    ## 4639       build       lotta     0   1 0.001 0.999
    ## 4709       build        body     0   1 0.001 0.999
    ## 4796        make       grape     0   1 0.001 0.999
    ## 4864       build        barn     0   1 0.001 0.999
    ## 5077       build      animal     0   1 0.001 0.999
    ## 5128       build    concrete     0   1 0.001 0.999
    ## 5219        make      outfit     0   1 0.001 0.999
    ## 5526       build        form     0   1 0.001 0.999
    ## 5537        make       kebab     0   1 0.001 0.999
    ## 5538        make       steel     0   1 0.001 0.999
    ## 5579      create         day     0   1 0.001 0.999
    ## 5741       build         top     0   1 0.002 0.998
    ## 5832        make      basket     0   1 0.002 0.998
    ## 5833        make      pillow     0   1 0.002 0.998
    ## 6104        make      square     0   1 0.002 0.998
    ## 6258       build       woman     0   1 0.002 0.998
    ## 6314       build      couple     0   1 0.002 0.998
    ## 6344        make    ornament     0   1 0.002 0.998
    ## 6345        make       plate     0   1 0.002 0.998
    ## 6346        make       wiper     0   1 0.002 0.998
    ## 6349       build        part     0   1 0.002 0.998
    ## 6573        make      market     0   1 0.002 0.998
    ## 6788       build        foot     0   1 0.003 0.997
    ## 6792        make   beginning     0   1 0.003 0.997
    ## 6793        make        loan     0   1 0.003 0.997
    ## 6794        make       sauce     0   1 0.003 0.997
    ## 7002       build       world     0   1 0.003 0.997
    ## 7114      create       thing     0   1 0.003 0.997
    ## 7151        make       juice     0   1 0.003 0.997
    ## 7152        make        meat     0   1 0.003 0.997
    ## 7272        make        masa     0   1 0.004 0.996
    ## 7430        make         ton     0   1 0.004 0.996
    ## 7534        make     clothes     0   1 0.004 0.996
    ## 7692       build       water     0   1 0.004 0.996
    ## 7799        make        copy     0   1 0.005 0.995
    ## 7800        make         hay     0   1 0.005 0.995
    ## 7801        make      sister     0   1 0.005 0.995
    ## 7933        make         bed     0   1 0.005 0.995
    ## 7934        make       break     0   1 0.005 0.995
    ## 7935        make        tail     0   1 0.005 0.995
    ## 8035        make       shirt     0   1 0.005 0.995
    ## 8151        make      cookie     0   1 0.005 0.995
    ## 8270        make       salad     0   1 0.006 0.994
    ## 8417        make        hair     0   1 0.006 0.994
    ## 8493       build           h     0   1 0.007 0.993
    ## 8588        make       stone     0   1 0.007 0.993
    ## 8937       build         way     0   1 0.008 0.992
    ## 9294        make    tomorrow     0   1 0.009 0.991
    ## 9622       build      people     0   1 0.011 0.989
    ## 9792        make        case     0   1 0.012 0.988
    ## 9793        make      dinner     0   1 0.012 0.988
    ## 10121       make         dad     0   1 0.014 0.986
    ## 10411      build       thing     0   1 0.016 0.984
    ## 10816       make        food     0   1 0.019 0.981
    ## 11310       make       today     0   1 0.025 0.975
    ## 11605       make       night     0   1 0.028 0.972
    ## 11771       make       money     0   1 0.030 0.970
    ## 11910       make         man     0   1 0.032 0.968
    ## 12744       make           h     0   1 0.047 0.953
    ## 13825       make      people     0   1 0.079 0.921
    ## 14481       make        time     0   1 0.118 0.882

    ##    [1] "\177"             "_lays"            "_size"           
    ##    [4] "!DR"              "'s"               "&"               
    ##    [7] "#"                "#Williams"        "a"               
    ##   [10] "a_"               "aa"               "abandon"         
    ##   [13] "abide"            "able"             "abortion"        
    ##   [16] "about"            "above"            "absoluteness"    
    ##   [19] "absorb"           "abuse"            "acadamy"         
    ##   [22] "Acapulco"         "accept"           "acceptable"      
    ##   [25] "access"           "accomplish"       "account"         
    ##   [28] "acculturate"      "ace"              "acknowledge"     
    ##   [31] "acquire"          "acre"             "act"             
    ##   [34] "action"           "actualize"        "ad"              
    ##   [37] "add"              "addict"           "addiction"       
    ##   [40] "addition"         "address"          "adequate"        
    ##   [43] "adjust"           "Adjust"           "adjustment"      
    ##   [46] "admire"           "admit"            "adopt"           
    ##   [49] "adult"            "advanc"           "advance"         
    ##   [52] "advantage"        "affect"           "affection"       
    ##   [55] "afford"           "AFL_CIO"          "afraid"          
    ##   [58] "after"            "afterwards"       "ag"              
    ##   [61] "age"              "agencie"          "agency"          
    ##   [64] "agent"            "aggressive"       "ago"             
    ##   [67] "agree"            "agreement"        "Agriculture"     
    ##   [70] "ahead"            "aich"             "aid"             
    ##   [73] "aids"             "aikido"           "aikidue"         
    ##   [76] "aint"             "air"              "aircondition"    
    ##   [79] "aircraft"         "airplane"         "al"              
    ##   [82] "alarm"            "ale"              "alive"           
    ##   [85] "all"              "alla"             "allegory"        
    ##   [88] "allocate"         "allow"            "alright"         
    ##   [91] "alternative"      "amateurs"         "amaze"           
    ##   [94] "ambiguous"        "amidst"           "amount"          
    ##   [97] "amp"              "analysis"         "and"             
    ##  [100] "angle"            "animal"           "Annette"         
    ##  [103] "announce"         "anoint"           "another"         
    ##  [106] "answer"           "answering"        "anthropomorphic" 
    ##  [109] "antiquate"        "any"              "anybody"         
    ##  [112] "anything"         "anytime"          "anywhere"        
    ##  [115] "apartment"        "aperture"         "apiece"          
    ##  [118] "apologize"        "Appaloosa"        "apparently"      
    ##  [121] "appear"           "appearance"       "apple"           
    ##  [124] "application"      "apply"            "appointment"     
    ##  [127] "appraisal"        "appreciate"       "appreciation"    
    ##  [130] "approach"         "approve"          "April"           
    ##  [133] "Aq"               "archway"          "area"            
    ##  [136] "argue"            "argument"         "arm"             
    ##  [139] "around"           "arrange"          "arrangement"     
    ##  [142] "arrive"           "arrugado"         "art"             
    ##  [145] "Art"              "article"          "artist"          
    ##  [148] "as"               "ash"              "ask"             
    ##  [151] "asleep"           "aspect"           "ass"             
    ##  [154] "assault"          "assertiveness"    "asset"           
    ##  [157] "assign"           "assignment"       "assist"          
    ##  [160] "assistant"        "associate"        "association"     
    ##  [163] "assume"           "assurance"        "asthma"          
    ##  [166] "ate"              "attach"           "attack"          
    ##  [169] "attaining"        "attend"           "attitude"        
    ##  [172] "attorney"         "attra"            "attract"         
    ##  [175] "attraction"       "attribute"        "auburn"          
    ##  [178] "aunt"             "author"           "authority"       
    ##  [181] "available"        "avoid"            "awaken"          
    ##  [184] "award"            "aware"            "away"            
    ##  [187] "awful"            "awoked"           "aye"             
    ##  [190] "b"                "B"                "babe"            
    ##  [193] "baby"             "back"             "backbone"        
    ##  [196] "backward"         "bacteria"         "bad"             
    ##  [199] "bag"              "baggage"          "bake"            
    ##  [202] "baking"           "bal"              "balance"         
    ##  [205] "bale"             "ball"             "balloon"         
    ##  [208] "band"             "bandage"          "bang"            
    ##  [211] "bank"             "banker"           "bar"             
    ##  [214] "barely"           "barn"             "base"            
    ##  [217] "baseball"         "basic"            "basically"       
    ##  [220] "basis"            "bastion"          "batch"           
    ##  [223] "bath"             "bathroom"         "batidor"         
    ##  [226] "batter"           "bay"              "be"              
    ##  [229] "beacon"           "bead"             "bean"            
    ##  [232] "bear"             "beat"             "beate"           
    ##  [235] "beaten"           "beatup"           "beautiful"       
    ##  [238] "because"          "become"           "bed"             
    ##  [241] "bedroom"          "beer"             "before"          
    ##  [244] "beforehand"       "beg"              "begin"           
    ##  [247] "beginning"        "behave"           "behavior"        
    ##  [250] "Belgian"          "believe"          "belly"           
    ##  [253] "belong"           "below"            "bend"            
    ##  [256] "benefin"          "benefit"          "bent"            
    ##  [259] "Benton"           "best"             "better"          
    ##  [262] "Betty"            "bid"              "big"             
    ##  [265] "bigger"           "bill"             "Bill"            
    ##  [268] "billion"          "billions"         "Billy"           
    ##  [271] "bin"              "bind"             "bing"            
    ##  [274] "bit"              "bitch"            "bite"            
    ##  [277] "bitter"           "black"            "blame"           
    ##  [280] "blanket"          "blar"             "blast"           
    ##  [283] "bleed"            "blend"            "bless"           
    ##  [286] "blind"            "blob"             "block"           
    ##  [289] "blood"            "blow"             "blowing"         
    ##  [292] "blowjob"          "blue"             "board"           
    ##  [295] "body"             "boil"             "boilerplate"     
    ##  [298] "bolt"             "bomb"             "bombard"         
    ##  [301] "bombardment"      "bond"             "bone"            
    ##  [304] "book"             "Book"             "boonks"          
    ##  [307] "boot"             "borrow"           "borrowed"        
    ##  [310] "Boston"           "both"             "bother"          
    ##  [313] "bottle"           "bottom"           "bouillon"        
    ##  [316] "bounce"           "bowl"             "bowle"           
    ##  [319] "box"              "boy"              "Boy"             
    ##  [322] "BR"               "brace"            "bracket"         
    ##  [325] "Brady"            "brain"            "branch"          
    ##  [328] "brand"            "brat"             "bread"           
    ##  [331] "break"            "breakfast"        "breath"          
    ##  [334] "breathe"          "breed"            "breeze"          
    ##  [337] "brekfast"         "brick"            "bride"           
    ##  [340] "bridge"           "bridle"           "bright"          
    ##  [343] "bring"            "brink"            "bro"             
    ##  [346] "broadcast"        "Broiling"         "broke"           
    ##  [349] "broken"           "broker"           "brood"           
    ##  [352] "brotch"           "brother"          "bruise"          
    ##  [355] "bruising"         "bry"              "bubble"          
    ##  [358] "buck"             "bucketload"       "buckets"         
    ##  [361] "bucks"            "budget"           "bug"             
    ##  [364] "build"            "building"         "bulk"            
    ##  [367] "bull"             "bully"            "bump"            
    ##  [370] "bunch"            "burden"           "bureaucracy"     
    ##  [373] "burgundy"         "burn"             "burnt"           
    ##  [376] "burst"            "bury"             "Bush"            
    ##  [379] "business"         "bust"             "busy"            
    ##  [382] "but"              "Bute"             "butt"            
    ##  [385] "butter"           "butterball"       "button"          
    ##  [388] "buy"              "buyer"            "by"              
    ##  [391] "c"                "cabinet"          "cable"           
    ##  [394] "cacciatore"       "cake"             "calendar"        
    ##  [397] "call"             "calm"             "calory"          
    ##  [400] "Calory"           "camp"             "can"             
    ##  [403] "canal"            "cancel"           "candy"           
    ##  [406] "cane"             "cant"             "capability"      
    ##  [409] "capable"          "cape"             "capsule"         
    ##  [412] "captain"          "car"              "Caravan"         
    ##  [415] "carbonate"        "card"             "care"            
    ##  [418] "career"           "careful"          "caring"          
    ##  [421] "carne"            "carpenter"        "carry"           
    ##  [424] "cars"             "cart"             "cartoon"         
    ##  [427] "carve"            "carwash"          "case"            
    ##  [430] "Casement"         "cassette"         "cast"            
    ##  [433] "Castle"           "castration"       "casualty"        
    ##  [436] "cat"              "catalog"          "catch"           
    ##  [439] "category"         "Cathlene"         "Catholic"        
    ##  [442] "cattle"           "cause"            "cd"              
    ##  [445] "CD"               "ceiling"          "cello"           
    ##  [448] "cello_"           "cent"             "Centennial"      
    ##  [451] "center"           "certainly"        "ch"              
    ##  [454] "chair"            "chairperson"      "champion"        
    ##  [457] "championship"     "chance"           "change"          
    ##  [460] "character"        "characteristic"   "characters"      
    ##  [463] "charge"           "chart"            "chase"           
    ##  [466] "cheap"            "cheaper"          "check"           
    ##  [469] "checkbook"        "chef"             "chemical"        
    ##  [472] "chest"            "chestnut"         "chew"            
    ##  [475] "chick"            "chicken"          "child"           
    ##  [478] "chile"            "chili"            "chilis"          
    ##  [481] "chill"            "chinese"          "chip"            
    ##  [484] "chock"            "chockfull"        "chocolate"       
    ##  [487] "chocos"           "choice"           "choke"           
    ##  [490] "choose"           "chose"            "chowder"         
    ##  [493] "Chris"            "christmas"        "Christmas"       
    ##  [496] "church"           "circle"           "circuit"         
    ##  [499] "circulate"        "circus"           "citizen"         
    ##  [502] "city"             "claim"            "Clap"            
    ##  [505] "clash"            "class"            "classic"         
    ##  [508] "classify"         "clean"            "cleaner"         
    ##  [511] "clear"            "cleft"            "click"           
    ##  [514] "client"           "climb"            "climbing"        
    ##  [517] "clinic"           "Clinton"          "clip"            
    ##  [520] "clipping"         "clo"              "clod"            
    ##  [523] "close"            "closer"           "clothes"         
    ##  [526] "clown"            "club"             "clubhouse"       
    ##  [529] "coals"            "coat"             "cocke"           
    ##  [532] "cocktail"         "cod"              "code"            
    ##  [535] "coexist"          "coffeemaker"      "cold"            
    ##  [538] "collect"          "collection"       "collective"      
    ##  [541] "collector"        "college"          "cologne"         
    ##  [544] "colony"           "color"            "Color"           
    ##  [547] "Colorado"         "colore"           "column"          
    ##  [550] "combatant"        "Combin"           "combine"         
    ##  [553] "come"             "Comely"           "comfortable"     
    ##  [556] "command"          "commend"          "comment"         
    ##  [559] "commentary"       "commit"           "commitment"      
    ##  [562] "committ"          "committee"        "communication"   
    ##  [565] "communion"        "community"        "company"         
    ##  [568] "compare"          "compensate"       "compensation"    
    ##  [571] "competitive"      "complain"         "complaint"       
    ##  [574] "complete"         "completion"       "complex"         
    ##  [577] "complicated"      "compost"          "con"             
    ##  [580] "concept"          "concern"          "concerned"       
    ##  [583] "concisely"        "conclude"         "concrete"        
    ##  [586] "Condense"         "condition"        "conditioner"     
    ##  [589] "conditioning"     "condom"           "conduct"         
    ##  [592] "conference"       "confirm"          "conflict"        
    ##  [595] "confront"         "confused"         "connect"         
    ##  [598] "connection"       "conquer"          "consensus"       
    ##  [601] "consent"          "conserve"         "consider"        
    ##  [604] "consist"          "consoloation"     "constraint"      
    ##  [607] "consultant"       "consume"          "contact"         
    ##  [610] "contain"          "container"        "Contaminat"      
    ##  [613] "continue"         "continuity"       "contract"        
    ##  [616] "contrary"         "contribute"       "contribution"    
    ##  [619] "contributors"     "control"          "controller"      
    ##  [622] "conversation"     "convert"          "convince"        
    ##  [625] "cook"             "cookie"           "cool"            
    ##  [628] "cooler"           "coop"             "cooperation"     
    ##  [631] "coordinate"       "coordinating"     "copy"            
    ##  [634] "corner"           "corps"            "correct"         
    ##  [637] "corresponds"      "corrupt"          "corsage"         
    ##  [640] "cost"             "cotton"           "couch"           
    ##  [643] "could"            "council"          "count"           
    ##  [646] "counter"          "country"          "couple"          
    ##  [649] "course"           "court"            "cousin"          
    ##  [652] "cover"            "coverage"         "covering"        
    ##  [655] "cow"              "coyote"           "crack"           
    ##  [658] "cradle"           "craft"            "cramp"           
    ##  [661] "cranberry"        "crank"            "crap"            
    ##  [664] "crashe"           "crave"            "crawl"           
    ##  [667] "crazy"            "cre"              "cream"           
    ##  [670] "create"           "credit"           "Crip"            
    ##  [673] "cripple"          "crippling"        "criterion"       
    ##  [676] "crock"            "cross"            "crotch"          
    ##  [679] "crouch"           "crow"             "crowd"           
    ##  [682] "crown"            "crumb"            "crumble"         
    ##  [685] "crust"            "cry"              "CT"              
    ##  [688] "cuajarone"        "cub"              "cuddle"          
    ##  [691] "cuffs"            "cup"              "curb"            
    ##  [694] "curiious"         "curl"             "current"         
    ##  [697] "curse"            "curve"            "customer"        
    ##  [700] "custommade"       "cut"              "cute"            
    ##  [703] "cutie"            "cutting"          "cycle"           
    ##  [706] "d"                "dad"              "dadada"          
    ##  [709] "dadadum"          "daddy"            "daiquiri"        
    ##  [712] "dam"              "damage"           "dampen"          
    ##  [715] "dance"            "dancer"           "dancing"         
    ##  [718] "dangerous"        "Danish"           "dare"            
    ##  [721] "Darlene"          "database"         "date"            
    ##  [724] "daughter"         "day"              "de"              
    ##  [727] "dead"             "deal"             "dealer"          
    ##  [730] "dear"             "death"            "Debby"           
    ##  [733] "debt"             "decade"           "decease"         
    ##  [736] "decide"           "decision"         "deck"            
    ##  [739] "decline"          "decorate"         "dedicate"        
    ##  [742] "dedicated"        "deduct"           "deduction"       
    ##  [745] "deed"             "deep"             "deeper"          
    ##  [748] "defeat"           "define"           "definition"      
    ##  [751] "degree"           "degrees"          "del"             
    ##  [754] "deliver"          "demand"           "democracy"       
    ##  [757] "demon"            "demonstrate"      "denial"          
    ##  [760] "denom"            "denominator"      "depart"          
    ##  [763] "department"       "departure"        "depend"          
    ##  [766] "deposit"          "deposits"         "depraved"        
    ##  [769] "depresse"         "deprive"          "Derby"           
    ##  [772] "Descend"          "descent"          "describe"        
    ##  [775] "description"      "desert"           "desig"           
    ##  [778] "design"           "designate"        "designs"         
    ##  [781] "destroy"          "destructive"      "deterioration"   
    ##  [784] "determi"          "determine"        "detrimental"     
    ##  [787] "devastate"        "develop"          "developer"       
    ##  [790] "development"      "device"           "devise"          
    ##  [793] "diabete"          "diagram"          "dial"            
    ##  [796] "diameter"         "Diane"            "diatribe"        
    ##  [799] "dicker"           "die"              "dif"             
    ##  [802] "difference"       "different"        "differential"    
    ##  [805] "difficult"        "digest"           "digge"           
    ##  [808] "dignity"          "Dillards"         "dinner"          
    ##  [811] "dip"              "direct"           "direction"       
    ##  [814] "dirty"            "disagree"         "disagreement"    
    ##  [817] "disappear"        "disappointment"   "discard"         
    ##  [820] "discharge"        "discoloration"    "discover"        
    ##  [823] "discovery"        "discuss"          "discussion"      
    ##  [826] "disease"          "disgust"          "dishwasher"      
    ##  [829] "disinterested"    "Dislodge"         "dispense"        
    ##  [832] "dispute"          "dissolve"         "distance"        
    ##  [835] "distant"          "distinction"      "distinctive"     
    ##  [838] "distribute"       "district"         "disturb"         
    ##  [841] "dive"             "divert"           "divide"          
    ##  [844] "Divide"           "do"               "doctor"          
    ##  [847] "Doctor"           "doctrine"         "document"        
    ##  [850] "dodge"            "dog"              "dogcatcher"      
    ##  [853] "dogma"            "dollar"           "dollars"         
    ##  [856] "dolphing"         "donate"           "done"            
    ##  [859] "door"             "dope"             "Dork"            
    ##  [862] "dose"             "doubt"            "Doug"            
    ##  [865] "dovetail"         "down"             "downs"           
    ##  [868] "downstairs"       "dozen"            "draft"           
    ##  [871] "drag"             "Drank"            "draw"            
    ##  [874] "dream"            "dress"            "dressing"        
    ##  [877] "drill"            "drink"            "drip"            
    ##  [880] "dripp"            "drive"            "driver"          
    ##  [883] "drop"             "drug"             "dry"             
    ##  [886] "dubbing"          "duck"             "duct"            
    ##  [889] "ducting"          "ducts"            "due"             
    ##  [892] "dug"              "dumb"             "dump"            
    ##  [895] "duty"             "dwell"            "e"               
    ##  [898] "ea"               "each"             "ear"             
    ##  [901] "earlier"          "early"            "earn"            
    ##  [904] "earning"          "earthquake"       "easier"          
    ##  [907] "easily"           "easy"             "eat"             
    ##  [910] "echo"             "Ecstasy"          "Ed"              
    ##  [913] "edge"             "edit"             "educate"         
    ##  [916] "education"        "effect"           "effective"       
    ##  [919] "efficiency"       "effort"           "egg"             
    ##  [922] "eh"               "eight"            "eighty"          
    ##  [925] "eightyeight"      "eightyfour"       "Einstein"        
    ##  [928] "either"           "el"               "elbow"           
    ##  [931] "ele"              "elect"            "electric"        
    ##  [934] "electrical"       "electronics"      "eleven"          
    ##  [937] "elevenhundr"      "Elevenhundr"      "elevenyearold"   
    ##  [940] "Elgin"            "eliminate"        "else"            
    ##  [943] "em"               "email"            "embarrassed"     
    ##  [946] "emotion"          "emphasis"         "empire"          
    ##  [949] "employ"           "employee"         "empower"         
    ##  [952] "empowerment"      "empty"            "enable"          
    ##  [955] "end"              "energy"           "engage"          
    ##  [958] "engine"           "engineer"         "England"         
    ##  [961] "English"          "enjoy"            "enough"          
    ##  [964] "enter"            "entertainment"    "entitle"         
    ##  [967] "entity"           "entourage"        "entries"         
    ##  [970] "environment"      "envy"             "enzyme"          
    ##  [973] "episode"          "equal"            "equals"          
    ##  [976] "equipment"        "era"              "Erasmus"         
    ##  [979] "escapade"         "escape"           "especially"      
    ##  [982] "establish"        "estate"           "estimate"        
    ##  [985] "esto"             "estoy"            "evaluate"        
    ##  [988] "evening"          "event"            "everybody"       
    ##  [991] "everyone"         "everything"       "everywhere"      
    ##  [994] "evidences"        "ew"               "ex"              
    ##  [997] "examine"          "example"          "exasperat"       
    ## [1000] "excavate"         "exceed"           "exception"       
    ## [1003] "excessive"        "exchanger"        "excited"         
    ## [1006] "excret"           "exelent"          "exhibit"         
    ## [1009] "exist"            "exit"             "expand"          
    ## [1012] "expansion"        "expect"           "expensive"       
    ## [1015] "experience"       "expert"           "explain"         
    ## [1018] "explanation"      "expose"           "express"         
    ## [1021] "Express"          "expression"       "extend"          
    ## [1024] "extension"        "extinct"          "extinction"      
    ## [1027] "eye"              "eyes"             "f"               
    ## [1030] "F"                "f_try"            "fabric"          
    ## [1033] "face"             "facility"         "fact"            
    ## [1036] "factor"           "fad"              "fag"             
    ## [1039] "fail"             "fair"             "faith"           
    ## [1042] "fall"             "fame"             "familiar"        
    ## [1045] "family"           "famous"           "fan"             
    ## [1048] "fancy"            "fantasy"          "far"             
    ## [1051] "farmer"           "farrier"          "farther"         
    ## [1054] "fascinate"        "fascination"      "fashio"          
    ## [1057] "fashion"          "fashionable"      "faster"          
    ## [1060] "fat"              "father"           "Father"          
    ## [1063] "fathers"          "fault"            "favorite"        
    ## [1066] "fax"              "Fe"               "fear"            
    ## [1069] "feather"          "feature"          "fee"             
    ## [1072] "feed"             "feeding"          "feel"            
    ## [1075] "feeling"          "fellow"           "felony"          
    ## [1078] "female"           "ferrier"          "festival"        
    ## [1081] "fever"            "fi"               "field"           
    ## [1084] "fifteen"          "fifth"            "fiftyeight"      
    ## [1087] "fiftyfour"        "fiftyone"         "fight"           
    ## [1090] "figure"           "file"             "Filet"           
    ## [1093] "fill"             "Filled"           "filling"         
    ## [1096] "film"             "filter"           "finance"         
    ## [1099] "financing"        "find"             "fine"            
    ## [1102] "finish"           "Fir"              "fire"            
    ## [1105] "fireplace"        "firm"             "first"           
    ## [1108] "fish"             "fit"              "fits"            
    ## [1111] "fitte"            "five"             "fivehundred"     
    ## [1114] "Fivehundred"      "fix"              "fixtur"          
    ## [1117] "flame"            "flar"             "flare"           
    ## [1120] "flash"            "flask"            "flat"            
    ## [1123] "flavors"          "fleck"            "flick"           
    ## [1126] "flip"             "Flng"             "float"           
    ## [1129] "floo"             "floor"            "flooring"        
    ## [1132] "floppe"           "flour"            "flow"            
    ## [1135] "fluid"            "fluidity"         "flumpitybump"    
    ## [1138] "flutter"          "fly"              "focus"           
    ## [1141] "foggy"            "fold"             "folk"            
    ## [1144] "follow"           "food"             "foot"            
    ## [1147] "football"         "for"              "forbid"          
    ## [1150] "force"            "forego"           "Forego"          
    ## [1153] "forget"           "form"             "fortyeight"      
    ## [1156] "fortyfive"        "forwards"         "fountain"        
    ## [1159] "four"             "fourteen"         "fourthgrader"    
    ## [1162] "fourtythree"      "fowl"             "Fq"              
    ## [1165] "fraction"         "frame"            "framework"       
    ## [1168] "freak"            "Fred"             "free"            
    ## [1171] "freedom"          "freestanding"     "freeze"          
    ## [1174] "frequency"        "fresh"            "Friday"          
    ## [1177] "friend"           "fro"              "from"            
    ## [1180] "front"            "Front"            "frozen"          
    ## [1183] "fruit"            "fruitcake"        "fry"             
    ## [1186] "fuck"             "fucke"            "fucking"         
    ## [1189] "fudge"            "fuel"             "fulfil"          
    ## [1192] "full"             "fulllevel"        "fumble"          
    ## [1195] "fun"              "fund"             "funny"           
    ## [1198] "funtion"          "furnace"          "fuse"            
    ## [1201] "fussy"            "future"           "futze"           
    ## [1204] "g"                "gain"             "gait"            
    ## [1207] "gal"              "Galleria"         "gallery"         
    ## [1210] "gallon"           "gallop"           "galore"          
    ## [1213] "game"             "gang"             "garage"          
    ## [1216] "garbage"          "garden"           "Garden"          
    ## [1219] "Gary"             "gas"              "gasket"          
    ## [1222] "gate"             "gather"           "gay"             
    ## [1225] "ge"               "gear"             "gee"             
    ## [1228] "gelatin"          "gelding"          "gender"          
    ## [1231] "genera"           "general"          "generate"        
    ## [1234] "generation"       "generator"        "gentleman"       
    ## [1237] "German"           "Gerry"            "get"             
    ## [1240] "gett"             "GI"               "Gibson"          
    ## [1243] "gift"             "giggle"           "girl"            
    ## [1246] "give"             "gland"            "glass"           
    ## [1249] "glop"             "glove"            "go"              
    ## [1252] "goal"             "goat"             "god"             
    ## [1255] "God"              "goldfish"         "gon"             
    ## [1258] "gone"             "gonna"            "good"            
    ## [1261] "goodlooking"      "goody"            "goof"            
    ## [1264] "goop"             "gorgeous"         "govern"          
    ## [1267] "grab"             "grace"            "grad"            
    ## [1270] "grade"            "graduate"         "graduation"      
    ## [1273] "gram"             "grandma"          "grant"           
    ## [1276] "grass"            "grasshopper"      "grassroot"       
    ## [1279] "grassy"           "grate"            "grateful"        
    ## [1282] "gravity"          "great"            "greater"         
    ## [1285] "Greg"             "grievance"        "grill"           
    ## [1288] "grind"            "grip"             "gross"           
    ## [1291] "ground"           "grounde"          "Grounde"         
    ## [1294] "group"            "grow"             "grumpy"          
    ## [1297] "guard"            "guess"            "guide"           
    ## [1300] "guideline"        "guil"             "guilt"           
    ## [1303] "guilty"           "gum"              "gun"             
    ## [1306] "guy"              "h"                "Habits"          
    ## [1309] "haggle"           "hair"             "half"            
    ## [1312] "hall"             "Hall"             "hand"            
    ## [1315] "handful"          "handicap"         "handle"          
    ## [1318] "handoff"          "hang"             "hangings"        
    ## [1321] "hanks"            "haove"            "happen"          
    ## [1324] "happene"          "happy"            "hard"            
    ## [1327] "harden"           "harder"           "HarleyDavidson"  
    ## [1330] "hat"              "hatch"            "hate"            
    ## [1333] "haul"             "have"             "hay"             
    ## [1336] "hazard"           "he"               "head"            
    ## [1339] "heading"          "heal"             "heale"           
    ## [1342] "healthy"          "hear"             "heart"           
    ## [1345] "heat"             "heater"           "heating"         
    ## [1348] "heaven"           "heavy"            "heck"            
    ## [1351] "heckle"           "heel"             "height"          
    ## [1354] "Helen"            "helicopter"       "heliport"        
    ## [1357] "hell"             "Hell"             "help"            
    ## [1360] "herb"             "herd"             "herde"           
    ## [1363] "herder"           "here"             "heroine"         
    ## [1366] "herself"          "hi"               "Hi"              
    ## [1369] "Hia"              "hide"             "high"            
    ## [1372] "higher"           "highest"          "highlight"       
    ## [1375] "highpoint"        "highway"          "hill"            
    ## [1378] "himself"          "hint"             "hip"             
    ## [1381] "hire"             "hiss"             "historian"       
    ## [1384] "history"          "hit"              "HIVOX"           
    ## [1387] "hm"               "Ho"               "hobble"          
    ## [1390] "Hobhouse"         "hold"             "holdings"        
    ## [1393] "hole"             "hom"              "home"            
    ## [1396] "homework"         "homosexual"       "honey"           
    ## [1399] "hoof"             "hook"             "hooker"          
    ## [1402] "hoove"            "hop"              "hope"            
    ## [1405] "hopp"             "horizon"          "hormone"         
    ## [1408] "horse"            "horsehoove"       "hospital"        
    ## [1411] "hot"              "hotel"            "hotter"          
    ## [1414] "hour"             "house"            "household"       
    ## [1417] "housing"          "how"              "hug"             
    ## [1420] "humor"            "hundr"            "hundred"         
    ## [1423] "hung"             "hunk"             "hunt"            
    ## [1426] "hunting"          "hurrie"           "hurry"           
    ## [1429] "hurt"             "hurte"            "hurts"           
    ## [1432] "husband"          "hustl"            "hustle"          
    ## [1435] "Hx"               "hydrate"          "hymn"            
    ## [1438] "I"                "ice"              "id"              
    ## [1441] "idea"             "ideal"            "identify"        
    ## [1444] "idiot"            "idolize"          "ignore"          
    ## [1447] "ille"             "illusion"         "imagine"         
    ## [1450] "impact"           "imperative"       "Imperator"       
    ## [1453] "impersonal"       "impervious"       "implement"       
    ## [1456] "implementing"     "imply"            "importance"      
    ## [1459] "important"        "impos"            "impossible"      
    ## [1462] "impound"          "impractical"      "impression"      
    ## [1465] "improve"          "improveament"     "improvement"     
    ## [1468] "impute"           "in"               "inche"           
    ## [1471] "incident"         "include"          "income"          
    ## [1474] "increase"         "incredible"       "incubation"      
    ## [1477] "inculcat"         "independent"      "Indiana"         
    ## [1480] "indicate"         "induce"           "induct"          
    ## [1483] "industry"         "infantry"         "infection"       
    ## [1486] "infiltration"     "influence"        "information"     
    ## [1489] "infusion"         "ingredient"       "initiation"      
    ## [1492] "injection"        "injur"            "injury"          
    ## [1495] "Inmate"           "inquiry"          "insane"          
    ## [1498] "inside"           "inspection"       "inspector"       
    ## [1501] "inspecttor"       "install"          "instance"        
    ## [1504] "instead"          "instep"           "instructor"      
    ## [1507] "instrument"       "insulate"         "insulation"      
    ## [1510] "insulator"        "insurance"        "integrate"       
    ## [1513] "intellectual"     "intend"           "interact"        
    ## [1516] "interest"         "interested"       "interesting"     
    ## [1519] "interfere"        "intermix"         "international"   
    ## [1522] "interpretation"   "interrupt"        "interruption"    
    ## [1525] "Intervarsity"     "interview"        "intimidate"      
    ## [1528] "into"             "introduce"        "introduction"    
    ## [1531] "invent"           "invest"           "investigate"     
    ## [1534] "investment"       "invince"          "invite"          
    ## [1537] "involve"          "involved"         "Iowa"            
    ## [1540] "irrespective"     "issue"            "it"              
    ## [1543] "item"             "its"              "itself"          
    ## [1546] "jack"             "jacket"           "Jackie"          
    ## [1549] "jag"              "jail"             "jam"             
    ## [1552] "Jamie"            "jaw"              "jealous"         
    ## [1555] "Jenn"             "Jenny"            "jerk"            
    ## [1558] "Jerrod"           "Jesus"            "jet"             
    ## [1561] "jigo"             "job"              "jockeying"       
    ## [1564] "John"             "join"             "joint"           
    ## [1567] "Jonathan"         "joy"              "judge"           
    ## [1570] "judgment"         "judgmental"       "judo"            
    ## [1573] "juice"            "July"             "jump"            
    ## [1576] "jumper"           "jumping"          "June"            
    ## [1579] "junior"           "junk"             "just"            
    ## [1582] "justifies"        "juveniles"        "k"               
    ## [1585] "Karo"             "ke"               "kebab"           
    ## [1588] "keep"             "Kendie"           "Kendra"          
    ## [1591] "Kentucky"         "Kevin"            "key"             
    ## [1594] "kick"             "kid"              "kidney"          
    ## [1597] "kill"             "killer"           "kind"            
    ## [1600] "kinda"            "kinday"           "kindergarten"    
    ## [1603] "king"             "kingdom"          "kiss"            
    ## [1606] "kitchen"          "Kitchen"          "knee"            
    ## [1609] "knife"            "knock"            "knot"            
    ## [1612] "know"             "knowingly"        "knowledge"       
    ## [1615] "l"                "L"                "la"              
    ## [1618] "lab"              "labor"            "Labor"           
    ## [1621] "labore"           "laborer"          "lack"            
    ## [1624] "ladder"           "lady"             "Lady"            
    ## [1627] "lake"             "lambada"          "lame"            
    ## [1630] "Lance"            "land"             "lane"            
    ## [1633] "large"            "last"             "late"            
    ## [1636] "later"            "laugh"            "launch"          
    ## [1639] "Laura"            "Lauren"           "lay"             
    ## [1642] "layer"            "Lcl"              "LCL"             
    ## [1645] "Le"               "lead"             "Leah"            
    ## [1648] "leak"             "leakage"          "leap"            
    ## [1651] "leaping"          "learn"            "lease"           
    ## [1654] "least"            "leave"            "lectur"          
    ## [1657] "ledge"            "leg"              "legend"          
    ## [1660] "legion"           "legislation"      "lemon"           
    ## [1663] "length"           "LeRoy"            "less"            
    ## [1666] "lessen"           "lesson"           "let"             
    ## [1669] "letter"           "Lettie"           "lettuce"         
    ## [1672] "lev"              "level"            "levele"          
    ## [1675] "lewd"             "Li"               "license"         
    ## [1678] "lick"             "lie"              "life"            
    ## [1681] "lifestyle"        "lift"             "ligament"        
    ## [1684] "light"            "like"             "limit"           
    ## [1687] "limitation"       "line"             "linguistic"      
    ## [1690] "link"             "liquid"           "Lisa"            
    ## [1693] "list"             "listen"           "lit"             
    ## [1696] "literature"       "little"           "liv"             
    ## [1699] "live"             "liver"            "livestock"       
    ## [1702] "living"           "load"             "loaf"            
    ## [1705] "loan"             "loave"            "local"           
    ## [1708] "Locat"            "lock"             "lonesome"        
    ## [1711] "long"             "longer"           "look"            
    ## [1714] "Lord"             "los"              "lose"            
    ## [1717] "loss"             "lot"              "love"            
    ## [1720] "lovers"           "low"              "lower"           
    ## [1723] "lucky"            "lucrative"        "Lug"             
    ## [1726] "lunch"            "lure"             "LVOX"            
    ## [1729] "m"                "ma"               "Ma"              
    ## [1732] "machine"          "Madeline"         "magnifying"      
    ## [1735] "mail"             "maintain"         "maintainance"    
    ## [1738] "maintenance"      "major"            "majority"        
    ## [1741] "make"             "makeup"           "making"          
    ## [1744] "malaise"          "malfunction"      "mall"            
    ## [1747] "man"              "manage"           "management"      
    ## [1750] "manager"          "mandatory"        "mango"           
    ## [1753] "manifest"         "manifestation"    "mankind"         
    ## [1756] "manure"           "many"             "map"             
    ## [1759] "march"            "mare"             "marine"          
    ## [1762] "mark"             "Mark"             "market"          
    ## [1765] "marketing"        "marry"            "masa"            
    ## [1768] "masculine"        "master"           "mat"             
    ## [1771] "match"            "mate"             "material"        
    ## [1774] "mathematic"       "mathematics"      "Matt"            
    ## [1777] "matter"           "may"              "May"             
    ## [1780] "mayate"           "meal"             "mean"            
    ## [1783] "meaning"          "meaningful"       "measure"         
    ## [1786] "measurement"      "meat"             "meditate"        
    ## [1789] "meet"             "meeting"          "Melissa"         
    ## [1792] "mellower"         "melt"             "member"          
    ## [1795] "memorandum"       "memory"           "mention"         
    ## [1798] "mesmerize"        "mess"             "metabolize"      
    ## [1801] "method"           "Mexico"           "mhm"             
    ## [1804] "mic"              "Michael"          "Michigan"        
    ## [1807] "microphone"       "microscope"       "middle"          
    ## [1810] "Mike"             "mile"             "military"        
    ## [1813] "milk"             "million"          "mind"            
    ## [1816] "mine"             "mingle"           "minimal"         
    ## [1819] "minimum"          "minister"         "mint"            
    ## [1822] "minus"            "minute"           "miserable"       
    ## [1825] "miss"             "missing"          "mission"         
    ## [1828] "mister"           "misuse"           "mix"             
    ## [1831] "mixer"            "mixing"           "mixture"         
    ## [1834] "mm"               "mobile"           "mobilize"        
    ## [1837] "mode"             "model"            "modify"          
    ## [1840] "moisture"         "molecule"         "molest"          
    ## [1843] "molt"             "mom"              "Mom"             
    ## [1846] "mommy"            "money"            "monitor"         
    ## [1849] "monster"          "month"            "moratorium"      
    ## [1852] "more"             "morning"          "mortgage"        
    ## [1855] "mortify"          "most"             "moth"            
    ## [1858] "mother"           "motion"           "motivation"      
    ## [1861] "motor"            "mount"            "mousse"          
    ## [1864] "mouth"            "move"             "movement"        
    ## [1867] "movie"            "mow"              "Mrc"             
    ## [1870] "MRC"              "Mrcread"          "Msg"             
    ## [1873] "much"             "Multiplies"       "multiply"        
    ## [1876] "muscle"           "museum"           "music"           
    ## [1879] "musician"         "mustache"         "mustard"         
    ## [1882] "muster"           "muumuu"           "my"              
    ## [1885] "mystery"          "mystic"           "nag"             
    ## [1888] "nail"             "name"             "nap"             
    ## [1891] "nation"           "nature"           "navy"            
    ## [1894] "nebulous"         "necessary"        "necessity"       
    ## [1897] "need"             "needle"           "neighbor"        
    ## [1900] "Neil"             "nephew"           "nervous"         
    ## [1903] "nest"             "networking"       "new"             
    ## [1906] "news"             "newspaper"        "next"            
    ## [1909] "Nicaragua"        "nice"             "nicer"           
    ## [1912] "Nierman"          "night"            "nine"            
    ## [1915] "Ninehundr"        "ninehundred"      "nineteen"        
    ## [1918] "nineteen_seventy" "Ninetenth"        "ninetyeight"     
    ## [1921] "nitrogen"         "no"               "nobody"          
    ## [1924] "nod"              "nodd"             "noise"           
    ## [1927] "noisy"            "none"             "Nonsense"        
    ## [1930] "normal"           "nose"             "not"             
    ## [1933] "note"             "nothing"          "notice"          
    ## [1936] "notion"           "notions"          "Notwithstand"    
    ## [1939] "novel"            "novelty"          "now"             
    ## [1942] "Now"              "number"           "Number"          
    ## [1945] "numbers"          "nurse"            "nut"             
    ## [1948] "o'clock"          "oasis"            "obedience"       
    ## [1951] "obey"             "object"           "obligations"     
    ## [1954] "observance"       "observe"          "Observe"         
    ## [1957] "obvious"          "occasion"         "October"         
    ## [1960] "odd"              "of"               "off"             
    ## [1963] "offer"            "office"           "officer"         
    ## [1966] "oh"               "oil"              "okay"            
    ## [1969] "old"              "older"            "Olympic"         
    ## [1972] "on"               "once"             "one"             
    ## [1975] "onehalf"          "onehundr"         "only"            
    ## [1978] "ontrol"           "Oodle"            "open"            
    ## [1981] "opening"          "opera"            "operate"         
    ## [1984] "operator"         "opinion"          "opinionate"      
    ## [1987] "opponent"         "opposite"         "or"              
    ## [1990] "order"            "oregano"          "organiza"        
    ## [1993] "organization"     "organizations"    "organize"        
    ## [1996] "organized"        "origin"           "original"        
    ## [1999] "originate"        "ornament"         "ornery"          
    ## [2002] "oth"              "other"            "otherwise"       
    ## [2005] "otter"            "ounce"            "ourselves"       
    ## [2008] "out"              "outfin"           "outfit"          
    ## [2011] "Outsi"            "outside"          "over"            
    ## [2014] "overcome"         "overflow"         "overheat"        
    ## [2017] "overlook"         "overthrow"        "overtop"         
    ## [2020] "overtops"         "overwhelm"        "ow"              
    ## [2023] "owe"              "owed"             "own"             
    ## [2026] "p"                "p_so"             "pa"              
    ## [2029] "pace"             "pacify"           "pack"            
    ## [2032] "package"          "pad"              "paddock"         
    ## [2035] "pain"             "paint"            "painting"        
    ## [2038] "pair"             "pajama"           "pan"             
    ## [2041] "pane"             "panel"            "pans"            
    ## [2044] "pants"            "paper"            "paperwork"       
    ## [2047] "paprika"          "par"              "parallel"        
    ## [2050] "paralyze"         "parent"           "park"            
    ## [2053] "parking"          "Parks"            "part"            
    ## [2056] "participate"      "participation"    "party"           
    ## [2059] "pass"             "passage"          "passion"         
    ## [2062] "passionate"       "past"             "pasta"           
    ## [2065] "pasture"          "pat"              "path"            
    ## [2068] "patient"          "patterns"         "Paul"            
    ## [2071] "pay"              "paycheck"         "payment"         
    ## [2074] "peace"            "peanut"           "peek"            
    ## [2077] "peg"              "Peg"              "penalize"        
    ## [2080] "penalty"          "penguin"          "penny"           
    ## [2083] "penstock"         "Pentagon"         "people"          
    ## [2086] "pepper"           "pepperoni"        "perceive"        
    ## [2089] "percent"          "percentage"       "perfect"         
    ## [2092] "perform"          "perfume"          "period"          
    ## [2095] "permit"           "pero"             "perpendicular"   
    ## [2098] "person"           "personality"      "perspective"     
    ## [2101] "perspire"         "pesticide"        "phase"           
    ## [2104] "phenomenon"       "philosophy"       "phone"           
    ## [2107] "pi"               "pick"             "picking"         
    ## [2110] "picture"          "pie"              "piece"           
    ## [2113] "pile"             "pill"             "pilot"           
    ## [2116] "pin"              "pipe"             "piss"            
    ## [2119] "pistachio"        "Pittsburgh"       "pizza"           
    ## [2122] "place"            "plan"             "plane"           
    ## [2125] "planning"         "plant"            "plantation"      
    ## [2128] "planter"          "plate"            "platform"        
    ## [2131] "play"             "playback"         "player"          
    ## [2134] "plead"            "pleasant"         "pleasure"        
    ## [2137] "plenty"           "plenum"           "plug"            
    ## [2140] "plugge"           "plumb"            "plus"            
    ## [2143] "point"            "pok"              "pole"            
    ## [2146] "policy"           "polite"           "politics"        
    ## [2149] "pollution"        "Polly"            "poner"           
    ## [2152] "poof"             "pool"             "poop"            
    ## [2155] "pop"              "popular"          "population"      
    ## [2158] "porous"           "porque"           "portion"         
    ## [2161] "position"         "positive"         "possess"         
    ## [2164] "possession"       "possibility"      "post"            
    ## [2167] "poster"           "posters"          "postpone"        
    ## [2170] "pot"              "potential"        "pottery"         
    ## [2173] "pound"            "Pound"            "Pounding"        
    ## [2176] "pour"             "poured"           "powder"          
    ## [2179] "power"            "powerful"         "practice"        
    ## [2182] "praise"           "Praline"          "pray"            
    ## [2185] "preach"           "precondition"     "predestin"       
    ## [2188] "pregnant"         "premium"          "preoccupy"       
    ## [2191] "prep"             "prepare"          "preponderance"   
    ## [2194] "presence"         "present"          "presentation"    
    ## [2197] "preserve"         "president"        "Presse"          
    ## [2200] "pressure"         "presume"          "pretend"         
    ## [2203] "pretty"           "prevent"          "price"           
    ## [2206] "prince"           "princess"         "principal"       
    ## [2209] "principle"        "principles"       "printer"         
    ## [2212] "probably"         "problem"          "problems"        
    ## [2215] "process"          "processe"         "processing"      
    ## [2218] "processor"        "produce"          "producer"        
    ## [2221] "product"          "program"          "project"         
    ## [2224] "promise"          "promote"          "pronounce"       
    ## [2227] "proofread"        "property"         "proposal"        
    ## [2230] "propose"          "protect"          "protocol"        
    ## [2233] "proud"            "prove"            "provide"         
    ## [2236] "provider"         "psyched"          "publicize"       
    ## [2239] "pudding"          "pull"             "pump"            
    ## [2242] "Pump"             "pumpe"            "punch"           
    ## [2245] "punish"           "purchase"         "pure"            
    ## [2248] "purpose"          "pursue"           "pursuit"         
    ## [2251] "push"             "put"              "putski"          
    ## [2254] "q"                "qualify"          "quality"         
    ## [2257] "quarter"          "que"              "queen"           
    ## [2260] "Queen"            "question"         "questioning"     
    ## [2263] "quick"            "quicken"          "quiere"          
    ## [2266] "quit"             "quo"              "quota"           
    ## [2269] "quote"            "r"                "race"            
    ## [2272] "racehorse"        "races"            "racing"          
    ## [2275] "rack"             "radio"            "radios"          
    ## [2278] "rain"             "raine"            "raise"           
    ## [2281] "ramp"             "range"            "rape"            
    ## [2284] "rat"              "rate"             "rath"            
    ## [2287] "ratio"            "ray"              "reach"           
    ## [2290] "reaction"         "read"             "Read"            
    ## [2293] "ready"            "reaffirm"         "real"            
    ## [2296] "realize"          "reallocate"       "really"          
    ## [2299] "rear"             "reason"           "reasonable"      
    ## [2302] "rebuild"          "rebuk"            "recall"          
    ## [2305] "receive"          "reception"        "recess"          
    ## [2308] "recipe"           "recite"           "recliner"        
    ## [2311] "recognize"        "reconcilable"     "reconcile"       
    ## [2314] "record"           "recorder"         "recording"       
    ## [2317] "recovere"         "red"              "redblood"        
    ## [2320] "reddish"          "redial"           "redo"            
    ## [2323] "reduce"           "refer"            "refinance"       
    ## [2326] "reflection"       "reframe"          "regain"          
    ## [2329] "regard"           "Regina"           "regis"           
    ## [2332] "register"         "registers"        "regulator"       
    ## [2335] "regurgitate"      "rehabb"           "rehabilitation"  
    ## [2338] "reign"            "reinforce"        "reinstall"       
    ## [2341] "rejoice"          "relate"           "relation"        
    ## [2344] "relational"       "relationship"     "relative"        
    ## [2347] "relay"            "relevance"        "relevant"        
    ## [2350] "relief"           "religious"        "relinquish"      
    ## [2353] "relive"           "remain"           "remanar"         
    ## [2356] "remark"           "remarkable"       "remember"        
    ## [2359] "remind"           "reminde"          "remodel"         
    ## [2362] "remorse"          "remove"           "rendition"       
    ## [2365] "rent"             "reorder"          "repair"          
    ## [2368] "repay"            "repayment"        "replace"         
    ## [2371] "replacement"      "report"           "reporter"        
    ## [2374] "represent"        "representative"   "request"         
    ## [2377] "require"          "requirement"      "rerent"          
    ## [2380] "rescue"           "research"         "researcher"      
    ## [2383] "resent"           "reserve"          "reservoir"       
    ## [2386] "reside"           "resident"         "resource"        
    ## [2389] "respect"          "respond"          "response"        
    ## [2392] "responsibility"   "responsible"      "responsive"      
    ## [2395] "rest"             "restore"          "restriction"     
    ## [2398] "result"           "retir"            "retire"          
    ## [2401] "retract"          "retreat"          "return"          
    ## [2404] "returner"         "rev"              "reveal"          
    ## [2407] "revealead"        "reverse"          "review"          
    ## [2410] "revolve"          "reward"           "rib"             
    ## [2413] "rich"             "richest"          "rid"             
    ## [2416] "ride"             "riding"           "right"           
    ## [2419] "righteousness"    "rigid"            "ring"            
    ## [2422] "rinse"            "rip"              "rise"            
    ## [2425] "risk"             "river"            "road"            
    ## [2428] "rob"              "Rob"              "robb"            
    ## [2431] "Robby"            "robe"             "Roberts"         
    ## [2434] "robs"             "Rockhopper"       "role"            
    ## [2437] "roll"             "Romig"            "roof"            
    ## [2440] "room"             "root"             "ros"             
    ## [2443] "Rosenblum"        "rot"              "rotor"           
    ## [2446] "rough"            "round"            "route"           
    ## [2449] "row"              "rubber"           "rude"            
    ## [2452] "ruin"             "rule"             "run"             
    ## [2455] "runner"           "runway"           "rush"            
    ## [2458] "s"                "S"                "S_through"       
    ## [2461] "Sabrina"          "sad"              "safety"          
    ## [2464] "sail"             "sake"             "salad"           
    ## [2467] "Salami"           "salary"           "sale"            
    ## [2470] "salmon"           "salt"             "same"            
    ## [2473] "sandwich"         "sanity"           "Sat"             
    ## [2476] "satisfye"         "Saturday"         "sauce"           
    ## [2479] "sausage"          "save"             "saw"             
    ## [2482] "say"              "saying"           "scale"           
    ## [2485] "scam"             "scare"            "scared"          
    ## [2488] "scarf"            "scary"            "scenario"        
    ## [2491] "scenarios"        "scene"            "scent"           
    ## [2494] "schedule"         "school"           "science"         
    ## [2497] "scoop"            "scoot"            "score"           
    ## [2500] "Scott"            "scrape"           "scratch"         
    ## [2503] "scream"           "screaming"        "screw"           
    ## [2506] "screwdriver"      "screwy"           "sculpture"       
    ## [2509] "se"               "sea"              "seafood"         
    ## [2512] "seal"             "search"           "season"          
    ## [2515] "seat"             "second"           "seconds"         
    ## [2518] "secret"           "Secretariat"      "section"         
    ## [2521] "secure"           "sedate"           "see"             
    ## [2524] "seek"             "seem"             "segregate"       
    ## [2527] "select"           "selection"        "selfdirect"      
    ## [2530] "sell"             "semana"           "semester"        
    ## [2533] "send"             "sense"            "sensore"         
    ## [2536] "sentence"         "separate"         "separation"      
    ## [2539] "sequence"         "serf"             "series"          
    ## [2542] "servants"         "serve"            "service"         
    ## [2545] "session"          "set"              "settle"          
    ## [2548] "seven"            "seventee"         "seventeen"       
    ## [2551] "seventy"          "sew"              "sh"              
    ## [2554] "Sh"               "sha"              "shaft"           
    ## [2557] "shak"             "shake"            "Shane"           
    ## [2560] "shap"             "shape"            "share"           
    ## [2563] "Shaybeck"         "she"              "shed"            
    ## [2566] "shedding"         "sheep"            "sheet"           
    ## [2569] "shell"            "shepherd"         "shield"          
    ## [2572] "shift"            "shifte"           "shine"           
    ## [2575] "ship"             "shirt"            "shit"            
    ## [2578] "shod"             "shoddy"           "shoe"            
    ## [2581] "shone"            "shoot"            "shop"            
    ## [2584] "shoppe"           "shopper"          "shore"           
    ## [2587] "short"            "shortage"         "shot"            
    ## [2590] "shoute"           "shove"            "shovel"          
    ## [2593] "shoveling"        "show"             "Shr"             
    ## [2596] "shred"            "shucks"           "Shuffl"          
    ## [2599] "shut"             "sibl"             "sick"            
    ## [2602] "sickness"         "side"             "sideway"         
    ## [2605] "sigh"             "sign"             "similar"         
    ## [2608] "sin"              "since"            "Sing"            
    ## [2611] "SING"             "singe"            "singer"          
    ## [2614] "Singhi"           "Singp"            "sink"            
    ## [2617] "sinn"             "sir"              "sister"          
    ## [2620] "sit"              "site"             "situation"       
    ## [2623] "six"              "sixth"            "sixty"           
    ## [2626] "sixtynine"        "size"             "sk"              
    ## [2629] "skeleton"         "skeptical"        "ski"             
    ## [2632] "skill"            "skip"             "slab"            
    ## [2635] "slam"             "slamm"            "Slappe"          
    ## [2638] "slave"            "sleep"            "slice"           
    ## [2641] "slide"            "sliding"          "sloppy"          
    ## [2644] "slow"             "slowe"            "sm"              
    ## [2647] "smack"            "small"            "smaller"         
    ## [2650] "smash"            "smashed"          "smell"           
    ## [2653] "smoke"            "smoking"          "snack"           
    ## [2656] "snap"             "snapp"            "snapper"         
    ## [2659] "sneezing"         "sng"              "sniff"           
    ## [2662] "SNIFF"            "snip"             "snob"            
    ## [2665] "snooze"           "snow"             "so"              
    ## [2668] "soak"             "Sob"              "sober"           
    ## [2671] "society"          "soda"             "sofa"            
    ## [2674] "soft"             "softball"         "softer"          
    ## [2677] "soil"             "solid"            "solve"           
    ## [2680] "some"             "somebody"         "someday"         
    ## [2683] "someone"          "someth"           "something"       
    ## [2686] "sometime"         "somewhere"        "son"             
    ## [2689] "song"             "soon"             "sore"            
    ## [2692] "sorry"            "sort"             "sound"           
    ## [2695] "soup"             "source"           "sourdough"       
    ## [2698] "south"            "spa"              "space"           
    ## [2701] "spade"            "spall"            "sparkling"       
    ## [2704] "spasm"            "speak"            "speaker"         
    ## [2707] "spec"             "SPEC"             "special"         
    ## [2710] "specialty"        "spectrum"         "speed"           
    ## [2713] "spell"            "spend"            "spice"           
    ## [2716] "spike"            "spill"            "spin"            
    ## [2719] "spinner"          "spirit"           "Spirit"          
    ## [2722] "spirituality"     "spit"             "spite"           
    ## [2725] "splice"           "splish"           "split"           
    ## [2728] "spoken"           "spook"            "spoonful"        
    ## [2731] "sport"            "spot"             "spr"             
    ## [2734] "spray"            "spre"             "spread"          
    ## [2737] "spring"           "sprinkle"         "sprinter"        
    ## [2740] "spurt"            "squa"             "square"          
    ## [2743] "squeeze"          "squirrel"         "ssurance"        
    ## [2746] "st"               "sta"              "stabilize"       
    ## [2749] "stack"            "stadium"          "staff"           
    ## [2752] "stage"            "stain"            "stairstepper"    
    ## [2755] "stallion"         "stand"            "standardbreed"   
    ## [2758] "staple"           "star"             "start"           
    ## [2761] "starve"           "starving"         "state"           
    ## [2764] "statement"        "statements"       "States"          
    ## [2767] "statio"           "station"          "stations"        
    ## [2770] "statue"           "stay"             "steady"          
    ## [2773] "steak"            "steal"            "steel"           
    ## [2776] "step"             "sterl"            "stew"            
    ## [2779] "stick"            "sticke"           "sticking"        
    ## [2782] "stike"            "stirr"            "stocking"        
    ## [2785] "stone"            "stop"             "store"           
    ## [2788] "storm"            "storms"           "story"           
    ## [2791] "str"              "straight"         "straighten"      
    ## [2794] "strap"            "streak"           "streamer"        
    ## [2797] "street"           "Street"           "stress"          
    ## [2800] "stretch"          "string"           "stripp"          
    ## [2803] "strips"           "strong"           "structure"       
    ## [2806] "stuck"            "stud"             "studio"          
    ## [2809] "study"            "stuff"            "stunt"           
    ## [2812] "stupid"           "style"            "styles"          
    ## [2815] "subject"          "submit"           "substance"       
    ## [2818] "substantiate"     "succeed"          "success"         
    ## [2821] "successful"       "such"             "suck"            
    ## [2824] "Sucke"            "sudden"           "sue"             
    ## [2827] "sugar"            "suggest"          "suit"            
    ## [2830] "suite"            "Sultan"           "sum"             
    ## [2833] "sump"             "sun"              "supervise"       
    ## [2836] "supplier"         "supply"           "support"         
    ## [2839] "supportive"       "suppose"          "sure"            
    ## [2842] "surface"          "surgery"          "surprise"        
    ## [2845] "surprised"        "survive"          "suspect"         
    ## [2848] "suspend"          "sustain"          "sw"              
    ## [2851] "SWALLOW"          "swap"             "sway"            
    ## [2854] "sweat"            "sweet"            "sweetie"         
    ## [2857] "swift"            "swimm"            "swing"           
    ## [2860] "switch"           "swoll"            "Swoll"           
    ## [2863] "symbolize"        "system"           "systems"         
    ## [2866] "t"                "t's"              "table"           
    ## [2869] "tablecloth"       "tablespoon"       "tacky"           
    ## [2872] "tags"             "tail"             "tailor"          
    ## [2875] "take"             "taker"            "talk"            
    ## [2878] "talkative"        "talking"          "tall"            
    ## [2881] "tallest"          "tam"              "tamale"          
    ## [2884] "tank"             "tap"              "tape"            
    ## [2887] "taping"           "taste"            "tax"             
    ## [2890] "taxi"             "tea"              "teach"           
    ## [2893] "teache"           "teacher"          "teaching"        
    ## [2896] "team"             "tear"             "technology"      
    ## [2899] "teeth"            "television"       "tell"            
    ## [2902] "temperature"      "temple"           "ten"             
    ## [2905] "tend"             "tender"           "tent"            
    ## [2908] "term"             "terminate"        "terrazzo"        
    ## [2911] "terrifying"       "terrorize"        "test"            
    ## [2914] "testify"          "testing"          "th"              
    ## [2917] "tha"              "thank"            "thanks"          
    ## [2920] "that"             "thaw"             "the"             
    ## [2923] "theater"          "theme"            "then"            
    ## [2926] "theology"         "theory"           "therapy"         
    ## [2929] "there"            "Therman"          "these"           
    ## [2932] "they"             "thi"              "thick"           
    ## [2935] "thief"            "thigh"            "thing"           
    ## [2938] "think"            "third"            "thirdgrader"     
    ## [2941] "thirtieth"        "thirty"           "thirtyeight"     
    ## [2944] "thirtyfive"       "this"             "Thoreau"         
    ## [2947] "thoroughbreed"    "those"            "though"          
    ## [2950] "thought"          "thousand"         "thr"             
    ## [2953] "threaten"         "three"            "three_quarter"   
    ## [2956] "Threehundr"       "threehundred"     "thrill"          
    ## [2959] "thrilled"         "throat"           "Throat"          
    ## [2962] "throw"            "Thump"            "THUMP"           
    ## [2965] "Thump_microphine" "Thursday"         "tick"            
    ## [2968] "ticket"           "tide"             "tie"             
    ## [2971] "tight"            "tighten"          "till"            
    ## [2974] "tilts"            "time"             "Times"           
    ## [2977] "tire"             "tired"            "title"           
    ## [2980] "today"            "together"         "Tom"             
    ## [2983] "tomb"             "tomorrow"         "ton"             
    ## [2986] "tone"             "tongue"           "tonight"         
    ## [2989] "too"              "tool"             "tooth"           
    ## [2992] "top"              "topical"          "tore"            
    ## [2995] "Toronto"          "tortilla"         "toss"            
    ## [2998] "total"            "totality"         "touch"           
    ## [3001] "tough"            "tour"             "tournament"      
    ## [3004] "towel"            "tower"            "towers"          
    ## [3007] "town"             "toy"              "tr"              
    ## [3010] "trace"            "track"            "trade"           
    ## [3013] "tradition"        "trailer"          "trails"          
    ## [3016] "train"            "trainer"          "training"        
    ## [3019] "trample"          "transfer"         "transformation"  
    ## [3022] "translate"        "transplant"       "transport"       
    ## [3025] "trash"            "travail"          "travel"          
    ## [3028] "treat"            "treatment"        "tree"            
    ## [3031] "tremendous"       "trials"           "trick"           
    ## [3034] "trickl"           "trim"             "Trim"            
    ## [3037] "trinity"          "trip"             "triumph"         
    ## [3040] "trivia"           "trot"             "trouble"         
    ## [3043] "truck"            "trucks"           "true"            
    ## [3046] "trunk"            "trust"            "truth"           
    ## [3049] "try"              "Ts"               "tshirt"          
    ## [3052] "Tsk"              "TSK"              "tube"            
    ## [3055] "tuck"             "tug"              "tune"            
    ## [3058] "tunnel"           "turf"             "turn"            
    ## [3061] "turnout"          "turtle"           "tutor"           
    ## [3064] "twat"             "twelfth"          "twelve"          
    ## [3067] "twenty"           "twentyeight"      "twentyfive"      
    ## [3070] "twentyfour"       "twentythree"      "twentytwo"       
    ## [3073] "twice"            "two"              "twobedroom"      
    ## [3076] "twohundred"       "Twohundred"       "twoyear"         
    ## [3079] "type"             "typical"          "Uchimata"        
    ## [3082] "uh"               "um"               "umbrellas"       
    ## [3085] "unbelievable"     "underneath"       "understand"      
    ## [3088] "understanding"    "underwater"       "unhappy"         
    ## [3091] "unheard"          "union"            "unit"            
    ## [3094] "unloved"          "unpack"           "unpotent"        
    ## [3097] "unseen"           "Unsweeten"        "unusual"         
    ## [3100] "unzip"            "up"               "upg"             
    ## [3103] "upset"            "upstairs"         "uptown"          
    ## [3106] "urge"             "use"              "used"            
    ## [3109] "user"             "vacation"         "vaccine"         
    ## [3112] "valedictorian"    "value"            "valve"           
    ## [3115] "varie"            "variety"          "vat"             
    ## [3118] "vendetta"         "venison"          "verdad"          
    ## [3121] "verse"            "version"          "Vertically"      
    ## [3124] "very"             "vey"              "Vfr"             
    ## [3127] "vi"               "vibrat"           "violation"       
    ## [3130] "virgin"           "virus"            "viruse"          
    ## [3133] "vision"           "visit"            "voice"           
    ## [3136] "void"             "volleyball"       "volunteer"       
    ## [3139] "vote"             "vowel"            "Vox"             
    ## [3142] "VOX"              "VOXHI"            "voy"             
    ## [3145] "w"                "wa"               "wafe"            
    ## [3148] "wage"             "wagon"            "wait"            
    ## [3151] "wake"             "walk"             "walks"           
    ## [3154] "wall"             "walls"            "wander"          
    ## [3157] "want"             "war"              "War"             
    ## [3160] "warehouse"        "warmer"           "warrantee"       
    ## [3163] "warranty"         "wash"             "washed"          
    ## [3166] "washer"           "Washington"       "waste"           
    ## [3169] "watch"            "water"            "watermelon"      
    ## [3172] "wave"             "way"              "Way"             
    ## [3175] "we"               "weak"             "wear"            
    ## [3178] "wedding"          "weed"             "week"            
    ## [3181] "weigh"            "weight"           "weird"           
    ## [3184] "well"             "wellbehaved"      "welleducate"     
    ## [3187] "were_"            "wet"              "Wh"              
    ## [3190] "WH"               "what"             "whatever"        
    ## [3193] "wheel"            "when"             "where"           
    ## [3196] "wherever"         "which"            "whip"            
    ## [3199] "who"              "whole"            "why"             
    ## [3202] "wide"             "wife"             "wiggl"           
    ## [3205] "will"             "Willie"           "willing"         
    ## [3208] "win"              "wind"             "window"          
    ## [3211] "wine"             "wing"             "winner"          
    ## [3214] "wip"              "wipe"             "wiper"           
    ## [3217] "wire"             "Wisconsin"        "wish"            
    ## [3220] "with"             "witness"          "wittiness"       
    ## [3223] "wok"              "Wolfe"            "woman"           
    ## [3226] "womb"             "wonder"           "wonderful"       
    ## [3229] "wood"             "woodwork"         "word"            
    ## [3232] "wording"          "work"             "world"           
    ## [3235] "worried"          "worry"            "worse"           
    ## [3238] "worth"            "would"            "wound"           
    ## [3241] "wrap"             "wrapping"         "wreck"           
    ## [3244] "wrestle"          "wrestling"        "write"           
    ## [3247] "writer"           "writings"         "wrong"           
    ## [3250] "x"                "X"                "Xp"              
    ## [3253] "XP"               "Xray"             "Xx"              
    ## [3256] "XX"               "XXX"              "Xxxx"            
    ## [3259] "XXXX"             "y"                "yank"            
    ## [3262] "yard"             "yea"              "yeah"            
    ## [3265] "year"             "yell"             "yesterday"       
    ## [3268] "yon"              "York"             "Yorker"          
    ## [3271] "you"              "young"            "younger"         
    ## [3274] "yourself"         "Ywn"              "YWN"             
    ## [3277] "zap"              "Zheezhee"         "zilch"           
    ## [3280] "zillion"          "zone"             "zones"

    ##       head_lemma       lemma light OBS   EXP     T           p
    ## 83          make       fudge     0   6 0.003 2.448 0.007208594
    ## 210        build         dam     0   4 0.001 1.999 0.022845338
    ## 343        build      garage     0   3 0.000 1.732 0.041683759
    ## 357        build    building     0   3 0.001 1.731 0.041772874
    ## 376         make      tamale     0   3 0.002 1.731 0.041772874
    ## 743       create     purpose     0   2 0.000 1.414 0.078728375
    ## 745        build        nest     0   2 0.000 1.414 0.078728375
    ## 795        build   character     0   2 0.000 1.414 0.078728375
    ## 796        build       plant     0   2 0.000 1.414 0.078728375
    ## 807         make   horseshoe     0   2 0.001 1.414 0.078728375
    ## 835         make   cartilage     0   2 0.001 1.414 0.078728375
    ## 868         make        atom     0   2 0.001 1.413 0.078875275
    ## 883         make     ceviche     0   2 0.001 1.413 0.078875275
    ## 912        build        area     0   2 0.002 1.413 0.078875275
    ## 943         make        gold     0   2 0.002 1.413 0.078875275
    ## 944         make      rubber     0   2 0.002 1.413 0.078875275
    ## 992         make       pasta     0   2 0.003 1.412 0.079022382
    ## 1059        make       pizza     0   2 0.005 1.411 0.079169697
    ## 1119       build          uh     0   2 0.007 1.409 0.079464951
    ## 1384        make       water     0   2 0.032 1.391 0.082159859
    ## 1693        make       thing     0   2 0.116 1.332 0.091476338
    ## 2315      create        rift     0   1 0.000 1.000 0.158692114
    ## 2332     produce    champion     0   1 0.000 1.000 0.158692114
    ## 2340      create      stress     0   1 0.000 1.000 0.158692114
    ## 2373     produce      report     0   1 0.000 1.000 0.158692114
    ## 2375      create      garden     0   1 0.000 1.000 0.158692114
    ## 2390       build  depression     0   1 0.000 1.000 0.158692114
    ## 2391       build  floodplain     0   1 0.000 1.000 0.158692114
    ## 2392       build      podium     0   1 0.000 1.000 0.158692114
    ## 2608      create   condition     0   1 0.000 1.000 0.158692114
    ## 2615      create   committee     0   1 0.000 1.000 0.158692114
    ## 2616    generate       power     0   1 0.000 1.000 0.158692114
    ## 2621     produce        heat     0   1 0.000 1.000 0.158692114
    ## 2638       build  attraction     0   1 0.000 1.000 0.158692114
    ## 2858       build   cofferdam     0   1 0.000 1.000 0.158692114
    ## 3025      create       cause     0   1 0.000 1.000 0.158692114
    ## 3026       build   consensus     0   1 0.000 1.000 0.158692114
    ## 3027       build     library     0   1 0.000 1.000 0.158692114
    ## 3533        make boilerplate     0   1 0.000 1.000 0.158692114
    ## 3534        make       decaf     0   1 0.000 1.000 0.158692114
    ## 3535        make       gravy     0   1 0.000 1.000 0.158692114
    ## 3536        make    leftover     0   1 0.000 1.000 0.158692114
    ## 3537        make        loaf     0   1 0.000 1.000 0.158692114
    ## 3538        make          sw     0   1 0.000 1.000 0.158692114
    ## 3539        make        tart     0   1 0.000 1.000 0.158692114
    ## 3768       build        step     0   1 0.000 1.000 0.158692114
    ## 3769       build     thought     0   1 0.000 1.000 0.158692114
    ## 4037       build       river     0   1 0.000 1.000 0.158692114
    ## 4038       build    spillway     0   1 0.000 1.000 0.158692114
    ## 4237        make       dingo     0   1 0.001 0.999 0.158934169
    ## 4238        make       quilt     0   1 0.001 0.999 0.158934169
    ## 4239        make     spatula     0   1 0.001 0.999 0.158934169
    ## 4396       build       fence     0   1 0.001 0.999 0.158934169
    ## 4639       build       lotta     0   1 0.001 0.999 0.158934169
    ## 4709       build        body     0   1 0.001 0.999 0.158934169
    ## 4796        make       grape     0   1 0.001 0.999 0.158934169
    ## 4864       build        barn     0   1 0.001 0.999 0.158934169
    ## 5077       build      animal     0   1 0.001 0.999 0.158934169
    ## 5128       build    concrete     0   1 0.001 0.999 0.158934169
    ## 5219        make      outfit     0   1 0.001 0.999 0.158934169
    ## 5526       build        form     0   1 0.001 0.999 0.158934169
    ## 5537        make       kebab     0   1 0.001 0.999 0.158934169
    ## 5538        make       steel     0   1 0.001 0.999 0.158934169
    ## 5579      create         day     0   1 0.001 0.999 0.158934169
    ## 5741       build         top     0   1 0.002 0.998 0.159176466
    ## 5832        make      basket     0   1 0.002 0.998 0.159176466
    ## 5833        make      pillow     0   1 0.002 0.998 0.159176466
    ## 6104        make      square     0   1 0.002 0.998 0.159176466
    ## 6258       build       woman     0   1 0.002 0.998 0.159176466
    ## 6314       build      couple     0   1 0.002 0.998 0.159176466
    ## 6344        make    ornament     0   1 0.002 0.998 0.159176466
    ## 6345        make       plate     0   1 0.002 0.998 0.159176466
    ## 6346        make       wiper     0   1 0.002 0.998 0.159176466
    ## 6349       build        part     0   1 0.002 0.998 0.159176466
    ## 6573        make      market     0   1 0.002 0.998 0.159176466
    ## 6788       build        foot     0   1 0.003 0.997 0.159419005
    ## 6792        make   beginning     0   1 0.003 0.997 0.159419005
    ## 6793        make        loan     0   1 0.003 0.997 0.159419005
    ## 6794        make       sauce     0   1 0.003 0.997 0.159419005
    ## 7002       build       world     0   1 0.003 0.997 0.159419005
    ## 7114      create       thing     0   1 0.003 0.997 0.159419005
    ## 7151        make       juice     0   1 0.003 0.997 0.159419005
    ## 7152        make        meat     0   1 0.003 0.997 0.159419005
    ## 7272        make        masa     0   1 0.004 0.996 0.159661785
    ## 7430        make         ton     0   1 0.004 0.996 0.159661785
    ## 7534        make     clothes     0   1 0.004 0.996 0.159661785
    ## 7692       build       water     0   1 0.004 0.996 0.159661785
    ## 7799        make        copy     0   1 0.005 0.995 0.159904808
    ## 7800        make         hay     0   1 0.005 0.995 0.159904808
    ## 7801        make      sister     0   1 0.005 0.995 0.159904808
    ## 7933        make         bed     0   1 0.005 0.995 0.159904808
    ## 7934        make       break     0   1 0.005 0.995 0.159904808
    ## 7935        make        tail     0   1 0.005 0.995 0.159904808
    ## 8035        make       shirt     0   1 0.005 0.995 0.159904808
    ## 8151        make      cookie     0   1 0.005 0.995 0.159904808
    ## 8270        make       salad     0   1 0.006 0.994 0.160148072
    ## 8417        make        hair     0   1 0.006 0.994 0.160148072
    ## 8493       build           h     0   1 0.007 0.993 0.160391579
    ## 8588        make       stone     0   1 0.007 0.993 0.160391579
    ## 8937       build         way     0   1 0.008 0.992 0.160635327
    ## 9294        make    tomorrow     0   1 0.009 0.991 0.160879317
    ## 9622       build      people     0   1 0.011 0.989 0.161368024
    ## 9792        make        case     0   1 0.012 0.988 0.161612740
    ## 9793        make      dinner     0   1 0.012 0.988 0.161612740
    ## 10121       make         dad     0   1 0.014 0.986 0.162102897
    ## 10411      build       thing     0   1 0.016 0.984 0.162594023
    ## 10816       make        food     0   1 0.019 0.981 0.163332524
    ## 11310       make       today     0   1 0.025 0.975 0.164816058
    ## 11605       make       night     0   1 0.028 0.972 0.165561089
    ## 11771       make       money     0   1 0.030 0.970 0.166058985
    ## 11910       make         man     0   1 0.032 0.968 0.166557848
    ## 12744       make           h     0   1 0.047 0.953 0.170330125
    ## 13825       make      people     0   1 0.079 0.921 0.178559059
    ## 14481       make        time     0   1 0.118 0.882 0.188920699

    ##       head_lemma       lemma light OBS   EXP     T          p
    ## 447         take     balloon     0   3 0.014 1.724 0.04240101
    ## 449         take         bag     0   3 0.015 1.723 0.04249136
    ## 474         take         car     0   3 0.029 1.715 0.04321981
    ## 1002        take       space     0   2 0.003 1.412 0.07902238
    ## 1341        take        foot     0   2 0.026 1.396 0.08140446
    ## 1442        take       money     0   2 0.040 1.386 0.08292053
    ## 1781        take       thing     0   2 0.151 1.307 0.09565214
    ## 3773        take       nests     0   1 0.000 1.000 0.15869211
    ## 3774        take     puppies     0   1 0.000 1.000 0.15869211
    ## 3775        take  silverware     0   1 0.000 1.000 0.15869211
    ## 3776        take        stub     0   1 0.000 1.000 0.15869211
    ## 3777        take      torque     0   1 0.000 1.000 0.15869211
    ## 3778        take     Tylenol     0   1 0.000 1.000 0.15869211
    ## 3779        take wastebasket     0   1 0.000 1.000 0.15869211
    ## 4536        take     capsule     0   1 0.001 0.999 0.15893417
    ## 4537        take    clipping     0   1 0.001 0.999 0.15893417
    ## 4538        take      guitar     0   1 0.001 0.999 0.15893417
    ## 5176        take        nail     0   1 0.001 0.999 0.15893417
    ## 5177        take        plug     0   1 0.001 0.999 0.15893417
    ## 5178        take          tw     0   1 0.001 0.999 0.15893417
    ## 5539       bring      cookie     0   1 0.001 0.999 0.15893417
    ## 5580        take   spacesuit     0   1 0.001 0.999 0.15893417
    ## 5937        take       shelf     0   1 0.002 0.998 0.15917647
    ## 6260        take   checkbook     0   1 0.002 0.998 0.15917647
    ## 6595        take       diary     0   1 0.003 0.997 0.15941900
    ## 6858        take        pill     0   1 0.003 0.997 0.15941900
    ## 7116        take        wire     0   1 0.003 0.997 0.15941900
    ## 7798        take     insulin     0   1 0.005 0.995 0.15990481
    ## 8096        take        gift     0   1 0.005 0.995 0.15990481
    ## 8358        take        buck     0   1 0.006 0.994 0.16014807
    ## 8359        take        drug     0   1 0.006 0.994 0.16014807
    ## 8360        take       pants     0   1 0.006 0.994 0.16014807
    ## 8469        take        tail     0   1 0.006 0.994 0.16014807
    ## 8561        take       bunch     0   1 0.007 0.993 0.16039158
    ## 8670        take    painting     0   1 0.007 0.993 0.16039158
    ## 8864        take         egg     0   1 0.008 0.992 0.16063533
    ## 9058        take       pound     0   1 0.009 0.991 0.16087932
    ## 9577        take        knee     0   1 0.011 0.989 0.16136802
    ## 10454       take       order     0   1 0.016 0.984 0.16259402
    ## 10911       take        tape     0   1 0.020 0.980 0.16357918
    ## 11011       take          em     0   1 0.021 0.979 0.16382607
    ## 11781       take        kind     0   1 0.031 0.969 0.16630830
    ## 12470       take      dollar     0   1 0.040 0.960 0.16856297
    ## 12532       take       water     0   1 0.042 0.958 0.16906666
    ## 13923       take         lot     0   1 0.082 0.918 0.17934316
    ## 14295       take      people     0   1 0.104 0.896 0.18515924

    ##       head_lemma       lemma light OBS   EXP     T           p obs
    ## 83          make       fudge     0   6 0.003 2.448 0.007208594  64
    ## 210        build         dam     0   4 0.001 1.999 0.022845338  37
    ## 343        build      garage     0   3 0.000 1.732 0.041683759  37
    ## 357        build    building     0   3 0.001 1.731 0.041772874  37
    ## 376         make      tamale     0   3 0.002 1.731 0.041772874  64
    ## 743       create     purpose     0   2 0.000 1.414 0.078728375   9
    ## 745        build        nest     0   2 0.000 1.414 0.078728375  37
    ## 795        build   character     0   2 0.000 1.414 0.078728375  37
    ## 796        build       plant     0   2 0.000 1.414 0.078728375  37
    ## 807         make   horseshoe     0   2 0.001 1.414 0.078728375  64
    ## 835         make   cartilage     0   2 0.001 1.414 0.078728375  64
    ## 868         make        atom     0   2 0.001 1.413 0.078875275  64
    ## 883         make     ceviche     0   2 0.001 1.413 0.078875275  64
    ## 912        build        area     0   2 0.002 1.413 0.078875275  37
    ## 943         make        gold     0   2 0.002 1.413 0.078875275  64
    ## 944         make      rubber     0   2 0.002 1.413 0.078875275  64
    ## 992         make       pasta     0   2 0.003 1.412 0.079022382  64
    ## 1059        make       pizza     0   2 0.005 1.411 0.079169697  64
    ## 1119       build          uh     0   2 0.007 1.409 0.079464951  37
    ## 1384        make       water     0   2 0.032 1.391 0.082159859  64
    ## 1693        make       thing     0   2 0.116 1.332 0.091476338  64
    ## 2315      create        rift     0   1 0.000 1.000 0.158692114   9
    ## 2332     produce    champion     0   1 0.000 1.000 0.158692114   3
    ## 2340      create      stress     0   1 0.000 1.000 0.158692114   9
    ## 2373     produce      report     0   1 0.000 1.000 0.158692114   3
    ## 2375      create      garden     0   1 0.000 1.000 0.158692114   9
    ## 2390       build  depression     0   1 0.000 1.000 0.158692114  37
    ## 2391       build  floodplain     0   1 0.000 1.000 0.158692114  37
    ## 2392       build      podium     0   1 0.000 1.000 0.158692114  37
    ## 2608      create   condition     0   1 0.000 1.000 0.158692114   9
    ## 2615      create   committee     0   1 0.000 1.000 0.158692114   9
    ## 2616    generate       power     0   1 0.000 1.000 0.158692114   1
    ## 2621     produce        heat     0   1 0.000 1.000 0.158692114   3
    ## 2638       build  attraction     0   1 0.000 1.000 0.158692114  37
    ## 2858       build   cofferdam     0   1 0.000 1.000 0.158692114  37
    ## 3025      create       cause     0   1 0.000 1.000 0.158692114   9
    ## 3026       build   consensus     0   1 0.000 1.000 0.158692114  37
    ## 3027       build     library     0   1 0.000 1.000 0.158692114  37
    ## 3533        make boilerplate     0   1 0.000 1.000 0.158692114  64
    ## 3534        make       decaf     0   1 0.000 1.000 0.158692114  64
    ## 3535        make       gravy     0   1 0.000 1.000 0.158692114  64
    ## 3536        make    leftover     0   1 0.000 1.000 0.158692114  64
    ## 3537        make        loaf     0   1 0.000 1.000 0.158692114  64
    ## 3538        make          sw     0   1 0.000 1.000 0.158692114  64
    ## 3539        make        tart     0   1 0.000 1.000 0.158692114  64
    ## 3768       build        step     0   1 0.000 1.000 0.158692114  37
    ## 3769       build     thought     0   1 0.000 1.000 0.158692114  37
    ## 4037       build       river     0   1 0.000 1.000 0.158692114  37
    ## 4038       build    spillway     0   1 0.000 1.000 0.158692114  37
    ## 4237        make       dingo     0   1 0.001 0.999 0.158934169  64
    ## 4238        make       quilt     0   1 0.001 0.999 0.158934169  64
    ## 4239        make     spatula     0   1 0.001 0.999 0.158934169  64
    ## 4396       build       fence     0   1 0.001 0.999 0.158934169  37
    ## 4639       build       lotta     0   1 0.001 0.999 0.158934169  37
    ## 4709       build        body     0   1 0.001 0.999 0.158934169  37
    ## 4796        make       grape     0   1 0.001 0.999 0.158934169  64
    ## 4864       build        barn     0   1 0.001 0.999 0.158934169  37
    ## 5077       build      animal     0   1 0.001 0.999 0.158934169  37
    ## 5128       build    concrete     0   1 0.001 0.999 0.158934169  37
    ## 5219        make      outfit     0   1 0.001 0.999 0.158934169  64
    ## 5526       build        form     0   1 0.001 0.999 0.158934169  37
    ## 5537        make       kebab     0   1 0.001 0.999 0.158934169  64
    ## 5538        make       steel     0   1 0.001 0.999 0.158934169  64
    ## 5579      create         day     0   1 0.001 0.999 0.158934169   9
    ## 5741       build         top     0   1 0.002 0.998 0.159176466  37
    ## 5832        make      basket     0   1 0.002 0.998 0.159176466  64
    ## 5833        make      pillow     0   1 0.002 0.998 0.159176466  64
    ## 6104        make      square     0   1 0.002 0.998 0.159176466  64
    ## 6258       build       woman     0   1 0.002 0.998 0.159176466  37
    ## 6314       build      couple     0   1 0.002 0.998 0.159176466  37
    ## 6344        make    ornament     0   1 0.002 0.998 0.159176466  64
    ## 6345        make       plate     0   1 0.002 0.998 0.159176466  64
    ## 6346        make       wiper     0   1 0.002 0.998 0.159176466  64
    ## 6349       build        part     0   1 0.002 0.998 0.159176466  37
    ## 6573        make      market     0   1 0.002 0.998 0.159176466  64
    ## 6788       build        foot     0   1 0.003 0.997 0.159419005  37
    ## 6792        make   beginning     0   1 0.003 0.997 0.159419005  64
    ## 6793        make        loan     0   1 0.003 0.997 0.159419005  64
    ## 6794        make       sauce     0   1 0.003 0.997 0.159419005  64
    ## 7002       build       world     0   1 0.003 0.997 0.159419005  37
    ## 7114      create       thing     0   1 0.003 0.997 0.159419005   9
    ## 7151        make       juice     0   1 0.003 0.997 0.159419005  64
    ## 7152        make        meat     0   1 0.003 0.997 0.159419005  64
    ## 7272        make        masa     0   1 0.004 0.996 0.159661785  64
    ## 7430        make         ton     0   1 0.004 0.996 0.159661785  64
    ## 7534        make     clothes     0   1 0.004 0.996 0.159661785  64
    ## 7692       build       water     0   1 0.004 0.996 0.159661785  37
    ## 7799        make        copy     0   1 0.005 0.995 0.159904808  64
    ## 7800        make         hay     0   1 0.005 0.995 0.159904808  64
    ## 7801        make      sister     0   1 0.005 0.995 0.159904808  64
    ## 7933        make         bed     0   1 0.005 0.995 0.159904808  64
    ## 7934        make       break     0   1 0.005 0.995 0.159904808  64
    ## 7935        make        tail     0   1 0.005 0.995 0.159904808  64
    ## 8035        make       shirt     0   1 0.005 0.995 0.159904808  64
    ## 8151        make      cookie     0   1 0.005 0.995 0.159904808  64
    ## 8270        make       salad     0   1 0.006 0.994 0.160148072  64
    ## 8417        make        hair     0   1 0.006 0.994 0.160148072  64
    ## 8493       build           h     0   1 0.007 0.993 0.160391579  37
    ## 8588        make       stone     0   1 0.007 0.993 0.160391579  64
    ## 8937       build         way     0   1 0.008 0.992 0.160635327  37
    ## 9294        make    tomorrow     0   1 0.009 0.991 0.160879317  64
    ## 9622       build      people     0   1 0.011 0.989 0.161368024  37
    ## 9792        make        case     0   1 0.012 0.988 0.161612740  64
    ## 9793        make      dinner     0   1 0.012 0.988 0.161612740  64
    ## 10121       make         dad     0   1 0.014 0.986 0.162102897  64
    ## 10411      build       thing     0   1 0.016 0.984 0.162594023  37
    ## 10816       make        food     0   1 0.019 0.981 0.163332524  64
    ## 11310       make       today     0   1 0.025 0.975 0.164816058  64
    ## 11605       make       night     0   1 0.028 0.972 0.165561089  64
    ## 11771       make       money     0   1 0.030 0.970 0.166058985  64
    ## 11910       make         man     0   1 0.032 0.968 0.166557848  64
    ## 12744       make           h     0   1 0.047 0.953 0.170330125  64
    ## 13825       make      people     0   1 0.079 0.921 0.178559059  64
    ## 14481       make        time     0   1 0.118 0.882 0.188920699  64

<figure>
<img src="README_files/figure-markdown_phpextra/fig-05-sema-T-make-1.png" alt="semasiological: sum T-score of near synonymes to make" />
<figcaption aria-hidden="true">semasiological: sum T-score of near synonymes to make</figcaption>
</figure>

<figure>
<img src="README_files/figure-markdown_phpextra/fig-06-sema-T-take-1.png" alt="semasiological: sum T-score of near synonymes to take" />
<figcaption aria-hidden="true">semasiological: sum T-score of near synonymes to take</figcaption>
</figure>

<figure>
<img src="README_files/figure-markdown_phpextra/fig-07-sema-p-make-1.png" alt="semasiological: p of near synonymes to make" />
<figcaption aria-hidden="true">semasiological: p of near synonymes to make</figcaption>
</figure>

<figure>
<img src="README_files/figure-markdown_phpextra/fig-08-sema-p-take-1.png" alt="semasiological: p of near synonymes to take" />
<figcaption aria-hidden="true">semasiological: p of near synonymes to take</figcaption>
</figure>

------------------------------------------------------------------------

# 2 B: references {#b-references .unnumbered}

<div id="refs" class="references csl-bib-body hanging-indent" markdown="1">

<div id="ref-gilquin_what_2008" class="csl-entry" markdown="1">

Gilquin, Gaëtanelle. 2008. “What You Think Ain’t What You Get: Highly Polysemous Verbs in Mind and Language.” <https://dial.uclouvain.be/pr/boreal/object/boreal:75833>.

</div>

<div id="ref-mehl_what_2021" class="csl-entry" markdown="1">

Mehl, Seth. 2021. “What We Talk about When We Talk about Corpus Frequency: The Example of Polysemous Verbs with Light and Concrete Senses.” *Corpus Linguistics and Linguistic Theory* 17 (1): 223–47. <https://doi.org/10.1515/cllt-2017-0039>.

</div>

<div id="ref-ucsb_santa_2005" class="csl-entry" markdown="1">

UCSB, John W. DuBois, L. Chafe Wallace, Charles Meyer, Sandra A. Thompson, Robert Englebretson, and Nii Martey. 2005. “Santa Barbara Corpus of Spoken American English Department of Linguistics - UC Santa Barbara.” *SBC*. <https://www.linguistics.ucsb.edu/research/santa-barbara-corpus>.

</div>

</div>
