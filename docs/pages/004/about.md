# About

Invalid Date

# About

This page is part of the same website.

It shows that you can have multiple HTML pages and still offer a
separate PDF report.

echo: true, command

``` r
# A very long R line to show wrapping in PDF:
paste("this-is-a-very-long-string", 1:100, collapse = " ")
```

    [1] "this-is-a-very-long-string 1 this-is-a-very-long-string 2 this-is-a-very-long-string 3 this-is-a-very-long-string 4 this-is-a-very-long-string 5 this-is-a-very-long-string 6 this-is-a-very-long-string 7 this-is-a-very-long-string 8 this-is-a-very-long-string 9 this-is-a-very-long-string 10 this-is-a-very-long-string 11 this-is-a-very-long-string 12 this-is-a-very-long-string 13 this-is-a-very-long-string 14 this-is-a-very-long-string 15 this-is-a-very-long-string 16 this-is-a-very-long-string 17 this-is-a-very-long-string 18 this-is-a-very-long-string 19 this-is-a-very-long-string 20 this-is-a-very-long-string 21 this-is-a-very-long-string 22 this-is-a-very-long-string 23 this-is-a-very-long-string 24 this-is-a-very-long-string 25 this-is-a-very-long-string 26 this-is-a-very-long-string 27 this-is-a-very-long-string 28 this-is-a-very-long-string 29 this-is-a-very-long-string 30 this-is-a-very-long-string 31 this-is-a-very-long-string 32 this-is-a-very-long-string 33 this-is-a-very-long-string 34 this-is-a-very-long-string 35 this-is-a-very-long-string 36 this-is-a-very-long-string 37 this-is-a-very-long-string 38 this-is-a-very-long-string 39 this-is-a-very-long-string 40 this-is-a-very-long-string 41 this-is-a-very-long-string 42 this-is-a-very-long-string 43 this-is-a-very-long-string 44 this-is-a-very-long-string 45 this-is-a-very-long-string 46 this-is-a-very-long-string 47 this-is-a-very-long-string 48 this-is-a-very-long-string 49 this-is-a-very-long-string 50 this-is-a-very-long-string 51 this-is-a-very-long-string 52 this-is-a-very-long-string 53 this-is-a-very-long-string 54 this-is-a-very-long-string 55 this-is-a-very-long-string 56 this-is-a-very-long-string 57 this-is-a-very-long-string 58 this-is-a-very-long-string 59 this-is-a-very-long-string 60 this-is-a-very-long-string 61 this-is-a-very-long-string 62 this-is-a-very-long-string 63 this-is-a-very-long-string 64 this-is-a-very-long-string 65 this-is-a-very-long-string 66 this-is-a-very-long-string 67 this-is-a-very-long-string 68 this-is-a-very-long-string 69 this-is-a-very-long-string 70 this-is-a-very-long-string 71 this-is-a-very-long-string 72 this-is-a-very-long-string 73 this-is-a-very-long-string 74 this-is-a-very-long-string 75 this-is-a-very-long-string 76 this-is-a-very-long-string 77 this-is-a-very-long-string 78 this-is-a-very-long-string 79 this-is-a-very-long-string 80 this-is-a-very-long-string 81 this-is-a-very-long-string 82 this-is-a-very-long-string 83 this-is-a-very-long-string 84 this-is-a-very-long-string 85 this-is-a-very-long-string 86 this-is-a-very-long-string 87 this-is-a-very-long-string 88 this-is-a-very-long-string 89 this-is-a-very-long-string 90 this-is-a-very-long-string 91 this-is-a-very-long-string 92 this-is-a-very-long-string 93 this-is-a-very-long-string 94 this-is-a-very-long-string 95 this-is-a-very-long-string 96 this-is-a-very-long-string 97 this-is-a-very-long-string 98 this-is-a-very-long-string 99 this-is-a-very-long-string 100"

echo: false, readlines  
cell-output cell-output-stdout

    [1] "System prompt: You are a member of the german parliament. You will be provided a plenary protocol text. Please summarize the text for presentation to your local community. Output summary in german language. Constraints: No preamble, output summary as plaintext with no extra formatting, limit summary to 20% of input text."
    [2] ""                                                                                                                                                                                                                                                                                                                                  
    [3] "Plenary protocol text: _bttx_"                                                                                                                                                                                                                                                                                                     

echo: true, readlines

``` r
ptx<-readLines("gemini-prompt.txt")
ptx
```

    [1] "System prompt: You are a member of the german parliament. You will be provided a plenary protocol text. Please summarize the text for presentation to your local community. Output summary in german language. Constraints: No preamble, output summary as plaintext with no extra formatting, limit summary to 20% of input text."
    [2] ""                                                                                                                                                                                                                                                                                                                                  
    [3] "Plenary protocol text: _bttx_"                                                                                                                                                                                                                                                                                                     

``` r
# A very long R line to show wrapping in PDF: # A very long R line to show wrapping in PDF: # A very long R line to show wrapping in PDF: # A very long R line to show wrapping in PDF: # A very long R line to show wrapping in PDF: # A very long R line to show wrapping in PDF: # A very long R line to show wrapping in PDF: # A very long R line to show wrapping in PDF:



readLines("gemini-prompt.txt")
```

    [1] "System prompt: You are a member of the german parliament. You will be provided a plenary protocol text. Please summarize the text for presentation to your local community. Output summary in german language. Constraints: No preamble, output summary as plaintext with no extra formatting, limit summary to 20% of input text."
    [2] ""                                                                                                                                                                                                                                                                                                                                  
    [3] "Plenary protocol text: _bttx_"                                                                                                                                                                                                                                                                                                     

``` r
t<-tempfile("t.txt")
writeLines(ptx,t)
#tx<-readtext::readtext(t)$text
#tx
##
```

``` r
# A very long R line to show wrapping in PDF:
paste("this-is-a-very-long-string", 1:100, collapse = " ")
```

    [1] "this-is-a-very-long-string 1 this-is-a-very-long-string 2 this-is-a-very-long-string 3 this-is-a-very-long-string 4 this-is-a-very-long-string 5 this-is-a-very-long-string 6 this-is-a-very-long-string 7 this-is-a-very-long-string 8 this-is-a-very-long-string 9 this-is-a-very-long-string 10 this-is-a-very-long-string 11 this-is-a-very-long-string 12 this-is-a-very-long-string 13 this-is-a-very-long-string 14 this-is-a-very-long-string 15 this-is-a-very-long-string 16 this-is-a-very-long-string 17 this-is-a-very-long-string 18 this-is-a-very-long-string 19 this-is-a-very-long-string 20 this-is-a-very-long-string 21 this-is-a-very-long-string 22 this-is-a-very-long-string 23 this-is-a-very-long-string 24 this-is-a-very-long-string 25 this-is-a-very-long-string 26 this-is-a-very-long-string 27 this-is-a-very-long-string 28 this-is-a-very-long-string 29 this-is-a-very-long-string 30 this-is-a-very-long-string 31 this-is-a-very-long-string 32 this-is-a-very-long-string 33 this-is-a-very-long-string 34 this-is-a-very-long-string 35 this-is-a-very-long-string 36 this-is-a-very-long-string 37 this-is-a-very-long-string 38 this-is-a-very-long-string 39 this-is-a-very-long-string 40 this-is-a-very-long-string 41 this-is-a-very-long-string 42 this-is-a-very-long-string 43 this-is-a-very-long-string 44 this-is-a-very-long-string 45 this-is-a-very-long-string 46 this-is-a-very-long-string 47 this-is-a-very-long-string 48 this-is-a-very-long-string 49 this-is-a-very-long-string 50 this-is-a-very-long-string 51 this-is-a-very-long-string 52 this-is-a-very-long-string 53 this-is-a-very-long-string 54 this-is-a-very-long-string 55 this-is-a-very-long-string 56 this-is-a-very-long-string 57 this-is-a-very-long-string 58 this-is-a-very-long-string 59 this-is-a-very-long-string 60 this-is-a-very-long-string 61 this-is-a-very-long-string 62 this-is-a-very-long-string 63 this-is-a-very-long-string 64 this-is-a-very-long-string 65 this-is-a-very-long-string 66 this-is-a-very-long-string 67 this-is-a-very-long-string 68 this-is-a-very-long-string 69 this-is-a-very-long-string 70 this-is-a-very-long-string 71 this-is-a-very-long-string 72 this-is-a-very-long-string 73 this-is-a-very-long-string 74 this-is-a-very-long-string 75 this-is-a-very-long-string 76 this-is-a-very-long-string 77 this-is-a-very-long-string 78 this-is-a-very-long-string 79 this-is-a-very-long-string 80 this-is-a-very-long-string 81 this-is-a-very-long-string 82 this-is-a-very-long-string 83 this-is-a-very-long-string 84 this-is-a-very-long-string 85 this-is-a-very-long-string 86 this-is-a-very-long-string 87 this-is-a-very-long-string 88 this-is-a-very-long-string 89 this-is-a-very-long-string 90 this-is-a-very-long-string 91 this-is-a-very-long-string 92 this-is-a-very-long-string 93 this-is-a-very-long-string 94 this-is-a-very-long-string 95 this-is-a-very-long-string 96 this-is-a-very-long-string 97 this-is-a-very-long-string 98 this-is-a-very-long-string 99 this-is-a-very-long-string 100"

``` r
1+2
```

    [1] 3

``` r
paste("this-is-a-very-long-string", 1:100)
```

      [1] "this-is-a-very-long-string 1"   "this-is-a-very-long-string 2"  
      [3] "this-is-a-very-long-string 3"   "this-is-a-very-long-string 4"  
      [5] "this-is-a-very-long-string 5"   "this-is-a-very-long-string 6"  
      [7] "this-is-a-very-long-string 7"   "this-is-a-very-long-string 8"  
      [9] "this-is-a-very-long-string 9"   "this-is-a-very-long-string 10" 
     [11] "this-is-a-very-long-string 11"  "this-is-a-very-long-string 12" 
     [13] "this-is-a-very-long-string 13"  "this-is-a-very-long-string 14" 
     [15] "this-is-a-very-long-string 15"  "this-is-a-very-long-string 16" 
     [17] "this-is-a-very-long-string 17"  "this-is-a-very-long-string 18" 
     [19] "this-is-a-very-long-string 19"  "this-is-a-very-long-string 20" 
     [21] "this-is-a-very-long-string 21"  "this-is-a-very-long-string 22" 
     [23] "this-is-a-very-long-string 23"  "this-is-a-very-long-string 24" 
     [25] "this-is-a-very-long-string 25"  "this-is-a-very-long-string 26" 
     [27] "this-is-a-very-long-string 27"  "this-is-a-very-long-string 28" 
     [29] "this-is-a-very-long-string 29"  "this-is-a-very-long-string 30" 
     [31] "this-is-a-very-long-string 31"  "this-is-a-very-long-string 32" 
     [33] "this-is-a-very-long-string 33"  "this-is-a-very-long-string 34" 
     [35] "this-is-a-very-long-string 35"  "this-is-a-very-long-string 36" 
     [37] "this-is-a-very-long-string 37"  "this-is-a-very-long-string 38" 
     [39] "this-is-a-very-long-string 39"  "this-is-a-very-long-string 40" 
     [41] "this-is-a-very-long-string 41"  "this-is-a-very-long-string 42" 
     [43] "this-is-a-very-long-string 43"  "this-is-a-very-long-string 44" 
     [45] "this-is-a-very-long-string 45"  "this-is-a-very-long-string 46" 
     [47] "this-is-a-very-long-string 47"  "this-is-a-very-long-string 48" 
     [49] "this-is-a-very-long-string 49"  "this-is-a-very-long-string 50" 
     [51] "this-is-a-very-long-string 51"  "this-is-a-very-long-string 52" 
     [53] "this-is-a-very-long-string 53"  "this-is-a-very-long-string 54" 
     [55] "this-is-a-very-long-string 55"  "this-is-a-very-long-string 56" 
     [57] "this-is-a-very-long-string 57"  "this-is-a-very-long-string 58" 
     [59] "this-is-a-very-long-string 59"  "this-is-a-very-long-string 60" 
     [61] "this-is-a-very-long-string 61"  "this-is-a-very-long-string 62" 
     [63] "this-is-a-very-long-string 63"  "this-is-a-very-long-string 64" 
     [65] "this-is-a-very-long-string 65"  "this-is-a-very-long-string 66" 
     [67] "this-is-a-very-long-string 67"  "this-is-a-very-long-string 68" 
     [69] "this-is-a-very-long-string 69"  "this-is-a-very-long-string 70" 
     [71] "this-is-a-very-long-string 71"  "this-is-a-very-long-string 72" 
     [73] "this-is-a-very-long-string 73"  "this-is-a-very-long-string 74" 
     [75] "this-is-a-very-long-string 75"  "this-is-a-very-long-string 76" 
     [77] "this-is-a-very-long-string 77"  "this-is-a-very-long-string 78" 
     [79] "this-is-a-very-long-string 79"  "this-is-a-very-long-string 80" 
     [81] "this-is-a-very-long-string 81"  "this-is-a-very-long-string 82" 
     [83] "this-is-a-very-long-string 83"  "this-is-a-very-long-string 84" 
     [85] "this-is-a-very-long-string 85"  "this-is-a-very-long-string 86" 
     [87] "this-is-a-very-long-string 87"  "this-is-a-very-long-string 88" 
     [89] "this-is-a-very-long-string 89"  "this-is-a-very-long-string 90" 
     [91] "this-is-a-very-long-string 91"  "this-is-a-very-long-string 92" 
     [93] "this-is-a-very-long-string 93"  "this-is-a-very-long-string 94" 
     [95] "this-is-a-very-long-string 95"  "this-is-a-very-long-string 96" 
     [97] "this-is-a-very-long-string 97"  "this-is-a-very-long-string 98" 
     [99] "this-is-a-very-long-string 99"  "this-is-a-very-long-string 100"

``` r
cat(readLines("gemini-prompt.txt"), sep = "\n")
```

System prompt: You are a member of the german parliament. You will be
provided a plenary protocol text. Please summarize the text for
presentation to your local community. Output summary in german language.
Constraints: No preamble, output summary as plaintext with no extra
formatting, limit summary to 20% of input text.

Plenary protocol text: *bttx*

### div

``` r
txt <- readLines("gemini-prompt.txt")
cat(sprintf('<div class="cell-output cell-output-stdout">
<pre><code>%s</code></pre>
</div>',txt))
```

<div class="cell-output cell-output-stdout">

<pre><code>System prompt: You are a member of the german parliament. You will be provided a plenary protocol text. Please summarize the text for presentation to your local community. Output summary in german language. Constraints: No preamble, output summary as plaintext with no extra formatting, limit summary to 20% of input text.</code></pre>

</div>

<div class="cell-output cell-output-stdout">

<pre><code></code></pre>

</div>

<div class="cell-output cell-output-stdout">

<pre><code>Plenary protocol text: _bttx_</code></pre>

</div>
