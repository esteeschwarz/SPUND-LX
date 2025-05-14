# 15203.info
#### reddit psych corpus notes

#### udpipe tagset:
<https://universaldependencies.org/u/pos/index.html>

#### udpipe tagset table

| POS tag | desciription              |     |
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
