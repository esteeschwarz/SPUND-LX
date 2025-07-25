# 15256.info
#### samling
- corpus
- Q: Zimmerer al. (2017)

-----
- F: coherence and proposition building, information structure
- corpus includes comments thread on url (topic)

[poster appendix](https://ogy.de/poster-coherence)   
snc:15307.1
-----

#### task
- query NP with definite article/demonstrative pronoun
- determine reference (introduction) distance of noun
  - within thread
  - compare definite/demontrative freq - distance to reference corpus
  - is the distance larger? 

  #### caveats
  looking into eval-002.csv which assembles all distances over target over query and including lemma and url we find that e.g. for 'dog' there is not more than 1 condition matching per url which is strange and maybe not possible as dog with lot of matches without query should not match only for condition b in url 1 for example but also with other noun precedents i.e. conditions. so that seems a flaw in the distance assembling function or in the part returning the q value...

  #### observations
  computing distances with antecedent.pos==DET(eval-004) and antecedent.pos~DET (eval-005) finds contrary results for distances obs vs. ref. TODO check again dist df creating function.
  
  #### todo
  - [ ] clean lemmata: many spelling errors in lemmalist > decreases pair factor
  - [ ] compute type/token ratio (lexical diversity) per url and include as fixed effect variable
  - [ ] ho-discourse givenness (referential distance), prince (1981)
  - [ ] ?what is proposition. ?what is presupposition. ?what is coherence.
