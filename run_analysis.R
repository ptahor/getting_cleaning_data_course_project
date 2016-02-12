# Loading libraries
library(dplyr)

# Creating a directory to storage the data and execute the script
if (!file.exists("GCDC_Project")) {
        dir.create("GCDC_Project")
        }

# Set working directory
setwd("GCDC_Project")

# Download the data from the source
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileURL, destfile = "Dataset.zip")
dateDownloaded <- date()
unzip("Dataset.zip")

# Reading data
# Training data sets
subject_train <- read.table("~/GCDC_Project/UCI HAR Dataset/train/subject_train.txt")
y_train <- read.table("~/GCDC_Project/UCI HAR Dataset/train/y_train.txt")
X_train <- read.table("~/GCDC_Project/UCI HAR Dataset/train/X_train.txt")

# Test data sets
subject_test <- read.table("~/GCDC_Project/UCI HAR Dataset/test/subject_test.txt")
y_test <- read.table("~/GCDC_Project/UCI HAR Dataset/test/y_test.txt")
X_test <- read.table("~/GCDC_Project/UCI HAR Dataset/test/X_test.txt")

# Activity labels and Features
activity_labels <- read.table("~/GCDC_Project/UCI HAR Dataset/activity_labels.txt",
                              colClasses = c("integer", "character"))
features_labels <- read.table("~/GCDC_Project/UCI HAR Dataset/features.txt",
                              colClasses = c("integer", "character"))
features_labels <- make.names(as.vector(features_labels[, 2]),
                              unique = TRUE)

# Labels to name the features
colnames(X_train) <- features_labels
colnames(X_test) <- features_labels

# Labels to name the activities
y_train <- inner_join(y_train, activity_labels)
y_test <- inner_join(y_test, activity_labels)
y_activities <- c("activity_code", "activity")
colnames(y_train) <- y_activities
colnames(y_test) <- y_activities

# Labels subject
colnames(subject_train) <- "subject"
colnames(subject_test) <- "subject"

# Merging datasets
id_train_test <- c(rep("train",length.out=nrow(subject_train)),
                   rep("test",length.out=nrow(subject_test)))
train <- cbind(subject_train, y_train, X_train)
test <- cbind(subject_test, y_test, X_test)
train_test_merged <- cbind(id_train_test, rbind(train, test))

# Creating a csv file containing the merged dataset
write.table(train_test_merged, file = "train_test_merged.csv")
View(train_test_merged)

# Extracting only the measurements on the mean and
# standard deviation for each measurement
mean_std <- train_test_merged %>%
        select(id_train_test, subject, activity, matches(".mean."), matches(".std."))

write.table(mean_std, file = "mean_std.csv")
View(mean_std)

# Creating a second, independent tidy data set with the
# average of each variable for each activity and each subject

global_averages <- mean_std %>%
        select(id_train_test, subject, activity, 5:length(mean_std)) %>%
        group_by(id_train_test, subject, activity) %>%
        summarize_each(funs(mean)) %>%
        arrange(id_train_test, subject, activity)

write.table(global_averages, file = "global_averages.csv")
View(global_averages)

write.table(global_averages, file = "global_averages.txt", row.name = FALSE)