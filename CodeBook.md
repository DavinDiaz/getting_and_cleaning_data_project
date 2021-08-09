## Code Book

The >run_analysis.R file performs all the analysis steps required for the peer-graded assignment, starting from getting and preparing the data to cleaning and generating the final file.
All the analysis can be summarised in a few steps:

1. Preparation: First we load the required libraries, in this case, just the >tidyverse library.
2. Getting the data: The second step corresponds to the download of the zip file with all the dataset and the subsecuent extraction of the files under the folder >UCI HAR Dataset
3. Load the data into R: The data previously downloaded and extracted comes in several files, which makes the next necessary step to load each file correspondingly:
    
    * **features** <- features.txt : The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals. This file contains 561 rows and 2 columns
    
    * **activities** <- activity_labels.txt : List of all the activities that were performed when taking the corresponding measurements with its corresponding labels This file contains 6 rows and 2 columns
    
    * **subjects_test** <- subjects_test.txt :  This is the test data of the subjects being observed. This file contains 2947 rows and just 1 column
    
    * **x_test** <- X_test.txt : These are the features that were recorded for the subjects assigned to the test set. This file contains 2947 rows and 561 columns corresponding to the features

    * **y_test** <- y_test.txt : This contains the codes for the activity corresponding to each observation on the test set. This file has 2947 rows and just 1 column

    * **subjects_train** <- subject_train.txt : This is the train data of the subjects being observed. This file contains 7352 rows and 1 column

    * **x_train**  <- X_train.txt : These are the features that were recorded for the subjects assigned to the train set. This file contains 7352 rows and 561 columns

    * **y_train** <- y_train.txt : This contains the codes for the activity corresponding to each observation on the train set. This file contains 7352 rows and 1 columns

4. Merging the train and test sets into a single data set
    
    * **X** <- rbind(X_test, X_train) : By merging the rows of both test and train X files, we end up with the data set X. This data set contains 10299 rows and 561 columns

    * **Y** <- rbind(Y_test, Y_train) : By merging the rows of both test and train Y files, we end up with the data set Y. This data set contains 10299 rows and 1 column

    * **subjects** <- rbind(subjects_test, subjects_train) : By merging the rows of both test and train subjects files, we end up with the data set subjects. This data set contains 10299 rows and 1 column

    * **merged_data** <- cbind(subjects, X, Y) : By merging the columns of the three files we just created, we end up with the data set >merged_data. This data set contains 10299 rows and 563 column

5. Extracting the measurements of the mean and standard deviation for each measurement
    
    * **tidy_data** <- >merged_data %>%select(subjects, code, contains("mean"), contains("std")) : By selecting only the first two columns of subjects and codes and selecting only the columns that reporte mean and standard deviation, we end up with the data set >tidy_data. This data set contains 10299 rows and 88 columns
     
6. Using descriptive activity names to name the activities in the data set

    * **tidy_data$code** <- activities[tidy_data$code, 2] : By replacing the original numbers on the code variable with their corresponding activity name found on the activities data set, we end up with the recoded variabel >code

7. Appropriately labels the data set with descriptive variable names

Some of the column names in tidy_data renamed into more comprehensivle names, including:

    * All Acc in column’s name replaced by Accelerometer
    * All Gyro in column’s name replaced by Gyroscope
    * All BodyBody in column’s name replaced by Body
    * All Mag in column’s name replaced by Magnitude
    * All start with character f in column’s name replaced by Frequency
    * All start with character t in column’s name replaced by Time

8. From the data set in step 4, creating a second, independent tidy data set with the average of each variable for each activity and each subject

    * **final_data** <- tidy_data%>%group_by(subject, activity)%>%summarise_all(mean) : By grouping the data by subject and activity, and then obtaining the mean for each variable, we end un with the data set final_data. This file contains 180 rows and 88 columns

    * **Final Data.txt** <- write.table(final_data, "Final Data.txt", row.name=FALSE) : Finally, save this data set into a new *txt* file. 
