
SOURCEDIR="."
SOURCEFILE="input.txt"

# EMAGYAR_MODULES=tok,morph,pos,conv-morph,dep,chunk,ner

BASE_STRUC="s"

FILE="source"


# all: all-e-magyar
# all-e-magyar: collect analyse-e-magyar postprocess
# all-none: collect analyse-none postprocess


# [1] -- collect input
#collect:
	cat $SOURCEDIR/$SOURCEFILE > $FILE.txt


# [2]/option#1 -- only words
#analyse-none:
#	cat $FILE.txt | tr '	' '\n' | tr ' ' '\n' > $FILE.tsv


# [2]/option#2 -- default e-magyar analysis
#analyse-e-magyar:
	# cat $(FILE).txt | docker run --rm -i mtaril/emtsv $(EMAGYAR_MODULES) | tail -n +2 > $(FILE).tsv
Rscript poscorp.R

# [3] -- primitive convert to NoSkE format
#postprocess:
	(echo '<doc file="file" n="1">\n<$BASE_STRUC>' ; cat $FILE.tsv | sed "s/^$$/<\/$BASE_STRUC>\n<$BASE_STRUC>/"; echo '</$BASE_STRUC>\n</doc>') > $FILE

# >>> (echo '<doc file="file" n="1">\n<s>' ; cat source.tsv | sed "s/^/<\/s>\n<s>/"; echo '</s>\n</doc>') > testvrt

(echo -e '<doc id="1">\n<s>';cat source.tsv ;echo '</s>\n</doc>') > testvrt
