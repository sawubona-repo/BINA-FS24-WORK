# --- ----------------------------------------------------------------------
# --- ASSOCIATION RULE MINING
# ---  
# --- with Grocery Store Data (small and large)
# ---
# ---    June 2016, D.Benninger
# --- v2 June 2017, dbe			- some minor bugs fixed
# --- v3 June 2019, dbe     - R coding extensions
# --- v4 June 2020, dbe			- some extensions (Groceries, onsen) and bugfixing
# --- v5 May  2021, dbe     - adapted for BINA FS21
# ---
# --- Libraries: arules, arulesViz
# ---
# --- Data:      Data_SampleGrocery.csv
# ---
# --- Links
# --- 	http://www.salemmarafi.com/code/market-basket-analysis-with-r/
# --- 	https://blog.exploratory.io/introduction-to-association-rules-market-basket-analysis-in-r-7a0dd900a3e0
# ---   http://r-statistics.co/Association-Mining-With-R.html
# --- ----------------------------------------------------------------------

# Packages arules und arulesViz installieren, falls nicht vorhanden
if(!"arules" %in% rownames(installed.packages())) install.packages("arules")
if(!"arulesViz" %in% rownames(installed.packages())) install.packages("arulesViz")

# Packages laden
library("arules")
library("arulesViz")

# Set Working Directory, where the Sample Data File is located
# setwd(choose.dir())
# getwd()


# --- ----------------------------------------
# --- ASSOCIATION Rule Mining - with Grocery Data
# --- ----------------------------------------
# --- DATA Load and Overview
# grocery <- read.csv("../Data_SampleGrocery.csv", header=TRUE, row.names=1)
grocery <- read.csv("Data_SampleGrocery.csv", header=TRUE, row.names=1)


grocery
View(grocery)
str(grocery)

head(grocery)
head(grocery[1,1:20])

grocery[1,1:10]
grocery[5,1:10]

summary(grocery)


# --- ----------------------------------------------------
# --- TRANSFORMATION
# If all the columns except the row name are two-valued data (0 or 1), matrix class is easier to deal with in association rules.
# If all the columns are string data, just convert the data.frame into transaction data without converting it into matrix data.
grocery <- as.matrix(grocery)

# --- convert into "transactions"
grocery.trans <- as(grocery, "transactions")

# --- inspect the transactions
View(grocery.trans)
summary(grocery.trans)
inspect(grocery.trans)

# --- -------------------------------------------
# --- ITEM FREQUENCY Plot/Viz
itemFrequencyPlot(grocery.trans, ylim=c(0,1), main ="(relative) Item Frequency")
# --- sorted and topN items plotted
itemFrequencyPlot(grocery.trans, topN=20, ylim=c(0,1), main ="(relative) Item Frequency")


# ----------------------------------------------
# --- Association Rule Mining with
# --- A PRIORI Algorithm
# ---
# apriori() is a function to make association rules.
# maxlen means a number of rules (in this case, number of effects of an grocery) in a association rule.
# support means how often it happens (or probability of an event). 0.04 is not so rare, not too often.
# confidence means how often it occurs under specific situations. If this is so small, it may be worth making #association rules in the first place.

grocery.rule <- apriori(grocery.trans, parameter = list(maxlen=4, support=0.04, confidence=0.55, ext=TRUE))


# --- inspect the mined rules
summary(grocery.rule)
inspect(grocery.rule)


# --- -------------------------------------------
# --- Extract a SUBSET of SPECIFIC RULES
# --- e.g. rules with a minimal lift value

# To extract specific association rules, use subset() function
# e.g. search for rules with {PIZZA} as part of the antedecent (or lhs) and a lift value of more than 1 
PIZZAandMORE_lhs <- subset(grocery.rule, subset=(lhs %in% "pizza") & (lift>1.0))


# --- inspect selected subset of rules
PIZZAandMORE_lhs
str(PIZZAandMORE_lhs)
inspect(PIZZAandMORE_lhs)

# e.g. search for rules with {SALAD} as part of the consequent (or rhs) and a lift value of more than 1 
SALAD_rhs <- subset(grocery.rule, subset=(rhs %in% "salad") & (lift>1.0))

inspect(SALAD_rhs)


# more search for rules with specific features and metrics
CHICKEN <- subset(grocery.rule, subset=(lhs %in% "chicken") & (lift>1.0))
inspect(CHICKEN)

CHICKEN10 <- subset(grocery.rule, subset=(lhs %in% "chicken") & (lift>1.0) & (count > 10))
inspect(CHICKEN10)

# --- --------------------------------------------------
# --- GRAPH/MATRIX VISUALIZATION of selected set of rules
# --- --------------------------------------------------
plot(grocery.rule, method = "graph", engine = "htmlwidget")

plot(CHICKEN, method = "graph", engine = "htmlwidget")
plot(CHICKEN, method = "grouped", engine = "interactive")
plot(CHICKEN, method = "matrix", engine = "htmlwidget")



# --- --------------------------------------------------
# --- ASSOCIATION RULE MINING with large grocery dataset
# --- --------------------------------------------------
library(arules)

# --- Data Load and Overview
data("Groceries")

Groceries

View(Groceries)
str(Groceries)

LIST(head(Groceries, 3))
inspect(head(Groceries,5))

summary(Groceries)

# --- -----------------------------------------
# --- Step1: FREQUENT ITEM SET Detection
# ---        calculates support for frequent items
# ---        using the ECLAT algorithm
# --- -----------------------------------------
frequentItems <- eclat (Groceries, parameter = list(supp = 0.07, maxlen = 15))

# --- inspect (and plot) frequent items
frequentItems
inspect(frequentItems)

itemFrequencyPlot(Groceries, topN=20, type="absolute", main="(absolute) Item Frequency")

# --- -----------------------------------------
# --- Step2: GENERATE RULES
# ---        with minsup and minconf metrics
# ---        using the APRIORI algorithm
# --- -----------------------------------------

# e.g. rules with min Support as 0.001, confidence as 0.8.
# ---
rules <- apriori (Groceries, parameter = list(supp = 0.001, conf = 0.5))
inspect(head(rules))

# e.g. 'high-confidence' rules
# ---
rules_conf <- sort (rules, by="confidence", decreasing=TRUE)

# show the support, lift and confidence for all rules
inspect(head(rules_conf))

# e.g. 'high-lift' rules
# ---
rules_lift <- sort (rules, by="lift", decreasing=TRUE)

# show the support, lift and confidence for all rules
inspect(head(rules_lift)) 

# --- ---------------------------------------------------
# --- HOW TO CONTROL THE NUMBER OF (generated) RULES?
# ---
# --- to get 'strong' rules, increase the value of 'conf' parameter
# --- to get 'longer' rules, increase 'maxlen'

# E.g. maxlen = 3 limits the elements in a rule to 3
# ---
rules <- apriori(Groceries, parameter = list (supp = 0.001, conf = 0.5, maxlen=3))

# show the support, lift and confidence for all rules
inspect(head(rules)) 

# --- ---------------------------------------------------
# --- HOW TO REMOVE REDUNDANT RULES
# ---

# --- get subset rules in vector
subsetRules <- which(colSums(is.subset(rules, rules)) > 1) 
length(subsetRules)

# --- remove subset rules
rules <- rules[-subsetRules]  
inspect(rules) 


# --- ---------------------------------------------------
# --- HOW TO FIND RULES RELATED TO GIVEN ITEM/s
# ---
# --- This can be achieved by modifying the appearance parameter in the apriori() function
# ---
# --- Example A: Find what factors influenced purchase of product X
#     To find out what customers had purchased before buying 'Whole Milk'
#     This will help you understand the patterns that led to the purchase of 'whole milk'

# --- FIRST: get rules that lead to buying 'whole milk'
rules <- apriori (data=Groceries, parameter=list (supp=0.001,conf = 0.08), appearance = list (default="lhs",rhs="whole milk"), control = list (verbose=F))

# --- SECOND: look for 'high-confidence' rules
rules_conf <- sort (rules, by="confidence", decreasing=TRUE) 
inspect(head(rules_conf))


# --- Example B: Find out what products were purchased after/along with product X
#     The is a case to find out the Customers who bought 'Whole Milk' also bought . . 
#     In the equation, 'whole milk' is in the antedecent (lhs = left hand side)

# --- FIRST: get rules that are lead by 'whole milk' buyed
rules <- apriori (data=Groceries, parameter=list (supp=0.001,conf = 0.15,minlen=2), appearance = list(default="rhs",lhs="whole milk"), control = list (verbose=F))

# --- SECOND: look for 'high-confidence' rules
rules_conf <- sort (rules, by="confidence", decreasing=TRUE) 
inspect(head(rules_conf))

