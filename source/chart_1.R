library(ggplot2)
LA <- read.csv("../data/los_angeles_edited.csv")
settlements <-LA$amount_awarded
year <-(LA$calendar_year) 

LA_bar_data <- data.frame(settlements, year)
LA_set_year <-ggplot (LA_bar_data, aes(year, settlements)) +
  geom_col(fill = "#FF6666") +
  scale_x_continuous(breaks= scales::pretty_breaks(), year) +
scale_x_continuous(breaks= year) +
  ggtitle("Los Angeles Settlements per Year") +
  scale_y_continuous(labels = scales::comma)
  





  