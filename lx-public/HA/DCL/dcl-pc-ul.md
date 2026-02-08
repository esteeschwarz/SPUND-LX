#### ext
wie man an diesem beispiel sieht, kann der seiteninhalt auch dynamisch aus externen quellen generiert werden zum zeitpunkt des aufrufs der seite; hier von dem repository, wo die primäre arbeit an diesem projekt vor sich geht. das heiszt, das templating system und die möglichkeit der aktualisierungen wird hier voll ausgereizt, weil prinzipiell jede online verfügbare markdown datei als quelle dieses dokumentabschnitts herangezogen werden kann und arbeiten auf diese weise, ohne am grundaufbau einer seite etwas ändern zu müssen, ohne aufand integriert werden und damit stets auf dem neuesten stand gehalten werden können. auszerdem kann auf diese weise jede\* user\* in der jeweils ihr vertrauten umgebung die bausteine bearbeiten ohne überhaupt kenntnisse mit dem jekyll framework udgl. haben zu müssen. hier genügt bereits ein github account, um die markdown datei online verfügbar machen zu können.

#### limitations, machbarkeit
wie wir sehen, ist "markdown" hier das mittel der wahl, um ziemlich convenient content zu kreiren. mit diesem "textformat" sollte man sich deshalb zumindest auseinandersetzen - was m.e. keine gröszere schwierigkeit darstellt und (auch m.e.) ohnehin der fixen formatierung innerhalb proprietärer oder auch open source WYSIWYG (what-you-see-is-what-you-get) textverarbeitungen [word, pages, openoffice udgl.] vorgezogen werden, da auf diese weise dokumente in freien und mit ausgiebigen features versehenen texteditoren erstellt/geschrieben werden und auf simple weise konsistent formatiert werden können, ohne mit einem haufen von untereinander nicht-kompatiblen stilen und vorlagen kämpfen zu müssen. mit diesem system sollte man sich for convenience sake jdfs. wirklich vertraut machen. markdown. simple is that... / und wer durchaus weiter in seinem word schreiben will, kann das leider trotzdem tun, den text als plain text exportieren und wenn dieser nur minimal formatiert wird, sieht er am ende schon gut aus.

##### markdown formatierungsbeispiel

	# header 1
	textabschnit usw...
	
	## head 1.1: eine kleine liste
	
	- item 1
	- item 2
	- item 3
	  - subitem 1
	  - subitem 2
	- item 4
	
	# head 2
	bissel text noch... und vielleicht eine kleine[^1] fusznote
	
	[^1]: fusznotentext, nur zur veranschaulichung

das sieht dann so aus (bringt zwar die abschnitte jetzt durcheinander, aber seis drum...)

# header 1
textabschnit usw...

## head 1.1: eine kleine liste

- item 1
- item 2
- item 3
  - subitem 1
  - subitem 2
- item 4

# head 2
bissel text noch... und vielleicht eine kleine[^1] fusznote

#### nochwas?
[...]

### notes on the umsetzung
[...]

[^1]:	fusznotentext, nur zur veranschaulichung