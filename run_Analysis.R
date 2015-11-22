# You should create one R script called run_analysis.R that does the following. 
# 1 Merges the training and the test sets to create one data set.
# 2 Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3 Uses descriptive activity names to name the activities in the data set
# 4 Appropriately labels the data set with descriptive variable names. 
# 5 From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
# 
# Good luck!
#setwd("C:/Users/lp187q/Box Sync/Personal/Path to 2020/Coursera/Data Especialization/03 Getting Data/Project 1")

library(dplyr)
library(doBy) # For summaryby


dataset_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(dataset_url, "Proj1.zip")
unzip("Proj1.zip")

trainact = read.table("./UCI HAR Dataset/train/y_train.txt",sep=" ", header = FALSE)
testact = read.table("./UCI HAR Dataset/test/y_test.txt",sep=" ", header = FALSE)

subjtrain = read.table("./UCI HAR Dataset/train/subject_train.txt",sep=" ", header = FALSE)
subjtest = read.table("./UCI HAR Dataset/test/subject_test.txt",sep=" ", header = FALSE)

train = read.table("./UCI HAR Dataset/train/X_train.txt", header = FALSE)
test = read.table("./UCI HAR Dataset/test/X_test.txt", header = FALSE)

features = read.table("./UCI HAR Dataset/features.txt", header = FALSE)
activlab = read.table("./UCI HAR Dataset/activity_labels.txt",header = FALSE)

# unique(trainact)
# unique(testact)
# 
# unique(subjtrain)
# unique(subjtest)

#intersect(names(train),names(test))
#Merge Train and Test Data
#merged2=merge(subjtrain,subjtest,all=TRUE)
#merged3=merge(trainact,testact,all=TRUE)

listtrain = data.frame(subjtrain,trainact,train)
listtest = data.frame(subjtest,testact,test)
merged = merge(listtrain,listtest,all=TRUE)

# Identify mean and std columns and their names
features$V2=tolower(features$V2)
m1=(grep("mean",features$V2))
m2=(grep("std",features$V2))
class(m1);class(m2)

d=c(m1,m2)

#Clean Up Variable Names

nam = (features$V2)
nam = gsub("-","",nam)
nam = gsub("[()]","",nam)
nam = gsub("[,]","",nam)
features$V2=nam

# Subset only columns for STD and MEAN as requested
newset=merged[,c(1,2,d+2)]

#Change names to descriptive ones
#names(features[d,2])

names(newset)=c("subject","activityid",features[d,2])

#Add activity names
newsetactiv = merge(newset,activlab,by.x="activityid",by.y="V1")

# Rename New Activity Labels

newsetactiv = rename(newsetactiv,activitylabel = V2)
# Remove ActivityID
newsetactiv = newsetactiv[,-1]

#Reorder column to 2nd position
newsetactiv = newsetactiv[,c(1,88,2:87)]

#create avg for each variable, for each activity and aech subject

newsetactiv$subject = factor (newsetactiv$subject)
avgtidy <- summaryBy(.~ activitylabel+subject, data=newsetactiv, FUN=c(mean))



# Save New Tidy Set
write.table(avgtidy,file="./avgtidyset.txt",row.names=FALSE)
