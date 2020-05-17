#Loading required packages
library(dplyr)
library(reshape2)

#Downloading the dataset
filename <- "getdataset.zip"

#Checking if the archieve already exists
if (!file.exists(filename)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileURL, filename)
} 
 
#Checking if the folder already exists
if (!file.exists("UCI HAR Dataset")) { 
  unzip(filename) 
}

#Reading all data files from the unzipped folder

activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")
features <- read.table("./UCI HAR Dataset/features.txt")

subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
x_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")

subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
x_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")


#Merging the training and test sets to create one data set
x <- rbind(x_test, x_train)
y <- rbind(y_test, y_train)
sub <- rbind(subject_test, subject_train)

#gets Activity Labels
activity_labels[,2] <- as.character(activity_labels[,2])

#Extract features columns named Mean and Std
selectedCols <- grep("-(mean|std).*", as.character(features[,2]))
selectedColNames <- features[selectedCols, 2]
selectedColNames <- gsub("-mean", "Mean", selectedColNames)
selectedColNames <- gsub("-std", "Std", selectedColNames)
selectedColNames <- gsub("[-()]", "", selectedColNames)

# Obtain the final data set that extracts only the measurements on the mean and standard deviation for each measurement
x <- x[selectedCols]
allData <- cbind(sub, y, x)
colnames(allData) <- c("Subject", "Activity", selectedColNames)

# Use descriptive activity names to name the activities in the data set
allData$Activity <- factor(allData$Activity, levels = activity_labels[,1], labels = activity_labels[,2])
allData$Subject <- as.factor(allData$Subject)

meltedData <- melt(allData, id = c("Subject", "Activity"))
tidyData <- dcast(meltedData, Subject + Activity ~ variable, mean)

# Appropriately labels the data set with descriptive variable names. 
names(tidyData)<-gsub("Acc", "Accelerometer", names(tidyData))
names(tidyData)<-gsub("Gyro", "Gyroscope", names(tidyData))
names(tidyData)<-gsub("BodyBody", "Body", names(tidyData))
names(tidyData)<-gsub("Mag", "Magnitude", names(tidyData))
names(tidyData)<-gsub("^t", "Time", names(tidyData))
names(tidyData)<-gsub("^f", "Frequency", names(tidyData))
names(tidyData)<-gsub("tBody", "TimeBody", names(tidyData))
names(tidyData)<-gsub("-mean()", "Mean", names(tidyData), ignore.case = TRUE)
names(tidyData)<-gsub("-std()", "STD", names(tidyData), ignore.case = TRUE)
names(tidyData)<-gsub("-freq()", "Frequency", names(tidyData), ignore.case = TRUE)
names(tidyData)<-gsub("angle", "Angle", names(tidyData))
names(tidyData)<-gsub("gravity", "Gravity", names(tidyData))

# Creates tidy data set with the average of each variable for each activity and each subject
FinalData <- tidyData %>%
  group_by(Subject, Activity) %>%
  summarise_all(funs(mean))

# writes the final cleaned dataset to a text file
write.table(FinalData, "FinalData.txt", row.name=FALSE)

