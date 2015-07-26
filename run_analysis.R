#Script for Getting and Cleaning Data Project - run_analysis.R
# This script will perform the following steps on the UCI HAR Dataset downloaded from 
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

#Requires library(dplyr)

setwd("C:/data/UCI HAR Dataset")

#SubjectsTest.txt - subset of 1-30 (2947x1); Xtest.txt - data (2947x561); Ytest.txt - Activity labels from 1-6 (2947x1)
subjectsTest <- read.table("test\\subject_test.txt", header = F)
Xtest <- read.table("test\\X_test.txt", header = F)
Ytest <- read.table("test\\Y_test.txt", header = F)

#Do same for "train" data
#SubjectsTrain.txt - subset of 1-30 (7352x1); Xtrain.txt - data (7352x561); Ytrain.txt - Activity labels from 1-6 (7352x1)
subjectsTrain <- read.table("train\\subject_train.txt", header = F)
Xtrain <- read.table("train\\X_train.txt", header = F)
Ytrain <- read.table("train\\Y_train.txt", header = F)

#Read in Features.txt - labels for the data files, numeric and name (561x2); and activity_labels.txt - labels for the Y files, numeric and name (6x2)
features <- read.table("features.txt", header = F)
activity <- read.table("activity_labels.txt", header = F)

## 1. Merges the training and the test sets to create one data set
#Add column names to tables   
colnames(Xtrain) <- features$V2
colnames(Ytrain) <- c("Activity")

#Train - Join Xtrain and Ytrain data together - Training data plus activity labels
Train <- cbind(Xtrain, Ytrain)
#TrainAll - Join Train and subjectsTrain - Training data plus activity labels plus subjects
colnames(subjectsTrain) <- c("Subject")
TrainAll <- cbind(Train, subjectsTrain)

#Add column names to tables   
colnames(Xtest) <- features$V2
colnames(Ytest) <- c("Activity")

#Test - Join Xtest and Ytest data together - Test data plus activity labels
Test <- cbind(Xtest, Ytest)
#TestAll - Join Test and subjectsTest - Test data plus activity labels plus subjects
colnames(subjectsTest) <- c("Subject")
TestAll <- cbind(Test, subjectsTest)

#AllData - Join Test and Train
AllData <- rbind(TrainAll, TestAll)
        
## 2. Extract only the measurements on the mean and standard deviation for each measurement
#Select for columns that are just mean or std_Dev data from features to create a list, then add Activity and subject columns to beginning
mean_std_columns <- c(563, 562, grep("-(mean|std)\\(\\)", features[, 2]))
Subset_mean_std <- AllData[, mean_std_columns]

##3. Uses descriptive activity names to name the activities in the data set
#Replace activity_label numeric with actual names and arrange by Subjects
Subset_mean_std[, 2] <- activity[Subset_mean_std[, 2], 2]
Subset_mean_std <- arrange(Subset_mean_std, Subject)

##4. Appropriately label the data set with descriptive variable names. 
#Expand column names to something more descriptive
names(Subset_mean_std) <- gsub("^t", "time", names(Subset_mean_std))
names(Subset_mean_std) <- gsub("^f", "frequency", names(Subset_mean_std))
names(Subset_mean_std) <- gsub("Acc", "Accelerometer", names(Subset_mean_std))
names(Subset_mean_std) <- gsub("Gyro", "Gyroscope", names(Subset_mean_std))
names(Subset_mean_std) <- gsub("Mag", "Magnitude", names(Subset_mean_std))
names(Subset_mean_std) <- gsub("\\()", "", names(Subset_mean_std))
names(Subset_mean_std) <- gsub("mean", "Mean", names(Subset_mean_std))
names(Subset_mean_std) <- gsub("std", "StdDev", names(Subset_mean_std))
    
##5.From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject.
TidyData <- aggregate(. ~Subject + Activity, Subset_mean_std, mean)
#Write out a new file
write.table(TidyData, file = "tidydata.txt",row.name=FALSE)

