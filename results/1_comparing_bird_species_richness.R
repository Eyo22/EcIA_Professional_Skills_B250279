#this package allows you to export stuff as excel files
install.packages("writexl")
#load contents of the "tidyverse" library which contains useful packages like ggplot2 for plotting, readr for easier data reading, and dplyr for data manipulation
library(tidyverse)
#other packages that might be required
library(ggplot2)
library(dplyr)
library(remotes)

#read bird transect data into R 
Associated_occurences__bird_transect_data <- read.csv("data/Arran Field course 2023 data entry - Associated occurences (bird transect data).csv", header = TRUE)
#read bird point count data into R
Associated_occurences__bird_point_count_data <- read.csv("data/Arran Field course 2023 data entry - Associated occurences (bird point count data).csv", header = TRUE)
#in these datasets each row represents a single species and there is one row for each species recorded in each sampling event (there is one sampling event per plot for the point counts and three sampling events per plot for the transect data)


##make a table the bird species recorded in the two plots

#vectors for the point count data
#isolate species names with a certian event ID from the species column
#transfer each of these lists to a vector which gives the species names for the north and south plot event IDs respectively
Npoint_count_birds <- Associated_occurences__bird_point_count_data$species[Associated_occurences__bird_point_count_data$eventID %in% "pointN"]
Npoint_count_birds

Spoint_count_birds <- Associated_occurences__bird_point_count_data$species[Associated_occurences__bird_point_count_data$eventID %in% "pointS"]
Spoint_count_birds


#vectors for the transect data
#make vectors of the names of bird species identified in all three transects of the surveys of the northern and southern plots respectively
Ntransects_birds <- Associated_occurences__bird_transect_data$species[Associated_occurences__bird_transect_data$eventID %in% c("n1birds","n2birds","n3birds")]
Ntransects_birds



Stransects_birds <- Associated_occurences__bird_transect_data$species[Associated_occurences__bird_transect_data$eventID %in% c("s1birds","s2birds","s3birds")]
Stransects_birds


#combine the corresponding vectors that give the names of the bird species identified in the point counts and the transects for the northern and southern plots respecitvely
North_birds_PTcombined <- c(Npoint_count_birds, Ntransects_birds)
South_birds_PTcombined <- c(Spoint_count_birds, Stransects_birds)

North_birds_PTcombined
South_birds_PTcombined


#Use the function unique() to remove species name duplicates from the combined vectors whilst preserving the unique species names - produces vectors consisting of the bird species recorded in all sampling events (transects and point counts) of the northern and southern plots respectively
North_birds <- unique(North_birds_PTcombined)
South_birds <- unique(South_birds_PTcombined)

North_birds
South_birds

#rearrange these vectors so the species names are in alphabetical order
North_birds_alphabetical <- sort(North_birds)
South_birds_alphabetical <- sort(South_birds)

North_birds_alphabetical
South_birds_alphabetical

#get the collective species richness identified by the two survey methods in each plot by using the function length() on the two combined vectors (with duplicates removed)
N_birdSR <- length(North_birds)
S_birdSR <- length(South_birds)
#The same number of species were recorded in the north and south plots (11) but they only share 5 of these species


#make a table of the bird species (alphabetically sorted) recorded in the northern and southern plots
birds_df <- data.frame(Northern_Plot_Birds = North_birds_alphabetical, Southern_Plot_Birds = South_birds_alphabetical)
birds_df

##make two vectors, one of common names and the other of alphabetically ordered scientific names of the bird species found across both plots then combine them into a data frame that gives the corresponding common name for each species name

#alphabetically ordered scientific names
Total_birds <- sort(unique(c(North_birds, South_birds)))
Total_birds

#corresponding common names in the same order 
common_names <- c("meadow pipit","eurasian siskin","hen harrier","western jackdaw","common raven","hooded crow","carrion crow","eurasian blue tit","european robin","common kestrel","eurasian chaffinch","northern wheatear","great tit","coal tit","dunnock","goldcrest","eurasian wren")

#data frame consisting of two collumns, one for species names and the other for common names
scientific_to_common_name_conversions <- data.frame(Scientific_Name = Total_birds, Common_Name = common_names)

##export the bird species and scientific-common names tables as excel files
library(writexl)
write_xlsx(birds_df, "C:/Users/EyoAl/Documents/Documents/Edinburgh Uni/Professional Skills in Ecology and Evolution/Ecological impact assessment/EcIA_Test_Code/figs/bird_species_table.xlsx")

write_xlsx(scientific_to_common_name_conversions, "C:/Users/EyoAl/Documents/Documents/Edinburgh Uni/Professional Skills in Ecology and Evolution/Ecological impact assessment/EcIA_Test_Code/figs/bird_scientific-common_names_table.xlsx")

#This data frame was subsequently edited manually to produce a table of birds with scientific name, common name and protection/conservation status