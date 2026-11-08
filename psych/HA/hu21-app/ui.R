library(shiny)
library(readtext)
library(markdown)
library(htmltools)
library(bslib)

# loaddata
#mdsrc_01<-"~/boxHKW/21S/DH/gith/DH_essais/sections/hux2021/hux_ha_shinyframe01.Rmd"
mdsrc_legende<-"https://raw.githubusercontent.com/esteeschwarz/DH_essais/main/sections/hux2021/hux_ha_shiny_legende.md"
#mdsrc_02<-"~/boxHKW/21S/DH/gith/essais/docs/SPUND_HA/12065.HA.meinschäfer.md"
mdsrc_HA<-"https://raw.githubusercontent.com/esteeschwarz/DH_essais/main/sections/hux2021/hux2021_HA_12304.md"
src_d<-("https://github.com/esteeschwarz/essais/raw/main/docs/hux2021/evaluation/sprdataprepared.csv")
frame_src<-"framesample.txt"
#frame_src<-("https://github.com/esteeschwarz/hux2021/raw/main/framesample.html")


###### here output of set of checkboxed input
# wrapped for implement view on shiny
# UI ---------------------------------------------------------------------------
ui <- fluidPage(
  theme = bs_theme(bootswatch = "lux"),
  
  
  # Title ----
  titlePanel("HUX2021: self paced reading experiment evaluation"),
  
  # Sidebar ----
  sidebarLayout(
    sidebarPanel(
      radioButtons("tm1", "target preceding phrase", 
                   list("include" = -1,
                        "exclude"= "not")),  
      radioButtons("t0", "target", 
                   list("include" = 0,
                        "exclude"= "not")),  
      
      radioButtons("t1", "target following phrase", 
                   list("include" = 1,
                        "exclude"= "not")),  
      radioButtons("out", "discard outliers", 
                   list("on" = 1,
                        "off"= 0)),  
      radioButtons("gilt", "only valid cases", 
                   list("on" = 1,
                        "off"= 0)),  
      radioButtons("ctrl", "add control observations", 
                   list("on" = 1,
                        "off"= 0)),  
      
      br(),
      #p("choose group to compare vs Other")
      radioButtons("groups", "chose group to compare vs All", 
                   list("single metaphor" = "SM",
                        "extended metaphor"= "EM",
                        "literal condition" = "LC",
                        "inverted single metaphor"= "MM"))
      
      # checkboxGroupInput("groups","select (1) group to compare vs Other",
      #                    c("single metaphor" = "SM",
      #                      "extended metaphor"="EM",
      #                      "literal condition"="LC",
      #                      "mixed model"="MM")),

      
    ), 
    # Main panel ----
    mainPanel(
      tabsetPanel(id="tabset",
                  tabPanel("visualisation",
                           verbatimTextOutput("info"),
                           plotOutput("plot"),
                           plotOutput("box"),
                           plotOutput("bars"),
                           HTML(mark(text=readLines(mdsrc_legende)))),
                  #tabPanel("documentation",HTML(mark_html(text=readLines(mdsrc_HA)))),
                  tabPanel("documentation",HTML(mark(text=c(readLines(mdsrc_HA),"snc:14273.4")))),
                  
                  tabPanel("data sample",verbatimTextOutput("daten")),
                  tabPanel("study sample",HTML(readLines(frame_src))),
                  tabPanel("data chosen",verbatimTextOutput("eval"))
                  ), #tabset end
#      verbatimTextOutput("compare",HTML(mark_html(text = readLines(mdsrc_legende)))),
                 # verbatimTextOutput("compare",  HTML(mark(text = readLines(mdsrc_legende))))
                #  verbatimTextOutput("legende")

          ) #sidebar layout
  ) #end mainpanel
) # end mainpage
