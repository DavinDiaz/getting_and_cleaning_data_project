# getting_and_cleaning_data_project

This repository corresponds to the final project of the course on getting and cleaning data of the student Davin Díaz. This repository contains all the files and instructions necessary to analize as requested the Human Activity recognition dataset from Harvard.

The original data set analized here can be found at: 
    
    https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip  
    
The repository contains the following files:

**CodeBook.md:** This is a code book that describes all the variables and data sets utilized and created, the data, and any transformation performed to clean up the data

**run_analysis.R** This is the R script that contains all the code that performs the data preparation and the 5 steps required as described in the course project’s definition:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
