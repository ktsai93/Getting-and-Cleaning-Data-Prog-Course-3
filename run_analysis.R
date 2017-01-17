# 1) Merges the training and the test sets to create one data set.
# 2) Extracts only the measurements on the mean and standard deviation for each measurement.
# 3) Uses descriptive activity names to name the activities in the data set
# 4) Appropriately labels the data set with descriptive variable names.
# 5) From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# 1 ####################################################

# Load training datasets
X_train <- read.table("train/X_train.txt")
y_train <- read.table("train/y_train.txt")
subject_train <- read.table("train/subject_train.txt")

# Load test datasets
X_test <- read.table("test/X_test.txt")
y_test <- read.table("test/y_test.txt")
subject_test <- read.table("test/subject_test.txt")

# Merge training and testing datasets
train_data <- cbind(subject_train, y_train, X_train)
test_data <- cbind(subject_test, y_test, X_test)
merged_data <- rbind(train_data, test_data)

# 2-4 ##################################################

# Name the activities in the dataset
activity_labels <- read.table("activity_labels.txt")[,2]
merged_data <- cbind(merged_data[,c(1,2)], activity_labels[merged_data[,2]], merged_data[,3:length(merged_data)])

# Label the dataset with descriptive variable names
features <- read.table("features.txt")[,2]
names(merged_data) <- c("subject", "activityid", "activitylabel", as.character(features))

# Extract measurements on only mean and std for each measurement
extract_mean_or_std <- grepl("mean|std", names(features))
data_mean_std <- merged_data[, c(TRUE, TRUE, TRUE, extract_mean_or_std)]

# 5 ####################################################

# Create tidy dataset with average of each variable for each activity and each subject
library(reshape2)

id_variables <- names(data_mean_std)[1:3]
measure_variables <- names(data_mean_std)[4:length(names(data_mean_std))]

melted_data <- melt(data_mean_std, id.vars = id_variables, measure.vars = measure_variables)
tidy_data <- dcast(melted_data, subject + activitylabel ~ variable, mean)

write.table(tidy_data, file = "tidy_data.txt", row.names = FALSE)
