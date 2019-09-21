#Week 7 Homework Assignment

#Load Packages
library(tidyverse)
library(data.table)
library(ggrepel)
library(readxl)
library(scales)

chc <- read_excel("Data Science School Documents/MSDS 670 Visualizations/Week 7/Week 7 Homework Data.xlsx",
                  sheet = "Colorado Health Care Costs")
chc

#Label the first row as column names
colnames(chc) <- as.character(unlist(chc[1,]))

#delete first row
chc = chc[-1,]

#Convert columns to numeric
chc$`Single Premium`<- as.numeric(chc$`Single Premium`)
chc$`Employee Plus One Premium` <- as.numeric(chc$`Employee Plus One Premium`)
chc$`Family Premium` <- as.numeric(chc$`Family Premium`)
chc <- data.table(chc)

#Check the structure
str(chc)

#Generate the plot
ggplot(data = chc, aes(Year, chc$`Single Premium`, group = 1)) +
  geom_point(color = "blue") +
  geom_line(color = "blue") +
  
  geom_point(data = chc, aes(Year, chc$`Employee Plus One Premium`), group = 1, color = "purple") +
  geom_line(data = chc, aes(Year, chc$`Employee Plus One Premium`), group = 1, color = "purple") +
  
  geom_point(data = chc, aes(Year, chc$`Family Premium`), group = 1, color = "grey") +
  geom_line(data = chc, aes(Year, chc$`Family Premium`), group = 1, color = "grey") +
  
  labs(title = "Colorado Healthcare Cost by Year (2008 - 2017)",
       subtitle = "Family Premiums appear to be rising the quickest during this time span") +
  
  xlab("Year") +
  ylab("Costs") +
  
  annotate("text", x = '2010', y = 4900, label = "Single Premium", color = "blue", size = 4, hjust = 'right') +
  annotate("text", x = '2010', y = 9750, label = "Employee Plus One Premium", color = "purple", size = 4, hjust = 'right') +
  annotate("text", x = '2010', y = 15000, label = "Family Premium", color = "grey", size = 4, hjust = 'right') +
  
  annotate("text", x = '2008', y = 4000, label = "$4,303.00", color = "blue", size = 3) +
  annotate("text", x = '2008', y = 8000, label = "$8,428.00", color = "purple", size = 3) +
  annotate("text", x = '2008', y = 11500, label = "$11,952.00", color = "grey", size = 3) +
  
  annotate("text", x = '2017', y = 6000, label = "$6,456.00", color = "blue", size = 3) +
  annotate("text", x = '2017', y = 12800, label = "$13,180.00", color = "purple", size = 3) +
  annotate("text", x = '2017', y = 18800, label = "19,396.00", color = "grey", size = 3)


