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
    
    # remove duplicate columns in measurements
    measurements <- rm_dupCols(measurements)
    
    # select only columns we want for our final result
    measurements <- measurements[,grep("mean()|std()", names(measurements))]
    
    # merge the 3 sets into a single set
    all_data <- measurements %>% mutate(subjects = subjects, activities = activities)
    
    # reorder the columns so the subject and activity are first
    all_data <- all_data[,c(ncol(all_data) - 1, ncol(all_data), 1:ncol(all_data) - 2)]
    
    # change the values for the activities to be descriptive
    activity_labels <- read.table("activity_labels.txt")
    all_data <- all_data %<% mutate(activities = activity_labels[activities, 2])
    
    # change the column names to be descriptive - more so?
    
    # return the data set - this is temporary
    
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
rm_dupCols <- function(data) {
    data %>% subset(., select=which(!duplicated(names(.))))
}