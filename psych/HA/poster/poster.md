# xTitle
# proposition & coherence in :schizophrenia: threads
### stephan schwarz / a. stefanowitsch:16827\_25S:sprache und psychose
## thema
Reference marking, coherence and information structure in schizophrenia language.[^1]
## hintergrund
Inspired by Zimmerer et alii (#REF) we are interested in observations concerning coherence and propositional conditions in schizophrenia language, as these linguistic markers appear underinvestigated in research while they seem to play a crucial role within target group language. (As such seen as asset of thinking or world building capacity which might suffer from linguistic deficits within the range of positive symptoms.)
## methode
To compute distances we queried a corpus for matching conditions where certain (assumed) determiners appear before similar nouns. This distance should give us information structural evidence of how strong these noun occurences are connected, i.e. if a noun appears out of the blue mostly or if it somewhere before has been introduced to the audience. In information structure definitions this would be termed with **given and new information** Prince (1981#REF).
---- 
## fragestellung
Measuring the referent-reference distance which we here assume as indicator of coherence we hope to find empirical evidence for disturbed or not world building capabilities within schizophrenia language.
## daten
We built a corpus of the reddit r/schizophrenia thread (`n= 747089` tokens) and a reference corpus of r/unpopularopinion (`n= 265670`). The corpus has been pos-tagged using the R udpipe:: package #REF which tags according to the universal dependencies tagset maintained by #REF. Still the 747089 tokens can only, with the workflow of growing the corpus and devising the noun distances developed be just a starting point from where with more datapoints statistical evaluation becomes relevant first.
---- 
## ergebnisse
## ergebnisse 2
| q   | dist | range  | corp | corp\\\_size | m      | m\\\_rel |
| :-- | ---: | -----: | :--- | -----------: | -----: | -------: |
| a   | 36   | 446.0  | obs  | 747089       | 747089 | 1.00000  |
| b   | 70   | 1451.0 | obs  | 747089       | 11415  | 0.01528  |
| c   | 49   | 807.0  | obs  | 747089       | 12516  | 0.01675  |
| d   | 49   | 834.0  | obs  | 747089       | 15141  | 0.02027  |
| e   | 53   | 917.0  | obs  | 747089       | 6983   | 0.00935  |
| f   | 57   | 1119.0 | obs  | 747089       | 4236   | 0.00567  |
| a   | 40   | 1619.5 | ref  | 265670       | 265670 | 1.00000  |
| b   | 41   | 2140.0 | ref  | 265670       | 4213   | 0.01586  |
| c   | 60   | 2116.5 | ref  | 265670       | 6542   | 0.02462  |
| d   | 51   | 1863.0 | ref  | 265670       | 6349   | 0.02390  |
| e   | 63   | 2947.5 | ref  | 265670       | 662    | 0.00249  |
| f   | 46   | 2473.5 | ref  | 265670       | 1576   | 0.00593  |

## ergebnisse 3
![][image-1]

# B. REF:

[^1]:	snc.1:h2.pb.1000char/pg

[image-1]:	file:///Users/guhl/Documents/GitHub/SPUND-LX/psych/HA/poster/index_files/figure-html/df1-vis-1.png
