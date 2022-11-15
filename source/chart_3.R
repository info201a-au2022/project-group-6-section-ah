library(dplyr)
library(ggplot2)
library(stringr)

baltimore_data <- read.csv("../data/baltimore_edited.csv")

sum_over <- baltimore_data %>% 
  filter(amount_awarded > 400000)

View(sum_over)

max <- max(baltimore_data$amount_awarded)
print(max)

baltimore_data$summary_allegations <- toupper(baltimore_data$summary_allegations)

baltimore_data$summary_allegations <- str_replace(baltimore_data$summary_allegations, "POLICE MISCONDUCT - FALSE ARREST", "False Arrest")
baltimore_data$summary_allegations <- str_replace(baltimore_data$summary_allegations, "VIOLATION OF CIVIL RIGHTS", "Civil Right")
baltimore_data$summary_allegations <- str_replace(baltimore_data$summary_allegations, "POLICE MISCONDUCT - MALICIOUS PROSECUTION", "Malicious Prosecutions")
baltimore_data$summary_allegations <- str_replace(baltimore_data$summary_allegations, "POLICE MISCONDUCT - USE OF FORCE", "Use of Force")
baltimore_data$summary_allegations <- str_replace(baltimore_data$summary_allegations, "POLICE MISCONDUCT - ILLEGAL SEARCH", "Illegal Search")
baltimore_data$summary_allegations <- str_replace(baltimore_data$summary_allegations, "POLICE MISCONDUCT - FALSE IMPRISONMENT", "False Imprisonment")
baltimore_data$summary_allegations <- str_replace(baltimore_data$summary_allegations, "OFFICER MISCONDUCT ", "")


baltimore_boxplot <- ggplot(baltimore_data, aes(x = as.factor(summary_allegations), y = amount_awarded)) +
  scale_y_continuous(labels = scales::comma,
                     limits = c(0, 400000)) +
  geom_boxplot(fill = "#a866ff") +
  labs(x = "Summary Allegations",
       y = "Settlement Amount in USD",
       title = "Spread of Settlement Money Across Cases") +
  theme(axis.text = element_text(size = 7))

baltimore_boxplot

unique_allegations <- unique(baltimore_data$summary_allegations)
print(unique_allegations)


baltimore_boxplot

View(baltimore_data)
