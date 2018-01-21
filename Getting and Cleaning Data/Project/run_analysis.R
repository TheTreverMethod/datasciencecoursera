run_analysis <- function(dir) {
    load_deps()
    setwd(dir)
    
    # load data from test set
    subjects_test <- read.table("test/subject_test.txt")
    activities_test <- read.table("test/y_test.txt")
    measurements_test <- read.table("test/X_test.txt")
    
    # load data from train set
    subjects_train <- read.table("train/subject_train.txt")
    activities_train <- read.table("train/y_train.txt")
    measurements_train <- read.table("train/X_train.txt")
    
    # combine each into a single table
    subjects <- rbind(subjects_test, subjects_train)
    activities <- rbind(activities_test, activities_train)
    measurements <- rbind(measurements_test, measurements_train)
    
    # assign colnames to measurements
    names(measurements) <- get_featureNames()
    
    # extract columns for means and standard deviations
    
    # take the columns from measurements, subjects, and activies
    # and merge into a single table
    
    # reorder the columns so the subject and activity are first
    
    # change the values for the activities to be descriptive
    
    # change the column names to be descriptive
    
    # create the second tidy data set that averages the values
    # for each subject and activity
}

load_deps <- function() {
    library(dplyr)
}
get_featureNames <- function() {
    features <- read.table("features.txt")
    features[,2]
}