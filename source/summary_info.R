library(tidyverse)
library(stringr)

# sample:
read.csv("../data/chicago_edited.csv")


fruit <- c("bananas", "apples", "mangoes", "grapes", "durian")
kcal <- c(200, 300, 120, 10, 420)
bh_df <- data.frame(fruit, kcal)

bh_plot <- ggplot(bh_df) +
  geom_col(aes(
    x = fruit,
    y = kcal
  ),
    fill = "orange")

num <- "2067771122"
word <- "loser"

# bright

chicago <- read.csv("../data/chicago_edited.csv")

#calculations:

chicago_summary <- summary(chicago %>% 
          select(amount_awarded)) # use for a scope
View(chicago_summary)

ccc <- chicago %>% 
  select(amount_awarded)

# coding and getting the summary components

chicago_mean_variable_df <- ccc %>% 
  summarise(mean = mean(amount_awarded, na.rm = TRUE))
chicago_mean <- chicago_mean_variable_df$mean

chicago_median_variable_df <- ccc %>% 
  summarise(x = median(amount_awarded, na.rm = TRUE))
chicago_median <- chicago_median_variable_df$x

chicago_min_variable_df <- ccc %>% 
  filter(amount_awarded == min(amount_awarded, na.rm = TRUE))
chicago_min <- chicago_min_variable_df$amount_awarded[1]

chicago_max_variable_df <- ccc %>% 
  filter(amount_awarded == max(amount_awarded, na.rm = TRUE))
chicago_max <- chicago_max_variable_df$amount_awarded[1]

chicago_total_variable_df <- ccc %>% 
  summarise(x = sum(amount_awarded, na.rm = TRUE))
chicago_total <- chicago_total_variable_df$x

chicago_false_arrest_amt <- chicago %>% 
  filter(str_detect(summary_allegations, "False Arrest"))


# list components

chicago_info <- list()
chicago_info$rows <- nrow(chicago)
chicago_info$cols <- ncol(chicago)
chicago_info$mean <- chicago_mean
chicago_info$median <- chicago_median
chicago_info$min <- chicago_min
chicago_info$max <- chicago_max
chicago_info$range <- chicago_max - chicago_min
chicago_info$std <- sd(chicago$amount_awarded, na.rm = TRUE)

#my additional:

chicago_info$total <- chicago_total_variable_df
chicago_info$false_arrest_charges <- nrow(chicago_false_arrest_amt)

View(chicago_info)

# start of prompt 1


# Of the many different cases within the Chicago police settlement cases, 
# case reason has been the highest settlements median/mean (choose at ur own discretion) 
# reason for these settlements.

# First, I need to find the number and different type of cases:

chicago_cases <- chicago %>% 
  select(summary_allegations)

chicago_cases_unique <- unique(chicago_cases) # i found that there are 12 types
                                              # of cases

chicago_case_summary <- chicago %>% 
  group_by(summary_allegations) %>% 
  count(summary_allegations)

chicago_reasons_money <- chicago %>% 
  group_by(summary_allegations) %>% 
  summarise(avg_settlements = mean(amount_awarded),
            med_settlements = median(amount_awarded))

chicago_cases <- left_join(chicago_reasons_money, 
                           chicago_case_summary,
                           by = "summary_allegations") 

chicago_cases <- chicago_cases %>% 
  mutate(type = str_sub(summary_allegations, 32))

# actual calculations:

chicago_highest_median_df <- chicago_cases %>% 
  filter(med_settlements == max(med_settlements))

chicago_highest_median_type <- chicago_highest_median_df$type 
chicago_highest_median_type <- tolower(chicago_highest_median_type) # STAR
chicago_highest_median <- chicago_highest_median_df$med_settlements 
chicago_highest_median <- prettyNum(chicago_highest_median,
                                    big.mark = ",", 
                                    scientific = FALSE) # STAR
# https://statisticsglobe.com/display-large-numbers-separated-with-comma-in-r
# making 100000000 into 100,000,000


# start of prompt 2:


# The average or median amount of settlements per year in city, is money.

# find how many years there are recorded:

chicago_total_years <- chicago %>% 
  group_by(calendar_year) %>% 
  count(calendar_year) # gives me 10 years, from 2010 - 2019.

chicago_avg_year <- chicago_total / 10

chicago_yearly_df <- chicago %>%
  group_by(calendar_year) %>% 
  summarise(total_settlement = sum(amount_awarded))

chicago_median_df <- chicago_yearly_df %>% 
  summarise(median = median(total_settlement))

chicago_mean_df <- chicago_yearly_df %>% 
  summarise(mean = mean(total_settlement))

chicago_yearly_median <- chicago_median_df$median
chicago_yearly_median <- prettyNum(chicago_yearly_median,
                                  big.mark = ",", 
                                  scientific = FALSE) # STAR


# salma

# salma

read.csv("../data/los_angeles_edited.csv")
LA_info <-list()
LA_info$rows <-nrow(`Los Angeles`)
LA_info$columns <-ncol(`Los Angeles`)
settlements <-`Los Angeles`$amount_awarded
LA_info$median <-median(settlements, na.rm = T)
LA_info$mean <-mean(settlements, na.rm = T)
LA_info$max <-max(settlements, na.rm = T)
LA_info$min <-min(settlements, na.rm = T)
LA_info$range <-range(settlements, na.rm = T)
LA_info$sd <-sd(settlements, na.rm = T)

#additional
LA_info$civilrights <-sum(num_civil_rights$amount_awarded, na.rm = F)
LA_info$gender_discrimination_charges <-nrow(LA_gender_discrimination_charges)

#functions for additional summary 
num_civil_rights <-`Los Angeles` %>%
  filter(str_detect(`Los Angeles`$summary_allegations, "Civil Rights"))
LA_gender_discrimination_charges <-`Los Angeles` %>%
  filter(str_detect(`Los Angeles`$summary_allegations, "Gender Discrimination"))

#prompt for dynamic paragraph
#The city of Los Angeles spent a total amount of "dollar amount" on police settlements in 2018. 

year_amt <- `Los Angeles` %>% 
  filter(str_detect(`Los Angeles`$calendar_year, "2018"))
total_settlements <-sum(year_amt$amount_awarded, na.rm = F)














# paul























