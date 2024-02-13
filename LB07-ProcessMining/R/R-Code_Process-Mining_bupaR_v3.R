# --- ----------------------------------------------------------------------
# --- Process Mining in R with bupaR
# --- 
# --- V1  April 2021, D.Benninger - initial version for BINA-FS21
# --- V2  13.04.21 dbe			minor correction (library "processanimateR" was missing)
# --- V3  June 2021, dbe    minor adaptions for CAS BIA11
# ---
# --- Libraries: bupaR
# ---            edeaR, eventdataR, processmapR, processmonitoR, petrinetR
# ---            heuristicsmineR (for the heuristics miner)
# ---            dplyr
# ---             
# --- Data:      patients				>> standard bupaR dataset 
# ---
# --- Links
# ---           https://www.bupar.net/
# --- 
# ---
# --- ----------------------------------------------------------------------

# PACKAGES installieren, falls nicht vorhanden
if(!"bupaR" %in% rownames(installed.packages())) install.packages("bupaR")
if(!"edeaR" %in% rownames(installed.packages())) install.packages("edeaR")
if(!"eventdataR" %in% rownames(installed.packages())) install.packages("eventdataR")
if(!"processmapR" %in% rownames(installed.packages())) install.packages("processmapR")
if(!"processmonitoR" %in% rownames(installed.packages())) install.packages("processmonitR")
if(!"petrinetR" %in% rownames(installed.packages())) install.packages("petrinetR")
if(!"heuristicsmineR" %in% rownames(installed.packages())) install.packages("heuristicsmineR")
if(!"processanimatedR" %in% rownames(installed.packages())) install.packages("processanimatedR")
if(!"dplyr" %in% rownames(installed.packages())) install.packages("dplyr")

# Packages laden
library(bupaR)

# Set WORKING Directory
# setwd(choose.dir())

# ----------------------------------------
# --- DATA OVERVIEW > patients < event log
# ----------------------------------------
eventdataR::patients

## Log of 5442 events consisting of:
## 7 traces 
## 500 cases 
## 2721 instances of 7 activities 
## 7 resources 
## Events occurred from 2017-01-02 11:41:53 until 2018-05-05 07:16:02 
##  
## Variables were mapped as follows:
## Case identifier:     patient 
## Activity identifier:     handling 
## Resource identifier:     employee 
## Activity instance identifier:    handling_id 
## Timestamp:           time 
## Lifecycle transition:        registration_type 
## 
## # A tibble: 5,442 x 7
##    handling patient employee handling_id registration_ty~ time               
##    <fct>    <chr>   <fct>    <chr>       <fct>            <dttm>             
##  1 Registr~ 1       r1       1           start            2017-01-02 11:41:53
##  2 Registr~ 2       r1       2           start            2017-01-02 11:41:53
##  3 Registr~ 3       r1       3           start            2017-01-04 01:34:05


# --- short data exploration
patdata <- eventdataR::patients

View(patdata)
str(patdata)
summary(patdata)

# --- sample data filtering and selection
library(dplyr)
selpatdata <- patdata  %>% 
                     filter(as.integer(patient) < 10) %>%
                     select(handling, patient, employee, registration_type, time ,.order) 

# --- write patients data to external file
write.csv(patdata, file = "DATA_patients.csv", row.names = TRUE)

# --- getting Metadata
patients %>% mapping

## Case identifier:     patient 
## Activity identifier:     handling 
## Resource identifier:     employee 
## Activity instance identifier:    handling_id 
## Timestamp:           time 
## Lifecycle transition:        registration_type

# --- getting Basics Information
patients %>% summary

## Number of events:  5442
## Number of cases:  500
## Number of traces:  7
## Number of distinct activities:  7
## Average trace length:  10.884
## 
## Start eventlog:  2017-01-02 11:41:53
## End eventlog:  2018-05-05 07:16:02
##                   handling      patient          employee  handling_id       
##  Blood test           : 474   Length:5442        r1:1000   Length:5442       
##  Check-out            : 984   Class :character   r2:1000   Class :character  
##  Discuss Results      : 990   Mode  :character   r3: 474   Mode  :character  
##  MRI SCAN             : 472                      r4: 472                     
##  Registration         :1000                      r5: 522                     
##  Triage and Assessment:1000                      r6: 990                     
##  X-Ray                : 522                      r7: 984                     
##  registration_type      time                         .order    
##  complete:2721     Min.   :2017-01-02 11:41:53   Min.   :   1  
##  start   :2721     1st Qu.:2017-05-06 17:15:18   1st Qu.:1361  
##                    Median :2017-09-08 04:16:50   Median :2722  
##                    Mean   :2017-09-02 20:52:34   Mean   :2722  
##                    3rd Qu.:2017-12-22 15:44:11   3rd Qu.:4082  
##                    Max.   :2018-05-05 07:16:02   Max.   :5442  
## 

# --- More detailed information about activities , cases, resources and traces can be obtained using the functions named accordingly. 
# --- For example, consider the overview of the cases of the patients event log 
patients %>% cases

## # A tibble: 500 x 10
##    patient trace_length number_of_activ~ start_timestamp     complete_timestamp 
##    <chr>          <int>            <int> <dttm>              <dttm>             
##  1 1                  6                6 2017-01-02 11:41:53 2017-01-09 19:45:45
##  2 10                 5                5 2017-01-06 05:58:54 2017-01-10 15:41:59
##  3 100                5                5 2017-04-11 16:34:31 2017-04-22 09:58:07
##  4 101                5                5 2017-04-16 06:38:58 2017-04-23 02:55:23
##  5 102                5                5 2017-04-16 06:38:58 2017-04-22 10:50:04

# ----------------------------------------
# --- EXPLORING EVENT DATA
# ----------------------------------------

# --- TIME perspective
# --- processing time: the sum of the duration of all activity instances
patients %>% 
		processing_time("activity") %>% 
		plot

# --- ORGANIZATIONAL perspective
# --- The resource frequency metric allows the computation of the number/frequency of resources 
# --- at the levels of log, case, activity, resource, and resource-activity.
patients %>%
    resource_frequency("resource")

# # A tibble: 7 x 3
##   employee absolute relative
##   <fct>       <int>    <dbl>
## 1 r1            500   0.184 
## 2 r2            500   0.184 
## 3 r6            495   0.182 
## 4 r7            492   0.181 
## 5 r5            261   0.0959
## 6 r3            237   0.0871
## 7 r4            236   0.0867

patients %>%
  resource_frequency("resource") %>%
  plot

# --- Resource involvement refers to the notion of the number of cases in which a resource is involved. 
# --- It can be computed at levels case, resource, and resource-activity.
patients %>%
    resource_involvement("resource") %>% 
    plot


# --- STRUCTURED perspective
# --- Activity presence shows in what percentage of cases an activity is present. It has no level-argument.
patients %>% 
    activity_presence() %>%
    plot

# --- The frequency of activities can be calculated using the activity_frequency function, 
# --- at the levels log, trace and activity.
patients %>%
    activity_frequency("activity")

## # A tibble: 7 x 3
##   handling              absolute relative
##   <fct>                    <int>    <dbl>
## 1 Registration               500   0.184 
## 2 Triage and Assessment      500   0.184 
## 3 Discuss Results            495   0.182 
## 4 Check-out                  492   0.181 
## 5 X-Ray                      261   0.0959
## 6 Blood test                 237   0.0871
## 7 MRI SCAN                   236   0.0867

# --- Start Activities
# --- The start of cases can be described using the start_activities function. 
# --- Available levels are activity, case, log, resource and resource activity.
patients %>%
    start_activities("resource-activity")

## # A tibble: 1 x 5
##   employee handling     absolute relative cum_sum
##   <fct>    <fct>           <int>    <dbl>   <dbl>
## 1 r1       Registration      500        1       1
##
## This shows that in this event log, all cases are started with the Registration by resource r1.

# --- End Activities
# --- Conversely, the end_activities functions describes the end of cases, 
# --- using the same levels: log, case, activity, resource and resource-activity.
patients %>%
    end_activities("resource-activity")

## # A tibble: 5 x 5
##   employee handling              absolute relative cum_sum
##   <fct>    <fct>                    <int>    <dbl>   <dbl>
## 1 r7       Check-out                  492    0.984   0.984
## 2 r6       Discuss Results              3    0.006   0.99 
## 3 r2       Triage and Assessment        2    0.004   0.994
## 4 r5       X-Ray                        2    0.004   0.998
## 5 r3       Blood test                   1    0.002   1


# ----------------------------------------
# --- CREATING PROCESS MAPS 
# ----------------------------------------

# --- Frequency profile
# --- By default, the process map is annotated with frequencies of activities and flows. 
# --- That's called the frequency profile, and can be created explicitly using the frequency function. 
# --- This function has a value argument, which can be used to adjust the frequencies shown, 
# --- for instance using relative frequencies instead of the default absolute ones.

# --- relative frequencies
patients %>%
    process_map(type = frequency("relative"))

# --- absolute frequencies
patients %>%
    process_map(type = frequency("absolute"))
    

# --- Performance profile
# --- One can also use a performance profile, focussing on processing time of activities. 
# --- The performance profile has two arguments: the FUN argument to specify the function to apply on the processing time (e.g. min, max, mean, median, etc.), 
# --- and the units argument to specificy the time unit to be used.

patients %>%
    process_map(performance(median, "days"))


# --- Combining different profiles for edges and for nodes
patients %>%
    process_map(type_nodes = frequency("relative_case"),
                type_edges = performance(mean,"hours"))

# --- Customizing the layout 
# --- Using the rankdir argument for TB (top-bottom), BT (bottom-top), RL (right-left)  or LR (left-right) as default
patients %>%
    process_map(type_nodes = frequency("relative_case"),
                type_edges = performance(mean,"hours"), rankdir ="TB")
                

# --- ANIMATE process map
library(processanimateR)
library(eventdataR)

# --- A basic animation with static color and token size
animate_process(patients)
animate_process(patients,rankdir="TB")

# --- Default token color, size, or image can be changed as follows
animate_process(patients, 
                mapping = token_aes(size = token_scale(12), shape = "rect", color= token_scale("red")))

# --- A full animation with resource coloring and legend
animate_process(patients, mode = "relative", jitter = 10, legend = "color",
                mapping = token_aes(color = token_scale("employee", scale = "ordinal", 
                range = RColorBrewer::brewer.pal(7, "Paired"))))

animate_process(patients, mode = "relative", jitter = 10, legend = "color",
                rankdir = "TB",
                mapping = token_aes(color = token_scale("employee", scale = "ordinal", 
                range = RColorBrewer::brewer.pal(7, "Paired"))))   
    
# --- PRECEDENCE diagrams
# --- A precendence diagrams is a two-dimensional matrix showing the flows between activities
# --- The precedence diagram can be visualized using the generic plot function
patients %>%
    precedence_matrix(type = "absolute") 

## # A tibble: 13 x 3
##    antecedent            consequent                n
##    <fct>                 <fct>                 <int>
##  1 Triage and Assessment End                       2
##  2 Blood test            End                       1
##  3 Start                 Registration            500
##  4 Registration          Triage and Assessment   500
##  5 MRI SCAN              Discuss Results         236
##  6 Triage and Assessment Blood test              237
##  7 Blood test            MRI SCAN                236
##  8 Discuss Results       Check-out               492
##  9 X-Ray                 End                       2
## 10 Check-out             End                     491
## 11 X-Ray                 Discuss Results         259
## 12 Triage and Assessment X-Ray                   261
## 13 Discuss Results       End                       3

# --- absolute frequencies
patients %>%
    precedence_matrix(type = "absolute") %>%
    plot
    
# --- relative frequencies
patients %>%
    precedence_matrix(type = "relative") %>%
    plot

# --- relative frequency of flows, for each antecendent
# --- i.e. given antecendent A, it is followed x% of the time by Consequent B
patients %>%
    precedence_matrix(type = "relative-antecedent") %>%
    plot
    
# --- relative frequency of flows, for each consequent
# --- i.e. given consequent B, it is preceded x% of the time by Antecedent A
patients %>%
    precedence_matrix(type = "relative-consequent") %>%
    plot
    

# ----------------------------------------
# --- SOCIAL NETWORK ANALYSIS 
# ----------------------------------------

# --- HANDOVER-OF-WORK Network
# --- A handover-of-work network can be created with the resource_map function. 
# --- It has the same arguments as the process_map function.
patients %>%
    resource_map()
    
patients %>%
    process_map(performance(mean, "hours"))



# ----------------------------------------
# --- The HEURISTICS MINER Algorithm
# ----------------------------------------

# --- The Heuristics miner algorithm is provided by the heuristicsmineR package.
library(bupaR)
library(heuristicsmineR)
library(petrinetR)

# Dependency graph / matrix
dependency_matrix(patients) %>% render_dependency_matrix()

# Causal graph / Heuristics net
causal_net(patients) %>% render_causal_net()

