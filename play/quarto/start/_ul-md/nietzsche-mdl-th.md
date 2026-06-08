# 16243.nietzsche.mdl.thesenpapier.draft
## intro
es soll untersucht werden, wie bei autor/, denen heute/vergangenheit eine ambivalente gesinnung (pol. themen) angedeutet wird, evtl. fragwürdige einstellungen auch auf nietzsche zurückgehen bzw. spuren dieser gesinnungen auch schon bei nietzsche zu finden sind. dazu sollen korpusanalysen durchgeführt werden (distant reading)
## method
1. erstellung nietzsche korpus
2. erstellung bsp. benn corpus resp. verfügbare (relevante: gesinnung[ambivalenz]) primaere korpus

- fuzzy string matching of [1] in [2]
	- train model on [1]
	- get embeddings for [2]
	- compare vectors and output nearest neighbour tokens

3. keyword list of relevant (gesinnung) tokens