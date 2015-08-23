---
title: "Codebook"
author: "alsjmonsoon"
date: "August 20th 2015"
---

## Project Description
Here, I practiced how to collect, work with and clean a data set, which is collected from the accelerometers from the Samsung Galaxy S smartphone. This project is course project for the Coursera class 'Getting and Cleaning Data'.

##Study/Experiment design and data processing for the orignial study

The original laboratory experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, the study captured 3-axial linear acceleratio-n and 3-axial angular velocity at a constant rate of 50Hz (such as tAcc-XYZ and tGyro-XYZ). These signals were used to estimate variables of the feature vector for each pattern: '-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data ("train") and 30% the test data ("test").

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity (tBodyAcc-XYZ and tGravityAcc-XYZ). The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. 

Feature Selection of the original study 
=================

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals. These time domain signals  were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals. Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm. 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing frequency domain signals. 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

###Notes on the original (raw) data 

*For each record it is provided:*
======================================

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

*The original dataset includes the following files:*
=========================================

- 'README.txt'

- 'features_info.txt': Shows information about the variables used on the feature vector.

- 'features.txt': List of all features.

- 'activity_labels.txt': Links the class labels with their activity name.

- 'train/X_train.txt': Training set.

- 'train/y_train.txt': Training labels.

- 'test/X_test.txt': Test set.

- 'test/y_test.txt': Test labels.

*The following files are available for the train and test data. Their descriptions are equivalent.* 

        - 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

* Please note: Original data set also include inertial Signals folders, which composed of*

        - `train/Inertial Signals/total_acc_x_train.txt`: The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the `total_acc_x_train.txt' and 'total_acc_z_train.txt` files for the Y and Z axis. 

        - `train/Inertial Signals/body_acc_x_train.txt`: The body acceleration signal obtained by subtracting the gravity from the total acceleration. 

        - `train/Inertial Signals/body_gyro_x_train.txt`: The angular velocity vector                 measured by the gyroscope for each window sample. The units are radians/second. 

##Creating the tidy datafile 

###Guide to create the tidy data file
1 Attach the http site and download the the data to a osx. The R version is 3.2.1.
2 Unzip the data. 
3.Read the data to R.
4.Inspect the data, figure out how data should be merged and what is the lay out for the raw data:
 For example:
 - X_test.txt:          # 2947 rows;  561 columns
 - y_test.txt:          # 2947 rows; 1 column
 - subject_test.txt     # 2947 rows; 1 column
 - features.txt         # 561 rows; 2 columns
 - activity_labels.txt  # 6 rows; 2 columns
 - Therefore No. of columns in `X_test.txt` matches the No. of rows in features.txt, so features.txt contains the column headings for the variables in `X_test.txt`.
 - From the row counts, it looks like we have to merge `subject_test.txt` and `y_test.txt`  to `X_test.txt` 
 - `y_test.txt` values are identified by in activity_labels.txt
5. Same procedure for data ispection will go with train data set as well.

###Cleaning of the data  the following steps describe the logical steps how I tackled the homework assignment)

[_Please see ReadMe document that describes the code in greater detail_]:

        1. Merges the training and the test data sets to create one data set.
        2. Uses descriptive activity names to name the activities in the data set. I obtained the the column names first before extract data. 
        3. Extracts only the measurements on the mean and standard deviation for each measurement. I extract not only all measurements with 'mean' and 'std' substring, but also extracted the 'meanFreq-' and  'Mean' substrings. I regard that mean frequency is also mean although it is calculated from weighted or derived data. The 'Mean' substring is obtained by averageing the singals in singal windows used on the angle() varialbe, this is also a mean value.
        4. Give descriptive names to columns
        5. Creat a independent tidy data set with the average of each variable for each activity and each subject.

##Description of the variables in the tidyData.txt (the final product of this homework) file
General description:
 - Dimensions of the dataset :[180 obs x 88 variables]
 - Summary of the data: 
 This tidy data summarize the average values for each variables for each subject (30 participants for the experiments) with 6 actitivity (walking,walking_upstairs,walking_downstairs,sitting,standing, and laying).
 - Variables present in the dataset:

###Variable 1 --subjectID  (variable class: factor) (no unit)
This variable describes 30 participants (the subject)from age (19-48), who performed the activitey for the experiement. They are numbered from 1 to 30. 

###Variable 2 --activity (variable class: factor) (no unit)
Six activities were performed by each participants, including walking, walking_upstairs, walking_downstairs, sitting, standing, laying with the smartphone. Therefore the total number of rows are 6X30=180 row.

###Varible 3-variable 88 (class: numeric). _please note: the following variables are the average values of each variable for each activity and each subject._ 

###Variable 3 to 5: timeBodyAcclerometer_mean_X(_Y/_Z) (unit: Hz)
The average body acceleration from the accelerometer for 3-axial signals in the X(or Y or Z) directions in the time domain.

###Variable 6 to 8: timeBodyAccelerometer_sd_X(_Y/_Z) (unit: Hz)
The standard deviation of body acceleration signal from the accelerometer for X, Y or Z 3-axial direction in the respectively in the time domain.

###Variable 9-11: timeGravityAccelerometer_mean_X(_Y/_Z) (unit: Hz)
The average gravity acceleration signal from the accelerometer in the X, Y or Z  3-axial directions, respecitivey in the time domain.

###Variable 12-14: timeGravityAcclerometer_sd_X(_Y/_Z) (unit: Hz)
The standard deviation of gravity acceleration signal from the accelerometer in the X, Y or Z -axial signals in, respectively in the time domain.

###Variable 15-17: timeBodyAccelerometerJerk_Mean_X(_Y/_Z) (unit: Hz)
The averge body linear acceleration velocity from the accelerometer in the X,Y, or Z axial direction, respectively in the time domain.

###Variable 18-20: timeBodyAccelerometerJerk_sd_X(_Y/_Z) (unit: Hz)
The standard deviation of body linear acceleration from the accelerometer in the X,Y, or Z -axial direction, respectively in the time domain.

###Variable 21-23: timeBodyGyroscope_mean_X(_Y/_Z) (unit: Hz)
The averge body acceleration from the gyroscope in the X, Y or Z -axial direction, respectively in the time domain.

###Variable 24-26: timeBodyGyroscope_sd_X(_Y/_Z) (unit: Hz)
The standard devitation of body acceleration  from the gyroscope from the gyroscope in the X, Y or Z - axial direction , respectively in the time domain.

###Variable 27-29: timeBodyGyroscopeJerk_mean_X(_Y/_Z) (unit: Hz)
The averge body angular velocity from the gyroscope measured in the X, Y or Z  axial direction, respectively in the time domain.

###Variable 30-32: timeBodyGyroscopeJerk_sd_X(_Y/_Z) (unit: Hz)
The standard devitation of of body angular velocity from the gyroscope in the X, Y or Z - axial direction, respectively in the time domain.

###Variable 33: timeBodyAccelerometerMagnitude_mean (unit: Hz)
The average calculated magnitude of body acceleration in all X Y and Z direcitons from the accelerometer in the time domain.

###Variable 34: timeBodyAccelerometerMagnitude_sd (unit: Hz)
The standard deviation for the magnitude of body acceleration in 3-axial signals (X Y and Z direcitons) from the accelerometer in the time domain.
 
###Variable 35: timeGravityAccelerometerMagnitude_mean (unit: Hz)
The average caculated magnitude of Gravity acceleration 3-axial signals (in all X Y and Z direcitons) from the accelerometer in the time domain.

###Variable 36: timeGravityAccelerometerMagnitude_sd (unit: Hz)
The standard deviation of magnitude of Gravity acceleration 3-axial signal (X Y and Z direcitons) from the accelerometer in the time domain.

###Variable 37: timeBodyAccelerometerJerkMagnitude_mean (unit: Hz)
The averge magnitude of body linear acceleration for 3-axial signals (X Y and Z direcitons) from the accelerometer in the time domain.

###Variable 38: timeBodyAccelerometerJerkMagnitude_sd (unit: Hz)
The standard deviation for the magnitude of the body linear acceleration 3-axial signals (X Y and Z direcitons) from the accelerometer in the time domain.

###Variable 39:timeBodyGyroscopeMagnitude_mean (unit: Hz)
The average magnitude of body acceleration for 3-axial signals (all X Y and Z direcitons meausred from the gyroscope in the time domain. 

###Variable 40:timeBodyGyroscopeMagnitude_sd (unit: Hz)
The standard deviation for the magnitude of body acceleration all X Y and Z axial direction measured from the gyroscope in the time domain.

###Variable 41: timeBodyGyroscopeJerkMagnitude_mean (unit: Hz)
The average magnitude of angular velocity for 3-axial signals (X Y and Z direcitons) measured from the gyroscope in the time domain.

###Variable 42: timeBodyGyroscopeJerkMagnitude_sd (unit: Hz)
The standard deviation of the magnitude of angular velocity in X Y and Z axial direcitons measured from the gyroscope in the time domain.

###Variable 43-45:  frequencyBodyAccelerometer_mean_X(_Y/_Z) (unit: Hz)
Averaged body acceleration measured from the accelerometer for in the X(or Y or Z) axial directions, respecctively in the frequency domain.

###Variable 46-48:  frequencyBodyAccelerometer_sd_X(_Y/_Z) (unit: Hz)
standard deviation of body acceleration from the accelerometer in the X(or Y or Z) in the axial directions, respectively in the frequency domain.

###Variable 49-51:  frequencyBodyAccelerometer_meanFreq_X(_Y/_Z) (unit: Hz)
Averaged the mean frequency of body acceleration from the accelerometer in the X(or Y or Z) axial directions, respectively in the frequency domain.

###Variable 52-54:  frequencyBodyAccelerometerJerk_mean_X(_Y/_Z) (unit: Hz)
Averaged body linear acceleration from the accelerometer in the X(or Y or Z)axial directions, respectively in the frequency domain.

###Variable 55-57:  frequencyBodyAccelerometerJerk_sd_X(_Y_Z) (unit: Hz)
Standard deviation body linear acceleration from the accelerometer in the X(or Y or Z) axial directions, respectively in the frequency domain.

###Variable 58-60:frequencyBodyAccelerometerJerk_meanFreq_X(_Y/_Z)  (unit: Hz)
the average body linear acceleraltion mean frequency from the accelerometer in the X(or Y or Z) axial direction, respecitvely in the frequency domain.

###Variable 61-63: frequencyBodyGyroscope_mean_X (Y/Z) (unit: Hz)
the average body acceleration signals from the gyroscope in the X, Y or Z direction of the 3-axial signals, respectively in the frequency domain

###Variable 64-66: frequencyBodyGyroscope_sd_X (Y/Z) (unit: Hz)
the standard deviaton of body acceleration signals from the gyroscope in the X, Y or Z direction of the 3-axial signals, respectively in the frequency domain

###Variable 67-69:frequencyBodyGyroscope_meanFreq_X(_Y/_Z) (unit: Hz)
the average body acceleraltion mean frequency meansured by the Gyroscope in the X(or Y or Z) axial direction, respecitvely in the frequency domain.

###Variable 70:frequencyBodyAccelerometerMagnitude_mean (unit: Hz)
The average magnitude for body accelearation measured by Acceleromenter in all three axial direction in the frequency domain

###Variable 71:frequencyBodyAccelerometerMagnitude_sd (unit: Hz)
The standard deviation of magnitdue of body accelearation measured by Accelerometer in all three axial direction in the frequency domain

###Variable 72:frequencyBodyAccelerometerMagnitude_meanFreq (unit: Hz)
The average mean frequency for manigutide signal of body acceleration, which were measured by accelrometein all three axial direction in the frequency domain.

###Variable 73: frequencyBodyGyroscopeJerkMagnitude_mean (unit: Hz)
The average frequency for the magnitude of angular velocity all three axial direction.

###Variable 74: frequencyBodyGyroscopeJerkMagnitude_sd (unit: Hz)
The standard deviation of the magnitude of angular velocity (measured by gyroscope) from all three axial direction in the frequency domain.

###Variable 75: frequencyBodyAccelerometerJerkMagnitude_meanFreq (unit: Hz)
The average mean frequence for the magnitude of linear body acceleration (meausred by accelerometer) from all three axial direction  in the frequencey domain.

###Variable 76: frequencyBodyGyroscopeMagnitude_mean (unit: Hz)
The average magnitude of gravity acceleration (measured by gyroscope) from all three axial direction in the frequence domain.

###Variable 77: frequencyBodyGyroscopeMagnitude_sd (unit: Hz)
The standard deviation for the magnitude of gravity acceleration (measured by gyroscope) from all three axial direction in the frequencey domain.

###Variable 78: frequencyBodyGyroscopeMagnitude_meanFreq (unit: Hz)
The average mean frequencey for the magnitude of gravity acceleration (meausred by gyroscope) from all three axial direction in the frequencey domain.

###Variable 79: frequencyBodyGyroscopeMagnitude_mean (unit: Hz)
The average magnitude of gravity acceleration (meausred by gyroscope) from all three axial direction in the frequencey domain.

###Variable 80: frequencyBodyGyroscopeJerkMagnitude_sd (unit: Hz)
The standard deviaton for the magnitude of gravity acceleration (meausred by gyroscope) from all three axial direction in the frequencey domain.

###Variable 81: frequencyBodyGyroscopeJerkMagnitude_meanFreq(unit: Hz)
The average mean frequencey for the magnitude of angular velocity (meausred by gyroscope) from all three axial direction in the frequencey domain.

###Variable 82: angle.timeBodyAccelerometerMean_gravity:
The averagd body acceleration mean gravity in a signal window in the time domain.

###Variable 83: angle.timeBodyAccelerometerJerkMean._gravityMean:
The averaged linenar body acceleration mean gravity (measured from accelerometer) obtained in a signal window in the time domain.

###Variable 84:angle.timeBodyGyroscopeMean_gravityMean:
The average mean gravity from the velocity acceleration (meausred by gyroscope) obtained in a signal window in the time domain.

###Variable 85:angle.timeBodyGyroscopeJerkMean_gravityMean:
The averge mean gravity from angular velocity (measured from the gyroscope) in a singal window in the time domain.

###Variable 86-87:angle.X(Y/Z)_gravityMean:
The averaged gravity mean obtained from a singal window for X (/Y/Z) axial direction, respectively. 

##Sources
==================================================================
This dataset used for this assignment is derived from Human Activity Recognition Using Smartphones Dataset Version 1.0 

_Referenced publication_: Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012
==================================================================

## Additional Acknowledgement
I have learned a great deal from the great discussion forum on Coursera, particularly Community TA David Hood's _very long and detailed project FAQ_ and other fellow students discussion.

