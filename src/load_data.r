library(mlbench)

wholesale_data = read.csv('../data/dataset.csv', header = TRUE)

colnames(wholesale_data)[8] <- 'Deli'

wholesale_data$Channel[wholesale_data$Channel == 1] <- "Horeca"
wholesale_data$Channel[wholesale_data$Channel == 2] <- "Retail"

wholesale_data$Region[wholesale_data$Region == 1] <- "Lisbon"
wholesale_data$Region[wholesale_data$Region == 2] <- "Oporto"
wholesale_data$Region[wholesale_data$Region == 3] <- "Other"