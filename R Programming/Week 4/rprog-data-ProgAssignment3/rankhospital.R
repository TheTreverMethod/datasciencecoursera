rankhospital <- function(state, outcome, num = "best") {
    
    # Read outcome data
    data <- get_outcomeData("outcome-of-care-measures.csv")
    
    # Validate state and outcome
    validate_outcome(outcome)
    validate_state(unique(data[,'State']), state)
    
    # Return hospital name with lowest rate
    outcomeColumn <- get_outcomeColumnIndex(outcome)
    
    # Filter the data for that state
    data <- data[which(is_inState(data, state)),]
    
    # Filter the data for valid values of the outcome
    data <- data[which(is_validOutcomeResult(data, outcomeColumn)),]
    
    # Create numeric column for outcome
    data[,'OutcomeNumeric'] <- as.numeric(data[,outcomeColumn])
    
    # Get sorting order by outcome, then name
    ranking <- order(data[,'OutcomeNumeric'], data[,'Hospital.Name'])
    
    # Return name of rank
    data[ranking,'Hospital.Name'][get_rankRequest(num,nrow(data))]
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
validate_state <- function(all_states, state) {
    if (!any(all_states == state)) {
        stop("invalid state")
    }
}

is_inState <- function(data, state) {
    data[,'State'] == state
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

