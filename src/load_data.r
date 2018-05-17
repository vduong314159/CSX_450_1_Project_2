library(mlbench)

wholesale_data = read.csv('../data/dataset.csv', header = TRUE)

colnames(wholesale_data)[8] <- 'Deli'

wholesale_data$Channel[wholesale_data$Channel == 1] <- "Horeca"
wholesale_data$Channel[wholesale_data$Channel == 2] <- "Retail"

wholesale_data$Region[wholesale_data$Region == 1] <- "Lisbon"
wholesale_data$Region[wholesale_data$Region == 2] <- "Oporto"
wholesale_data$Region[wholesale_data$Region == 3] <- "Other"

display_outliers <- function(feature, param = 4, df = wholesale_data) {
    feature_vec =  as.vector(wholesale_data[[feature]])
    Q1 <- quantile(feature_vec, .25)
    Q3 <- quantile(feature_vec, .75)
    tukey_window <- param*(Q3-Q1)

    # less_than_Q1 & greater_than_Q3 are masks, meaning they're vectors whose
    # elements are booleans
    less_than_Q1 <- wholesale_data[[feature]] < Q1 - tukey_window
    greater_than_Q3 <- wholesale_data[[feature]] > Q3 + tukey_window
    tukey_mask <- (less_than_Q1 | greater_than_Q3)
    outliers <- wholesale_data[tukey_mask,]
    return(outliers)
}

outlier_dfs <- sapply(X = colnames(Filter(is.numeric, wholesale_data)), FUN = display_outliers, simplify = FALSE)

## sapply() is difficult because rownames() returns a vector and sapply does not append vectors to return a vector
## it will return a list which messes up following code
raw_outliers <- c()
for (feat in outlier_dfs) {
    ndx <- c(row.names(feat))
    raw_outliers <- c(raw_outliers, ndx)
}

freq_outliers <- as.data.frame(table(raw_outliers))

outliers_many_feats <- freq_outliers[freq_outliers$Freq > 1,]$raw_outliers
is_outlier_for_many_feats <- rownames(wholesale_data) %in% outliers_many_feats
wholesale_data <- wholesale_data[!is_outlier_for_many_feats,]
