library(tidyverse)
library(stringr)
library(tidyr)
library(RColorBrewer)

chicago <- read.csv("../data/chicago_edited.csv")

ccc_chart_df <- chicago %>% 
  mutate(allegation = str_sub(summary_allegations, 32)) %>% 
  select(allegation, amount_awarded) %>% 
  filter(allegation != "", 
         allegation != "Other Police Misconduct:Non-Intentional",
         allegation != "Other Police Misconduct:Intentional") %>% 
  filter(is.na(amount_awarded) == FALSE)

ccc_chart_df2 <- chicago %>% 
  mutate(allegation = str_sub(summary_allegations, 32)) %>% 
  select(allegation, amount_awarded) %>% 
  filter(allegation == "Excessive Force Minor" | 
         allegation == "False Arrest" | 
         allegation == "Illegal Search/Seizure") %>% 
  filter(is.na(amount_awarded) == FALSE)



chicago_chart <- ggplot(ccc_chart_df) +
  geom_boxplot(
    aes(
      x = allegation,
      y = amount_awarded
    )
  ) + 
  scale_y_continuous(labels = scales::comma)


chicago_chart2 <- ggplot(ccc_chart_df2) +
  geom_boxplot(
    aes(
      x = allegation,
      y = amount_awarded
    ) 
  ) + 
  scale_y_continuous(labels = scales::comma) 


ccc_chart_df3 <- chicago %>% 
  mutate(Allegation = str_sub(summary_allegations, 32)) %>% 
  select(Allegation, amount_awarded) %>% 
  group_by(Allegation) %>% 
  summarise(total_settlements = sum(amount_awarded)) %>% 
  filter(Allegation != "")


chichart <- ggplot(ccc_chart_df3) +
  aes(fill = Allegation, x = "", y = total_settlements) +
  geom_bar(position="stack", stat="identity") + 
  scale_y_continuous(labels = scales::comma) +
  labs(
    x = "",
    y = "Settlement Amount in USD",
    title = "Distribution of Settlement Accross Different Police 
             Misconduct Allegations in Chicago"
  ) + scale_fill_manual(values = c("#695D3A","#fecd80",
                                   "#f7a55e","#f38072",
                                   "#ec2d46", "#f292bb","#e3b7d4",
                                   "#8b8cc1","#95cbe2",
                                   "#a1d9d9", "#98d0ab"))

chichart













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








