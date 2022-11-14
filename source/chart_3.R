library(dplyr)
library(ggplot2)

baltimore_data <- read.csv("../data/baltimore_edited.csv")

max <- max(baltimore_data$amount_awarded)
print(max)

baltimore_boxplot <- ggplot(baltimore_data, aes(x = as.factor(summary_allegations), y = amount_awarded)) +
  geom_boxplot(fill = "#a866ff") +
  xlab("summary_allegations") +
  ylim(0, 400000)


unique_allegations <- unique(baltimore_data$summary_allegations)
print(unique_allegations)

balitimore_boxplot_labels <- baltimore_boxplot
#levels(balitimore_boxplot_labels)

baltimore_boxplot


View(baltimore_data)


?toupper
