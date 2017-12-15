library(stringr);

pollutantmean <- function(directory, pollutant, id = 1:332) {
    
    get_dataframe <- function(f) {
        read.csv(f)
    }
    get_pollutantvector <- function(df) {
        df[,pollutant][!is.na(df[,pollutant])]
    }
    
    setwd(directory)
    
    files <- paste(str_pad(id, 3, pad = "0"), '.csv')
    
    all_values <- c()
    
    for(f in files) {
        # read each one into a data frame
        frame <- get_dataframe(f)
        
        # get all the values of that pollutant that aren't NA
        file_values <- get_pollutantvector(frame)
        
        # add to a vector containing all values
        all_values <- c(all_values, file_values)
    }
    
    mean(all_values)
}