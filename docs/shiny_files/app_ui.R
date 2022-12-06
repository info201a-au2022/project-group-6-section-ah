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


# summary -------------------------------------------------------------------

summary_main_content <- mainPanel(
  
  h2("Mean/Median Settlement Amounts Between Cities"),
  
  p("Comparing and contrasting multiple citys' mean and median settlement
    amounts over the years proves to be really useful in seeing stark differences.
    For example, we can see from Springfield or Milwaukee's data that there are
    immense spikes within settlement medians and means from time to time. When
    researching the amount of settlement money that goes into police misconduct,
    results seem to vary a lot depending on the city, which leaves a greater
    emphasis on studying the cities that have these spikes.
    However, one pattern emerging from this data is that the amount of settlement
    money going into police misconduct cases have been steadily increasing across
    most states within the past few years. From this, we can speculate that more
    people have been coming out with police misconduct cases, or the severity of
    newer cases have been higher."),
  
  h2("Total Settlement Amounts over the Years"),
  
  p("The biggest takeaway from looking at the ", strong("total"), " settlement
    amounts within U.S. cities is seeing how much money a city puts into
    police misconduct cases and what it means for the city's total amount of cases.
    Despite the spikes and outliars within the median/mean graph, many cities
    will not differ from others when it comes to the mean and median amount of 
    police misconduct cases. Instead, the difference of case amounts is clearly
    seen from this graph, where cities like Cleveland slightly outnumbers most
    states. Then, Chicago is seen with greater numbers than Cleveland, and finally,
    New York City towers over every other city when it comes to case amounts,
    resulting in higher total settlement amounts. This pattern is seen and can be
    applicable to all cities."),
  
  h2("Misconduct Types over the Years"),
  
  p("When looking at the number of cases and the distribution of settlement money
  across different types of police misconduct cases, the biggest takeaway is that
    false arrests are by far the highest reason for police misconduct cases to
    occurr. Consistently, false arrests have been the highest reason for them,
    and yet it is also consistently not the reason for the highest settlement money.
    Instead, that goes to cases that have to do with Reversed Convictions
    or Serious Excessive Force. The severity of each case is essential when
    considering the amount of money that goes into the settlements, however,
    something should be done to lower the amount of false arrests as well.")
)

summary_panel <- tabPanel(
  "Summary Takeaways",
  
  titlePanel("Important Findings within the Charts"),
  
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
  
  p(strong("a."), "The datasets were created by Amelia Thomson-DeVeaux, 
    Laura Bronner, and Damini Sharma. Published on 2/22/22, the datasets go in
    depth about the increase of police settlements for misconduct within the last
    few years. It explores why that could be possible by acknowledging different
    possibilities that are all worth thinking about, such as “are police
    misconduct cases happening more?” and “are people coming out with police
    misconduct stories to cause the increase in settlements?”"),
  
  p(strong("b."),"The sources were funded by the Marshall Project, which is a 
    nonprofit organization in the U.S. that focuses on the criminal justice 
    system. Here, the data benefits not only those who want to know more about 
    police misconduct and its settlements, but also communities that have been 
    affected by police misconduct. This sort of transparency is important
    for those affected by police misconduct, as it shows the real weight of 
    the issue."),
  
  p(strong("c."), "The sources took its data from city governments themselves. 
    The authors asked city governments for data, and only some agreed to
    do so. Although this limits the sources’ findings, as not all cities
    are included in the dataset, it is definitely credible and trustworthy."),
    
  p(strong("d."), "The datasets were found on the dataset website, 
    “FiveThirtyEight.” We find all of our sources to be useful in our research, 
    as the content is valuable and important to create a conversation around 
    police misconduct and its abusive behaviors. All our sources are
    listed below."),
  
  
  h2("Findings"),
  
  p("In this project, we had four different research questions in mind that we
  wanted to find answers to help better understand the impact police misconduct
  has on the United States."),
  
  p("The first question was “What is the typical occurrence/frequency of 
    police misconduct in the US?”. One occurrence/frequency that stood out was
    how a year with just one misconduct case’s settlement amount could be so 
    high that it would be greater than other years that have many police
    misconduct cases. This is because some cases are a lot more serious than 
    others and require a lot more settlement money. Also, the cases with the
    highest settlements in most cities are excessive force and false arrest
    allegations. "),
  
  p("The second research question was “What kinds of cases are usually involved
    with police misconduct?”. A lot of cases that are usually involved police
    misconduct are civil rights violations, illegal searches, excessive force,
    and false arrests. These cases often have pretty high settlement amounts 
    and greater consequences for the officers involved since they are taken
    more seriously and have a big impact on the victims and their families."),
  
  p("The third research question was “What are some results of police 
  misconduct cases?”. Police misconduct cases are usually a long fight. There
  are many steps such as an investigation, multiple court hearings, and
  meetings with attorneys. And even then not all cases make it all the way to
  get settlement amounts. But the cases that do make it, get settlement money 
  and justice. Depending on the allegation of the misconduct the police 
  officer(s) involved may get their license revoked or suspended. The 
  settlement amount also depends on how serious the case is. For example, 
  if someone were seriously injured or falsely imprisoned for a large amount
  of time or experiencing long-term emotional/physical/mental damage, they 
  would get more settlement money."),
  
  h2("Discussion"),
  
  p("There are many different types of allegations that are involved in police
  misconduct cases. From failure to respond to medical care to malicious 
  prosecution. There are so many ways that police can abuse their power and
  harm the life of a citizen. Throughout this project, we looked at many 
  different cities and all of their different police misconduct cases 
  throughout the years. The purpose of our four research questions was to look 
  at the bigger picture and dig deeper into the issue of police misconduct in
  the United States. Since each case is so different and there are so many 
  different outcomes to each case."),
  
  p("As we analyzed our data and made multiple charts and tables, we realized 
    that a year with just one misconduct case’s settlement amount could be so 
    high that it would be greater than other years that have many police 
    misconduct cases. False arrest cases that result in long jail sentences
    are often paid a great amount of settlement money, as well as serious 
    excessive force cases. These settlements could reach as high as a couple 
    of million dollars. In comparison to multiple minor cases such as an
    illegal search that only gets a couple thousand each.  In addition, we
    also looked into what usually happens when there is police misconduct. 
    The importance of finding this answer was to look at all the different 
    outcomes that someone could face while seeking justice for their police
    misconduct case. There were limitations to finding an answer to this due
    to the fact that every situation is different and there are so many
    different factors that contribute to how the case could play out."),
  
  p("We also looked into why large amounts of settlements are being paid.
    The importance of finding an answer to this is because police departments
    always have funds to protect themselves and their workers from actually
    facing real consequences for their actions and use money as a shield to
    protect themselves. According to our data, over the past ten years, cities
    have spent more than $3 billion to resolve misconduct lawsuits. It sounds 
    like a lot of money, three billion dollars. The nation's three largest
    cities which are Los Angeles, Chicago, and New Your had a combined budget 
    of over $115 billion just last year, spending the largest chunk, of $2.5
    billion over ten years. This is a massive amount of money to be spending 
    on the wrongdoing of police officers."),
  
  h2("Conclusion"),
  
  p("Our main goal for this project was to spread awareness of police 
    misconduct in the United States. In spite of the fact that police are 
    there to protect citizens and maintain their safety, they frequently pose 
    a threat to that safety. People worry about what will happen to them 
    anytime they are stopped by the police or engaged with them because they 
    are aware of what occurs to people across the country. It occurs frequently
    and there are a lot of incidents of misconduct that happen. Cases of 
    misconduct are brought up as a result of the abuse of power that police 
    have over citizens. In the data analysis we have supplied throughout this
    project, we have observed that they abuse their power."),
  
  p("The datasets that our project focused on were examples of misconduct in 
  several American cities. The years of each case, the summary allegation, 
  the city, and the settlement amount were the main factors that we 
  concentrated on for the majority of our project. Each of these variables
  helped us compare the police misconduct cases and settlements in each city.
  Each city had a different amount of cases and settlements, and it just 
  depends on the severity of a case."),
  
  p("It has become vital to hold police officers accountable for misconduct as 
  the nation has seen incident after incident of police abuse. Police personnel 
  still hardly face criminal charges, despite the increased attention. 
  Therefore, when contact with the police goes wrong, victims' main means of 
  obtaining justice and financial recompense is through civil lawsuits."),
  
  p("The best way for police misconduct cases to be reduced is by spreading
    awareness of everything going on around the cities that we live in.
    Advocacy plays a huge role in reducing injustice in the United States. 
    People all over the country have served time for crimes they did not
    commit and although they may have received settlement money that doesn’t 
    make up for all the trauma that they were put through throughout the
    process of fighting for that justice. Settlement money won’t help bring
    back people that police have wrongfully killed, or make up for the years
    that were lost while spending time in jail for a crime they did not commit.
    Police need to be held more accountable and there should be a greater
    punishment than just a license revoked."),
  
  h2("Acknowledgements"),
  
  p("We would like to thank Biftu Ibrahim for keeping us company during 
    our meetings."),
  
  h2("References"),
  
  p(em("Alternatives to police services"),". Defund The Police. 
       (2020, September 20). 
       https://defundthepolice.org/alternatives-to-police-services/"),
  
  p("Civil Rights Division. (2020).", em("Addressing Police Misconduct Laws 
                                         Enforced by the Department Of 
                                         Justice"),". 
    The United States Department of Justice. 
    https://www.justice.gov/crt/addressing-police-misconduct-laws-
    enforced-department-justice"),
  
  p("Edwards, F., Lee, H., Esposito, M. (2019). Risk of being killed by 
    police use of force in the United States by age, race–ethnicity, and sex.",
    em("Proceedings of the National Academy of Sciences"), 
    "116(34), 16793–16798. https://doi.org/10.1073/pnas.1821204116"),
  
  p("Lum, C., Koper, C. S., & Wu, X. (2021). Can we really defund the police? 
    A nine-agency study of police response to calls for service.", 
    em("Police Quarterly"), 
    ", 25(3), 255–280. https://doi.org/10.1177/10986111211035002"),
  
  p("Thomson-DeVeaux, A., Sharma, D., Bronner, L. (2021, February 22).",
    em("Cities Spend Millions On Police Misconduct Every Year. 
       Here’s Why It’s So Difficult to Hold Departments Accountable."), 
    "FiveThirtyEight. 
    Retrieved from 
    https://fivethirtyeight.com/features/police-misconduct-costs-cities-
    millions-every-year-but-thats-where-the-accountability-ends/")
  
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