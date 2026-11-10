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
    sidebarPanel("PRESETS:",
      radioButtons("norm_target", "normalize to", 
                   list("obs" = "_rel_obs",
                        "ref"= "_rel_ref",
                    "all" = "_rel_all",
               "don't normalize" = "")),
      radioButtons("limit", "discard outliers", 
                   list("yes" = T,
                        "no"= F)),
                   radioButtons("det.t", "DET", 
                   list("include in lm" = T,
                        "don't include"= F)),  

                        radioButtons("author", "author", 
                   list("include in lm" = T,
                        "don't include"= F)),
                        radioButtons("range", "range", 
                   list("include in lm" = T,
                        "don't include"= F)),
                        radioButtons("lemma", "lemma", 
                   list("include in lm" = T,
                        "don't include"= F)),
                        radioButtons("embed", "embed score", 
                   list("include in lm" = T,
                        "don't include"= F)), 
      radioButtons("lme", "simple regression", 
                   list("on" = T,
                        "off"= F)),  
            actionButton("submit","apply preset & run"),

      br(),
      #p("choose group to compare vs Other")
    ), 
    # Main panel ----
    mainPanel(
      tabsetPanel(id="tabset",
                  tabPanel("visualisation",
                           verbatimTextOutput("info"),
                           plotOutput("boxplot1"),
                           plotOutput("barplot.mean"),
                           plotOutput("barplot.median"),
                           plotOutput("lmeplot"),
                           plotOutput("gplot"),

                           HTML("dfe.table"),
                           HTML(mark(text=readLines(mdsrc_legende))
                           )),
                  #tabPanel("documentation",HTML(mark_html(text=readLines(mdsrc_HA)))),
                  tabPanel("numbers",
                                             verbatimTextOutput("effects"),
                           verbatimTextOutput("modelexp"),
                           verbatimTextOutput("dfs1"),
                           verbatimTextOutput("dfs2")),
                  # summary table (static, built at UI creation)
                  tabPanel("debug",  tableOutput("dbg_tbl"))

# HTML(mark(text=c(readLines(mdsrc_HA),"snc:14273.4"))

                  
                   #tabset end

          )
       #tabset #sidebar layout
  ) #end mainpanel
)
  ) #sidebar end
#  )  # end mainpage
