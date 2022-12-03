library(shiny)
library(tidyverse)
library(plotly)

# some code -----------------------------------------------------------------

df_ui <- read.csv("all_cities.csv") %>% 
  select(city) %>% 
  unique()

View(df_ui)
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
  "Comparing Settlement Medians",
  
  titlePanel("Comparing Settlement Amount Medians of Major Cities Over the Years"),
  
  chart1_sidebar_content,
  
  chart1_main_content
)

# chart 2 -------------------------------------------------------------------

chart2_sidebar_content <- sidebarPanel(
  h3("Configurations"),
  
  selectInput(
    inputId = "chart2_city",
    label = "Select a city to view:",
    choices = df_ui$city,
    selected = "Los Angeles"
  )
)
  
chart2_main_content <- mainPanel(
  plotlyOutput(outputId = "chart2_plot")
)

chart2_panel <- tabPanel(
  "Settlement Totals Across the Years",
    
  titlePanel("My Page 2"),
  
  chart2_sidebar_content,
  
  chart2_main_content
)

# chart 3 ------------------------------------------------------------------
chart3_sidebar_content <- sidebarPanel(
  h3("Configurations"),
  
  selectInput(
    inputId = "chart3_city",
    label = "Select a city to view:",
    choices = df_ui$city,
    selected = "Los Angeles"
  ),
  
  sliderInput(
    inputId = "chart3_years",
    label = "Selected Years",
    min = 2005,
    max = 2020,
    value = c(2009, 2020),
    sep = ""
  ),
  
  size_input <- sliderInput(
    "sizes",
    label = "Size of point", min = 1, max = 10, value = 5
  )
)

chart3_main_content <- mainPanel(
  plotlyOutput(outputId = "chart3_plot")
)

chart3_panel <- tabPanel(
  "Settlement Totals Across the Years",
  
  titlePanel("My Page 3"),
  
  chart3_sidebar_content,
  
  chart3_main_content
)
# chart 4 -------------------------------------------------------------------

#chart4_sidebar_content <- sidebarPanel(
#  h3("Configurations"),
#  
#  selectInput(
#    inputId = "chart4_city",
#    label = "Select a city to view:",
#    choices = df_ui$city,
#    selected = "Los Angeles"
#  ),
#  
#  selectInput(
#    inputId = "calculation",
#    label = "Select a calculation to view:",
#    choices = c("Median", "Mean", "Range", "Max", "Min"),
#    selected = "Mean"
#  ),
#  
#  sliderInput(
#    inputId = "chart4_years",
#    label = "Selected Years",
#    min = 2005,
#    max = 2020,
#    value = c(2009, 2020),
#    sep = ""
#  ),
#  
#  size_input <- sliderInput(
#    "sizes",
#    label = "Size of point", min = 1, max = 10, value = 5
#  ),
#  
#  radioButtons(
#    inputId = "colors",
#    label = "Select a color for the scatter plot",
#    choices = c("Pink", "Blue", "Green", "Red", "Yellow"),
#    selected = "Pink"
#  )
#)
#
#chart4_main_content <- mainPanel(
#  plotlyOutput(outputId = "chart4_plot")
#)
#
#chart4_panel <- tabPanel(
#  "Chart 4",
#  
#  titlePanel("My Page 4"),
#  
#  chart4_sidebar_content,
#  
#  chart4_main_content
#)

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
