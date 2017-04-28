
Previous steps


The data for the project must be downloaded and unzipped in the working directory of R.
The files needed are:
"features.txt" - contains the names of the variables
"subject_text" - contains the identifier of the subjects whose data were used for test. Each row identifies 
the subject who performed the activity for each window sample 
"y_text" - contains the label of the activity made by each subject for each window sample (test data)
"X_text" - contains the results of each experiment for each subject and for each window sample (test data)
"subject_train" - contains the identifier of the subjects whose data were used for train. Each row identifies 
the subject who performed the activity for each window sample 
"y_text" - contains the label of the activity made by each subject for each window sample (train data)
"X_text" - contains the results of each experiment for each subject and for each window sample (train data)



Description of the script


1.- The script begins loading the libraries "data.table", "dplyr" and "plyr"
2.- Then, the file "features.txt" is read to obtain the names of the variables (data frame "variables"). 
3.- The first column of the data frame "variables" is converted into a vector to use it to change the names of the 
variables when the data is loaded into a data frame.
4.- The vector "variables" is completed with the names "User" and "Activity"
5.- The data related to the subjects, the labels of the activities and the results of each experiment are read into three dataframes:
    - subject_test
    - y_test
    - test
6.- They are merged into a unique data frame ("user_activity_test"). The variables of this data frame are renamed with those included in the vector "variables"
7.- The script repeats steps 5 and 6 to create the data frame "user_activity_train" with the train data
8.- both data frames ("user_activity_test" and "user_activity_train") are merged by rows and ordered by user and activity into the data frame "data_mean_std"
9.- Only the variables whose names included the string "mean()" or "std() are selected
10.- The names of the variables are renamed with new more descriptive names
11.- The activity labels are substituted by descriptive names of the activities
12.- The data frame "data_mean_std" is grouped by user and activity. Then, the mean is calculated for each group, loading the results in the data frame "data_summary"
13.- The data frame is printed to the file "final_data.txt" in the working directory



