# 15203.info
#### reddit psych corpus notes

#### udpipe tagset:
<https://universaldependencies.org/u/pos/index.html>

#### udpipe tagset table

| POS tag | description              |     |
| ------- | ------------------------- | --- |
| ADJ     | adjective                 |     |
| ADP     | adposition                |     |
| ADV     | adverb                    |     |
| AUX     | auxiliary                 |     |
| CCONJ   | coordinating conjunction  |     |
| DET     | determiner                |     |
| INTJ    | interjection              |     |
| NOUN    | noun                      |     |
| NUM     | numeral                   |     |
| PART    | particle                  |     |
| PRON    | pronoun                   |     |
| PROPN   | proper noun               |     |
| PUNCT   | punctuation               |     |
| SCONJ   | subordinating conjunction |     |
| SYM     | symbol                    |     |
| VERB    | verb                      |     |
| X       | other                     |     |

#### nosketchengine API

```bash
curl -X GET "https://corp.dh-index.org/ske/concordance?corpname=reddit-psych&format=json&q=q%5Bword%3D%22language%22%5D+within+%3Cdoc+author%3D%22%28.%2A%29%22+%2F%3E"
```

the following query fetches a complete concordance similar to the web interface view, including struct meta data (as e.g. author). based on that it's possible to in case of the intended study perform further queries limited to these authors possibly with english or other L2 features, as "language" (a rough first guess) is subject of the posts.

```bash
curl -X GET "https://corp.dh-index.org/ske/concordance?corpname=reddit-psych&q=q%5Blemma%3D%22language%22%5D&attrs=word,upos,lemma&structs=s,doc&refs=doc.id,doc.author&ctxattrs=word,upos,lemma&context=10+10&viewMode=json"
```

[> view query results in browser](https://corp.dh-index.org/ske/concordance?corpname=reddit-psych&q=q%5Blemma%3D%22language%22%5D&attrs=word,upos,lemma&structs=s,doc&refs=doc.id,doc.author&ctxattrs=word,upos,lemma&context=10+10&viewMode=json)


