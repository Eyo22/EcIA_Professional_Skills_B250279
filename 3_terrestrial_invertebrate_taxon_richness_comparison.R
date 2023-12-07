#this package allows you to export stuff as excel files
install.packages("writexl")
#load contents of the "tidyverse" library which contains useful packages like ggplot2 for plotting, readr for easier data reading, and dplyr for data manipulation
library(tidyverse)
#other packages that might be required
library(ggplot2)
library(dplyr)
library(remotes)

#read terrestrial invertebrate data into R 
Occurences_terrestrial_invert_data <- read.csv("data/Arran Field course 2023 data entry - Occurences (terrestrial invert data).csv", header = TRUE)
#in these datasets each row represents a single taxon that could be identified down to class level (at least) and there is one row for each taxon recorded in each sampling event (each sampling event represents a point where sweep netting or pitfall trap methods were utilised along each transect, there was a total of 26 terrestrial invertebrate sampling events per plot)(However there are 7 rows that only record absences of data from some southern plot sampling events [i.e. rows with occurrenceStatus: “absent”], these are: SLP1, SLP4, SLP6, SLP7, SLP8, SLS1, SLS3 )

##make dataframes of the terrestrial invertebrate families recorded in the two plots


#isolate family names with a certian event ID from the family column
#transfer each of these lists to a vector which gives the species names for the north and south plot event IDs respectively
N_ter_inverts <- Occurences_terrestrial_invert_data$family[Occurences_terrestrial_invert_data$eventID %in% c("NLS1","NLS2","NLS3","NLS4","NLS5","NLS6","NMS1","NMS2","NMS3","NMS4","NMS5","NMS6","NMS7","NMS8","NHS1","NHS2","NHS3","NHS4","NHS5","NLP1","NLP2","NLP3","NLP4","NLP5","NLP6","NLP7")]
N_ter_inverts
#family could not be identified in 4 elements of the N_ter_inverts vector (thus it has 4 empty strings) 

S_ter_inverts <- Occurences_terrestrial_invert_data$family[Occurences_terrestrial_invert_data$eventID %in% c("SLS2","SLS4","SLS5","SLS6","SMS1","SMS2","SMS3","SMS4","SMS5","SHS1","SHS2","SHS3","SHS4","SHS5","SHS6","SHS7","SLP2","SLP3","SLP5")]
S_ter_inverts
#family could not be identified in 14 elements of the S_ter_inverts vector (thus it has 14 empty strings)

#clean the vectors by removing empty strings ("")/any NA values
N_ter_inverts_cleaned <- N_ter_inverts[!(N_ter_inverts == "" | is.na(N_ter_inverts))]
N_ter_inverts_cleaned

S_ter_inverts_cleaned <- S_ter_inverts[!(S_ter_inverts == "" | is.na(S_ter_inverts))]
S_ter_inverts_cleaned

#remove duplicated family names in these two vectors and sort the remaining family names into alphabetical order
N_ter_invert_families <- sort(unique(N_ter_inverts_cleaned))
N_ter_invert_families

S_ter_invert_families <- sort(unique(S_ter_inverts_cleaned))
S_ter_invert_families

#count the number of families identified in each plot
length(N_ter_invert_families)
length(S_ter_invert_families)
#37 families were identified in the northern plot whilst only 29 were identified in the southern plot

#turn the vectors into data frames
terrestrial_invert_families_N <- data.frame(Northern_Plot_families = N_ter_invert_families)
terrestrial_invert_families_N

terrestrial_invert_families_S <- data.frame(Southern_Plot_families = S_ter_invert_families)
terrestrial_invert_families_S



##export terrestrial_invert_families_N and terrestrial_invert_families_S as excel files
library(writexl)
write_xlsx(terrestrial_invert_families_N, "C:/Users/EyoAl/Documents/Documents/Edinburgh Uni/Professional Skills in Ecology and Evolution/Ecological impact assessment/EcIA_Test_Code/figs/terrestrial_invert_families_north_plot.xlsx")
write_xlsx(terrestrial_invert_families_S, "C:/Users/EyoAl/Documents/Documents/Edinburgh Uni/Professional Skills in Ecology and Evolution/Ecological impact assessment/EcIA_Test_Code/figs/terrestrial_invert_families_south_plot.xlsx")
