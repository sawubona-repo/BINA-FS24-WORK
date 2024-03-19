# --- ----------------------------------------------------------------------
# --- EXPLORATORY DATA ANALYSIS (EDA) Example
# --- 
# --- (c) March 2022, D.Benninger   -  initial  for BINA course
# ---
# --- Libraries: DataExplorer 
# ---
# --- Data:  diabetes      (@JBrownlee Github Repository)                    
# ---
# --- Links
# ---   https://cran.r-project.org/web/packages/DataExplorer/vignettes/dataexplorer-intro.html
# ---   https://www.r-bloggers.com/2021/03/faster-data-exploration-with-dataexplorer/
# ---   
# ---
# --- Version
# ---    V1 March 2022 dbe
# --- ----------------------------------------------------------------------

# --- Packages installieren, falls nicht vorhanden
if(!"DataExplorer" %in% rownames(installed.packages())) install.packages("DataExplorer")

# load libraries
library(DataExplorer)

# read in dataset
diabetes_data <- read.csv("https://raw.githubusercontent.com/jbrownlee/Datasets/master/pima-indians-diabetes.csv", header = FALSE)
View(diabetes_data)

# fix column names
names(diabetes_data) <- c("number_of_times_pregnant", "plasma_glucose_conc", "diastolic_bp", "triceps_skinfold_thickness", "two_hr_serum_insulin", "bmi", "diabetes_pedigree_function", "age", "label")
View(diabetes_data)

# create report
create_report(dia)

