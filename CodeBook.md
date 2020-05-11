# Code Book

The raw data provided in the UCI HAR Dataset is split into training and test sets, which are structured identically. The data provided is in the form of a 561-element vector. Of this, the field containing mean or standard deviation values (identified from the features.txt file) were extracted to form the final, tidy dataset for our purposes.

The data from both test and training sets are merged, and only columns pertaining to mean or standard deviation values are taken. For every subject and activity combination, the mean of every variable is taken to form the tidy data set.