## script to clean data run_analysis.R
library(data.table)
library(dplyr)
library(plyr)
## read the names of variables from features.txt file
variables <- read.table("./features.txt", sep = "\n", header = FALSE)
## convert dataframe variables in a vector to be merged with the data of test and train
variables <- as.vector(variables$V1, mode = "any")
## include the names of the variables "User" and "Activity")
variables_complete <- c("User", "Activity", variables)
## read files "subject_test.txt", "y_test.txt" and "X_test.txt" and create a unique dataframe
subject_test <- read.table("./subject_test.txt", sep = "\n", header = FALSE)
y_test <-read.table("./y_test.txt", sep ="\n", header = FALSE)
test <- read.table("./X_test.txt", sep = "", header = FALSE)
## merge user, activity and results of the test in a dataframe
user_activity_test <- data.frame(subject_test$V1, y_test$V1, test)
##rename names of dataframe with variables_complete
colnames(user_activity_test) <- variables_complete
## do the same with train data
subject_train <- read.table("./subject_train.txt", sep = "\n", header = FALSE)
y_train <-read.table("./y_train.txt", sep ="\n", header = FALSE)
train <- read.table("./X_train.txt", sep = "", header = FALSE)
user_activity_train <- data.frame(subject_train$V1, y_train$V1, train)
colnames(user_activity_train) <- variables_complete
## merge the two dataframes by rows
data_complete <- bind_rows(user_activity_test, user_activity_train)
## order the dataframe by user and activity
data_complete <- data_complete[order(data_complete$User, data_complete$Activity),]
## select only the columns with mean or std
data_mean_std <-data_complete[,grep("User|Activity|mean()|std()", colnames(data_complete))]
## However, the former instruction select also the columns with meanFreq and I have tried to eliminate them with regular
## expressions, without success. I extract these columns with the following instructions
## identify the columns with "meanFreq()" string
meanFreq <- grep("meanFreq()", colnames(data_mean_std))
## eliminate from the dataframe these columns
data_mean_std <- data_mean_std[,-meanFreq]
## rename the variables of the dataframe
new_name_variables <- c("User", "Activity",
                        "time_domain_body_accelerometer_signal_X_axis_mean",
                        "time_domain_body_accelerometer_signal_Y_axis_mean",
                        "time_domain_body_accelerometer_signal_Z_axis_mean",
                        "time_domain_body_accelerometer_signal_X_axis_std",
                        "time_domain_body_accelerometer_signal_Y_axis_std",
                        "time_domain_body_accelerometer_signal_Z_axis_std",
                        "time_domain_gravity_accelerometer_signal_X_axis_mean",
                        "time_domain_gravity_accelerometer_signal_Y_axis_mean",
                        "time_domain_gravity_accelerometer_signal_Z_axis_mean",
                        "time_domain_gravity_accelerometer_signal_X_axis_std",
                        "time_domain_gravity_accelerometer_signal_Y_axis_std",
                        "time_domain_gravity_accelerometer_signal_Z_axis_std",
                        "time_domain_body_accelerometer_jerk_signal_X_axis_mean",
                        "time_domain_body_accelerometer_jerk_signal_Y_axis_mean",
                        "time_domain_body_accelerometer_jerk_signal_Z_axis_mean",
                        "time_domain_body_accelerometer_jerk_signal_X_axis_std",
                        "time_domain_body_accelerometer_jerk_signal_Y_axis_std",
                        "time_domain_body_accelerometer_jerk_signal_Z_axis_std",
                        "time_domain_body_gyroscope_signal_X_axis_mean",
                        "time_domain_body_gyroscope_signal_Y_axis_mean",
                        "time_domain_body_gyroscope_signal_Z_axis_mean",
                        "time_domain_body_gyroscope_signal_X_axis_std",
                        "time_domain_body_gyroscope_signal_Y_axis_std",
                        "time_domain_body_gyroscope_signal_Z_axis_std",
                        "time_domain_body_gyroscope_jerk_signal_X_axis_mean",
                        "time_domain_body_gyroscope_jerk_signal_Y_axis_mean",
                        "time_domain_body_gyroscope_jerk_signal_Z_axis_mean",
                        "time_domain_body_gyroscope_jerk_signal_X_axis_std",
                        "time_domain_body_gyroscope_jerk_signal_Y_axis_std",
                        "time_domain_body_gyroscope_jerk_signal_Z_axis_std",
                        "time_domain_body_accelerometer_3D_signal_mean",
                        "time_domain_body_accelerometer_3D_signal_std",
                        "time_domain_gravity_accelerometer_3D_signal_mean",
                        "time_domain_gravity_accelerometer_3D_signal_std",
                        "time_domain_body_accelerometer_jerk_3D_signal_mean",
                        "time_domain_body_accelerometer_jerk_3D_signal_std",
                        "time_domain_body_gyroscope_3D_signal_mean",
                        "time_domain_body_gyroscope_3D_signal_std",
                        "time_domain_body_gyroscope_jerk_3D_signal_mean",
                        "time_domain_body_gyroscope_jerk_3D_signal_std",
                        "frequency_domain_body_accelerometer_signal_X_axis_mean",
                        "frequency_domain_body_accelerometer_signal_Y_axis_mean",
                        "frequency_domain_body_accelerometer_signal_Z_axis_mean",
                        "frequency_domain_body_accelerometer_signal_X_axis_std",
                        "frequency_domain_body_accelerometer_signal_Y_axis_std",
                        "frequency_domain_body_accelerometer_signal_Z_axis_std",
                        "frequency_domain_body_accelerometer_jerk_signal_X_axis_mean",
                        "frequency_domain_body_accelerometer_jerk_signal_Y_axis_mean",
                        "frequency_domain_body_accelerometer_jerk_signal_Z_axis_mean",
                        "frequency_domain_body_accelerometer_jerk_signal_X_axis_std",
                        "frequency_domain_body_accelerometer_jerk_signal_Y_axis_std",
                        "frequency_domain_body_accelerometer_jerk_signal_Z_axis_std",
                        "frequency_domain_body_gyroscope_signal_X_axis_mean",
                        "frequency_domain_body_gyroscope_signal_Y_axis_mean",
                        "frequency_domain_body_gyroscope_signal_Z_axis_mean",
                        "frequency_domain_body_gyroscope_signal_X_axis_std",
                        "frequency_domain_body_gyroscope_signal_Y_axis_std",
                        "frequency_domain_body_gyroscope_signal_Z_axis_std",
                        "frequency_domain_body_accelerometer_3D_signal_mean",
                        "frequency_domain_body_accelerometer_3D_signal_std",
                        "frequency_domain_body_accelerometer_jerk_3D_signal_mean",
                        "frequency_domain_body_accelerometer_jerk_3D_signal_std",
                        "frequency_domain_body_gyroscope_3D_signal_mean",
                        "frequency_domain_body_gyroscope_3D_signal_std",
                        "frequency_domain_body_gyroscope_jerk_3D_signal_mean",
                        "frequency_domain_body_gyroscope_jerk_3D_signal_std"
                        )
colnames(data_mean_std) <- new_name_variables
## substitute the codes of activities by descriptive names
data_mean_std$Activity[data_mean_std$Activity == "1"] <- "walking"
data_mean_std$Activity[data_mean_std$Activity == "2"] <- "walking_upstairs"
data_mean_std$Activity[data_mean_std$Activity == "3"] <- "walking_downstairs"
data_mean_std$Activity[data_mean_std$Activity == "4"] <- "sitting"
data_mean_std$Activity[data_mean_std$Activity == "5"] <- "standing"
data_mean_std$Activity[data_mean_std$Activity == "6"] <- "laying"
## initialize an auxiliar dataframe to insert the results of the mean
data_summary <- data.frame()
## group the data by User and Activity and calculate the mean for each group
data_summary <- summarise_all(group_by(data_mean_std, User, Activity), mean)
## write the final file
write.table(data_summary, "./final_data.txt")	