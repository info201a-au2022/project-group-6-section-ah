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

baltimore_data$summary_allegations <- str_replace(baltimore_data$summary_allegations, "POLICE MISCONDUCT - FALSE ARREST", "FA")
baltimore_data$summary_allegations <- str_replace(baltimore_data$summary_allegations, "VIOLATION OF CIVIL RIGHTS", "CR")
baltimore_data$summary_allegations <- str_replace(baltimore_data$summary_allegations, "POLICE MISCONDUCT - MALICIOUS PROSECUTION", "MP")
baltimore_data$summary_allegations <- str_replace(baltimore_data$summary_allegations, "POLICE MISCONDUCT - USE OF FORCE", "OUF")
baltimore_data$summary_allegations <- str_replace(baltimore_data$summary_allegations, "POLICE MISCONDUCT - ILLEGAL SEARCH", "IS")
baltimore_data$summary_allegations <- str_replace(baltimore_data$summary_allegations, "POLICE MISCONDUCT - FALSE IMPRISONMENT", "FI")
baltimore_data$summary_allegations <- str_replace(baltimore_data$summary_allegations, "OFFICER MISCONDUCT ", "")


baltimore_boxplot <- ggplot(baltimore_data, aes(x = as.factor(summary_allegations), y = amount_awarded)) +
  geom_boxplot(fill = "#a866ff") +
  xlab("summary_allegations") +
  ylim(0, 400000) +
  theme(axis.text = element_text(size = 7))

baltimore_boxplot

unique_allegations <- unique(baltimore_data$summary_allegations)
print(unique_allegations)


baltimore_boxplot

View(baltimore_data)

