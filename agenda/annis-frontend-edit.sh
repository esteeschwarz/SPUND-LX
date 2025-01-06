# 15023.notes
# the ANNIS frontend contains a corpus selector which falls back to the corpora directory i.e. showing all available corpora nomatter if on an instance i.e. you cannot hide corpora in the dir from public.

# ANNIS frontend html to corpus selector element 
<input type="text" class="v-filterselect-input" autocomplete="0.8563441342551953" dir="" tabindex="0" placeholder="Select corpus selection set" style="width: 100%;">
# > this to remove from script
# > no. .jar is compiled
# decompile, edit, recompile (cop)
<https://github.com/leibnitz27/cfr?tab=readme-ov-file>
java -jar cfr.jar yourfile.jar --outputdir /path/to/output
javac -d /path/to/classes /path/to/output/**/*.java
jar cf newfile.jar -C /path/to/classes .