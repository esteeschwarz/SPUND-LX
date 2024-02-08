get.light.annotation<-function(corpus.df.deprel){
  concrete.give<-c(1066,2620,10469,20369,20373,20377,31957,41100,45424,45538,48045,50236,51759,52340,52341,54654,56016,60668,
                   61952,64351,67497,69012,70356,71167,74595,75162,76991,77442,77553,81098,81099,81859,81860,94278,
                   96953,99281,99880)
  
  concrete.give.txt<-c("sticker","sweets","antibiotic","gift","iguana","recognition","toothpick","herb","anything","enzyme","cake","lettuce","candy","card","literature","ornament","tape","ticket","pair","clothes","juice","pepper","money","goldfish","machine","cup","kiss","amount","bit","picture","mine","pass","dollar","ten","drink","something","car","lot")
  
  concrete.make.txt<-c("horseshoe","sound","cartilage","ceviche","food","noise","hay","grape","cookie","spatula","clothes","wiper","quilt","outfit","copy","tape","string","intercession","application","balloon","basket","kebab","salad","juice","gravy","tamale","sauce","ton","tail","stuff","papers","pasta","loaf","sandwich","ornament","picture","pillow","database","statue","pizza","fudge","recipe","pan","plate","decaf","tart")
  
  concrete.take<-c(848,6381,14466,16674,18611,18809,19366,22031,24813,24827,24829,24831,24832,24834,24835,29159,32908,36540,
                   38239,38243,38247,38253,38254,38258,45020,45021,45032,49577,49582,49583,49588,53267,56405,56406,56409,
                   59372,61588,61592,65654,65656,65657,66021,69440,71127,72201,72320,73797,73798,78435,78440,78442,
                   79454,79456,82282,83099,83834,83836,84599,85311,85932,88155,89310,91865,93070,96464,96465,99149,
                   99745,104020,117695)
  
  concrete.take.txt<-c("balloon","shelf","checkbook","car","bag","everything","puppies","silverware","torque","tree","Tupperware","wastebasket","wire","money","capsule","guitar","stub","tail","Tylenol","blanket","clipping","tablecloth","crown","medicine","nail","spacesuit","sweater","hers","knife","rack","rock","diary","woodwork","pill","ticket","trash","plug","some","tape","band","flip","water","container","pants","buck","insulin","foot","painting","drug","gift","cart","hair","egg","ball","dollar","pound","drink","thing","NPH")
  concrete.false.take<-c("while","time","care","advantage","picture","half","off","down","dollars to do it","look","with me","out","them to")
  concrete.false.take.regx<-paste0(concrete.false.take,collapse = "|")
  concrete.false.take.regx<-paste0("(",concrete.false.take.regx,")")
  #concrete.take.txt<-gsub("\\.[NA0-1]","",concrete.take.txt)
  # write_clip(paste0(concrete.take.txt,collapse = '","'))
  ##########################################################
  ### apply light label
  corpus.df.deprel$light<-NA
  corpus.df.deprel$alt<-"a-other"
  ###
#   q.lemma<-"make|made|making"
#   q.lemma<-"give|given|gave"
#   lemma<-"make"
#   lemma<-"give"
#   ###
# #  concrete.array<-c(concrete.make.txt)
# #  concrete.array<-c(concrete.give.txt)
#   # #  concrete.array
  apply.light<-function(corpus.df.deprel=corpus.df.deprel,q.lemma,lemma,concrete.array){
    corpus.df.deprel$lemma<-gsub("[^a-zA-z']","",corpus.df.deprel$lemma)
    corpus.df.deprel$head_lemma_value<-gsub("[^a-zA-z']","",corpus.df.deprel$head_lemma_value)
    m5<-corpus.df.deprel$lemma==""
    corpus.df.deprel$lemma[m5]<-NA
    m6<-corpus.df.deprel$head_lemma_value==""
    corpus.df.deprel$head_lemma_value[m6]<-NA
    m1<-grepl(q.lemma,corpus.df.deprel$sentence)
    m13<-grepl(lemma,corpus.df.deprel$lemma)
    m14<-grepl(lemma,corpus.df.deprel$head_lemma_value)
    
    # sum(m1)
    # sum(m13)
    # #corpus.df.deprel$sentence[m1]
    # #unique(corpus.df.deprel$head_lemma_value)
    # length(unique(corpus.df.deprel$head_token_value))
    # length(unique(corpus.df.deprel$token))
    # #table(corpus.df.deprel$lemma)
    corpus.df.deprel$alt[m1]<-lemma # set concrete instances
    corpus.df.deprel$light[m13]<-1 # set all to light
    #lemma
    library(stringi)
    library(purrr)
    concrete.regx<-paste0(concrete.array,collapse = "|")
    concrete.regx<-paste0('(',concrete.regx,')')
    m38<-grepl(concrete.regx,corpus.df.deprel$lemma)
    m41.alt<-corpus.df.deprel$alt==lemma
    #sum(m41)
    corpus.df.deprel$light[m41.alt]<-1
    m42.conc<-corpus.df.deprel$lemma[m41.alt]%in%concrete.array|corpus.df.deprel$token[m41.alt]%in%concrete.array
  #  sum(m42.conc)
    m43.obj<-corpus.df.deprel$obj[m41.alt][m42.conc]==lemma
    corpus.df.deprel$light[m41.alt][m42.conc][m43.obj]<-0
    #    sum(m40)
    #   corpus.df.deprel$lemma[m41][m39][m40]
    m39.conc.sent<-grepl(concrete.regx,corpus.df.deprel$sentence[m41.alt])
    m40.lemma.alt.sent<-grepl(lemma,corpus.df.deprel$lemma[m41.alt][m39.conc.sent])
    # sum(lemma,corpus.df.deprel$lemma[m39][m40])
    # corpus.df.deprel$light[m38]<-0
    corpus.df.deprel$light[m41.alt][m39.conc.sent][m40.lemma.alt.sent]<-0
    return(corpus.df.deprel)
  }
  
  corpus.df.deprel<-apply.light(corpus.df.deprel,"make|made|making","make",concrete.make.txt)
  corpus.df.deprel<-apply.light(corpus.df.deprel,"take|took|taken|taking","take",concrete.take.txt)
  corpus.df.deprel<-apply.light(corpus.df.deprel,"give|gave|given|giving","give",concrete.give.txt)
  table(corpus.df.deprel$alt,corpus.df.deprel$light,corpus.df.deprel$head_lemma_value)
  #chk
  return(corpus.df.deprel)
}


get.collex<-function(coll6,filter.pos,vers,na.rm=FALSE){
  m3<-coll6$lemma==coll6$head_lemma_value # remove observations with lemma==head_lemma
  sum(m3,na.rm = T)
  #coll6na<-coll6
  coll6<-coll6[!m3,]
  m4<-!is.na(coll6$light)
#  sum(m4)
 # k<-1
  if(na.rm==F)
    coll6$light[m4]<-"n.a."
  # m5<-is.na(coll6$obj.to)
  # coll6<-coll6[!m5,]
  if(length(filter.pos)>0){
    for(k in length(filter.pos)){
      col<-names(filter.pos[k])
      coll6<-coll6[coll6[[col]]%in%filter.pos[[k]],]
    }
  }
  if(vers=="light"){
    colldf.light<-data.frame(head_lemma=coll6$head_lemma_value,lemma=coll6$lemma,light=coll6$light)
    coll6.2<-collex.covar.mult(colldf.light,threshold = 1,decimals = 3)
  }
  #  coll6.2
  if(vers=="lemma"){
    colldf.lemma<-data.frame(head_lemma=coll6$head_lemma_value,lemma=coll6$lemma)
    coll6.2<-collex.covar(colldf.lemma,decimals = 3)
  }
  return(coll6.2)
}
