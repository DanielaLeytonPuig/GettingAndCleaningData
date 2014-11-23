##Load libraries
library(data.table)
library(reshape2)
library(plyr)

##Download the zip file and unzip it

url<-"http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url,destfile="data.zip")
unzip("data.zip")

##Read all needed files into R

activity_labels<-read.table("UcI HAR Dataset/activity_labels.txt")
features<-read.table("UcI HAR Dataset/features.txt")

test_labels<-read.table("UCI HAR Dataset/test/y_test.txt")
test_data<-read.table("UCI HAR Dataset/test/X_test.txt")
subject_test<-read.table("UCI HAR Dataset/test/subject_test.txt")

train_labels<-read.table("UCI HAR Dataset/train/y_train.txt")
train_data<-read.table("UCI HAR Dataset/train/X_train.txt")
subject_train<-read.table("UCI HAR Dataset/train/subject_train.txt"

#################################################################################                          

##1. Merge the training and the test sets to create one data set.
data<-rbind(train_data,test_data) 

#change column names for features
colnames(data) <-features$V2       

#################################################################################
                          
## 2. Extract only the measurements on the mean and standard deviation for each measurement. 

#extract number of the columns of means and the columns of stdev
columns_stdev<-grep("-std()",colnames(data),ignore.case=TRUE)
columns_means<-grep("-mean()",colnames(data),ignore.case=TRUE)  
                          
#add them together
col_extract<-sort(c(columns_means,columns_stdev))

#extract the data into a new data frame
new_data<-data[,col_extract]

#################################################################################
                          
## 3. Use descriptive activity names to name the activities in the data set

#bind subject data from train and test and give it column name
subjects<-rbind(subject_train,subject_test)
colnames(subjects)<-"subjects"

#bind activity data from train and test and give it column name
activity<-rbind(train_labels,test_labels)
colnames(activity)<-"activity"

#change number in the activity data for the activity name
activity$activity <- activity_labels[activity$activity,"V2"]

#bind the data (means, stdev) with the subject and activity columns                          
new_data<-cbind(new_data,subjects,activity)

#################################################################################
                          
## 4. Appropriately labels the data set with descriptive variable names.

#change column names into more readable names                          
colnames(new_data)<-gsub("^t", "time", colnames(new_data))
colnames(new_data)<-gsub("^f", "frequency", colnames(new_data))
colnames(new_data)<-gsub("Acc", "Accelerometer", colnames(new_data))
colnames(new_data)<-gsub("Gyro", "Gyroscope", colnames(new_data))
colnames(new_data)<-gsub("Mag", "Magnitude", colnames(new_data))
colnames(new_data)<-gsub("BodyBody", "Body", colnames(new_data))
                          
#################################################################################
                          
## 5. From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject.
                                                                   
#Melt data by subjects and by activities
TidyData<-melt(new_data,id.vars=c("subjects","activity"))
#get means of the melted data                          
meansTidyData<- dcast(subjects+activity~variable,data=TidyData,fun=mean)                 
      
#save meansTidyData into a file
write.table(meansTidyData, file="MeansTidyData.txt", sep=" ",row.name=FALSE)


                          
                          