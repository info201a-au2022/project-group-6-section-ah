library(shiny)
library(tidyverse)
library(plotly)

# some code -----------------------------------------------------------------

df_ui <- read.csv("all_cities.csv") %>% 
  select(city) %>% 
  unique()

View(df_ui)
# intro ---------------------------------------------------------------------

intro_main_content <- mainPanel(
  h1("Introduction"),
  
  p("In the United States, police have historically been at the forefront of 
  many issues. They frequently abuse the power they have over citizens, leading 
  them to believe that their actions are acceptable and justified. They always 
  seem to escape punishment for their actions. Whether it involves unexplained 
  and unjustified killings, arrests, profiling, violence, etc. justice is 
  frequently not served for the victims.  However, for this project, we will 
  concentrate on police who are held accountable for their misconduct and the 
  settlements they establish with the victims and their families in major 
  American cities. This will examine the specific cases that take place and 
  the corresponding settlements."),
  
  h1("Our Data"),
  
  p("We have 4 datasets that we have included in this project. One of them 
    focuses on 30 major cities in the United States and the other three focus 
    on singular cities which are Los Angeles, New York, and Chicago. Our 
    project used these datasets to focus on examples of misconduct in several 
    American cities. The years of each case, the summary allegation, and the 
    settlement amount were the main variables that we concentrated on for the 
    majority of our project.")
)

intro_panel <- tabPanel(
  "Home",
  
  titlePanel("Home"),
  
  intro_main_content
)

# chart 1 -----------------------------------------------------------------==

chart1_sidebar_content <- sidebarPanel(
  h3("Configurations"),
  
  radioButtons(
    inputId = "calculation",
    label = "Select a measure of center to view:",
    choices = c("Median", "Mean"),
    selected = "Median"
  ),
  
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
  
  p("This is a multi-variable line chart that displays the trends of 
    settlements, measured in either the median or mean. Each line/color is 
    represented by a city. It is also cross-referenced by the total of all 
    cities combined. Years displayed on the X-axis may be adjusted to 
    appropriately fit the scale. This is a useful tool to compare settlements 
    in measures of center, of not only cities but also the total population of 
    all the cities in the data combined.")
)

chart1_panel <- tabPanel(
  "Comparing Settlements",
  
  titlePanel("Comparing Settlement Amounts of Major Cities Over the Years"),
  
  chart1_sidebar_content,
  
  chart1_main_content
)

# chart 2 -------------------------------------------------------------------

chart2_sidebar_content <- sidebarPanel(
  h3("Configurations"),
  
  selectInput(
    inputId = "chart2_city",
    label = "Select cities to view:",
    choices = df_ui$city,
    selected = "San Francisco"
  ),
  
  selectInput(
    inputId = "chart2_city2",
    label = "",
    choices = df_ui$city,
    selected = "Milwaukee"
  ),
  
  selectInput(
    inputId = "chart2_city3",
    label = "",
    choices = df_ui$city,
    selected = "Detroit"
  )
)
  
chart2_main_content <- mainPanel(
  plotlyOutput(outputId = "chart2_plot"),
  
  p("This is a multi-variable bar chart that displays the trends of the total 
    settlement amount across the years. Each color represents a city, and each 
    bar represents the year, corresponding to the color/city. This is a useful 
    tool to compare settlement totals of different cities over the years.")
)

chart2_panel <- tabPanel(
  "Settlement Totals Distributions",
    
  titlePanel("Settlement Amount Totals Across the Years"),
  
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
  "Cases Across the Years",
  
  titlePanel("Amount of Police Misconduct Cases Across the Years"),
  
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
