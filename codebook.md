#Codebook Course Project
##Getting and Cleaning Data

##Data

###Source data
The data used for this project can be found here:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

##Tidy data
The source data is processed to create a tidy data set containing the average values for each combination of activity and subject in the source data.

The tidy data can be found in the file "averageDataTidy.txt"


##Variables

activityName - Name of one of the six activities:
	1 WALKING
	2 WALKING_UPSTAIRS
	3 WALKING_DOWNSTAIRS
	4 SITTING
	5 STANDING
	6 LAYING

subjectID - Identifier for the subjects who performed the tests
	1:30

activityID - Identifier of one of the six activities:
	1 WALKING
	2 WALKING_UPSTAIRS
	3 WALKING_DOWNSTAIRS
	4 SITTING
	5 STANDING
	6 LAYING

Features: Average values for each combination of activity and subject for


tBodyAcc-XYZ
tGravityAcc-XYZ
tBodyAccJerk-XYZ
tBodyGyro-XYZ
tBodyGyroJerk-XYZ
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
fBodyAcc-XYZ
fBodyAccJerk-XYZ
fBodyGyro-XYZ
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag

'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

For these features the following are supplied: 

mean(): Mean value
std(): Standard deviation


## Transformations

1. The source data was downloaded and unpacked.
The source data subsists of several files:
- activity_labels.txt
- features.txt
- train/subject_train.txt
- train/X_train.txt
- train/y_train.txt
- test/subject_test.txt
- test/X_test.txt
- test/y_test.txt

2. The meta data was loaded
the meta data contains information about the features and the activities

3. The training data was loaded
the meta data for features was used to name the columns for the x_train dataset

4. The test data was loaded
the meta data for features was used to name the columns for the x_test dataset

5. The training data was combined into a single dataframe
- subject_train
- y_train
- x_train

6. The test data was combined in to a single dataframe
- subject_test
- y_test
- x_test

7. The training and test data were put together into a new dataframe: completeData

8. From completeData only the columns concerning Mean and Standard Deviation were subtracted into a new dataframe: meanStdData

9. A column containing descriptive activity names was added to meanStdData.Activity

10. A new dataframe was created from meanStdData.Activity containing the average for every X-feature for each activity and subject: averageData

11. The resulting dataframe averageData was written to file: "./averageDataTidy.txt"
