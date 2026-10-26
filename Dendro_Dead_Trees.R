
## Title: Dead tree analysis
## Intention: See what's happening 

## Author: Maura Collins
## Date of last edit: 06/10/2026


## SCRIPT NOTES:
# 1) This script references the Dendro_Setup.R file
# you want the dataframes named:

# if you don't want the core data
# site_A2, site_B2, site_C2

# if you do want the core data
# site_A4, site_B4, site_C4


## LIBRARY
source("S:/Ecology/Student_folders_&_files/Maura 2026/Dendro Exploration/Dendro_Setup.R")
library(ggplot2)
#this source gives you tidyverse and readxl, it needs to be saved before you can 
#run this line successfully

################################################################################

## PULL OUT DEAD TREES WITH MEASUREMENTS

dead_A <- site_A2 %>% filter(status == 'Dead' & !is.na(change_in_circum_mm))
dead_B <- site_B2 %>% filter(status == 'Dead' & !is.na(change_in_circum_mm))
dead_C <- site_C2 %>% filter(status == 'Dead' & !is.na(change_in_circum_mm))

dead_measured1 <- bind_rows(dead_A, dead_B)

dead_measured <- bind_rows(dead_measured1, dead_C)

dead_A <- site_A14 %>%
  filter(status == 'Dead')



ggplot(dead_A, aes(date, cumulative_BAI, color = ID)) +
   geom_line(size = 1) +
   theme_minimal() +
   labs(
        title = "Dead Trees: BAI in Bandelier NM over time",
       x = "Time",
        y = "BAI",
        color = "Tree")+
   theme(plot.title = element_text(hjust = 0.5), 
                   axis.title.x = element_text(size = 12), 
                  axis.title.y = element_text(size = 12))

  







