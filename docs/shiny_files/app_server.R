library(shiny)
library(tidyverse)
library(plotly)
library(data.table)

all_cities_df <- read.csv("all_cities.csv") %>% 
  select(-X)

chicago <- read.csv("chicago_edited.csv")

chicago_cases <- chicago %>% 
  mutate(type = str_sub(summary_allegations, 32)) %>%
  select(calendar_year, amount_awarded, type) %>% 
  filter(type != "") %>% 
  filter(type != "Other Police Misconduct:Intentional") %>% 
  filter(type != "Other Police Misconduct:Non-Intentional") %>% 
  filter(type != "Other Police Misconduct")

# chart 1 ---------------------------------------------------------------
server<- function(input, output) {
  output$chart1_plot <- renderPlotly({
    
    if (input$calculation == "Median") {
      calculate <- function(x, na.rm = TRUE) {
        return(median(x, na.rm = TRUE))
      }
    }
    
    if(input$calculation == "Median"){
      calculation_label <- "Total Median"
    }
    
    if (input$calculation == "Mean") {
      calculate <- function(x, na.rm = TRUE) {
        return(mean(x, na.rm = TRUE))
      }
    }
    
    if(input$calculation == "Mean"){
      calculation_label <- "Total Mean"
    }
    
    if (input$calculation == "Max") {
      calculate <- function(x, na.rm = TRUE) {
        return(max(x, na.rm = TRUE))
      }
    }
    
    if(input$calculation == "Max"){
      calculation_label <- "Total Max"
    }
    
    if (input$calculation == "Min") {
      calculate <- function(x, na.rm = TRUE) {
        return(min(x, na.rm = TRUE))
      }
    }
    
    if(input$calculation == "Min"){
      calculation_label <- "Total Min"
    }
    
    total <- all_cities_df %>% 
      group_by(calendar_year) %>% 
      summarise(amount_awarded_calculation = calculate(amount_awarded, na.rm = TRUE)) %>% 
      filter(calendar_year < 3000) %>% 
      mutate(city = calculation_label)
    
    cities <- all_cities_df %>% 
      filter(city == input$chart1_city1 | city == input$chart1_city2 |
               city == input$chart1_city3) %>% 
      group_by(calendar_year, city) %>% 
      summarise(amount_awarded_calculation = calculate(amount_awarded, na.rm = TRUE))%>% 
      filter(calendar_year < 3000)
    
    total_df <- rbind(total, cities)
    
    total_df$city <- factor(total_df$city, levels = c(calculation_label, 
                                                      input$chart1_city1,
                                                      input$chart1_city2,
                                                      input$chart1_city3))
    
    the_plot <- ggplot(total_df, aes(
      x = calendar_year,
      y = amount_awarded_calculation
    )) + geom_line(aes(color = city)) + 
      scale_y_continuous(labels = scales::comma) +
      labs(
        x = "Year",
        y = paste(input$calculation, "Settlement Amount in USD"),
        color = "City"
      ) + xlim(input$chart1_years)
    
    ggplotly(the_plot)
    
    
    
  })
  
  # chart 2 ---------------------------------------------------------------
  output$chart2_plot <- renderPlotly({
    
    if (input$chart2_select == "Settlement Amount") {
      df <- all_cities_df %>% 
        filter(city == input$chart2_city | city == input$chart2_city2 |
                 city == input$chart2_city3) %>% 
        group_by(calendar_year, city) %>% 
        summarise(n = sum(amount_awarded))
    }
    
    if (input$chart2_select == "Number of Cases") {
      df <- all_cities_df %>% 
        filter(city == input$chart2_city | city == input$chart2_city2 |
                 city == input$chart2_city3) %>% 
        group_by(calendar_year, city) %>% 
        count()
    }
    
    
    el_plot <- ggplot(df, aes(
      x = calendar_year,
      y = n,
      fill = city
    )) + geom_col(position = "dodge") +
      scale_x_continuous(breaks = df$calendar_year) +
      labs(
        x = "Year",
        y = input$chart2_select,
        title = ("Distributions")
      ) + scale_y_continuous(labels = scales::comma)
    
    ggplotly(el_plot) 
    
    
  })
  
  
  # chart 3 old -------------------------------------------------------------
  output$chart6_plot <- renderPlotly({
    amount_df <- all_cities_df %>% 
      filter(city == input$chart3_city) %>% 
      group_by(calendar_year) %>% 
      summarize(amount_of_cases = length(amount_awarded))
    
    scatter_plot <- ggplot(data = amount_df, aes(x = calendar_year, y = amount_of_cases)) +
      geom_point(size = input$sizes, color = "#6FABF9") +
      scale_y_continuous(labels = scales::comma) +
      xlim(input$chart3_years) +
      ggtitle("") +
      labs(
        x = "Year",
        y = "Amount of Cases",
        color = "City",
        caption = "")
    
    scatter_plot
  })
  
  # chart 3 -----------------------------------------------------------------
  
  output$chart3_plot <- renderPlotly({
    
    if (input$chart3_year != "All") {
      chicago_cases <- chicago_cases %>% 
        filter(calendar_year == input$chart3_year)
    }
    
    if (input$chart3_select == "Settlement Amount") {
      chicago_cases <- chicago_cases %>%
        group_by(type) %>% 
        summarise(n = sum(amount_awarded, na.rm = TRUE))
    }
    
    if (input$chart3_select == "Number of Cases") {
      chicago_cases <- chicago_cases %>%
        group_by(type) %>% 
        count()
    }
    
    xd <- ggplot(chicago_cases, aes(
      x = type,
      y = n,
      fill = type)) +
      geom_col() +
      labs(
        x = "Misconduct Category",
        y = input$chart3_select,
        fill = "Misconduct Category Legend"
      ) +
      theme(axis.text.x = element_blank()) +
      scale_y_continuous(labels = scales::comma)
    ggplotly(xd)
  })
  
  
  # report table for dataset ------------------------------------------------
  
  output$datasetreport <- renderTable({
    names <- c("all_cities.csv", "baltimore_edited.csv", "chicago_edited.csv",
               "los_angeles_edited.csv", "new_york_edited.csv")
    
    colx <- c(3, 20, 24, 23, 21)
    
    rowx <- c(39066, 82, 1515, 997, 32632)
    
    dataset <- data.frame(File = names, 
                                 Columns = colx,
                                 Rows = rowx)
    
    table <- setDT(dataset)
    table
    
  })
  
  
}

# test code ----

df <- all_cities_df %>% 
  filter(city == "Los Angeles" | city == "Memphis" |
           city == "Chicago") %>% 
  group_by(calendar_year, city) %>%
  count()