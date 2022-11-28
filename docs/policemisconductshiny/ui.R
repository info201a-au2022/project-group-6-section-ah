library(shiny)
library(tidyverse)

# intro

intro_main_content <- mainPanel()

intro_panel <- tabPanel(
  "Introduction",
  
  titlePanel("Introduction"),

  intro_main_content
  )

# chart 1

chart1_sidebar_content <- sidebarPanel(
  h2("sidebar stuff teehee")
)

chart1_main_content <- mainPanel(
  p("Hello, and welcome.")
)

chart1_panel <- tabPanel(
  "Chart 1",
  
  titlePanel("My Page 1"),
  
  chart1_sidebar_content,
  
  chart1_main_content
  )

# chart 2

chart2_sidebar_content <- sidebarPanel()

chart2_main_content <- mainPanel()

chart2_panel <- tabPanel(
  "Chart 2",
  
  titlePanel("My Page 2"),
  
  chart2_sidebar_content,
  
  chart2_main_content
)

# chart 3

chart3_sidebar_content <- sidebarPanel()

chart3_main_content <- mainPanel()

chart3_panel <- tabPanel(
  "Chart 3",
  
  titlePanel("My Page 3"),
  
  chart3_sidebar_content,
  
  chart3_main_content
)

# summary

summary_main_content <- mainPanel()

summary_panel <- tabPanel(
  "Summary",
  
  titlePanel("My summary takeaways"),
  
  summary_main_content
)

# report

report_main_content <- mainPanel()

report_panel <- tabPanel(
  "Report",
  
  titlePanel("My report"),
  
  summary_main_content
)




shinyUI(fluidPage(
  navbarPage("Police Misconduct", intro_panel, chart1_panel, chart2_panel,
             chart3_panel, summary_panel, report_panel)
))
