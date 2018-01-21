run_analysis <- function() {
    library(dplyr)
    
    # load data
    subjects <- get_subjects()
    activities <- get_activities()
    measurements <- get_measurements()
    
    # assign colnames to measurements
    names(measurements) <- get_featureNames()
    
    # remove duplicate columns in measurements
    measurements <- rm_dupCols(measurements)
    
    # select only columns we want for our final result
    measurements <- measurements[,grep("mean\\(\\)|std\\(\\)", names(measurements))]
    
    # rename columns for subject and activity sets
    subjects <- rename(subjects, subjects = V1)
    activities <- rename(activities, activities = V1)
    
    # merge the 3 sets
    all_data <- cbind(subjects, activities, measurements)
    
    # change the values for the activities to be descriptive
    activity_labels <- read.table("activity_labels.txt")
    all_data <- all_data %>% mutate(activities = activity_labels[activities, 2])
    
    # sort by subject id
    all_data <- all_data %>% arrange(subjects)
    
    # create the second tidy data set that averages the values for each subject and activity
    averages <- group_by(all_data, subjects, activities)
    averages <- summarize_all(averages, funs(mean))
    
    # write the data to a file
    write.csv(averages, file = "../measurementsAvg.csv", row.names = FALSE)
}

get_subjects <- function() {
    subjects_test <- read.table("test/subject_test.txt")
    subjects_train <- read.table("train/subject_train.txt")
    rbind(subjects_test, subjects_train)
}
get_activities <- function() {
    activities_test <- read.table("test/y_test.txt")
    activities_train <- read.table("train/y_train.txt")
    rbind(activities_test, activities_train)
}
get_measurements <- function() {
    measurements_test <- read.table("test/X_test.txt")
    measurements_train <- read.table("train/X_train.txt")
    rbind(measurements_test, measurements_train)
}
get_featureNames <- function() {
    features <- read.table("features.txt")
    features[,2]
}
rm_dupCols <- function(data) {
    data %>% subset(., select=which(!duplicated(names(.))))
}