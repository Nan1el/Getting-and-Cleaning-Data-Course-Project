# Getting and Cleaning Data Project Code Book

## About the source data

The source data are from the Human Activity Recognition Using
Smartphones Data Set. A full description is available at the site where
the data was obtained:
<http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones>
Here are the data for the project:
<https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip>

## About the R Script

The run\_analysis.R script performs the data preparation and then
followed by the 5 steps required as described in the course project’s
definition.

1.Download the dataset

2.Assign each data to variables

-   features &lt;- features.txt: The features selected for this database
    come from the accelerometer and gyroscope 3-axial raw signals
    tAcc-XYZ and tGyro-XYZ.

-   activities &lt;- activity\_labels.txt :List of activities performed
    when the corresponding measurements were taken and its codes
    (labels)

-   subject\_test &lt;- test/subject\_test.txt :contains test data of
    9/30 volunteer test subjects being observed

-   x\_test &lt;- test/X\_test.txt :contains recorded features test data

-   y\_test &lt;- test/y\_test.txt :contains test data of
    activities’code labels

-   subject\_train &lt;- test/subject\_train.txt : contains train data
    of 21/30 volunteer subjects being observed

-   x\_train &lt;- test/X\_train.txt :contains recorded features train
    data

-   y\_train &lt;- test/y\_train.txt :contains train data of
    activities’code labels

3.Merges the training and the test sets to create one data set

-   setx is created by merging x\_train and x\_test using rbind()
    function

-   sety is created by merging y\_train and y\_test using rbind()
    function

-   setsubject is created by merging subject\_train and subject\_test
    using rbind() function

-   merged\_dataset is created by merging setsubject, sety and setx
    using cbind() function

4.Extracts only the measurements on the mean and standard deviation for
each measurement. projectdata is created by subsetting merged\_dataset,
selecting only columns: subject, code and the measurements on the mean
and standard deviation (std) for each measurement

5.Uses descriptive activity names to name the activities in the data
set. desc\_df is created by merging activities and projectdata by code,
creating a new variable with the activity name

6.Appropriately labels the data set with descriptive variable names:

-   code column in desc\_df renamed into activities

-   All Acc in column’s name replaced by Accelerometer

\*All Gyro in column’s name replaced by Gyroscope

-   All BodyBody in column’s name replaced by Body

-   All Mag in column’s name replaced by Magnitude

-   All start with character f in column’s name replaced by Frequency

-   All start with character t in column’s name replaced by Time

7.From the data set in step 4, creates a second, independent tidy data
set with the average of each variable for each activity and each subject

-   tidy\_dataset is created by sumarizing desc\_df taking the means of
    each variable for each activity and each subject, after groupped by
    subject and activity.

-   Export tidy\_dataset into uci\_har\_dataset.txt file.
