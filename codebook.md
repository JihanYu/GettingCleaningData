----------------------------------------------------------------------------------------
# run_analysis.R

## Read the train & test data
- x_train : read the "X_train.txt" file from the "test" directory(variables of the features)
- y_train : read the "Y_train.txt" file from the "test" directory(labels of the features)
- subject_train : read the "subject_train.txt" file from the "test" directory (subject number)
- test files are same as above

## Merge and sort the train & test datasets
- train.data : combine the loaded data - "Subject", "label", "variables"
- total.data : merge the train & test datasets and sort the data in the order of "subject", then "activity"

## Read features of the variables and extract mean & standard deviations / Label the dataset with variable names
- features : read the "features.txt" file (this contains variable names of test_x or train_x)
- t.f : "t" means the time domain signals and "f" indicates frequency domain signals
- feat.split : split the variable names according to the character "-"
- fillND : the function which fills "not defined" string to the empty space
- mean.id / std.id : indices indicating the mean and standard deviations
- meanstd.data : sub-datasets which have the mean and standard deviation variables

## Calculate average of each variables for each activity and each subject
- use "reshape2" library
- data.long : melt the subset mean & std data(meanstd_data) as the subject & activity
- ave.data : calculate the average according to the subject & activity
          this results the averaged measurements for each activity and each subject
- the result data set(ave.data) is saved as the file, "result_ave.csv".

----------------------------------------------------------------------------------------
# result_ave.txt
- this has the average of each variable for each activity and each subject
- 180 rows and 48 columns
- 180 rows contain 30 subjects and each subject has 6 activities
- 48 columns contain 2 indicator(Subject & activity) and 46 variables about mean & std