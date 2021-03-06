best <- function(state, outcome) {
    
    # Read outcome data
    data <- get_outcomeData("outcome-of-care-measures.csv")
    
    # Validate state and outcome
    validate_outcome(outcome)
    validate_state(unique(data[,'State']), state)
    
    # Return hospital name with lowest rate
    outcomeColumn <- get_outcomeColumnIndex(outcome)
    validRows <- which(is_inState(data, state) & (!is.na(get_outcomeNumeric(data, outcomeColumn))))
    minOutcome <- min(as.numeric(data[validRows,outcomeColumn]))
    bestHospitals <- which(is_inState(data, state) & get_outcomeNumeric(data, outcomeColumn) == minOutcome)
    sort(data[bestHospitals,'Hospital.Name'])[1]
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
get_outcomeNumeric <- function(data, col) {
    as.numeric(data[,col])
}