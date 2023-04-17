setwd("C:/Users/Daniel/Desktop/Bases de Datos")

install.packages("readr")
library(readr)
library(dplyr)
library(lubridate)


# downloading .zip file

# set path
path <- "C:/Users/Daniel/Desktop/Bases de Datos/courseraproject.zip"

# set url
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

# download
download.file(url, path)

# unzip the zip file

unzip("courseraproject.zip")

# read the files (use read.table to read txt files)

subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")

x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "code")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "code")
features <- read.table("UCI HAR Dataset/features.txt", col.names = c("n","functions"))
activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))

# now we begin the analysis script

# first step: merge the training and the test sets

setx <- rbind(x_train, x_test)
sety <- rbind(y_train, y_test)

setsubject <- rbind(subject_train, subject_test)

merged_dataset <- cbind(setsubject, sety, setx)

# second step: there are lot of variables for different statistics,
# so we mustselect only the ones we need: mean and standard deviation.
# they are named as "mean" and "std" something. Select the columns which
# names contains "mean" or "std", along with id variables (subject & code)

projectdata <- merged_dataset %>% select(subject, code,
                                         contains("mean"),
                                         contains("std"))

# third step: rename the activities in the dataset based on
# descriptive activities names that are available on the
# "activities" dataset

desc_df <- projectdata %>% 
        merge(activities, by = "code")

# 4th setp: label thdata set with descriptive variable names

names(desc_df)<-gsub("Acc", "Accelerometer", names(desc_df))
names(desc_df)<-gsub("Gyro", "Gyroscope", names(desc_df))
names(desc_df)<-gsub("BodyBody", "Body", names(desc_df))
names(desc_df)<-gsub("Mag", "Magnitude", names(desc_df))
names(desc_df)<-gsub("^t", "Time", names(desc_df))
names(desc_df)<-gsub("^f", "Frequency", names(desc_df))
names(desc_df)<-gsub("tBody", "TimeBody", names(desc_df))
names(desc_df)<-gsub("-mean()", "Mean", names(desc_df), ignore.case = TRUE)
names(desc_df)<-gsub("-std()", "STD", names(desc_df), ignore.case = TRUE)
names(desc_df)<-gsub("-freq()", "Frequency", names(desc_df), ignore.case = TRUE)
names(desc_df)<-gsub("angle", "Angle", names(desc_df))
names(desc_df)<-gsub("gravity", "Gravity", names(desc_df))


# fifth step: create an independent data set with the average of each variable
# for each activity and each subject. This is made by dplyr with group_by and
# summarise

tidy_dataset <- desc_df %>%
        group_by(subject, activity) %>%
        summarise_all(mean)

# we are done, now it's time to check the data set

str(tidy_dataset)
View(tidy_dataset)

# now we just save the dataset

write.table(tidy_dataset, "uci_har_dataset.txt", row.names = FALSE)







