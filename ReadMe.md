---
title: "ReadMe.md"
Author:"alsjmonsoon"
date: "August 19, 2015"
---
#Course assignment for Getting and Cleaning Data

####This README.md in the repo describing how the run_anlaysis. R script works. 
*Please Note:the numbers 1, 2, 3, 4, 5 listed below correspond to the homework assignment numbers from the instructor. Each of the my codes for 'run_analysis.R' is explaned in detail in this document. Also I am using `` as a quatation for my code from run_analysis.R*

Load the relavant libraries
`library(reshape2)`
`library(dplyr)`
`library(plyr)`

*Innital step: downlaod the zipfile and unzip it. Also check the working directory before reading all dataframe (xtrain, ytrain, xtest, ytest, subject_test,subject_train, act_labels and features) into R.* Please note that I didn't need the inertial folders from the origial dataset, therefore no data is read from there.

`fileUrl<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"` -->attach to the url link
`download.file(fileUrl,destfile="~/Desktop/dataset.zip",method="curl")`-->download the file
`unzip("dataset.zip")`-->unzip the file to a folder called `UCI HAR Dataset`
`setwd(~/Desktop/UCI HAR Dataset)` -->set the working directory

`xtrain<-read.table("train/X_train.txt",sep="",header=FALSE)`
`ytrain<-read.table("train/y_train.txt",sep="",header=FALSE)`
`subject_train<-read.table("train/subject_train.txt",sep="",header=FALSE)`

`xtest<-read.table("/test/x_test.txt",sep="",header=FALSE)`
`ytest<-read.table("/test/y_test.txt",sep="",header=FALSE)`
`subject_test<-read.table("subject_test.txt",sep="",header=FALSE)`

`act_labels<-read.table("activity_labels.txt",sep="",header=FALSE)`
`features<-read.table("features.txt",sep="",header=FALSE)`

## 1.Merges the training and the test data sets to create one data set, note this is not tidy data.

#### 1.1 firstly in the test data folder, sort out/examine all the test_x, test_y, and clip them together with subject_test file. 

`names(subject_test)<-"subjectID"`   --> assign the column name to subject_test file
`names(ytest)<-"activity"`         # assign the column name to subject_test file

Becasue the number of columns in xtest.txt matches the # rows in features.txt, so features.txt contains the column headings for the variables in xtest.txt.

`features1<-select(features,V2)`  --> this selects the second column which describes features of the measurements for features1.txt and remove the first column with numbers

# the following three line of codes replace unwanted character string in the features1 with more readable strings.
`features1$V2 <- gsub(",", "_", features1$V2)` -->replace"," 
`features1$V2 <- gsub("\\(\\)", "", features1$V2)`--> replace " ()" 
`features1$V2 <- gsub("-", "_", features1$V2)`    -->replace"-"

`featureW<-t(features1)` --> transpose the features1.txt into a wide format.
`colnames(xtest)<-featureW` -->assign xtest dataframe's column names with featureW.
#this is the step for appropriately labling that data set with descriptive variable names.

`test<-cbind(subject_test,ytest,xtest)`--> column combine suject_test, ytest and xtest to get complete data for the test data
`View(test)`--> view test.txt file

####1.2 Now, sort out all the train data and clip them together similar to the steps we did in 1.2 Also add column names for xtrain.txt
`names(subject_train)<-"subjectID"` --> assign the column name to subject_train.txt
`names(ytrain)<-"activity"` --> assign the column name to ytrain.txt
`colnames(xtrain)<-featureW` --> assign the column name to xtrain.txt
`train<-cbind(subject_train,ytrain,xtrain)`-->column combine suject_test, ytest and xtest to get a complete data for the train data
View(train)

####1.3 row combind test data set and train data set to be a completed dataset called DFmerged. 
`DFmerged<-rbind(test,train)`--> row combine two data set

#### 1.4 It turns out there are duplicated column names although their underlying values are different. therefore we need to make unique names using make.names() for each column before extract data. For this discussion please refer discussion on Coursera "https://class.coursera.org/getdata-031/forum/thread?thread_id=214. Please note, these duplicated columns eventually were not among those selected columns for the step 2. So an alternative approach here would be to delete those duplicated columns at this step. 

`valid_column_names <- make.names(names=names(DFmerged), unique=TRUE, allow_ = TRUE)`
`names(DFmerged) <- valid_column_names`

##2 Extracts only the measurements on the mean (M/mean) and standard deviation (S/std) for each measurement together qirh the first two columns (subjectID and activity): 

`extractedDF<-select(DFnew, subjectID, activity, matches("mean|std"))` -->select columns for tidy data later. 
_please note, I selected all variables 'mean' or 'std' with both upper or lower cases, also including 'meanFreq' substring in my tidy data set. Therefore this may result more columns (84)_

##3 Uses descriptive activity names to name the activities in the data set. Here I replaced the activity numbers in the data and with descriptive terms which are words.

`extractedDF$activity<-factor(extractedDF$activity,
                       levels=c(1,2,3,4,5,6),
                       labels=c("walking", "walking_upstairs", "walking_downstairs", "sitting", "standing", "laying"))`

##4: the homework step 4 is asking to give descriptive names to columns. The following commands is to replace the short names in the orginal column names and make it more understandable. 

`namelist1<-colnames(extractedDF)`
`namelist1<- gsub("std","sd",namelist1)`
`namelist1<-sub("^t","time",namelist1)`
`namelist1<-sub(".t",".time",namelist1)`
`namelist1 <-gsub("BodyAcc", "BodyAccelerometer", namelist1)`
`namelist1 <-gsub("GravityAcc", "GravityAccelerometer", namelist1)`
`namelist1 <-gsub("BodyGyro", "BodyGyroscope", namelist1)`
`namelist1<-gsub("f","frequency",namelist1)`
`namelist1<-gsub("BodyBody","Body",namelist1)`
`colnames(extractedDF)<-namelist1`  --> resign the descriptive names back to extractedDF dataframe


##5 From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

`tidyDF<-extractedDF%>%
        group_by(subjectID,activity)%>%
        summarise_each(funs(mean))`
`View(tidyDF)`

##6. save the data as txt file with write.table_

`write.table(tidyDF,file="~/Desktop/UCI HAR Dataset/final_data/tidyData.txt",row.names=FALSE)`

_read data back to R_
`tidyData<-read.table("~/Desktop/UCI HAR Dataset/final_data/tidyData.txt",head=TRUE)`

####"As mentioned in the rubric: either long or wide form is acceptable, see https://class.coursera.org/getdata-031/forum/thread?thread_id=28 for discussion"--David Hood####

##7 read back to R (from the submitted link on coursera)--please copy folloing codes into your R studio
`address <- "https://s3.amazonaws.com/coursera-uploads/user-70283134b2b74179e2bf5cc2/975115/asst-3/f1d5405049ae11e5b6c239d2c1272cc9.txt"`
`address <- sub("^https", "http", address)`
`tidyData <- read.table(url(address), header = TRUE)`
`View(tidyData)`
 

 
