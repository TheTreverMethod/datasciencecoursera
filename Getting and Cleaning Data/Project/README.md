# Getting and Cleaning Data Final Project

### Thanks for taking the time to view the finalized version of this project.

#### This repository contains the following:
* The tidy data set titled `measurementsAvg.csv`.
* A script titled `run_analysis.R` that creates the data set.
* A code book that explains the data, the variables in the data, the process used to create the data, and also a study design section that includes information from the original study about how the original data was obtained.
* A file titled `features_info.txt` that provides information about the variables in the tidy data set, and also others from the original data. This file was copied from the original data set.

The original data and a full description can be found here:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

#### There was only one script used to create the data. The assumptions it makes are listed below:
* The `dplyr` package is installed.
* The working directory is the folder that contains the original data.
* There is a writable folder one directory up from the working directory where the resulting data can be written.