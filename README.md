<<<<<<< HEAD
#Getting and Cleaning Data Project

The raw datafiles for the project were downloaded from [https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip]()
using:
=======
# Getting-and-Cleaning-Data-Project
Created for the Coursera Getting and Cleaning data project
The raw datafiles for the project were downloaded from [https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip]()

using:

>>>>>>> 72f05c36c782f252412ff6e1e10ade510255f5f8
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="./data/Dataset.zip")
unzip(zipfile="./data/Dataset.zip",exdir="./data")

The working directory was set to:
setwd("C:/data/UCI HAR Dataset")

library(dplyr) is a required package

The following files were read into R Studio:
SubjectsTest.txt - subset of 1-30 (2947x1); Xtest.txt - data (2947x561); Ytest.txt - Activity_labels.txt from 1-6 (2947x1) all with no headers
SubjectsTrain.txt - subset of 1-30 (7352x1); Xtrain.txt - data (7352x561); Ytrain.txt - Activity_labels.txt from 1-6 (7352x1) all with no headers
Features.txt - labels for the data files, numeric and name (561x2); and activity_labels.txt - labels for the Y files, numeric and name (6x2)

1. Merge the training and the test sets to create one data set
<<<<<<< HEAD
-Add column names to individual tables   
    features.txt > Xtrain, Xtest
    Activity > Ytrain, Ytest
    Subject > subjectsTrain, subjectsTest
=======
-Add column names to individual tables

    features.txt > Xtrain, Xtest
    Activity > Ytrain, Ytest
    Subject > subjectsTrain, subjectsTest
    
>>>>>>> 72f05c36c782f252412ff6e1e10ade510255f5f8
-Combine (Xtrain, Ytrain > Train) and (Xtest, Ytest > Test)
-Combine (Train, subjectsTrain > TrainAll) and (Test, subjectsTest > TestAll)
-Combine (TrainAll, TestAll > AllData)
    
2. Extract only the measurements on the mean and standard deviation for each measurement
-Select for columns that are just mean or std_Dev data from features.txt to create a list, add Activity and subject columns to beginning

3. Uses descriptive activity names to name the activities in the data set
Replace activity_label numeric with actual names and arrange by Subjects

4. Appropriately label the data set with descriptive variable names. 
-Expand column names to something more descriptive by replacing:
    "^t", "time"
    "^f", "frequency"
    "Acc", "Accelerometer"
    "Gyro", "Gyroscope"
    "Mag", "Magnitude"
    "\\()", ""
    "mean", "Mean"
    "std", "StdDev"
    
5.From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject.
<<<<<<< HEAD
-Write out a new file: "tidydata.txt" as comma delimited
=======
-Write out a new file: "tidydata.txt" as comma delimited
>>>>>>> 72f05c36c782f252412ff6e1e10ade510255f5f8
