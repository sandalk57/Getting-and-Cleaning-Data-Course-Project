### CODE OVERVIEW: Using  data collected from the accelerometers from the Samsung Galaxy S smartphone,
### this code is used to prepare tidy data that can be used for later analysis. 
### Output: tidy_dataset.txt containing the resulting clean and tidy data


# Initialization ----------------------------------------------------------

# load dplyr library
require(dplyr)


# Get data ----------------------------------------------------------------

# Download data zip file if it hasn't already been downloaded
zipUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
zipFile <- "UCI HAR Dataset.zip"

if (!file.exists(zipFile)) {
  download.file(zipUrl, zipFile, mode = "wb")
}

# Unzip data file if data directory doesn't already exist
dataPath <- "UCI HAR Dataset"
if (!file.exists(dataPath)) {
  unzip(zipFile)
}


# Read data ---------------------------------------------------------------

# read training data
train_subjects <- read.table(file.path(dataPath,"train/subject_train.txt"))
train_data <- read.table(file.path(dataPath, "train/X_train.txt"))
train_labels <- read.table(file.path(dataPath, "train/Y_train.txt"))

# read test data
test_subjects <- read.table(file.path(dataPath,"test/subject_test.txt"))
test_data <- read.table(file.path(dataPath, "test/X_test.txt"))
test_labels <- read.table(file.path(dataPath, "test/Y_test.txt"))

# read features names
features <- read.table(file.path(dataPath, "features.txt"), as.is = TRUE)

# read activity labels
activity_labels <- read.table(file.path(dataPath, "activity_labels.txt"))


# 1. Merge training and test sets -----------------------------------------

# Merge individual data tables to make one single data table
dataset <- rbind(
  cbind(train_subjects, train_data, train_labels),
  cbind(test_subjects, test_data, test_labels)
)

# Rename columns
colnames(dataset) <- c('Subject', features[, 2], 'Activity')


# 2. Extract only the measurements on the mean and standard deviation for each measurement --------

# determine columns of data set to keep based on column name
index <- grepl("Subject|Activity|mean|std", colnames(dataset))

# keep data in these columns only 
dataset_2 <- dataset[, index]



# 3. Use descriptive activity names to name the activities in the data set --------

# Replace activity code in dataset_2 with activity name
dataset_2$Activity <- factor(x = dataset_2$Activity, levels = activity_labels[, 1],
                             labels = activity_labels[, 2])



# 4. Appropriately label the data set with descriptive variable names --------

# Get column names
dataset_2_col_names <- colnames(dataset_2)

# Remove special characters in column names
dataset_2_col_names <- gsub("[\\(\\)-]", "", dataset_2_col_names)

# Expand abbreviations 
dataset_2_col_names <- gsub("Acc", "Accelerometer", dataset_2_col_names)
dataset_2_col_names <- gsub("mean", "Mean", dataset_2_col_names)
dataset_2_col_names <- gsub("std", "StandardDeviation", dataset_2_col_names)
dataset_2_col_names <- gsub("Gyro", "Gyroscope", dataset_2_col_names)
dataset_2_col_names <- gsub("Mag", "Magnitude", dataset_2_col_names)
dataset_2_col_names <- gsub("Freq", "Frequency", dataset_2_col_names)
dataset_2_col_names <- gsub("^f", "Frequency", dataset_2_col_names)
dataset_2_col_names <- gsub("^t", "Time", dataset_2_col_names)
dataset_2_col_names <- gsub("BodyBody", "Body", dataset_2_col_names)

# Use new column names
colnames(dataset_2) <- dataset_2_col_names



# 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject --------

# Group dataset_2 by subject and activities and then compute average of each variable
dataset_3 <- dataset_2 %>% group_by(Subject, Activity) %>%
  summarise(across(everything(),mean))



# Save output to tidy_dataset.txt -----------------------------------------

write.table(dataset_3, "tidy_dataset.txt", row.names = FALSE, 
            quote = FALSE)

