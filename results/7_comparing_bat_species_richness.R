#this package allows you to export stuff as excel files
install.packages("writexl")
#load contents of the "tidyverse" library which contains useful packages like ggplot2 for plotting, readr for easier data reading, and dplyr for data manipulation
library(tidyverse)
#other packages that might be required
library(ggplot2)
library(dplyr)
library(remotes)

#read the auidomoth data into R 
Associated_occurences_audiomoth_data <- read.csv("data/Arran Field course 2023 data entry - StandardisedBatOccurences.csv", header = TRUE)
Associated_occurences_audiomoth_data
#in these datasets each row represents a single species and there is one row for each species recorded in each sampling event (there were 4 sampling events)


##make lists of bat species recorded by the camera traps in the two plots

#isolate species names with a certian event ID from the species column
#transfer each of these lists to a vector which gives the species names for the north and south plot event IDs respectively
N_bats <- Associated_occurences_audiomoth_data$scientificName[Associated_occurences_audiomoth_data$eventID %in% c("NorthN3Bats","NorthN4Bats")]
N_bats

S_bats <- Associated_occurences_audiomoth_data$scientificName[Associated_occurences_audiomoth_data$eventID %in% c("SouthN1Bats","SouthN2Bats")]
S_bats



#Use the function unique() to remove species name duplicates from the vectors whilst preserving the unique species names
#Use the function sor() to sort the species names into alphabetical order
North_bats <- sort(unique(N_bats))
South_bats <- sort(unique(S_bats))

North_bats
South_bats

#add an empty element ("") to the North_bat vector so it is the same length as the South_bat vector and they can be combined into a data frame
empty <- ""
empty
North_bats <- c(North_bats, empty)

#combine the North_bats and South_bats vectors into a data frame that represents a table of bat species detected in the northern and southern plots respectively
bat_species <- data.frame(Northern_Plot_Bats = North_bats, Southern_Plot_Bats = South_bats)
bat_species

##export the bat species table as an excel file
library(writexl)
write_xlsx(bat_species, "C:/Users/EyoAl/Documents/Documents/Edinburgh Uni/Professional Skills in Ecology and Evolution/Ecological impact assessment/EcIA_Test_Code/figs/bat_species_table.xlsx")

##make a table consisting of the scientific and common names of these bat species

#combine the North_bats and South_bats vectors
bats_scientificNm <- c(North_bats, South_bats)

#use the functions unique() and sort() to remove duplicate names and order the remaining elements alphabetically
bats_scientificNm <- sort(unique(bats_scientificNm))
bats_scientificNm
#remove any blank elements ("")
bats_scientificNm <- bats_scientificNm[-1]
bats_scientificNm

#make a vector of common names that correspond to the scientific names
bats_commonNm <- c("Western barbastelle","Serotine bat","Alcathoe bat","Bechstein's bat","Brandt's bat","Daubenton's bat","Whiskered bat","Natterer's bat","Lesser noctule","Common noctule","Nathusius's pipistrelle","Common pipistrelle","Soprano pipistrelle","Brown long-eared bat","Grey long-eared bat","Greater horseshoe bat","Lesser horseshoe bat")
bats_commonNm

#combine the scientific and common name vectors into a data frame that represents a table of bat scientific names alongside their corresponding common names 
bat_scientific_common_names <- data.frame(Scientific_name = bats_scientificNm, Common_name = bats_commonNm)
bat_scientific_common_names

##export the bat scientific-common name table as an excel file
library(writexl)
write_xlsx(bat_scientific_common_names, "C:/Users/EyoAl/Documents/Documents/Edinburgh Uni/Professional Skills in Ecology and Evolution/Ecological impact assessment/EcIA_Test_Code/figs/bat_scientific_to_common_name_conversions.xlsx")
#This data frame was subsequently edited manually to produce a table of mammals with scientific name, common name and protection/conservation status