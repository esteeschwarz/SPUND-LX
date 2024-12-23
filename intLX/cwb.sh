cwb-encode -d ~/pro/cwb/reddit/reddit1 -f com.vrt.1-1000.txt -c utf8 -P token -P lemma -P tag -S text+id -S s


# mini12:
# registry 


-P doc_id -P paragraph_id -P sentence_id -P sentence -P token_id -P word -P lemma -P upos -P feats -P head_token_id -P dep_rel -P df_id -P date -P author -P com_id -P url

rdf.6
word,pos,lemma,doc_id,p_id,sent_id,sent,tok_id,feat,head_tok_id,rel,df_id,date,author,x,url

# compile
# or:
cwb-encode -d ~/mycorpus -f filename.xml -R /usr/local/share/cwb/registry/mycorpus -c latin1 -P pos -P lemma -S text+id -S s -0 corpus

cwb-encode -d ~/cwb/indexed/rdf6 -f cwb/corpora/reddit/cwb.vrt -c UTF8 -P pos -P lemma, -P doc_id, -P p_id, -P sent_id, -P sent, -P tok_id, -P feat, -P head_tok_id, -P rel, -P df_id, -P date, -P author, -P x, -P url -S doc+id -S s

cwb-makeall -V REDDIT

# lapsi
-P lemma -P tag -P feats -P sentence -P tok_id -P head_tok_id -P dep_rel -P doc_id -P par_id -P sent_id -P timestamp -P date -P com_id -P author -P votes -P url

cwb-encode -d ~/pro/cwb/indexed/rdf1 -f com.vrt.1-1000.txt -R ~/pro/cwb/registry/rgrdf1 -c UTF8 -P lemma -P tag -P feats -P sentence -P tok_id -P head_tok_id -P dep_rel -P doc_id -P par_id -P sent_id -P timestamp -P date -P com_id -P author -P votes -P url -S text+id -S s

cwb-encode -d ~/pro/cwb/indexed/rdf1 -f com.vrt.1-1000.txt -R ~/pro/cwb/registry/rgrdf1 -c UTF8 -P lemma -P tag -P feats -P sentence -P tok_id -P head_tok_id -P dep_rel -P doc_id -P par_id -P sent_id -P timestamp -P date -P com_id -P author -P votes -P url -S text+id -S s
