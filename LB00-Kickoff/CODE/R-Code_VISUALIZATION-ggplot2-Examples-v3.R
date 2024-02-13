# --- ----------------------------------------------------------------------
# --- DATA VISUALIZATION Examples with GGPLOT2
# --- 
# --- (c) June 2019, D.Benninger
# ---     Mars 2021, D.Benninger - customized for BINA course
# ---
# --- Libraries: ggplot2, ggExtra 
# ---           (+standard R plot functions plot, qplot, hist)
# ---
# --- Data:  mpg      (motorcycle measures)                    
# ---        (standard R dataset in library ggplot2)
# ---
# --- Links
# ---   https://ggplot2.tidyverse.org/
# ---   http://r-statistics.co/Top50-Ggplot2-Visualizations-MasterList-R-Code.html
# ---   
# ---
# --- Version
# ---    V1 June 2019 dbe
# ---    V2 May  2020 dbe - extended for CAS BIA10
# ---    V3 Mars 2021 dbe - customized for BINA course
# --- ----------------------------------------------------------------------

# --- check and set working directory (note use "/" instead of "\")
# setwd("c:/<your working directory orfolder>")
getwd()

# --- Packages ggplot2, ggExtra installieren, falls nicht vorhanden
if(!"ggplot2" %in% rownames(installed.packages())) install.packages("ggplot2")
if(!"ggExtra" %in% rownames(installed.packages())) install.packages("ggExtra")

# --- Packages laden
library("ggplot2")
library("ggExtra")

# --- Set standards 
# turn-off scientific notation like 1e+48
options(scipen=999) 
# pre-set the bw theme.
theme_set(theme_bw()) 


# --- Fuel economy data from 1999 to 2008 for 38 popular models of cars
# --- (data frame with 234 rows and 11 variables)
# --- car manufaturer list "mtcars"
data(mpg, package="ggplot2") # alternate source: "http://goo.gl/uEeRGu")
mpg
str(mpg)
summary(mpg)


# --- Scatterplot -----------------------------------
g <- ggplot(mpg, aes(cty, hwy)) +
		geom_point() +
    geom_smooth(method="lm", se=F) +
    xlim(c(0,50)) + 
    ylim(c(0,50)) +
	    labs(subtitle="mpg: city vs highway mileage",
	    y="hwy", 
	    x="cty",

  	  title="Scatterplot with overlapping points",
    	caption="Source: midwest")
plot(g)

dim(mpg)

# --- scatterplot with jittered points -------------
g <- ggplot(mpg, aes(cty, hwy)) +
     geom_jitter(width = .5, size=1) +
     xlim(c(0,50)) +
     ylim(c(0,50)) +
     labs(subtitle="mpg: city vs highway mileage",
          y="hwy",
          x="cty",
          title="Jittered Points")
plot(g)


# --- Histogram plot -----------------------------------
g <- ggplot(mpg, aes(displ)) + scale_fill_brewer(palette = "Spectral")
g + geom_histogram(aes(fill=class),
binwidth = .1,
col="black",
size=.1) + # change binwidth
labs(title="Histogram with Auto Binning",
subtitle="Engine Displacement across Vehicle Classes")

# --- with fixed binning
g + geom_histogram(aes(fill=class),
bins=5,
col="black",
size=.1) + # change number of bins
labs(title="Histogram with Fixed Bins",
subtitle="Engine Displacement across Vehicle Classes") 

# --- Histogramm & Scatterplot combined ----------------
mpg_select <- mpg[mpg$hwy >= 35 & mpg$cty > 27, ]
g <- ggplot(mpg, aes(cty, hwy)) + 
  geom_count() + 
  geom_smooth(method="lm", se=F)

plot(g)
ggMarginal(g, type = "histogram", fill="transparent")
ggMarginal(g, type = "boxplot", fill="transparent")
ggMarginal(g, type = "density", fill="transparent")


# --- Density plot -------------------------------------
g <- ggplot(mpg, aes(cty))
g + geom_density(aes(fill=factor(cyl)), alpha=0.8) +
	labs(title="Density plot",
	subtitle="City Mileage Grouped by Number of cylinders",
	caption="Source: mpg",
	x="City Mileage",
	fill="# Cylinders")

# --- BOX plot -----------------------------------------
g <- ggplot(mpg, aes(class, cty))
	g + geom_boxplot(varwidth=T, fill="plum") +
	labs(title="Box plot",
	subtitle="City Mileage grouped by Class of vehicle",
	caption="Source: mpg",
	x="Class of Vehicle",
	y="City Mileage")
	
	
# --- with classes
g <- ggplot(mpg, aes(class, cty))
	g + geom_boxplot(aes(fill=factor(cyl))) +
	theme(axis.text.x = element_text(angle=0, vjust=0.6)) +
	ylim(c(0,40)) +
	labs(title="Box plot",
	subtitle="City Mileage grouped by Class of vehicle",
  caption="Source: mpg",
	x="Class of Vehicle",
	y="City Mileage")
	
	
# --- violin plot
g <- ggplot(mpg, aes(class, cty))
	g + geom_violin() +
	ylim(c(0,40)) +
	labs(title="Violin plot",
	subtitle="City Mileage vs Class of vehicle",
	caption="Source: mpg",
	x="Class of Vehicle",
	y="City Mileage")

# --- BAR chart ----------------------------------------
# --- first prepare the data, calculate frequency
freqtable <- table(mpg$manufacturer)
df <- as.data.frame.table(freqtable)
head(df)

# --- plot
g <- ggplot(df, aes(Var1, Freq))
	g + geom_bar(stat="identity", width = 0.5, fill="tomato2") +
	labs(title="Bar Chart",
	subtitle="Manufacturer of vehicles",
	caption="Source: Frequency of Manufacturers from 'mpg' dataset") +
	theme(axis.text.x = element_text(angle=90, vjust=0.6))
	
# --- with classes
g <- ggplot(mpg, aes(manufacturer))
	g + geom_bar(aes(fill=class), width = 0.75) +
	theme(axis.text.x = element_text(angle=90, vjust=0.6)) +
	labs(title="Categorywise Bar Chart",
	subtitle="Manufacturer of vehicles",
	caption="Source: Manufacturers from 'mpg' dataset")
	

