# Coursera-Getting-and-Cleaning-Data-Course-Project
This note helps users to understand how the code in "run_analysis.R" script works.

The following process is performed in the code:

1. Download the UCI HAR datset zip file if it doesn't exist and unzip it
2. Load the subject, activity and features information from both test and training data
3. Load the general description of features and activity labels 
4. Merge the training and test datasets into one dataset
5. Retain only means and standard deviation for each measurement in the data
6. Create a tidy dataset with average of each variable for each activity and each subject
7. The final result is shown in "tidysummarydata.txt"
