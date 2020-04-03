# Data-Science-Course-3-Getting-and-Cleaning-Data
The script run_analysis.R uses the data.table package for renaming column and reading in files. It includes 5 steps:

1.Merges the training and the test sets to create one data set. The x_data.txt, y_data.txt, subject_data.txt should be binded by row, afterwards all three of them are binded by column.

2.Extracts only the measures on the mean and standard deviation. For the column of x_data.txt, extract only the ones that have mean() or std() in their names.

3.Here the descriptive activity names are used to name the activities in the data set. Match each number in the y_data column with activity_labels.txt.

4.Labels the data set with descriptive variable names. Rename the column of y_data and subject_data.

5.Creates a  independent tidy data set with the average of each variable for each activity and each subject.
Write out the tidy dataset to tidydata.txt.


Our TidyData contains 180 observations and 68 variables.
