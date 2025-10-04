# 15303.ha.draft
## subject

Investigate reference marking, coherence and information structure in schizophrenia language by measuring distance of similar nouns within range of comment thread preceded by certain determinants.[^1]

## background

Inspired by @zimmerer_deictic_2017 we are interested in observations concerning coherence and propositional statement conditions in schizophrenia language, as these linguistic markers appear underinvestigated in that fields research whilst they seem to play a crucial role target group language features. (As such seen as asset of thinking or world building capacity which might suffer from linguistic deficits within the range of positive symptoms.)

## definitions, terminology
### coherence
There are several preliminary affordances to a successful communication. One is the *coherence* of a [text = way of communication](), which accounts for the partner being able to follow the topic and relate subjects and objects referenced. There can be more or less *common*  references and such, that need to be embedded in context to be understood. The underlying network of informations to create that context is what we call *information structure* of a text. The level of complexity of that network defines how simple it would be to gather the reference from the given information. We could have to go back many sentences or even infer reference from metaphors or such to be able to understand what is said or in the other case simply recall the subject of the last sentence to get the meaning (reference) of the pronoun in `also {she} said thisandthat...`. 
The capacity to imagine or have in mind, what concrete information is accessible to the adressee (what he actually knows or can infer) is key to a successful communication, since factors like common knowledge, weltwissen and shared knowledge between adressant and adressee and information accessible from the text itself varies depending on topic, setting, intimacy of the partners and such. So one cannot always be sure that all information provided is sufficient, but the grade to which one can give the right estimate to this sufficiency should here be a measure for our hypothesis, that the very coherence in disturbed language is deficient such that an utterance is more difficult to understand within the frame of given information.
Now one indicator of that coherence we assume is *reference distance* where according to our hypothesis a larger distance would be observed in places where the adressant overestimates[^2] the ability of the partner to follow a reference. That would mean that we find a medium shorter distance between referent and reference in the reference corpus[^3] and larger distances in the target corpus. The references we are interested in are nouns that appear as anaphors i.e. here as noun analogies. The assumption is that if a noun is repeated *and* is combinded with certain preceding determiners, the speaker assumes that the adressee has some knowledge of what is talked about, depending on the strength of the determination. So [this, that, those, these]() would be rather strong determiners requiring that the noun most definitely was introduced before; these four determiners depict on of our 5 conditions listed below.

### deictic anchoring and propositional complexity
#### raw
[@zimmerer_deictic_2017, introduction]
- linguistic deviation
Deictic anchoring is an inherent part of the process by which we make references to aspects in the world including entities, events, locations, and time. (2)
Propositions are statements about the world which can be true or false.
Kuperberg (7) notes that in people with schizophrenia, cortical activity to semantic abnormalities in sentences is particularly small compared to controls if interpretation requires integration of several sentences. (3)
Delusions and thought disorder can be considered disruptions of propositional meaning
described the onset of a delusion as the loss of ability to transcend an experience and see it with the eyes of others.
In thought disorder, the ability to express coherent propositions can be severely impaired. Sentences are structurally incomplete, abandoned by the speaker, or contain grammatical errors which severely hinder their interpretation

## questions
Measuring the referent-reference distance which we assume as indicator of coherence we hope to find empirical evidence for disturbed or not world building capacities within schizophrenia language. Premising that a large noun distance indicates a low reference-referent association we hypothesise that in a language/ToM setting where the speakers estimation of the audiences context understanding capacities is disturbed we will find higer medium scores for the distance under matching conditions. An environment which has potential to test our hypothesis is the reddit thread r/schizophrenia. As reference corpus we chose reddit r/unpopularopinion. 
The distance measured should give us information structural evidence of how strong the noun occurences[^4] are connected, i.e. if a noun appears out of the blue mostly or if it somewhere before has been introduced to the audience thus it will be more or less legitimated to be determined by an antecedent. 
Our basic assumptions rely on the *taxonomy of given end new information* coined by @prince_toward_1981. She develops a hierarchy of references(fn:informations in a text) with specific relations to each other, where each item is attributed in terms of *familiarity*[^5], that defines ranges of 1. givennes in the sense of predictability/recoverability, 2. givenness in the sense of saliency, 3. givenness in the sense of "shared knowledge". (cf. @prince_toward_1981, pp. 226) We base our hypothesis of *reference distance as indicator for coherence* on this model assuming that the reference/association strength[^6] determines the level of text coherence. 

## daten
We built a corpus of the reddit r/schizophrenia thread (`n=755074` tokens) and a reference corpus of r/unpopularopinion (`n=271563`). Both were pos-tagged using the R udpipe package (@wijffels_udpipe_2023) which tags according to the universal dependencies tagset maintained by @de_marneffe_universal_2021. Still the 755074 tokens can only, within the workflow of growing the corpus and devising the noun distances developed be just a starting point from where with more datapoints statistical evaluation becomes relevant first.  
The dataframe used for our model (actual: MX) consists of `939879` distance datapoints (sample Tab.X) derived from the postagged corpus.

## methods
To compute distances we queried the corpus for matching conditions where certain (probable) determiners appear before analogue nouns (anaphors). For each datapoint we collect variables as:

- thread url
- author (anonymised)
- thread length (tokens)
- lexical diversity (type/token ratio)
- lemma
- distance (to the preceding occurence, e.g. for three occurences of [dog]() we collect 2 distance datapoints)

The main function to determine the distances runs on a subset of the corpus with only including all nouns and their position in the corpus. It finds all duplicated nouns per url thread and computes their distances by token position.

## reflections
### range
Evaluating with a growing corpus and (reaching up to M[odel]()12 with our methods of computing distances) we interestingly find our basic hypothesis tested again, showing an overall larger distance of analogue nouns within the range of 1 thread url for the target corpus. While until M7 we devised distances from a manually assigned url identifier we saw the necessity to define our "range of interest" according to the original http url of the thread, since with a growing corpus the old url ids - derived from the get_thread_url() method of the redditExtractoR package (@rivera_redditextractor_2023) used for fetching the reddit content - there a no new url ids created since one url fetch gets each time always only around 1000 urls. To ensure unique url ranges within the corpus we as said in M11 assigned the range (within which the noun distance is calculated) to the real thread url. The corpus itself is after each fetch sorted after url and timestamp so it represents the real flow of conversation within one thread which is important since our distance model is based on the token distances within that thread, so they should follow their natural occurence in time.

### author trace id
Another nice new feature in M11 is the aut_id variable which represents the comment author and is unique to that. In the base .sqlite database the authors are already anonymised, so there should be no way from the published data back to the original author name of the comment. But, as also expected, including aut_id as random effect in the linear regression model, the significance level for the covariables of interest as are

1. q = the condition matching of the noun-preceding token
2. det = wether that match has postag "DET"
3. target = obs or reference corpus
finally increases.

### lexical diversity
We thought about some serious caveats within the latest  method: If (lucky for our hypothesis) the target corpus has significantly higher distance scores over nearly all conditions, does that automatically indicate a less coherent reference-referent association within what is expressed in the comments? Couldn't we also assume that if the analogue nouns appear more distanced in general that a topic which is including these nouns is simply expanding over a wider range i.e. timeframe? What does that do to our assumptions in terms of coherence? A good way here could be to integrate (from M3) a general lexical diversity factor per url as fixed effect because we can assume that a higher type/token ratio logically decreases the probability of a noun appearing multiple times within a range and we could take that effect into account. 

### semantics, word field, embedding
Further we created another covariable possible to integrate in the evaluation model: The probability of one specific noun appearing on its specific position in the thread range, computed with help of an open LL word embedding model (@huggingface_all-minilm-l6-v2_2025.) This is a common AI way of devising semantic relations in a corpus which exceeds a just frequency based keyword analysis. Using an LLM here allows for a distinctive identification of world field embeddings of the noun in question. In that way we get another variable linguistic feature extracted which may give general insights into the level of standardisation that applies to the corpora. So if a noun is found to be embedded with a high score into its context (the url thread) then it can be very much expected to be found there and appears less out-of-context.[^7]

### statistics
In this context we thought about what it means statistically, if a high-score embedded word also ranks high in (distance) significance i.e. generally what the relations of the covariates in the context of the linear regression evaluation express. Let us picture this:
1. a word receives a high embed score if it is probable for appearing within the thread according to the LLM.
2.  therefore the necessity to introduce/elaborate on it sinks, since it can be considered a "known" entity within the context given.
3. now if a person is using this word, the determined use appears less incoherent by itself.
4. the reference distance thus may increase without losing in coherence.
5. **conclusion:** if we for our linear regression use a (base) formula like `distance ~ corpus ` , a numerical `embed_score` predictor should correlate positive with the estimates for `dist` if applied correctly, nestcepas?

### caveats
Since devising the word embed score does take much computing ressources we had a script run on a server that solves the computing. But the first essai to integrate the new var into the evaluation model failed due to levels \< 2. Why? Because since we ran the script over the complete url ranges in the corpus and that is sorted after target,[^8] we did not compute any values for the reference corpus. So we learned this way again on linear regression models which require that a variable has more than one level (which would not be the case if the lmer() function excludes all NA rows: there would be no observations left with target=ref since all its embed.score values are NA and so all target.ref rows will be removed during regression.)




[^1]:	snc.1:h2.pb.1000char/pg.queries.cites

[^2]:	due to lack of empathy or a general self-alignment

[^3]:	where the participants may show a more realistic estimation of beforementioned ability

[^4]:	preceded by conditioned determiners

[^5]:	cf. Prince: speaker assumptions about hearer familiarity = assumed familiarity

[^6]:	which should be weaker with growing distance between reference-referent

[^7]:	only according to the LLM training data, which is still a blackbox

[^8]:	where "obs" comes first

