# 12303.hux2021 evaluation app
# 20220725(14.28) 
# author: esteeschwarz, on base of:
# http://econometricsbysimulation.shinyapps.io/OLS-App/
# app deployed at:https://vision2020.shinyapps.io/hux2021/
##########################################################
# stages:
# 20220725(15.22) working, deployed.
# TODO: selection of group for groupwise comparison, lmer test
# 14273.link correction over all pages connected

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
#source("ui.r")
#source("server.R")
shinyApp(ui = "ui.R", server ="server.R")
