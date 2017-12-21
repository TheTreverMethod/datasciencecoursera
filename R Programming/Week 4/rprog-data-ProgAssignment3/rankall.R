rankall <- function(outcome, num = "best") {
    
    # Read outcome data
    data <- get_outcomeData("outcome-of-care-measures.csv")
    
    # Validate outcome
    validate_outcome(outcome)
    
    # Get the column index for the outcome
    outcomeColumn <- get_outcomeColumnIndex(outcome)
    
    # Filter the data for valid values of the outcome
    data <- data[which(is_validOutcomeResult(data, outcomeColumn)),]
    
    # Create numeric column for outcome
    data[,'OutcomeNumeric'] <- as.numeric(data[,outcomeColumn])
    
    # Get sorting order by state, outcome, then name
    ranking <- order(data[,'State'], data[,'OutcomeNumeric'], data[,'Hospital.Name'])
    
    # Sort data
    data <- data[ranking,]
}

get_outcomeData <- function(fileName) {
    read.csv(fileName, colClasses = "character")
}
get_outcomeColumnIndex <- function(outcome) {
    if (outcome == "heart attack") {
        return(11)
    }
    else if (outcome == "heart failure") {
        return(17)
    }
    else {
        return(23)
    }
}
validate_outcome <- function(outcome) {
    if (!any(c("heart attack", "heart failure", "pneumonia") == outcome)) {
        stop("invalid outcome")
    }
}

is_validOutcomeResult <- function(data, col) {
    !is.na(as.numeric(data[,col]))
}
get_outcomeNumeric <- function(data, col) {
    as.numeric(data[,col])
}
get_rankRequest <- function(num, nrow) {
    if (num == "best") {
        return(1)
    }
    else if (num == "worst") {
        return(nrow)
    }
    else {
        num
    }
}