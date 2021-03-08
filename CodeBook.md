# Code Book for Getting and Cleaning Data Course Project

The final tidy data set __tidy_data.txt__ contains the average of each variable for each activity and subject.

See the __README.md__ file of this repository for data set description.

## Data structure

The __tidy_data.txt__ data file is a text file, containing space-separated values.

The first row contains the names of the variables.

The data set contains 180 rows, each containing a subject and activity identifiers and 79 averaged measurements.

## Identifiers
* __Subject__ subject code, integer from 1 to 30
* __Activity__ string factor with 6 levels: WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING

## Variables
The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals __TimeAccelerometerXYZ__ and __TimeGyroscopeXYZ__. These time domain signals (prefix 'Time') were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals ( __TimeBodyAccelerometerXYZ__ and __TimeGravityAccelerometerXYZ__) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals ( __TimeBodyAccelerometerJerkXYZ__ and __TimeBodyGyroscopeJerkXYZ__). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm ( __TimeBodyAccelerometerMagnitude__, __TimeGravityAccelerometerMagnitude__, __TimeBodyAccelerometerJerkMagnitude__, __TimeBodyGyroscopeMagnitude__, __TimeBodyGyroscopeJerkMagnitude__).  

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing __FrequencyBodyAccelerometerXYZ__, __FrequencyBodyAccelerometerJerkXYZ__, __FrequencyBodyGyroscopeXYZ__, __FrequencyBodyAccelerometerJerkMagnitude__, __FrequencyBodyGyroscopeMagnitude__, __FrequencyBodyGyroscopeJerkMagnitude__. (Note the prefix 'Frequency' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:
'XYZ' is used to denote 3-axial signals in the X, Y and Z directions.  


* TimeBodyAccelerometerXYZ
* TimeGravityAccelerometerXYZ
* TimeBodyAccelerometerJerkXYZ
* TimeBodyGyroscopeXYZ
* TimeBodyGyroscopeJerkXYZ
* TimeBodyAccelerometerMagnitude
* TimeGravityAccelerometerMagnitude
* TimeBodyAccelerometerJerkMagnitude
* TimeBodyGyroscopeMagnitude
* TimeBodyGyroscopeJerkMagnitude
* FrequencyBodyAccelerometerXYZ
* FrequencyBodyAccelerometerJerkXYZ
* FrequencyBodyGyroscopeXYZ
* FrequencyBodyAccelerometerMagnitude
* FrequencyBodyAccelerometerJerkMagnitude
* FrequencyBodyGyroscopeMagnitude
* FrequencyBodyGyroscopeJerkMagnitude

The set of variables that were estimated from these signals are: 

* mean(): Mean value
* std(): Standard deviation


## Transformations
The zip file containing the source data is located at https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip.

The following transformations were applied to the source data:

1. __Assign each data to variables__
+ `train_subjects` <- `train/subject_train.txt` contains train data of 21 subjects 
+ `train_data`<- `train/X_train.txt`contains train data of recorded features 
+ `train_labels`<- `train/Y_train.txt`contains contains train data of activities’ code labels

+ `test_subjects`<- `test/subject_test.txt`contains test data of 9 subjects
+ `test_data`<- `test/X_test.txt`contains test data of recorded features
+ `test_labels`<- `test/Y_test.txt`contains test data of activities' code labels

+ `features`<- `features.txt`contains the features selected for this database which come from the accelerometer and gyroscope 3-axial raw signals

+ `activity_labels`<- `activity_labels.txt`contains the list of activities performed when the corresponding measurements were taken and its codes (labels)

2. __Merge the training and test sets to create one data set__

`dataset`is created using **cbind()** function by merging both training and test merged data sets from `train_subjects`, `train_data` and `train_labels` and from `test_subjects`, `test_data`and `test_labels`respectively, merged using **rbind()** function.

subject and labels columns are respectively renamed `Subject`and `Activity`. Measurements columns are renamed using the variable in `features`

3. __Extract only the measurements on the mean and standard deviation for each measurement__

`dataset_2`is created by subsetting `dataset`, selecting only the following columns: `Subject`, `Activity`and the measurements on the `mean`and `std`(standard deviation).

4. __Use descriptive activity names to name the activities in the data set__

Entire numbers in`Activity`column of the `dataset_2` are replaced with corresponding activity taken from second column of the `activity_labels` variable.

5. __Appropriately label the data set with descriptive variable names__

+ All `Acc` in column’s name replaced by `Accelerometer`
+ All `mean` in column's name replaced by `Mean`
+ All `std` in column's name replaced by `StandardDeviation`
+ All `Gyro` in column’s name replaced by `Gyroscope`
+ All `Mag` in column’s name replaced by `Magnitude`
+ All `Freq`in column's name replaced by `Frequency`
+ All start with character `f` in column’s name replaced by `Frequency`
+ All start with character `t` in column’s name replaced by `Time`
+ All `BodyBody` in column’s name replaced by `Body`

6. __Creates a second, independent tidy data set with the average of each variable for each activity and each subject__

`dataset_3` is created by summarizing `dataset_2` taking the means of each variable for each activity and each subject, after groupped by subject and activity.
`dataset_3`is exported into `tidy_dataset.txt` file.




