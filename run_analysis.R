# Loading required libraries
library(dplyr)

# Establish the name of the file we will download
filename <- "Getting_and_Cleaning_Data_Project.zip"

# Checking if archieve already exists. If not, download it 
if (!file.exists(filename)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileURL, filename, method="curl")
}  

# Checking if folder exists to create it
if (!file.exists("UCI HAR Dataset")) { 
  unzip(filename) 
}

# Loading all the data frames one by one
features <- read.table("UCI HAR Dataset/features.txt", col.names = c("n","functions"))
activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "code")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "code")


## Step 1: Merges the training and the test sets to create one data set.


# Bind test and train data X
X <- rbind(x_train, x_test)

# Bind test and train data Y
Y <- rbind(y_train, y_test)

# Bind subject data
subject <- rbind(subject_train, subject_test)

# Merge the three data sets generated
merged_data <- cbind(subject, Y, X)

## Step 2: Extracts only the measurements on the mean and standard deviation for each measurement.

tidy_data <- merged_data %>%
  select(subject, code, contains("mean"), contains("std"))

## Step 3: Uses descriptive activity names to name the activities in the data set.

tidy_data$code <- activities[tidy_data$code, 2]


## Step 4: Appropriately labels the data set with descriptive variable names.

names(tidy_data)[2] = "activity"
names(tidy_data)<-gsub("Acc", "Accelerometer", names(tidy_data))
names(tidy_data)<-gsub("Gyro", "Gyroscope", names(tidy_data))
names(tidy_data)<-gsub("BodyBody", "Body", names(tidy_data))
names(tidy_data)<-gsub("Mag", "Magnitude", names(tidy_data))
names(tidy_data)<-gsub("^t", "Time", names(tidy_data))
names(tidy_data)<-gsub("^f", "Frequency", names(tidy_data))
names(tidy_data)<-gsub("tBody", "TimeBody", names(tidy_data))
names(tidy_data)<-gsub("-mean()", "Mean", names(tidy_data), ignore.case = TRUE)
names(tidy_data)<-gsub("-std()", "STD", names(tidy_data), ignore.case = TRUE)
names(tidy_data)<-gsub("-freq()", "Frequency", names(tidy_data), ignore.case = TRUE)


## Step 5: From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

final_data <- tidy_data %>%
  group_by(subject, activity) %>%
  summarise_all(mean)
write.table(final_data, "Final Data.txt", row.name=FALSE)