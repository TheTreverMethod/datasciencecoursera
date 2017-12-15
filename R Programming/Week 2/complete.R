complete <- function(directory, id = 1:332) {
    
    get_dataframe <- function(f) {
        read.csv(f)
    }
    
    has_reading <- function(df, pollutant) {
        !is.na(df[,pollutant])
    }
    
    get_files <- function(directory, id) {
        paste(directory, '/', str_pad(id, 3, pad = "0"), '.csv', sep = "")
    }
    
    nobs <- c()
    
    for(f in get_files(directory, id)) {
        # read each one into a data frame
        frame <- get_dataframe(f)
        
        # get logical vectors for pollutants based on the absence of na values
        complete <- has_reading(frame, 'sulfate') & has_reading(frame, 'nitrate')
        
        # add number of completes to nobs vector
        nobs <- c(nobs, length(which(complete)))
    }
    
    data.frame(id, nobs)
}