corr <- function(directory, threshold = 0) {
    
    # create the corr vector to be returned
    correlations <- c()
    
    # get all the files in the working directory
    files <- dir(directory)
    
    # for each file, get a data frame with all rows that have complete observed cases
    for (f in files) {
        df <- read.csv(paste(directory, '/', f, sep = ''))
        complete_cases <- df[complete.cases(df),]
        
        if (nrow(complete_cases) >= threshold) {
            cor <- cor(complete_cases[,'sulfate'], complete_cases[,'nitrate'])
            correlations <- c(correlations, cor)
        }
    }
    correlations
}