##Course assignment for Getting and Cleaning Data

#Load the libraries relavant to the homework
library(reshape2)
library(dplyr)
library(plyr)

#read all dataset from test and train folders into R

fileUrl<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="~/Desktop/dataset.zip",method="curl")
unzip("dataset.zip")
setwd("~/Desktop/UCI HAR Dataset")
xtrain<-read.table("train/X_train.txt",sep="",header=FALSE)
ytrain<-read.table("train/y_train.txt",sep="",header=FALSE)
subject_train<-read.table("train/subject_train.txt",sep="",header=FALSE)

xtest<-read.table("test/X_test.txt",sep="",header=FALSE)
ytest<-read.table("test/y_test.txt",sep="",header=FALSE)
subject_test<-read.table("test/subject_test.txt",sep="",header=FALSE)

act_labels<-subject_test<-read.table("activity_labels.txt",sep="",header=FALSE)
features<-read.table("features.txt",sep="",header=FALSE)

# 1.Merges the training and the test sets to create one data set

colnames(subject_test)<-"subjectID"    # this is assign the column name to subject_test file
colnames(ytest)<-"activity"         # assign the column name to subject_test file

features1<-select(features,V2)  # this selects the second column, which describes features of the measurements

# the following three line of codes replace unwanted character string in the features1's 
#column with more readable strings.
features1$V2 <- gsub(",", "_", features1$V2)
features1$V2 <- gsub("\\(\\)", "", features1$V2) 
features1$V2 <- gsub("-", "_", features1$V2)

featureW<-t(features1) # transpose the features1 into a wide format
colnames(xtest)<-featureW ## assign xtest datafram's column names with featureW

test<-cbind(subject_test,ytest,xtest) ## column combine suject_test, ytest and xtest to get complete data for the test
View(test)

#1.2 Now, sort out all the train data and clip them together. Also add column names
colnames(subject_train)<-"subjectID"
colnames(ytrain)<-"activity"
colnames(xtrain)<-featureW
train<-cbind(subject_train,ytrain,xtrain)
View(train)

#1.3 row combind test data set and train data set to be a completed dataset.

DFmerged<-rbind(test,train)

#1.4 It turns out there are duplicated column names although their underlying values are different. 
#therefore we need to make unique names for each column before extract data. For this discussion 
#please refer discussion on Coursera "https://class.coursera.org/getdata-031/forum/thread?thread_id=214

valid_column_names <- make.names(names=names(DFmerged), unique=TRUE, allow_ = TRUE)
names(DFmerged) <- valid_column_names

#2 Extracts only the measurements on the mean (M/mean) and standard deviation (S/std) for each measurement  

extractedDF<-select(DFmerged, subjectID, activity, matches("mean|std"))

#3 Uses descriptive activity names to name the activities in the data set:

extractedDF$activity<-factor(extractedDF$activity,
                       levels=c(1,2,3,4,5,6),
                       labels=c("walking", "walking_upstairs", "walking_downstairs", "sitting", "standing", "laying"))

#4: this step is to give descriptive names to columns
namelist1<-colnames(extractedDF)
namelist1<- gsub("std","sd",namelist1)
namelist1<-sub("^t","time",namelist1)
namelist1<-sub("angle.t","angle.time",namelist1)
namelist1 <-gsub("BodyAcc", "BodyAccelerometer", namelist1)
namelist1 <-gsub("GravityAcc", "GravityAccelerometer", namelist1)
namelist1 <-gsub("BodyGyro", "BodyGyroscope", namelist1)
namelist1<-gsub("f","frequency",namelist1)
namelist1<-gsub("BodyBody","Body",namelist1)
namelist1<-gsub("Mag","Magnitude",namelist1)
colnames(extractedDF)<-namelist1 # resign the descriptive names back to extractedDF dataframe

#5:From the data set in step 4, creates a second, independent tidy data set with the
##average of each variable for each activity and each subject.

tidyDF<-extractedDF%>%
        group_by(subjectID,activity)%>%
        summarise_each(funs(mean))
View(tidyDF)

# 6. save the data as txt file with write.table and read back to R

write.table(tidyDF,file="~/Desktop/UCI HAR Dataset/final_data/tidyData.txt",row.names=FALSE)

# read data back to R
tidyData<-read.table("~/Desktop/UCI HAR Dataset/final_data/tidyData.txt",head=TRUE)

# 7. read the data back to R (from the submitted Coursera Link)--load to R studio
address <- "https://s3.amazonaws.com/coursera-uploads/user-70283134b2b74179e2bf5cc2/975115/asst-3/f1d5405049ae11e5b6c239d2c1272cc9.txt"
address <- sub("^https", "http", address)
tidyData <- read.table(url(address), header = TRUE)
View(tidyData)

#Please note, as mentioned in the rubric as either long or wide form is acceptable
#see https://class.coursera.org/getdata-031/forum/thread?thread_id=28 for discussion"
