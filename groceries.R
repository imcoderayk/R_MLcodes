library("arules") # Used for building association rules i.e. apriori algorithm


groceries <- read.csv(file.choose())

View(groceries)

str(groceries)

arules <- apriori(groceries, parameter = list(support = 0.002, confidence = 0.50, minlen = 2))
arules

# Viewing rules based on lift value
inspect(head(sort(arules, by = "lift"))) # to view we use inspect 

# Overal quality 
head(quality(arules))

# install.packages("arueslViz")
library("arulesViz") # for visualizing rules

# Different Ways of Visualizing Rules
plot(arules)

windows()
plot(arules, method = "grouped")
plot(arules[1:10], method = "graph") # for good visualization try plotting only few rules

write(arules, file = "a_rules.csv", sep = ",")

getwd()

