# 17462.coherence evaluation app
# 20261108(06.04) 
# author: esteeschwarz, on base of:
# http://econometricsbysimulation.shinyapps.io/OLS-App/
# on final base at:https://vision2020.shinyapps.io/hux2021/
##########################################################
# stages:
# 20261108(06.05) building.

# Load packages ----------------------------------------------------------------
library(shiny)
###
#compute.R
###### here output of set of checkboxed input
# wrapped for implement view on shiny
# UI ---------------------------------------------------------------------------
# SERVER
# Create the Shiny app object --------------------------------------------------
#library(bslib)
source("ui.r")
source("server.R")
#shinyApp(ui = "ui.R", server ="server.R")
shinyApp(ui , server)
