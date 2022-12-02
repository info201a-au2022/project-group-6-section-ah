library(shiny)
library(tidyverse)
library(plotly)

# some code -----------------------------------------------------------------

df_ui <- read.csv("all_cities.csv") %>% 
  select(city) %>% 
  unique()

# intro ---------------------------------------------------------------------

intro_main_content <- mainPanel()

intro_panel <- tabPanel(
  "Introduction",
  
  titlePanel("Introduction"),
  
  intro_main_content
)

# chart 1 -----------------------------------------------------------------==

chart1_sidebar_content <- sidebarPanel(
  h3("Configurations"),
  
  selectInput(
    inputId = "chart1_city1",
    label = "Select cities to compare:",
    choices = df_ui$city,
    selected = "Memphis"
  ),
  
  selectInput(
    inputId = "chart1_city2",
    label = "",
    choices = df_ui$city,
    selected = "Los Angeles"
  ),
  
  selectInput(
    inputId = "chart1_city3",
    label = "",
    choices = df_ui$city,
    selected = "Philadelphia"
  ),
  
  sliderInput(
    inputId = "chart1_years",
    label = "Selected Years",
    min = 2005,
    max = 2020,
    value = c(2009, 2020),
    sep = ""
  )
)

chart1_main_content <- mainPanel(
  plotlyOutput(outputId = "chart1_plot"),
  
  p("Caption")
)

chart1_panel <- tabPanel(
  "Settlement Medians",
  
  titlePanel("Comparing Settlement Amount Medians of Major Cities Over the Years"),
  
  chart1_sidebar_content,
  
  chart1_main_content
)

# chart 2 -------------------------------------------------------------------

chart2_sidebar_content <- sidebarPanel()

chart2_main_content <- mainPanel()

chart2_panel <- tabPanel(
  "Chart 2",
  
  titlePanel("My Page 2"),
  
  chart2_sidebar_content,
  
  chart2_main_content
)

# chart 3 -------------------------------------------------------------------

chart3_sidebar_content <- sidebarPanel()

chart3_main_content <- mainPanel()

chart3_panel <- tabPanel(
  "Chart 3",
  
  titlePanel("My Page 3"),
  
  chart3_sidebar_content,
  
  chart3_main_content
)

# summary -------------------------------------------------------------------

summary_main_content <- mainPanel()

summary_panel <- tabPanel(
  "Summary",
  
  titlePanel("My summary takeaways"),
  
  summary_main_content
)

# report --------------------------------------------------------------------

report_main_content <- mainPanel()

report_panel <- tabPanel(
  "Report",
  
  titlePanel("My report"),
  
  summary_main_content
)




ui<- fluidPage(
  navbarPage("Police Misconduct", intro_panel, chart1_panel, chart2_panel,
             chart3_panel, summary_panel, report_panel)
)
