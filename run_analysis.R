#### Import and Tidy Dataset, and

## Import dply: ##
library(dplyr)

## Download all Data: ##
#Test Set
DT_test_y <- read.table("UCI HAR Dataset/test/y_test.txt")
DT_test_X <- read.table("UCI HAR Dataset/test/X_test.txt")
DT_test_subject <- read.table("UCI HAR Dataset/test/subject_test.txt")
#Train Set
DT_train_y <- read.table("UCI HAR Dataset/train/y_train.txt")
DT_train_X <- read.table("UCI HAR Dataset/train/X_train.txt")
DT_train_subject <- read.table("UCI HAR Dataset/train/subject_train.txt")
#Column Lables
labels <- read.table("UCI HAR Dataset/features.txt")
activity <- read.table("UCI HAR Dataset/activity_labels.txt")
# Rename column labels with feature dictionary
names(DT_test_X) <- labels$V2
names(DT_train_X) <- labels$V2


##1. Merge train and test sets together: ##
DT_X <- rbind(DT_train_X,DT_test_X)
DT_y <- rbind(DT_train_y,DT_test_y)
DT_subject <- rbind(DT_train_subject,DT_test_subject)
#Remove staging data to free memory (optional)
rm(DT_test_y,DT_test_X,DT_train_y,DT_train_X,DT_train_subject,DT_test_subject)


##2. Extract only required fields: ##
# Grab only the fields with "mean" and "std"
mean_and_std <- c(grep("mean|std",names(DT_X),value=TRUE))
# filter down to only these fields
DT_X <- DT_X %>% select(mean_and_std)


##3. Manipulate the column names into tidydata form: ##
# make lower case
names(DT_X) <- tolower(names(DT_X))
# change prefix to clearer names
names(DT_X) <- sub("^t","time",names(DT_X))
names(DT_X) <- sub("^f","fft",names(DT_X))
# remove symbols
names(DT_X) <- gsub("-","",names(DT_X))
names(DT_X) <- gsub("\\(\\)","",names(DT_X))
# for subject id
names(DT_subject) <- "subjectid"

##4. Label activty id with name from data dictionary
DT_y <- merge(DT_y,activity,by = "V1",sort=FALSE)
DT_y <- DT_y %>% select(V2) %>% rename(activity=V2)
# Merge X and y sets: ##
DT <- cbind(DT_subject,DT_y,DT_X)


##5. Average values for each activity and each subject
numeric_col <- names(select(DT,!subjectid:activity))

DT_ave <- DT %>% group_by(activity,subjectid) %>% summarise(across(all_of(numeric_col),mean))


## Write each data set to text file 
write.table(DT,"UCI_HAR_tidy.txt",sep = ",")
write.table(DT_ave,"averages.txt",sep = ",")




