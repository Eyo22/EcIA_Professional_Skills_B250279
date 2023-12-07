#this package allows you to export stuff as excel files
install.packages("writexl")
#load contents of the "tidyverse" library which contains useful packages like ggplot2 for plotting, readr for easier data reading, and dplyr for data manipulation
library(tidyverse)
#other packages that might be required
library(ggplot2)
library(dplyr)
library(remotes)

#read aquatic invertebrate data into R 
Occurences_aquatic_invert_data <- read.csv("data/Arran Field course 2023 data entry - Occurences (aquatic inverts).csv", header = TRUE)
#in these datasets each row represents a single taxon that could be identified down to order level (at least) and there is one row for each taxon recorded in each sampling event (each sampling event represents a point where kick sampling methods were utilised along each transect, there was a total of 5 aquatic invertebrate sampling events in the northern plot stream and 11 sampling events in the southern plot (5 in the stream and 6 in the marsh))



##make dataframes of the aquatic invertebrate orders recorded in the northern plot stream, southern plot stream and southern plot blanket bog


#isolate order names with a certain event ID from the order column
#transfer each of these lists to a vector which gives the order names for the north strem, south stream and south marsh event IDs respectively

#northern plot stream
NS_aq_invert_ord <- Occurences_aquatic_invert_data$order[Occurences_aquatic_invert_data$eventID %in% c("N1Stream","N2Stream","N3Stream","N4Stream","N5Stream")]
NS_aq_invert_ord

#southern plot stream
SS_aq_invert_ord <- Occurences_aquatic_invert_data$order[Occurences_aquatic_invert_data$eventID %in% c("S1Stream","S2Stream","S3Stream","S4Stream","S5Stream")]
SS_aq_invert_ord
#for some reason R is not detecting orders with a S4Stream sampling ID (the vector should have 12 elements not 10) but all the orders sampled in this water body are recorded in this vector and the final result will not be affected

#southern plot marsh
SM_aq_invert_ord <- Occurences_aquatic_invert_data$order[Occurences_aquatic_invert_data$eventID %in% c("S1Marsh","S2Marsh","S3Marsh","S4Marsh","S5Marsh","S6Marsh")]
SM_aq_invert_ord




#remove duplicated order names in these vectors and sort the remaining order names into alphabetical order
NS_aq_invert_ord <- sort(unique(NS_aq_invert_ord))
NS_aq_invert_ord

SS_aq_invert_ord <- sort(unique(SS_aq_invert_ord))
SS_aq_invert_ord
#in this vector coleoptera was spelt with a capital C in one instance and spelled incorrectly in another instance
#these incorrect elements must therefore be removed from the vector:
SS_aq_invert_ord <- SS_aq_invert_ord[-c(2,3)]
SS_aq_invert_ord

SM_aq_invert_ord <- sort(unique(SM_aq_invert_ord))
SM_aq_invert_ord

#count the number of orders identified in each water body
length(NS_aq_invert_ord)
length(SS_aq_invert_ord)
length(SM_aq_invert_ord)
#6 orders were identified in the northern stream and 5 were identified in the southern stream whilst 6 were identified in the southern marsh (blanket bog)

#turn the vectors into data frames
aquatic_invert_orders_North_stream <- data.frame(Northern_Stream_Orders = NS_aq_invert_ord)
aquatic_invert_orders_North_stream

aquatic_invert_orders_South_stream <- data.frame(Southern_Stream_Orders = SS_aq_invert_ord)
aquatic_invert_orders_South_stream

aquatic_invert_orders_South_bog <- data.frame(Southern_bog_Orders = SM_aq_invert_ord)
aquatic_invert_orders_South_bog


##export these data frames as excel files
library(writexl)
write_xlsx(aquatic_invert_orders_North_stream, "C:/Users/EyoAl/Documents/Documents/Edinburgh Uni/Professional Skills in Ecology and Evolution/Ecological impact assessment/EcIA_Test_Code/figs/aquatic_invert_orders_north_stream.xlsx")

write_xlsx(aquatic_invert_orders_South_stream, "C:/Users/EyoAl/Documents/Documents/Edinburgh Uni/Professional Skills in Ecology and Evolution/Ecological impact assessment/EcIA_Test_Code/figs/aquatic_invert_orders_south_stream.xlsx")

write_xlsx(aquatic_invert_orders_South_bog, "C:/Users/EyoAl/Documents/Documents/Edinburgh Uni/Professional Skills in Ecology and Evolution/Ecological impact assessment/EcIA_Test_Code/figs/aquatic_invert_orders_south_bog.xlsx")
#consider merging these data frames in excel to make a table

##make dataframes of the aquatic invertebrate families recorded in the northern plot stream, southern plot stream and southern plot blanket bog

#isolate family names with a certain event ID from the family column
#transfer each of these lists to a vector which gives the family names for the north strem, south stream and south marsh event IDs respectively

#northern plot stream
NS_aq_invert_fam <- Occurences_aquatic_invert_data$family[Occurences_aquatic_invert_data$eventID %in% c("N1Stream","N2Stream","N3Stream","N4Stream","N5Stream")]
NS_aq_invert_fam
#family could not be identified in 7 (of 24) elements of the NS_aq_invert_fam vector (thus it has 7 empty strings) 

#southern plot stream
SS_aq_invert_fam <- Occurences_aquatic_invert_data$family[Occurences_aquatic_invert_data$eventID %in% c("S1Stream","S2Stream","S3Stream","S4Stream","S5Stream")]
SS_aq_invert_fam
#family could not be identified in 7 (of 12) elements of the SS_aq_invert_fam vector (thus it has 7 empty strings) 
#for some reason R is not detecting families with a "S4Stream" sampling ID (the vector should have 12 elements not 10) but all the families sampled in this water body are recorded in this vector and the final result will not be affected


#southern plot marsh
SM_aq_invert_fam <- Occurences_aquatic_invert_data$family[Occurences_aquatic_invert_data$eventID %in% c("S1Marsh","S2Marsh","S3Marsh","S4Marsh","S5Marsh","S6Marsh")]
SM_aq_invert_fam
#nothing could be identified down to family level in the southern marsh

#clean the vectors by removing empty strings ("")/any NA values
NS_aq_invert_fam <- NS_aq_invert_fam[!(NS_aq_invert_fam == "" | is.na(NS_aq_invert_fam))]
NS_aq_invert_fam

SS_aq_invert_fam <- SS_aq_invert_fam[!(SS_aq_invert_fam == "" | is.na(SS_aq_invert_fam))]
SS_aq_invert_fam


#remove duplicated family names in these vectors and sort the remaining order names into alphabetical order
NS_aq_invert_fam <- sort(unique(NS_aq_invert_fam))
NS_aq_invert_fam

SS_aq_invert_fam <- sort(unique(SS_aq_invert_fam))
SS_aq_invert_fam


#turn the vectors into data frames
aquatic_invert_families_North_stream <- data.frame(Northern_Stream_Families = NS_aq_invert_fam)
aquatic_invert_families_North_stream

aquatic_invert_families_South_stream <- data.frame(Southern_Stream_Families = SS_aq_invert_fam)
aquatic_invert_families_South_stream


##export these data frames as excel files
library(writexl)
write_xlsx(aquatic_invert_families_North_stream, "C:/Users/EyoAl/Documents/Documents/Edinburgh Uni/Professional Skills in Ecology and Evolution/Ecological impact assessment/EcIA_Test_Code/figs/aquatic_invert_families_north_stream.xlsx")

write_xlsx(aquatic_invert_families_South_stream, "C:/Users/EyoAl/Documents/Documents/Edinburgh Uni/Professional Skills in Ecology and Evolution/Ecological impact assessment/EcIA_Test_Code/figs/aquatic_invert_families_south_stream.xlsx")
#consider merging these data frames in excel to make a table

