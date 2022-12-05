library(shiny)
library(tidyverse)
library(plotly)
library(shinythemes)

# some code -----------------------------------------------------------------

df_ui <- read.csv("all_cities.csv") %>% 
  select(city) %>% 
  unique()

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
  
  radioButtons(
    inputId = "chart2_select",
    label = "Select the Viewing Method:",
    choices = c("Settlement Amount", "Number of Cases"),
    selected = "Settlement Amount"
  ),
  
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
    settlement amount, and the total amount of cases across the years. Each 
    color represents a city, and each bar represents the year, corresponding
    to the color/city. This is a useful tool to compare both settlement totals
    and the total amount of cases in different cities over the years.")
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
  
  radioButtons(
    inputId = "chart3_select",
    label = "Select the Viewing Method:",
    choices = c("Settlement Amount", "Number of Cases"),
    selected = "Settlement Amount"
  ),
  
  selectInput(
    inputId = "chart3_year",
    label = "Select a Year to View:",
    choices = c("All", 2010:2019),
    selected = "All"
  )
)

chart3_main_content <- mainPanel(
  plotlyOutput(outputId = "chart3_plot"),
  
  p("This is a bar graph that displays the total amount of settlements, and 
    amount of cases, within specific police misconduct categories. Each bar 
    represents a type of police misconduct, which can be referenced from the
    legend. Users can switch whether to see the dollar amount of settlements
    or the number of cases. Users can also look at trends in specific years.")
)

chart3_panel <- tabPanel(
  "Misconduct Types Across the Years",
     
  titlePanel("Types of Police Misconduct Cases Across the Years in Chicago,
             Illinois"),
     
  chart3_sidebar_content,
   
  chart3_main_content)
































# old chart 3 -----------------------------------------

# chart3_sidebar_content <- sidebarPanel(
#   h3("Configurations"),
#   
#   selectInput(
#     inputId = "chart3_city",
#     label = "Select a city to view:",
#     choices = df_ui$city,
#     selected = "Los Angeles"
#   ),
#   
#   sliderInput(
#     inputId = "chart3_years",
#     label = "Selected Years",
#     min = 2005,
#     max = 2020,
#     value = c(2009, 2020),
#     sep = ""
#   ),
#   
#   size_input <- sliderInput(
#     "sizes",
#     label = "Size of point", min = 1, max = 10, value = 5
#   )
# )
# 
# chart3_main_content <- mainPanel(
#   plotlyOutput(outputId = "chart3_plot")
# )
# 
# chart3_panel <- tabPanel(
#   "Cases Across the Years",
#   
#   titlePanel("Amount of Police Misconduct Cases Across the Years"),
#   
#   chart3_sidebar_content,
#   
#   chart3_main_content
# )
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

report_main_content <- mainPanel(
  h1("Police Misconduct in the United States"),
  
  p("Code name: ", em("PBS Kids")),
  
  p(strong("Authors: Bright Hoang | Paul Oh | Salma Yusuf")),
  
  p(em("Keywords: Police Misconduct / Police Reform / Civil Court Settlement 
       / Police Reform")),
  
  h2("Abstract"),
  
  p("Our main concern is with the outrageous amount of instances of police 
    misconduct and the high amount of settlement paid for these misconducts. 
    This is important because no one wants to be a victim of police misconduct, 
    but it does exist, so we need to have a discussion about instances that do 
    occur. We plan to highlight these cases to not only educate but to research 
    law enforcement policies that will decrease the number of police 
    misconducts."),
  
  h2("Introduction"),
  
  p("Police have always been at the center of a lot of issues in the United 
    States. They tend to abuse the power that they hold over citizens which 
    lets them believe that their actions are justified and reasonable. From 
    unexplained and unjustified killings, arrests, profiling, violence, etc. 
    They always seem to not be held accountable for their actions and there is 
    often no justice that is served. However, for this project, we will be 
    focusing on police that is held accountable for their misconduct and the 
    settlements that they make to the victims and/or their families in major 
    cities in the United States. This will include the specific misconducts 
    that happen and the settlements that go along with them. We will also focus 
    on how we can reduce police misconduct and understand why it happens 
    starting off with specific cases in major cities across America."),
  
  h2("Problem Domain"),
  
  h4(strong("Background")),
  
  p("Over the years, many police departments in major cities in the United 
    States have spent hundreds of millions of taxpayer dollars on police 
    misconduct settlements. But first, what exactly is determined as police 
    misconduct? Police misconduct can be defined as law enforcement committing 
    illegal and unethical acts on official duty. According to the United States
    Department of Justice (DOJ), police misconduct can be included in 
    “both", em("criminal"),"and", em("civil"), "statutes” 
    (Civil Rights Division, 2020, para. 2)."),
  
  h4(strong("Human Values")),
  
  p("It is important to recognize the lives and experiences of victims of 
    police misconduct. Police brutality, the ultimate form of police misconduct, 
    has a racial disproportion against Black Americans. Black men are 2.5 times 
    more likely to be killed by law enforcement compared to their white 
    counterparts (Edwards, 2019, p. 16794). It is necessary to protest against 
    the racial injustices Americans face from the very entity, law enforcement, 
    meant to protect them."),
  
  h4(strong("Stakeholders")),
  
  p("Direct stakeholders of this data include: law enforcement personnel, 
    government officials, and news journalists. Law enforcement is a direct 
    stakeholder because the entire dataset is based upon their ability to do 
    their job. They can reflect on this information and be more aware of the 
    scenarios that may occur in their line of work. Journalists, specifically
    those who specialize in justice and social issues, are also direct
    stakeholders because they are able to utilize their resources and skills 
    to publicize stories of police misconduct. An indirect stakeholder would
    be Americans who read the articles written by those journalists and those 
    who pay government taxes that law enforcement agencies use to pay
    settlements for victims."),
  
  h4(strong("Harms & Benefits")),
  
  p("A possible result of this data could be a type of police reform. An 
    example of this is the “Defund the Police” movement, which fights for the 
    relocation of police funds, and to turn to alternative policing services 
    (“Alternatives to police services,” 2020). This conversation often strikes
    up debate about whether or not defunding the police is beneficial or not. 
    The root and common denominator of all police misconduct are well, police.
    Abolishing the police systems will certainly decrease the number of police
    misconduct. However, there are possible harms and tradeoffs. It has been 
    debated that abolishing the police will turn the nation into the “Purge,”
    a dystopian society where all crimes are decriminalized for twelve hours. 
    It has also been argued the police are frequently called for a wide variety
    of reasons such as traffic disputes, everyday issues, suspicious behavior, 
    etc (Lum et al., 2021, p. 271)."),
  
  h2("Research Questions"),
  
  p("1.", strong("Question:"), 
    
    "What is the typical occurrence/frequency of police misconduct in the US?"),
  
  p(strong("Importance:"), "As police misconduct involves police officers who 
    are supposed to be under the law at any given time, it is important to know 
    just how much police misconduct goes on within the police forces of the U.S.
    Knowing its frequency will help figure out how prominent of a problem this
    is."),
  
  p("2.", strong("Question:"), 
    
    "What kinds of cases are usually involved with police misconduct?"),
  
  p(strong("Importance:"), "This question gives more insight into how exactly 
    police officers within the United States are using their power. This could 
    be through excessive force, sexual assault, fraud, forceful confessions,
    and more. Overall, we need to know more about the areas in which police 
    abuse or exercise their power."),
  
  p("3.", strong("Question:"), 
    
    "What are some results of police misconduct cases?"),
  
  p(strong("Importance:"), "After finding out what examples of police 
    misconduct occur throughout the country, the next thing to find out is 
    what happens as a result of these cases. This question may be hard to 
    answer, as not every case of police misconduct goes noticed, however, 
    knowing what happens to cases that do go noticed is important to observe. 
    Researching this question will reveal whether or not police officers are 
    held accountable, or even if they are held accountable as equally 
    as others."),
  
  h2("Datasets"),
  
  p("The datasets used in this report lists the different police misconduct
    cases on a city level. The dataset is grouped by many big cities in the 
    country, showing a more focused view on police misconduct. It also shows 
    the amount awarded to those who were affected in the form of police
    settlements. These numbers can reveal results from cases of police 
    misconduct where settlements were successfully made and can show how 
    direct stakeholders were impacted by the police misconduct cases."),
  
  tableOutput("datasetreport"),
  
  
  
)

report_panel <- tabPanel(
  "Report",
  
  titlePanel("Report Page"),
  
  report_main_content
)




ui<- fluidPage(
  theme = shinytheme("flatly"),
  navbarPage("Police Misconduct", intro_panel, chart1_panel, chart2_panel,
             chart3_panel, summary_panel, report_panel)
)
