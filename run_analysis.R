library(data.table)

setwd("C:/Users/yetis.batmaz/Documents/")
        
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file( url, destfile = "data.zip" )
unzip("data.zip")

# set new working directory for list.files()
setwd("C:/Users/yetis.batmaz/Documents/UCI HAR Dataset")

# We need the following files:
# TEST: test/subject_test.txt  , test/X_test.txt  , test/y_test.txt
# TRAIN: train/subject_train.txt, train/X_train.txt, train/y_train.txt
# [-1] for exlcuding the Inertial Signals
trainfile <- list.files( "train", full.names = TRUE )[-1]
testfile  <- list.files( "test" , full.names = TRUE )[-1]

# Read in all six files
file <- c( trainfile, testfile )
D <- lapply( file, read.table, stringsAsFactors = FALSE, header = FALSE )


# Step 1 
# Merging the train and test sets to create one data set
# rbind the train and test data by each variable
D1 <- mapply ( rbind, D[ c(1:3) ], D[ c(4:6) ] )

# data2: the whole single dataset
# column 1 = subject, column 2-562 = feature,  column 563 = activity
D2 <- do.call( cbind, D1 )


# Step 2 
# Feature column: extract only mean and standard deviation for each measurement
# match it using features.txt(second file in list.file() )
# featurename is in the second column(V2)
featurenames <- fread( list.files()[2], header = FALSE, stringsAsFactor = FALSE )

# set the column names for D2 (Task required in Step 4) 
# label the data set with descriptive variable names.
setnames( D2, c(1:563), c( "subject", featurenames$V2, "activity" ) )

# Extract only the column that have mean() or std() in the end
# Add 1 to it, because the first column in D2 is subject not feature
locs <- grep( "std|mean\\(\\)", featurenames$V2 ) + 1

# data3 : contains only the mean and standard deviation for feature column 
D3 <- D2[, c( 1, locs, 563 ) ]


# Step 3 
# Use descriptive activity names to name the activities in the data set
# match it using activity_labels.txt(first file in list.file() )
activitynames <- fread( list.files()[1], header = FALSE, stringsAsFactor = FALSE )

D3$activity <- activitynames$V2[ match( D3$activity, activitynames$V1 ) ]


# Step 5 
# Create a tidy data set
# with the average of each variable for each activity and each subject.
TidyData <- aggregate( . ~ subject + activity, data = D3, FUN = mean )

# write out TidyData
write.table( TidyData, "tidydata.txt", row.names = FALSE )
