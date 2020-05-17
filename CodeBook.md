Coursera Data Science Specialization Course
Getting and Cleanng Data
Course Projec

Data:
    The goal of the project was to collect, work with and clean the data set. The data was obtained from the UCI Machine Learning website.
    The archived data set can be obtained using the link here : https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Processing:
The run_analysis.R script performs the following 5 steps to obtain the desired clean dataset.

   Step 1 : Obtaining the dataset
    
        The dataset was downloaded and extracted in a folder named UCI HAR Dataset


   Step 2: Read Each data file and assign a name to each
        
        activity_labels : Read activity_labels.txt file (6 rows, 2 columns). It contained the list of activities performed when measurements were taken.
        
        features : Read features.txt file (561 rows, 2 columns). It contained the features selected.
    
        subject_test : Read subject_test.txt file (2947 rows, 1 column). It contained data of test subjects
        
        x_test : Read X_test.txt file (2947 rows, 561 columns). It contained recorded features test data
        
        y_test : Read y_test.txt file (2947 rows, 1 columns). It contained recorded activity test data

        subject_train : Read subject_train.txt file (7352 rows, 1 column). It contined train data of test subjects

        x_train : Read X_train.txt file (7352 rows, 561 columns). It contained recorded features training data

        y_train : Read y_train.txt file (7352 rows, 1 columns). It contained recorded activities training data


  Step 3: Merging Training and Testing Data Sets
  
        X (10299 rows, 561 columns) was created by merging x_train and x_test using rbind() function
        Y (10299 rows, 1 column) was created by merging y_train and y_test using rbind() function
        sub (10299 rows, 1 column) was created by merging subject_train and subject_test using rbind() function
        
        
  Step 4: Extract only the measurements on mean and standard deviation for each measurement
  
        Second column from the activity_labels was obtained using the as.character(activity_labels[,2] function
        Grep function was used to search column matches for 'mean' and 'std'. Only those columns were then merged from each of the above datasets.
        alldata (10299 rows, 88 columns) was then created by merging sub, X and Y using cbind() function.
        
        
  Step 5: Appropriately labels the data set with descriptive variable names. 
  
        All Acc in column name was renamed to Accelerometer
        All Gyro in column names was renamed to Gyroscope
        All BodyBody in column names was renamed to Body
        All Mag in column names was renamed to Magnitude
        All columns starting with t were renamed to Time
        All columns starting with f were renamed to Frequency
        All columns starting with tbody were renamed to TimeBody
        All columns with mean(), std(), freq() were renamed to Mean, STD and Frequency respectively
        All columns with angle, gravity were renamed to Angle, Gravity respectively
  
  
  Step 6: Create independent tidy data set with the average of each variable for each activity and each subject
  
        Final Data (180 rows, 88 columns) is created by summarizing TidyData and taking mean of each variable for each activity and subject after grouping by subject and activity


  Step 7: Export FinalData into FinalData.txt file.

