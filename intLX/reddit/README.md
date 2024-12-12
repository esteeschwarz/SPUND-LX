# 15506.info
## reddit/de corpus essai

#### annotation layers

| layer           | example | expliquer                        |
| --------------- | ------- | -------------------------------- |
| doc\_id         |         |                                  |
| paragraph\_id   |         |                                  |
| sentence\_id    |         |                                  |
| sentence        |         | complete sentence                |
| token\_id       |         | token position in sentence       |
| word            |         | token                            |
| lemma           |         | lemma                            |
| upos            |         | PoS tag                          |
| feats           |         | gender, numerus, case            |
| head\_token\_id |         | position of head token           |
| dep\_rel        |         | relation token / head token      |
| df\_id          |         | id of text in untagged dataframe |
| date            |         | date of comment                  |
| author          |         | author of comment                |
| com\_id         |         | comment id                       |
| url             |         | comment url                      |

#### queries
- you can query in all fields, using complex or simple queries
- use the CQL builder to construct a complex query
  - the language is CQL, just the field names have to be adapted to above scheme

> so if you want to query for a female NOUN + lemma "haben" or "tun" use:   
`[upos="NOUN" & feats=".*Fem.*"] [lemma="haben|tun"]`   
in the CQL builder, which shows you 994 hits if all is correct.

