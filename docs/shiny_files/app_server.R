library(shiny)
library(tidyverse)
library(plotly)

all_cities_df <- read.csv("all_cities.csv") %>% 
  select(-X)


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
        y = "Median Settlement Amount",
        color = "City"
      ) + xlim(input$chart1_years)
    
    ggplotly(the_plot)
    
    
    
  })
  
  
  
}