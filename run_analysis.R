library(dplyr)

# read the table identifying label to task
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")
# read the table identifying the variables in each dataset
features <- read.table("./UCI HAR Dataset/features.txt")
# get a list containing the column indexes of mean and measurements
col_ids <- c(grep("mean\\(\\)", features[, 2]), grep("std\\(\\)", features[, 2]))
# use this to get names of the columns
col_names <- features[col_ids, 2]

# read test set data, get only the required columns
x <- read.table("./UCI HAR Dataset/test/X_test.txt")[, col_ids]
# read test set labels, and since it has only one variable turn it into a vector
y <- read.table("./UCI HAR Dataset/test/y_test.txt")[, 1]
# read subjects
subjects <- read.table("./UCI HAR Dataset/test/subject_test.txt")[, 1]
# create test data.frame
test_data <- cbind(subjects, y, x)

# repeat steps for training data
x <- read.table("./UCI HAR Dataset/train/X_train.txt")[, col_ids]
y <- read.table("./UCI HAR Dataset/train/y_train.txt")[, 1]
subjects <- read.table("./UCI HAR Dataset/train/subject_train.txt")[, 1]
train_data <- cbind(subjects, y, x)
rm("x", "y", "subjects")

# merge the training and test sets
merged_data <- rbind(test_data, train_data)
# rename the columns. The first two columns are named explicitly, and the rest are come from the col_names vector
names(merged_data) <- c("subject", "activity", col_names)

# convert activities to factor variable
merged_data[, 2] <- factor(activity_labels[merged_data[, 2], 2], levels = activity_labels[, 2])

# create a new data.frame for the mean of each variable for each subject and each activity
average_data <- merged_data %>% group_by(subject, activity) %>% summarise_at(col_names, mean)
# write the new, tidy data to file
write.table(average_data, "tidy_data.txt", row.names = FALSE)