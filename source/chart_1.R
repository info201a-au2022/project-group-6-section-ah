library(ggplot2)
LA <- read.csv("../data/los_angeles_edited.csv")
settlements <-LA$amount_awarded
year <-as.Date(LA$calendar_year,format = "%Y") 

LA_bar_data <- data.frame(LA_settlements, LA_year)
ggplot (LA_bar_data, aes(year, settlements), xlab("year"), ylab("settlements"),  
        xlim=c(2010, 2020 )) +
  geom_bar(stat = "identity") +
  scale_x_continuous(breaks= scales::pretty_breaks(), year) +
scale_x_continuous(breaks= year)





  