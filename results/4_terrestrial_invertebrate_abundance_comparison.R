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
#in these data sets each row represents a single taxon that could be identified down to class level (at least) and there is one row for each taxon recorded in each sampling event (each sampling event represents a point where sweep netting or pitfall trap methods were utilised along each transect, there was a total of 26 terrestrial invertebrate sampling events per plot)(However there are 7 rows that only record absences of data from some southern plot sampling events [i.e. rows with occurrenceStatus: “absent”], these are: SLP1, SLP4, SLP6, SLP7, SLP8, SLS1, SLS3 )

##Compare the total abundance of terrestrial invertebrates identified in the Northern and Southern plots

#make two vectors of the individualCount values recorded with north and south plot event IDs respectively
N_ter_inverts <- Occurences_terrestrial_invert_data$individualCount[Occurences_terrestrial_invert_data$eventID %in% c("NLS1","NLS2","NLS3","NLS4","NLS5","NLS6","NMS1","NMS2","NMS3","NMS4","NMS5","NMS6","NMS7","NMS8","NHS1","NHS2","NHS3","NHS4","NHS5","NLP1","NLP2","NLP3","NLP4","NLP5","NLP6","NLP7")]
N_ter_inverts
 

S_ter_inverts <- Occurences_terrestrial_invert_data$individualCount[Occurences_terrestrial_invert_data$eventID %in% c("SLS2","SLS4","SLS5","SLS6","SMS1","SMS2","SMS3","SMS4","SMS5","SHS1","SHS2","SHS3","SHS4","SHS5","SHS6","SHS7","SLP2","SLP3","SLP5")]
S_ter_inverts

#sum the contents of these vectors to get the total abundance of terrestrial invertebrates sampled in each plot
sum(N_ter_inverts)

sum(S_ter_inverts)
#238 terrestrial invertebrates were sampled on the northern plot whilst only 162 were sampled on the southern plot

##Compare the abundance of terrestrial invertebrate species (identified in both plots) between plots

#make two vectors of the species recorded with north and south plot event IDs respectively
N_ter_invert_sp <- Occurences_terrestrial_invert_data$species[Occurences_terrestrial_invert_data$eventID %in% c("NLS1","NLS2","NLS3","NLS4","NLS5","NLS6","NMS1","NMS2","NMS3","NMS4","NMS5","NMS6","NMS7","NMS8","NHS1","NHS2","NHS3","NHS4","NHS5","NLP1","NLP2","NLP3","NLP4","NLP5","NLP6","NLP7")]
N_ter_invert_sp


S_ter_invert_sp <- Occurences_terrestrial_invert_data$species[Occurences_terrestrial_invert_data$eventID %in% c("SLS2","SLS4","SLS5","SLS6","SMS1","SMS2","SMS3","SMS4","SMS5","SHS1","SHS2","SHS3","SHS4","SHS5","SHS6","SHS7","SLP2","SLP3","SLP5")]
S_ter_invert_sp

#combine the species vectors and individualCount vectors from the respective plots into data frames 
N_terrestrial_invert_sp_abundance <- data.frame(N_ter_invert_sp = N_ter_invert_sp, N_ter_invert_ab = N_ter_inverts)
N_terrestrial_invert_sp_abundance

S_terrestrial_invert_sp_abundance <- data.frame(S_ter_invert_sp = S_ter_invert_sp, S_ter_invert_ab = S_ter_inverts)
S_terrestrial_invert_sp_abundance
#now look at these data frames and make a note of the indices of rows that have species names: 
#north plot abundances with species names (by indices):3,6,11,12,13,14,16,18,19,23,24,29,39,47,48,52,64,67,99,105
#south plot abundances with species names (by indices):1,8,27,35,36,44,53,55,56,61,70,71,76,83


#use the values above to make vectors of indices that correspond with empty strings (blank species names) in the species vector
#for the north plot
n <- 1:108
N <- n[-c(3,6,11,12,13,14,16,18,19,23,24,29,39,47,48,52,64,67,99,105)]

#for the south plot
s <- 1:84
S <- s[-c(1,8,27,35,36,44,53,55,56,61,70,71,76,83)]

#clean the individualCount vectors by removing values that correspond with empty strings (blank species names) in the species vector
N_ter_inverts_cleaned <- N_ter_inverts[-c(N)]
N_ter_inverts_cleaned

S_ter_inverts_cleaned <- S_ter_inverts[-c(S)]
S_ter_inverts_cleaned

#clean the species vectors by removing empty strings ("")/any NA values
N_ter_invert_sp_cleaned <- N_ter_invert_sp[!(N_ter_invert_sp == "" | is.na(N_ter_invert_sp))]
N_ter_invert_sp_cleaned

S_ter_invert_sp_cleaned <- S_ter_invert_sp[!(S_ter_invert_sp == "" | is.na(S_ter_invert_sp))]
S_ter_invert_sp_cleaned

#combine the cleaned species vectors and individualCount vectors from the respective plots into data frames (just helps better visualise rows with species and associated individual count)
N_terrestrial_invert_sp_abundance_cleaned <- data.frame(N_ter_invert_sp = N_ter_invert_sp_cleaned, N_ter_invert_ab = N_ter_inverts_cleaned)
N_terrestrial_invert_sp_abundance_cleaned

S_terrestrial_invert_sp_abundance_cleaned <- data.frame(S_ter_invert_sp = S_ter_invert_sp_cleaned, S_ter_invert_ab = S_ter_inverts_cleaned)
S_terrestrial_invert_sp_abundance_cleaned


##remove species that aren't shared between the northern and southern plots from the species vectors and remove their corresponding individualCount values from the individualCount vectors
#make a list of species recorded in both plots
N_ter_invert_sp_cleaned
S_ter_invert_sp_cleaned
sort(N_ter_invert_sp_cleaned)
sort(S_ter_invert_sp_cleaned)
#species that were recorded on both plots: atrica, fusca, rubra, segmentata 

#for the northern plot
#remove the species that werent recorded on both plots from the northern species and individual count vectors
N_ter_inverts_shared <- N_ter_inverts_cleaned[-c(1,2,3,4,5,6,7,9,10,11,16)]
N_ter_invert_sp_shared <- N_ter_invert_sp_cleaned[-c(1,2,3,4,5,6,7,9,10,11,16)]
N_ter_inverts_shared
N_ter_invert_sp_shared

#use the individualCount_N and species_N vectors to count total number of observations (abundance) associated with each species (as there are separate counts for the same species recorded in different sampling events)
n_segmentata <- sum(N_ter_inverts_shared[c(1,5,6,7,9)])
n_rubra <- N_ter_inverts_shared[3]
n_fusca <- sum(N_ter_inverts_shared[c(2,8)])
n_atrica <- N_ter_inverts_shared[4]


#for the species vector we simply remove duplicates with the function unique() and sort the remaining species names into alphabetical order 
species <- sort(unique(N_ter_invert_sp_shared))
species
#create a new individualCount_N vector of total abundance per species (as recorded on the northern plot) - with species abundance values in the same order as the corresponding species labels
total_individualCount_N <- c(n_atrica, n_fusca, n_rubra, n_segmentata)
total_individualCount_N


#for the southern plot
#remove the species that werent recorded on both plots from the northern species and individual count vectors
S_ter_inverts_shared <- S_ter_inverts_cleaned[-c(1,2,3,4,5,10,14)]
S_ter_invert_sp_shared <- S_ter_invert_sp_cleaned[-c(1,2,3,4,5,10,14)]
S_ter_inverts_shared
S_ter_invert_sp_shared

#use the individualCount_N and species_N vectors to count total number of observations (abundance) associated with each species (as there are separate counts for the same species recorded in different sampling events)
n_segmentata <- sum(S_ter_inverts_shared[c(1,2,5,7)])
n_rubra <- S_ter_inverts_shared[3]
n_fusca <- S_ter_inverts_shared[4]
n_atrica <- S_ter_inverts_shared[6]

#create a new individualCount_N vector of total abundance per species (as recorded on the northern plot) - with species abundance values in the same order as the corresponding species labels
total_individualCount_S <- c(n_atrica, n_fusca, n_rubra, n_segmentata)
total_individualCount_S



#combine the species, total_individualCount_N and total_individualCount_S into a data frame that gives each species shared between the northern and southern plot along with its corresponding abundance in the northern plot and the southern plot respectively
species_abundance <- data.frame(species = species, individualCount_Northern_Plot = total_individualCount_N,individualCount_Southern_Plot = total_individualCount_S)
species_abundance
#note that the species names are in alphabetical order of species not genus name
#the full scientific names for the respective species in the table are Zygiella atrica, Formica fusca, Myrmica rubra and Metellina segmentata


#export the species abundance table as an excel file
library(writexl)
write_xlsx(species_abundance, "C:/Users/EyoAl/Documents/Documents/Edinburgh Uni/Professional Skills in Ecology and Evolution/Ecological impact assessment/EcIA_Test_Code/figs/terrestrial_invertebrate_species_abundance_table.xlsx")

## make data frames showing terrestrial invertebrate genus/species name and associated abundance

#make two vectors of the individualCount values recorded with north and south plot event IDs respectively
N_ter_inverts <- Occurences_terrestrial_invert_data$individualCount[Occurences_terrestrial_invert_data$eventID %in% c("NLS1","NLS2","NLS3","NLS4","NLS5","NLS6","NMS1","NMS2","NMS3","NMS4","NMS5","NMS6","NMS7","NMS8","NHS1","NHS2","NHS3","NHS4","NHS5","NLP1","NLP2","NLP3","NLP4","NLP5","NLP6","NLP7")]
N_ter_inverts

S_ter_inverts <- Occurences_terrestrial_invert_data$individualCount[Occurences_terrestrial_invert_data$eventID %in% c("SLS2","SLS4","SLS5","SLS6","SMS1","SMS2","SMS3","SMS4","SMS5","SHS1","SHS2","SHS3","SHS4","SHS5","SHS6","SHS7","SLP2","SLP3","SLP5")]
S_ter_inverts

#make two vectors of the scientific name recorded with north and south plot event IDs respectively
N_ter_invert_sp <- Occurences_terrestrial_invert_data$scientificName[Occurences_terrestrial_invert_data$eventID %in% c("NLS1","NLS2","NLS3","NLS4","NLS5","NLS6","NMS1","NMS2","NMS3","NMS4","NMS5","NMS6","NMS7","NMS8","NHS1","NHS2","NHS3","NHS4","NHS5","NLP1","NLP2","NLP3","NLP4","NLP5","NLP6","NLP7")]
N_ter_invert_sp


S_ter_invert_sp <- Occurences_terrestrial_invert_data$scientificName[Occurences_terrestrial_invert_data$eventID %in% c("SLS2","SLS4","SLS5","SLS6","SMS1","SMS2","SMS3","SMS4","SMS5","SHS1","SHS2","SHS3","SHS4","SHS5","SHS6","SHS7","SLP2","SLP3","SLP5")]
S_ter_invert_sp

#combine the scientificName vectors and individualCount vectors from the respective plots into data frames 
N_terrestrial_invert_sp_abundance <- data.frame(N_ter_invert_sp = N_ter_invert_sp, N_ter_invert_ab = N_ter_inverts)
N_terrestrial_invert_sp_abundance

S_terrestrial_invert_sp_abundance <- data.frame(S_ter_invert_sp = S_ter_invert_sp, S_ter_invert_ab = S_ter_inverts)
S_terrestrial_invert_sp_abundance
#now look at these data frames and make a note of the indices of rows that have species/genus names: 
#north plot abundances with species/genus names (by indices):3,5,8,11,12,13,14,16,17,18,19,23,24,29,39,44,47,48,50,52,,64,67,72,76,77,80,81,85,89,94,99,104,105
#south plot abundances with species/genus names (by indices):1,8,27,35,36,44,53,55,56,59,61,63,68,69,70,71,75,76,77,83

#use the values above to make vectors of indices that correspond with empty strings (blank scientific names) in the species/genus vector
#for the north plot
n <- 1:108
N <- n[-c(3,5,8,11,12,13,14,16,17,18,19,23,24,29,39,44,47,48,50,52,64,67,72,76,77,80,81,85,89,94,99,104,105)]

#for the south plot
s <- 1:84
S <- s[-c(1,8,27,35,36,44,53,55,56,59,61,63,68,69,70,71,75,76,77,83)]

#clean the individualCount vectors by removing values that correspond with empty strings (blank scientific names) in the species/genus vector
N_ter_inverts_cleaned <- N_ter_inverts[-c(N)]
N_ter_inverts_cleaned

S_ter_inverts_cleaned <- S_ter_inverts[-c(S)]
S_ter_inverts_cleaned

#clean the species/genus vectors by removing empty strings ("")/any NA values
N_ter_invert_sp_cleaned <- N_ter_invert_sp[!(N_ter_invert_sp == "" | is.na(N_ter_invert_sp))]
N_ter_invert_sp_cleaned

S_ter_invert_sp_cleaned <- S_ter_invert_sp[!(S_ter_invert_sp == "" | is.na(S_ter_invert_sp))]
S_ter_invert_sp_cleaned
sort(N_ter_invert_sp_cleaned)
sort(S_ter_invert_sp_cleaned)
#combine the cleaned scientificName vectors and individualCount vectors from the respective plots into data frames (to help visualise the data better at this stage of processing)
N_terrestrial_invert_sp_abundance_cleaned <- data.frame(N_ter_invert_sp = N_ter_invert_sp_cleaned, N_ter_invert_ab = N_ter_inverts_cleaned)
N_terrestrial_invert_sp_abundance_cleaned

S_terrestrial_invert_sp_abundance_cleaned <- data.frame(S_ter_invert_sp = S_ter_invert_sp_cleaned, S_ter_invert_ab = S_ter_inverts_cleaned)
S_terrestrial_invert_sp_abundance_cleaned

#for the northern plot data
#use the individualCount_N and scientificName_N vectors to count total number of observations (abundance) associated with each species/genus (as there are separate counts for the same species/genus recorded in different sampling events)
n_Scathophaga_stercoraria <- N_ter_inverts_cleaned[1]
n_Conomelus_sp <- sum(N_ter_inverts_cleaned[c(2,3)])
n_Notostira_elongata <- N_ter_inverts_cleaned[4] 
n_Entomobrya_nivalis <- N_ter_inverts_cleaned[5]
n_Empis_livida <- N_ter_inverts_cleaned[6]
n_Araneus_quadratus <- sum(N_ter_inverts_cleaned[c(7,8)])
n_Tetragnatha_sp <- N_ter_inverts_cleaned[9]
n_Metallina_segmentata <- sum(N_ter_inverts_cleaned[c(10,18,21,22,33)])
n_Stygnocoris_sabulosus <- N_ter_inverts_cleaned[11]
n_Arion_rufus <- sum(N_ter_inverts_cleaned[c(12,13)])
n_Dicyrtoma_fusca <- sum(N_ter_inverts_cleaned[c(14,31)])
n_Myrmica_rubra <- N_ter_inverts_cleaned[15]
n_Stenus_sp <- N_ter_inverts_cleaned[16]
n_Zygiella_atrica <- N_ter_inverts_cleaned[17]
n_Cepaea_hortensis <- N_ter_inverts_cleaned[19]
n_Zygiella_x_notata <- N_ter_inverts_cleaned[20]
n_Tipula_sp <- sum(N_ter_inverts_cleaned[c(23,27,29,32)])
n_Coenosia_sp <- sum(N_ter_inverts_cleaned[c(24,26,30)])
n_Hydrellia_sp <- N_ter_inverts_cleaned[25]
n_Lonchoptera_sp <- N_ter_inverts_cleaned[28]



#for the scientificName vector we can remove duplicates with the function unique() and sort the remaining scientific names into alphabetical order 
species_genuses_N <- sort(unique(N_ter_invert_sp_cleaned))
species_genuses_N
#however due to a spelling mistake, "Metallina segemenata" the incorrect spelling, is present alongside the correct spelling of "Metellina segmentata"
#to remove the incorrect spelling from the list:
species_genuses_N <- species_genuses_N[-11]
species_genuses_N
#create a new individualCount_N vector of total abundance per species/genus (as recorded on the northern plot) - with species abundance values in the same order as the corresponding species labels
total_individualCount_N <- c(n_Araneus_quadratus,n_Arion_rufus,n_Cepaea_hortensis,n_Coenosia_sp,n_Conomelus_sp,n_Dicyrtoma_fusca,n_Empis_livida,n_Entomobrya_nivalis,n_Hydrellia_sp,n_Lonchoptera_sp,n_Metallina_segmentata,n_Myrmica_rubra,n_Notostira_elongata,n_Scathophaga_stercoraria,n_Stenus_sp,n_Stygnocoris_sabulosus,n_Tetragnatha_sp,n_Tipula_sp,n_Zygiella_atrica,n_Zygiella_x_notata)
total_individualCount_N

#combine the resulting vectors above to make a data frame that gives the various species and genera identified in the northern plot along with their associated abundance values 
species_genus_abundance_N <- data.frame(scientific_name = species_genuses_N, individualCount_Northern_Plot = total_individualCount_N)
species_genus_abundance_N


#for the southern plot data
#use the individualCount_S and scientificName_N vectors to count total number of observations (abundance) associated with each species/genus (as there are separate counts for the same species/genus recorded in different sampling events)
S_ter_inverts_cleaned
S_ter_invert_sp_cleaned
n_Araneus_quadratus <- S_ter_inverts_cleaned[1]
n_Formica_fusca <- S_ter_inverts_cleaned[9]
n_Gonatium_rubens <- S_ter_inverts_cleaned[3]
n_Leptopterna_sp <- S_ter_inverts_cleaned[17]
n_Lipoptena_cervi <- S_ter_inverts_cleaned[20]
n_Metellina_segmentata <- sum(S_ter_inverts_cleaned[c(6,7,15,18)])
n_Myrmica_rubra <- S_ter_inverts_cleaned[8]
n_Odiellus_spinosus <- S_ter_inverts_cleaned[2]
n_Pachytomella_parallela <- S_ter_inverts_cleaned[11]
n_Pachytomella_sp <- S_ter_inverts_cleaned[13]
n_Tetragnatha_sp <- sum(S_ter_inverts_cleaned[c(10,14,19)])
n_Tipula_oleracea <- sum(S_ter_inverts_cleaned[c(4,5)])
n_Tipula_sp <- S_ter_inverts_cleaned[12]
n_Zygiella_atrica <- S_ter_inverts_cleaned[16]
 


#for the scientificName vector we can remove duplicates with the function unique() and sort the remaining scientific names into alphabetical order 
species_genuses_S <- sort(unique(S_ter_invert_sp_cleaned))
species_genuses_S
#however due to a spelling mistake, "Metallina segemenata" the incorrect spelling, you will have to change the spelling in the resulting data frame once it has been exported to excel

#create a new individualCount_N vector of total abundance per species/genus (as recorded on the northern plot) - with species abundance values in the same order as the corresponding species labels
total_individualCount_S <- c(n_Araneus_quadratus,n_Formica_fusca,n_Gonatium_rubens,n_Leptopterna_sp,n_Lipoptena_cervi,n_Metellina_segmentata,n_Myrmica_rubra,n_Odiellus_spinosus,n_Pachytomella_parallela,n_Pachytomella_sp,n_Tetragnatha_sp,n_Tipula_oleracea,n_Tipula_sp,n_Zygiella_atrica)
total_individualCount_S

#combine the resulting vectors above to make a data frame that gives the various species and genera identified in the southern plot along with their associated abundance values 
species_genus_abundance_S <- data.frame(scientific_name = species_genuses_S, individualCount_Southern_Plot = total_individualCount_S)
species_genus_abundance_S

#export the species/genus abundance tables as an excel file
library(writexl)
write_xlsx(species_genus_abundance_N, "C:/Users/EyoAl/Documents/Documents/Edinburgh Uni/Professional Skills in Ecology and Evolution/Ecological impact assessment/EcIA_Test_Code/figs/northern_plot_terrestrial_invertebrate_species_and_genus_abundance_table.xlsx")

write_xlsx(species_genus_abundance_S, "C:/Users/EyoAl/Documents/Documents/Edinburgh Uni/Professional Skills in Ecology and Evolution/Ecological impact assessment/EcIA_Test_Code/figs/southern_plot_terrestrial_invertebrate_species_and_genus_abundance_table.xlsx")
