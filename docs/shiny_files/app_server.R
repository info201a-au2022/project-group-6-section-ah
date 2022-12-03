library(shiny)
library(tidyverse)
library(plotly)

all_cities_df <- read.csv("all_cities.csv") %>% 
  select(-X)

?factor
# chart 1 ---------------------------------------------------------------
server<- function(input, output) {
  output$chart1_plot <- renderPlotly({
    total <- all_cities_df %>% 
      group_by(calendar_year) %>% 
      summarise(amount_awarded_median = median(amount_awarded, na.rm = TRUE)) %>% 
      filter(calendar_year < 3000) %>% 
      mutate(city = "Total Median")
    
    cities <- all_cities_df %>% 
      filter(city == input$chart1_city1 | city == input$chart1_city2 |
               city == input$chart1_city3) %>% 
      group_by(calendar_year, city) %>% 
      summarise(amount_awarded_median = median(amount_awarded, na.rm = TRUE))%>% 
      filter(calendar_year < 3000)
    
    total_df <- rbind(total, cities)
  
    total_df$city <- factor(total_df$city, levels = c("Total Median", 
                                                      input$chart1_city1,
                                                      input$chart1_city2,
                                                      input$chart1_city3))
    
    the_plot <- ggplot(total_df, aes(
      x = calendar_year,
      y = amount_awarded_median
    )) + geom_line(aes(color = city)) + 
      scale_y_continuous(labels = scales::comma) +
      labs(
        x = "Year",
        y = "Median Settlement Amount in USD",
        color = "City"
      ) + xlim(input$chart1_years)
    
    ggplotly(the_plot)
    
    
    
  })
  
# chart 2 ---------------------------------------------------------------
  output$chart2_plot <- renderPlotly({
    df <- all_cities_df %>% 
      filter(city == input$chart2_city) %>% 
      group_by(calendar_year) %>%
      summarise(amount_awarded = sum(amount_awarded))
    
    el_plot <- ggplot(df, aes(
      x = calendar_year,
      y = amount_awarded
    )) + geom_col(fill = "#CC95E0", color = "#CC95E0") +
      scale_x_continuous(breaks = df$calendar_year) +
      labs(
        x = "Year",
        y = "Total Settlement Amount in USD",
        title = paste(input$chart2_city, "Distributions")
      ) + scale_y_continuous(labels = scales::comma)
    
    ggplotly(el_plot) 
    
    
  })
 
# chart 3 ---------------------------------------------------------------
  output$chart3_plot <- renderPlotly({
    if (input$calculation == "Median") {
      calculate <- function(x, na.rm = TRUE) {
        return(median(x, na.rm = TRUE))
      }
    }
<<<<<<< HEAD
    
=======
      
>>>>>>> c45f471d97bcdee5d70d1d75b7c8e6486eb51246
    if (input$calculation == "Mean") {
      calculate <- function(x, na.rm = TRUE) {
        return(mean(x, na.rm = TRUE))
      }
    }
    
    if (input$calculation == "Range") {
      calculate <- function(x, na.rm = TRUE) {
        return(range(x, na.rm = TRUE))
      }
    }
    
    if (input$calculation == "Max") {
      calculate <- function(x, na.rm = TRUE) {
        return(max(x, na.rm = TRUE))
      }
    }
    
    if (input$calculation == "Min") {
      calculate <- function(x, na.rm = TRUE) {
        return(min(x, na.rm = TRUE))
      }
    }
    
    
    chart3_df <- all_cities_df %>% 
      filter(city == input$chart3_city) %>% 
      group_by(calendar_year) %>% 
      summarize(amount_awarded = calculate(amount_awarded, na.rm = TRUE))
    
    scatter_plot <- ggplot(data = chart3_df, aes(x = calendar_year, y = amount_awarded, color = input$colors)) +
      geom_point(size = input$sizes) +
      scale_y_continuous(labels = scales::comma) +
      xlim(input$chart1_years) +
      ggtitle("") +
      labs(
        x = "Year",
        y = "Settlement Amount",
        caption = "") 
    scatter_plot
  })
<<<<<<< HEAD
}
=======
}



>>>>>>> c45f471d97bcdee5d70d1d75b7c8e6486eb51246