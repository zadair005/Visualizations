#Week 7 Discussion Exercise R Script

# Load the housing data
philly <- read_excel("Data Science School Documents/MSDS 670 Visualizations/Week 7/Week 7 In Class Data.xlsx", 
                     sheet = 'Philly')
philly

#Label the first row as column names 
colnames(philly) <- as.character(unlist(philly[1,]))

#Delete 1st row
philly = philly[-1, ]

#Convert to datatable
philly <- data.table(philly)

#Convert to numeric
philly$`Number of Square Feet per $1,000,000` <- as.numeric(philly$`Number of Square Feet per $1,000,000`)

#Divide the price per sqf by 10
philly$`Number of Square Feet per $1,000,000` <- philly$`Number of Square Feet per $1,000,000`/10

#Change the price column name
setnames(philly, "Number of Square Feet per $1,000,000", "Number of Square Feet per $100,000")

#Check the structure
str(philly)

#Basic barplot
p <- ggplot(data=philly, aes(x=City, y=`Number of Square Feet per $100,000`)) +
  geom_bar(stat="identity")

p + coord_flip() + labs(title="City Housing Data", x = "Number of Square Feet per $100,000", y = "Cities")

#Highlight the highest 20% of cities where their square feet per $100,000 is extremely high
philly_data = philly %>%
  group_by(City) %>%
  summarize(sq_feet_mean = mean(`Number of Square Feet per $100,000`)) %>%
  mutate(hilite = ifelse(sq_feet_mean > quantile(sq_feet_mean, 0.8),
                         "NOT GOOD", "GOOD"))
philly_data %>%
  ggplot(aes(x = factor(City), y = sq_feet_mean, fill = hilite)) + 
  geom_col() + coord_flip() + labs(title = "Big Cities Housing Data", y = "Number of Square Feet per $100,000", x = "Cities")

#As we can see from the new chart, the ones not highlighted red are the ones in the 20th percentile where their 
#Housing numbers very high based on the number of square footage per $100,000.