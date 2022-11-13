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


bargraph
















# paul























