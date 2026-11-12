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
  tags$head(tags$style(HTML("
    .scroll-sidebar {
      height: calc(100vh - 40px);
      overflow-y: auto;
      position: sticky;
      top: 20px;
    }
  "))),
  theme = bs_theme(bootswatch = "lux"),
  
  
  # Title ----
  titlePanel("W26 coherence-c: S25 term paper evaluation"),
  
  # Sidebar ----
  sidebarLayout(
    sidebarPanel("PRESETS:",
       class = "scroll-sidebar",
      width = 3,
      radioButtons("norm_target", "normalize to", 
                   list("don't normalize" = "",
"obs" = "_rel_obs",
                        "ref"= "_rel_ref",
                    "all" = "_rel_all")),
      radioButtons("limit", "discard outliers", 
                   list("no" = F,
                        "yes"= T)),
                        radioButtons("author", "author", 
                   list("include in lm" = T,"don't include"= F
                        )),

                        radioButtons("url", "url", 
                   list("don't include"= F,"include in lm" = T
                        )),
                        radioButtons("det.t", "DET", 
                   list(
                        "don't include"= F,
                     "include in lm" = T)),  

                        radioButtons("range.t", "range", 
                   list("don't include"= F,"include in lm" = T
                        )),
                        radioButtons("lemma", "lemma", 
                   list("don't include"= F,"include in lm" = T
                        )),
                        radioButtons("embed.t", "embed score", 
                   list("don't include"= F,"include in lm" = T
                        )), 
      radioButtons("lme", "simple regression", 
                   list("off"= F,"on" = T
                        )),  
            actionButton("submit","apply preset & run"),
            hr(),
                                       HTML(mark(text=readLines("legend.md"))),


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

                           verbatimTextOutput("dfe.table"),
                           HTML(mark(text=readLines("legend.md"))
                           )),
                  #tabPanel("documentation",HTML(mark_html(text=readLines(mdsrc_HA)))),
                  tabPanel("numbers",
                                             verbatimTextOutput("effects"),
                           verbatimTextOutput("modelexp"),
                           verbatimTextOutput("dfs1"),
                           verbatimTextOutput("dfs2"),
                           verbatimTextOutput("dfslm")),

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
