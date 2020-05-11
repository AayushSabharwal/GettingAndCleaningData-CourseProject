# Getting And Cleaning Data - Course Project

The run_analysis.R script performs basic functions to clean and process the data in the UCI HAR Dataset and writes the output to a new file, named tidy_data.txt. Following are the steps performed by the script to complete this process:

1. The script reads the tables activity_labels.txt and features.txt. activity_labels.txt allows identification of activity names given in y_train.txt and y_test.txt so as to later convert them from integers to factor variables. features.txt contains information about the variables in X_test.txt and X_train.txt, so we can identify which columns correspond to which value. From there, the script extracts the relevant column IDs which contain "mean()" or "std()" as a substring using \\\\ to ensure that the parentheses are not considered metacharacters. From this, the script also extracts relevant variable names as well.

2. The script reads X_test.txt, and takes subsets out only the columns required as identified from the grep operations in the previous step. The script also reads y_test.txt, and inputs it as a vector by subsetting the first (and only) column. The script then reads the corresponding subject indices, again inputting as a vector. These three fields are then combined into one data.frame using cbind. The same procedure is repeated for the training set.

3. The data.frame variables obtained from the previous step are merged using rbind, since they contain the same variables. The resultant data.frame is named by using the column names obtained from step 1.

4. The activity field is converted from an integer variable to a factor variable. Firstly, the script obtains a character vector corresponding to the names of the activities, as identified by the activity_labels data.frame. This is converted to a factor variable, whose levels have to be explicitly specified so as to maintain the same correspondance between integer and factor as specified in activity_labels.

5. To obtain the tidy set by taking the average of every field for every subject and every activity, the dplyr library is used. By successive chaining of functions achieved through the %>% operator, we take the merged data.frame, group the fields by subject and activity using group_by, and then summarise each field using the summarise_at function. This function is passed the list of variable names to summarise and the mean function to apply on each variable. Hence, we obtain a tidy data.frame which is stored in average_data and then saved to file as tidy_data.txt
