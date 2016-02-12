**CODE BOOK**
=============
Data Sources
------------
Here are the data for the project:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

A full description is available at the site where the data was obtained:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Data Description
----------------
The experiments were carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, 3-axial linear acceleration and 3-axial angular velocity were captured at a constant rate of 50Hz. The experiments were video-recorded to label the data manually. The obtained dataset were randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data (train) and 30% the test data (test).
The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

Files Provided
--------------
 - Triaxial acceleration from the accelerometer (total acceleration) and
   the estimated body acceleration.
 - Triaxial Angular velocity from the gyroscope.
 - A 561-feature vector with time and frequency domain variables.
 - Its activity label.
 - An identifier of the subject who carried out the experiment.

Files used in the project
-------------------------
- **README.txt:** Contains a description of the overall project and data. It was used to understand the data and their details.
- **features_info.txt:** Shows information about the variables used, details about the signals and the names to identify the variables.
- **features.txt:** List of all features evaluated. This file was used to generate the names of the columns.
- **activity_labels.txt:** Links the class labels with their activity name. This file was used to generate names
- **train/X_train.txt:** Contains the data associated to the training set.
- **train/y_train.txt:** Training labels.
- **test/X_test.txt:** Contains the data associated to the test set.
- **test/y_test.txt:** Test labels.

Description of the code
-----------------------

 - The code was programmed in **Windows 7 (64 bit)**, using **R 3.2.3**
 - The only R library used in the code was **dplyr**
 - The code automatically download the compressed data and storage them in a folder named **"GCDC_Project"**. If the folder doesn't exist, the code will create it in **"My Documents"**. The data will uncompressed automatically.
 - The training data, test data and labels are read using the **"read.table"** function
 - The labels were processed using the function **"make.names"** in order to conserve the structure of them, avoiding conflicts with the R language, and repeating names
 - To assign real names, to the activity codes, was used the **"join"** function of **dplyr**
 - To merge the data sets the **"cbind"** and **"rbind"** functions were used to join by columns and rows respectively. As result, the file **train_test_merged.csv** is generated and located inside the **GCDC_Project** folder, this file contains the merged data, including descriptive activity names and variable names
 - The measurements on the mean and standard deviation were extracted in a second file. This was realized using the **dplyr** function **"select"** and special function **"matches"**. As result, the file **mean_std.csv** is generated and located inside the **GCDC_Project** folder.
 - The project request an additional, independent tidy data set, with the average of each variable for each activity and each subject. It was realized with **dplyr**, using **pipelines** involving the functions **"select"**, **"group"**, **"summarise"** and **"arrange"**. The new data set corresponds to the **global_averages.csv** file, generated and located inside the **GCDC_Project** folder.