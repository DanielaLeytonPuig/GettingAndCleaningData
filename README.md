@@ -1,4 +1,4 @@

 
##Coursera. Getting and Cleaning Data 
 
+————————————————
 
###How to run the analysis script:

run_analysis.R can be run from any working directory. It will download and unzip the files, and go in the necessary subdirectories to import the files it needs.
 
The output of the run_analysis.R script is file "meansTidyData.txt" that contains summarised data of the mean and the standard deviation for each variable from the initial dataset.
 
The script does the following:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

