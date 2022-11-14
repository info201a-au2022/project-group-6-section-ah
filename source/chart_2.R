library(tidyverse)
library(stringr)
library(tidyr)

chicago <- read.csv("../data/chicago_edited.csv")

ccc_chart_df <- chicago %>% 
  mutate(allegation = str_sub(summary_allegations, 32)) %>% 
  select(allegation, amount_awarded) %>% 
  filter(allegation != "") %>% 
  filter(is.na(amount_awarded) == FALSE)


chicago_chart <- ggplot(ccc_chart_df) +
  geom_violin(
    aes(
      x = allegation,
      y = amount_awarded
    )
  ) + 
  scale_y_continuous(labels = scales::comma) +
  coord_flip()









locations <- c("Vietnam", "Vietnam", "Vietnam", "Vietnam", "Vietnam",
        "USA", "USA", "USA", "USA", "USA",
        "Antarctica", "Antarctica", "Antarctica","Antarctica","Antarctica", 
        "Vietnam")

temp <- c(90, 80, 100, 110, 75, 
        66, 60, 70, 80, 50,
        26, 20, 10, 5, 15, 87)

df_weather <- data.frame(location = locations, degrees = temp)

weather_plot <- ggplot(df_weather) + geom_boxplot(
  aes(
    x = location,
    y = degrees
  )
)








