# load libraries
library(plyr)

# download the dataset
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile = "./UCI_HAR_Dataset.zip")

# save download date
dateDownloaded <- date()

# unzip dataset
unzip("./UCI_HAR_Dataset.zip")

#
# read the files
#

# read the meta data: feature and activity labels
featuresLabels <- read.table("./UCI_HAR_Dataset/features.txt", col.names=c("featureID","feature"))
activityLabels <- read.table("./UCI_HAR_Dataset/activity_labels.txt", col.names=c("activityID","activityName"))

# create factor with features to use as col.names
featuresCols <- featuresLabels$feature


# read subject_train with columnname "subject"
subject_train <- read.table("./UCI_HAR_Dataset/train/subject_train.txt",  col.names = c("subjectID"))

# read y_train with columnname "subject"
y_train <- read.table("./UCI_HAR_Dataset/train/y_train.txt", col.names = c("activityID"))

# read x_train with columnname "subject"
x_train <- read.table("./UCI_HAR_Dataset/train/x_train.txt", col.names = featuresCols)

# read subject_test with columnname "subject"
subject_test <- read.table("./UCI_HAR_Dataset/test/subject_test.txt",  col.names = c("subjectID"))

# read y_test with columnname "subject"
y_test <- read.table("./UCI_HAR_Dataset/test/y_test.txt", col.names = c("activityID"))

# read x_train with columnname "subject"
x_test <- read.table("./UCI_HAR_Dataset/test/x_test.txt", col.names = featuresCols)


#
# step 1: Merge the training and the test sets to create one data set
#


# combine training data
trainingData <- cbind(subject_train, y_train, x_train)

# combine test data
testData <- cbind(subject_test, y_test, x_test)

# combine training and test data
completeData <- rbind(trainingData, testData)


#
# step 2: Extract only the measurements on the mean and standard deviation for each measurement
#

# these variables can be recognized because they contain the strings "mean()" and std()"
featuresMeanStd <- (grepl("mean()", featuresLabels$feature, fixed = TRUE)) | grepl("std()", featuresLabels$feature, fixed = TRUE)

# get the features for the subset
featuresLabelsMeanStd <- featuresLabels[featuresMeanStd,]

# get the right column index
featuresToSelect <- featuresLabelsMeanStd$featureID + 2

# add subject and activityId columns
subsetToSelect <- c(c(1,2), featuresToSelect)

# get the subset
meanStdData <- completeData[,subsetToSelect]


#
# step 3: add column containing descriptive activity names
#

# merge meanStdData with activityLabels
meanStdData.Activity <- merge(meanStdData,activityLabels)


#
# step 4: Rename columns with decriptive variable names
#

# added column names when reading the x_data


#
# step 5: From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
#

# mean every column based on activtyName and subjectID

averageData <- ddply(meanStdData.Activity, .(activityName,subjectID), numcolwise(mean))

# write the table to file

write.table(averageData, file = "./averageDataTidy.txt", row.names = FALSE, quote = FALSE)
