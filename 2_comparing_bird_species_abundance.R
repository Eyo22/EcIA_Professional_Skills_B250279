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


##Using point count and transect data, produce two data frames, one consisting of each species in the northern plot and its associated abundance and the other consisting of each species in the southern plot and its associated abundance (or one data frame with data from both plots)

#lets first try this with the point count data

#Data frame for species and associated abundance for the northern plot point count
point_species_count_N <- Associated_occurences__bird_point_count_data[c(1:5), c("species", "individualCount")]

#Data frame for species and associated abundance for the southern plot point count
point_species_count_S <- Associated_occurences__bird_point_count_data[c(6:9), c("species", "individualCount")]

point_species_count_N
point_species_count_S

#lets now do this for the transect data

#Data frame for species and associated abundance for the northern plot transects
transect_species_count_N <- Associated_occurences__bird_transect_data[c(1:13), c("species", "individualCount")]

#Data frame for species and associated abundance for the southern plot transects
transect_species_count_S <- Associated_occurences__bird_transect_data[c(14:32), c("species", "individualCount")]

transect_species_count_N
transect_species_count_S


##Create an alphabetically ordered vector of the names of species seen in both northern and southern plots and vectors of the associated abundance of these species in the northern and southern plots respectively
##then use these three vectors to make a table and a histogram comparing bird species abundance in the northern and southern plots

#combine the columns of these transect and point count data frames 

#isolate the individualCount columns from the original data frames as stand alone vectors and combine them 
point_individualCount_N <- point_species_count_N[1:5,"individualCount"]
transect_individualCount_N <- transect_species_count_N[1:13, "individualCount"]
point_individualCount_N
transect_individualCount_N

individualCount_N <- c(point_individualCount_N, transect_individualCount_N)
sum(individualCount_N)
#isolate the species columns from the original data frames as stand alone vectors and combine them 
point_species_N <- point_species_count_N[1:5,"species"]
transect_species_N <- transect_species_count_N[1:13, "species"]

species_N <- c(point_species_N, transect_species_N)  

#view the combined vectors
individualCount_N
species_N

#remove species that aren't shared between the northern and southern plots from the combined species vector and remove their corresponding individualCount values from the combined individualCount vector
#species that were recorded on both plots: Anthus pratensis, Coloeus monedula, Parus major, Prunella modularis, Troglodytes troglodytes
individualCount_N <- individualCount_N[-c(1,3,9,12,13,15,16,18)]
species_N <- species_N[-c(1,3,9,12,13,15,16,18)]

#use the individualCount_N and species_N vectors to count total number of observations (abundance) associated with each species (as there are separate counts for the same species recorded in different sampling events)
n_Troglodytes_troglodytes <- sum(individualCount_N[c(1,5,9,10)])
n_Anthus_pratensis <- sum(individualCount_N[c(3,4,8)])
n_Coloeus_monedula <- individualCount_N[2]
n_Parus_major <- individualCount_N[6]
n_Prunella_modularis <- individualCount_N[7]

#for the species vector we simply remove duplicates with the function unique() and sort the remaining species names into alphabetical order 
species <- sort(unique(species_N))

#create a new individualCount_N vector of total abundance per species (as recorded on the northern plot) - with species abundance values in the same order as the corresponding species labels
total_individualCount_N <- c(n_Anthus_pratensis, n_Coloeus_monedula, n_Parus_major, n_Prunella_modularis, n_Troglodytes_troglodytes)
total_individualCount_N


#create another vector of total abundance per species (as recorded on the southern plot) - also with species abundance values in the same order as the corresponding species labels
point_species_count_S
transect_species_count_S

#combine the columns of these transect and point count data frames 

#isolate the individualCount columns from the original data frame as stand alone vectors and combine them 
point_individualCount_S <- point_species_count_S[1:4,"individualCount"]
transect_individualCount_S <- transect_species_count_S[1:19, "individualCount"]
point_individualCount_S
transect_individualCount_S

individualCount_S <- c(point_individualCount_S, transect_individualCount_S)
sum(individualCount_S)
#isolate the species columns from the original data frame as stand alone vectors and combine them 
point_species_S <- point_species_count_S[1:4,"species"]
transect_species_S <- transect_species_count_S[1:19, "species"]

#combine the point_species_S and transect_species_S vectors 

species_S <- c(point_species_S, transect_species_S)  

individualCount_S
species_S

#remove species that aren't shared between the northern and southern plots
#shared species are: Anthus pratensis, Coloeus monedula, Parus major, Prunella modularis, Troglodytes troglodytes
individualCount_S <- individualCount_S[-c(2,8,10,11,12,15,16,20,22,23)]
species_S <- species_S[-c(2,8,10,11,12,15,16,20,22,23)]

#use the individualCount_S and species_S vectors to count total number of observations (abundance) associated with each species
n_Troglodytes_troglodytes <- sum(individualCount_S[c(1,4,8,11)])
n_Anthus_pratensis <- sum(individualCount_S[c(7,9,13)])
n_Coloeus_monedula <- individualCount_S[3]
n_Parus_major <- sum(individualCount_S[c(6,10,12)])
n_Prunella_modularis <- sum(individualCount_S[c(2,5)])


#create a new individualCount_S vector of total abundance per species - with species abundance values in the same order as the corresponding species lables
total_individualCount_S <- c(n_Anthus_pratensis, n_Coloeus_monedula, n_Parus_major, n_Prunella_modularis, n_Troglodytes_troglodytes)
total_individualCount_S

#combine the species, total_individualCount_N and total_individualCount_S into a data frame that gives each species shared between the northern and southern plot along with its corresponding abundance (as obtained from point count and transect data) in the northern plot and the southern plot respectively
species_abundance <- data.frame(species = species, individualCount_Northern_Plot = total_individualCount_N,individualCount_Southern_Plot = total_individualCount_S)

species_abundance
#export the species abundance table as an excel file
library(writexl)
write_xlsx(species_abundance, "C:/Users/EyoAl/Documents/Documents/Edinburgh Uni/Professional Skills in Ecology and Evolution/Ecological impact assessment/EcIA_Test_Code/figs/bird_species_abundance_table.xlsx")


#make a histogram illustrating the differences in abundance of these species between the two plots

#make the data into a data frame with a format that is more compatible for making a histogram
species <- c(species, species)
species
individualCount <- c(total_individualCount_N, total_individualCount_S)
#a new vector of associated plot category ("N" for northern plot and "S" for southern plot) will be added to the new data fram as a column
Plot <- c("N","N","N","N","N","S","S","S","S","S")
species_abundance_forhist <- data.frame(species = species, individualCount = individualCount,Plot = Plot)

#plot the bar chart
ggplot(species_abundance_forhist, aes(x = species, y = individualCount, fill = str_to_title(Plot))) +
         geom_col(position = "dodge", colour = "black") +
         labs(x = "Species", y = "Abundance", fill = "Plot") +
         scale_x_discrete(labels = c("Anthus pratensis", "Coloeus monedula", "Parus major", "Prunella modularis", "Troglodytes troglodytes"))

#to export the bar chart as an image click on the zoom button in the plot window, right click on the zoomed image and select "save image as"



