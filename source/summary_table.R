library(tidyverse)
library(stringr)
library(knitr)
library(DT)

chicago <- read.csv("../data/chicago_edited.csv")
chicago <- chicago %>% 
  mutate(Year = calendar_year)


summary_chart <- chicago %>% 
  group_by(Year) %>% 
  summarise(
    "Median Settlement per Case" = median(amount_awarded),
    "Mean Settlement per Case" = mean(amount_awarded),
    "Highest Settlement Amount" = max(amount_awarded),
    "Lowest Settlement Amount" = min(amount_awarded)
    )


C_DUI <- chicago %>% 
  filter(str_detect(summary_allegations, "DUI")) %>% 
  group_by(Year) %>% 
  summarise("Median DUI Case" = median(amount_awarded),
            "Mean DUI Case" = mean(amount_awarded))


C_EF_Minor <- chicago %>% 
  filter(str_detect(summary_allegations, "Excessive Force Minor")) %>% 
  group_by(Year) %>% 
  summarise("Median Excessive Force Minor Case" = median(amount_awarded),
            "Mean Excessive Force Minor Case" = mean(amount_awarded))


C_EF_Serious <- chicago %>% 
  filter(str_detect(summary_allegations, "Excessive Force Serious")) %>% 
  group_by(Year) %>% 
  summarise("Median Excessive Force Serious Case" = median(amount_awarded),
            "Mean Excessive Force Serious Case" = mean(amount_awarded))


C_EDMP <- chicago %>% 
  filter(str_detect(summary_allegations, "Extended Detention / Malicious Prosecution")) %>% 
  group_by(Year) %>% 
  summarise("Median Extended Detention / Malicious Prosecution Case" = median(amount_awarded),
            "Mean Extended Detention / Malicious Prosecution Case" = mean(amount_awarded))


C_False_Arrest <- chicago %>% 
  filter(str_detect(summary_allegations, "False Arrest")) %>% 
  group_by(Year) %>% 
  summarise("Median False Arrest Case" = median(amount_awarded),
            "Mean False Arrest Case" = mean(amount_awarded))


C_issc <- chicago %>% 
  filter(str_detect(summary_allegations, "Illegal Search/Seizure")) %>% 
  group_by(Year) %>% 
  summarise("Median Illegal Search/Seizure Case" = median(amount_awarded),
            "Mean Illegal Search/Seizure Case" = mean(amount_awarded))


C_revcon <- chicago %>% 
  filter(str_detect(summary_allegations, "Reversed Conviction")) %>% 
  group_by(Year) %>% 
  summarise("Median Reversed Conviction Case" = median(amount_awarded),
            "Mean Reversed Conviction Case" = mean(amount_awarded))

summary_chart <- left_join(summary_chart, C_DUI, by = "Year")
summary_chart <- left_join(summary_chart, C_EDMP, by = "Year")
summary_chart <- left_join(summary_chart, C_EF_Minor, by = "Year")
summary_chart <- left_join(summary_chart, C_EF_Serious, by = "Year")
summary_chart <- left_join(summary_chart, C_False_Arrest, by = "Year")
summary_chart <- left_join(summary_chart, C_issc, by = "Year")
summary_chart <- left_join(summary_chart, C_revcon, by = "Year")

summary_chart <- summary_chart %>% 
  mutate_if(is.numeric, round)

summary_chart2 <- kable(summary_chart)

summary_chart3 <- datatable(summary_chart)

# summary_chart_tb <- as.data.frame.table(summary_chart, TRUE)
