# 17425.meinschaefer.colloquium

## recap of term paper 
...to understand statistical analyses done (linear regression modeling...)

- paper referring: [open](https://esteeschwarz.github.io/DC-LX/essais/coherence/)

### notes
this is something like the :ernstfall: > to try method-evaluate/present a 2 years old very technical paper. keywords like

- reproducability
- interoperability

come into play here even when trying to re-build on the base of my own scripts. the paper was created as .rmd documents and output as a bookdown page with a navigating structure through the chapters, the different (here: models) used to evaluate the hypothesis being displayed with corresponding results. (cf. above paper link)

now it would have been good to not (stray) markdown and data files across different repositories and glued together to a finalised website and pdf but to - according to :good scientific practice: ever mentioned - to have an .Rproj dir which assembles that all. but didnt. so now again...

well..., in the course of (inventing it anew) we can also gleich build an app to have the different models/methods showing off nicely-parallel and with just view switches instead of chapters.

now..., sundee 5.50am, still time to go :).

> app running: [here](https://stschwarz.userpage.fu-berlin.de/links?title=stat-coherence&ref=pages-coll)

- this is maintenant only a proxy to the different models that can be applied to analyse the data. so the app is doing nothing new or else than running the lmer() test with the provided (UI selectable) parameters and output graphs/summaries for the applied model. also inlcluding the possibility to test models with a sample dataset provided based on randomized/equalised distribution of response and parameters.