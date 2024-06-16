# shell: pip install wn
###
import wn
wn.download('ewn:2020')
wn.synsets('coffee')
wn.download('odenet:1.4')
wn.synsets('bau')
w=wn.words('trauer')
ss=wn.synsets('bau')
ss = wn.synsets('trauer', pos='n')[0]
ss.hypernyms()[0].lemmas()
ss.hyponyms()[0].lemmas()
ss.definition()
ss.translate(lang='en')
