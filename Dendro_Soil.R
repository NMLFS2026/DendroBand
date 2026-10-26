## Title: Dendroband Soil Analysis
## Intention: Setting up the dendroband data for Kay

## Author: Maura Collins
## Date of last edit: 06/09/2026


## SCRIPT NOTES:
# 1) This script references the Dendro_Setup.R file
# you want the dataframes named:

#A_tube_soil   
#A_vernier_soil 
#B_tube_soil    
#B_vernier_soil 
#C_tube_soil    
#C_vernier_soil


## LIBRARY
source("S:/Ecology/Student_folders_&_files/Maura 2026/Dendro Exploration/Dendro_Setup.R")
library(ggplot2)
#this source gives you tidyverse and readxl, it needs to be saved before you can 
#run this line successfully

################################################################################

## CLEAN DATA

#the adjustments are only for the dendrometer band readings
# the coalesce chooses the non NA value if there are multiple days that have 
# different values. Also removes the notes and adjust columns
A_t_soil <- A_tube_soil %>% group_by(date) %>%
  summarize( soil_temp_F = coalesce(first(soil_temp_F))) 
  
A_v_soil <- A_vernier_soil %>% group_by(date) %>%
  summarize( soil_temp_F = coalesce(first(soil_temp_F)))

B_t_soil <- B_tube_soil %>% group_by(date) %>%
  summarize( soil_temp_F = coalesce(first(soil_temp_F)))

B_v_soil <- B_vernier_soil %>% group_by(date) %>%
  summarize( soil_temp_F = coalesce(first(soil_temp_F)))

C_t_soil <- C_tube_soil %>% group_by(date) %>%
   summarize( soil_temp_F = coalesce(first(soil_temp_F)))
 
C_v_soil <- C_vernier_soil %>% group_by(date) %>%
  summarize( soil_temp_F = coalesce(first(soil_temp_F)))

################################################################################

## COMBINE BY SITE
#a
SOIL_site_A <- bind_rows(A_t_soil, A_v_soil) %>% rename(A_temp_F = soil_temp_F) 
dim(SOIL_site_A)

#b
SOIL_site_B <- bind_rows(B_t_soil, B_v_soil) %>% rename(B_temp_F = soil_temp_F) 
dim(SOIL_site_B)

#c
SOIL_site_C <- bind_rows(C_t_soil, C_v_soil) %>% rename(C_temp_F = soil_temp_F)
dim(SOIL_site_C)


################################################################################

## COMBINE ALL
q1 <- left_join(SOIL_site_A, SOIL_site_B, by = 'date') 
all_soil <- left_join(q1, SOIL_site_C, by = 'date')


################################################################################

## CONVERT FOR GRAPHING

w <- all_soil %>% rename('Lower' = A_temp_F,
                         'Upper' = B_temp_F,  
                         'Mid Elevation' = C_temp_F
) %>%
  pivot_longer(
  cols = c(Lower, Upper, 'Mid Elevation'), 
  names_to = 'site',
  values_to = 'temp_f'
)

################################################################################

## GRAPHS

#strong seasonality
ggplot(w, aes(date, temp_f, color = site)) +
  geom_line(size = 1) +
  theme_minimal() +
  labs(
    title = "Soil Temperature in Bandelier NM over time, by Elevation",
    x = "Time",
    y = "Temperature  (\u00b0F)",
    color = "Site")+
  theme(plot.title = element_text(hjust = 0.5), 
        axis.title.x = element_text(size = 12), 
        axis.title.y = element_text(size = 12))


#Just graph from jan 2026 to now
w1 <- w %>% filter(date >= '2026-01-01') # can change date here
ggplot(w1, aes(date, temp_f, color = site)) +
  geom_line(size = 1) +
  theme_minimal() +
  labs(
    title = "Soil Temperature in Bandelier NM over time, by Elevation",
    x = "Time",
    y = "Temperature  (\u00b0F)",
    color = "Site")+
  theme(plot.title = element_text(hjust = 0.5), 
        axis.title.x = element_text(size = 12), 
        axis.title.y = element_text(size = 12))


#graph the average by year of soil temp















