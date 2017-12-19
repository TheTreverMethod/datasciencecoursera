best <- function(state, outcome) {
    
    # Read outcome data
    data <- get_outcomeData("outcome-of-care-measures.csv")
    
    # Validate state and outcome
    validate_outcome(outcome)
    validate_state(unique(data[,'State']), state)
    
    # Return hospital name with lowest rate
    outcomeColumn <- get_outcomeColumnIndex(outcome)
    indicesByStateAndOutcome <- get_validIndicesByStateAndOutcome(data, state, outcomeColumn)
    min_outcomeValue <- min(data[indicesByStateAndOutcome,outcomeColumn])
    best <- which(data[,'State'] == state & data[,outcomeColumn] == min_outcomeValue)
    data[best,'Hospital.Name']
}

get_outcomeData <- function(fileName) {
    read.csv(fileName, colClasses = "character")
}
get_validIndicesByStateAndOutcome <- function(all_data, state, outcomeIndex) {
    which(data[,'State'] == state & (!is.na(as.numeric(data[,outcomeIndex]))))
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
