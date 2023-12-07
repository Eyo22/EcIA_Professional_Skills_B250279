#this package allows you to export stuff as excel files
install.packages("writexl")
#load contents of the "tidyverse" library which contains useful packages like ggplot2 for plotting, readr for easier data reading, and dplyr for data manipulation
library(tidyverse)
#other packages that might be required
library(ggplot2)
library(dplyr)
library(remotes)

#read camera trap data into R 
Associated_occurences_camera_trap_data <- read.csv("data/Arran Field course 2023 data entry - Occurences (Camera Traps).csv", header = TRUE)
Associated_occurences_camera_trap_data
#in these datasets each row represents a single species and there is one row for each species recorded in each sampling event (there were 18 sampling events but relatively few yielded data)


##make lists of mammal species recorded by the camera traps in the two plots

#isolate species names with a certian event ID from the species column
#transfer each of these lists to a vector which gives the species names for the north and south plot event IDs respectively
N_mammals <- Associated_occurences_camera_trap_data$species[Associated_occurences_camera_trap_data$eventID %in% c("north1-1","north7-1","north7-2","north7-3","north5-1","north5-2","north8-1","north9-1")]
N_mammals
#remove all non mammals from this vector (i.e. the bird a. pratensis)
N_mammals <- N_mammals[-7]
N_mammals

##probably don't need this code
S_mammals <- Associated_occurences_camera_trap_data$species[Associated_occurences_camera_trap_data$eventID %in% c("south2-1","south4-1","south5-1","south5-2","south5-3")]
S_mammals
#c. elephas was the only species recorded on the southern plot camera traps
##probably don't need this code



#Use the function unique() to remove species name duplicates from the vectors whilst preserving the unique species names
#Use the function sor() to sort the species names into alphabetical order
North_mammals <- sort(unique(N_mammals))
South_mammals <- sort(unique(S_mammals))

North_mammals
South_mammals

#there is so little data that you do not need to do any more coding or make a table, you can simply just talk about species richness by looking at the raw data or the lists you made above
#you probably wouldn't need to put this on github

##Make a histogram of abundance per mammal species per plot

