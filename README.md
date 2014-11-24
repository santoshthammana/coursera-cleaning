## Introduction

The "run_analysis.R" script performs all analysis and writes the output to the "tidy_summary.txt" file.
It is assumed that the unzipped UCI Har Dataset directory is in the same directory as the "run_analysis.R" script.

## Script Information

1. Data was taken from the UCI HAR Dataset, which can be downloaded here:
   https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

   The following files were used:

   train/X_train.txt

   train/y_train.txt

   train/subject_train.txt

   test/X_test.txt

   test/y_test.txt

   test/subject_test.txt

   activity_labels.txt


   The first 3 files consist of training data.  The remaining 3 files consist of test data.
   The X_train.txt and X_test.txt files consist of the 561 features collected.
   The y_train.txt and y_test.txt files are corresponding activity codes.
   The subject_train.txt and subject_test.txt files are the IDs of subjects performing the activities.
   The activity_labels.txt file maps the activity codes to the actual activity.

   The included run_analysis.R script performs all the analysis and save the output to "tidy_summary.txt".
   The output is an average value of each variable (feature) for each subject/activity pair.

2. The X_train.txt and X_test.txt files were read with a fixed width format reader.  16 characters are used for each numerical field.
   The Y_train.txt, Y_test.txt, subject_train.txt, and subject_test.txt files were read with a csv format reader.  There is only one field per line.

3. The training and test data were merged.  In the data frames, training data was placed on "top" of the test data.
   This results in X_all, y_all, and subject_all.

4. Mean and standard deviation measurements were extracted from the feature data.  This was done by looking at the original dataset's features.txt file,
   and taking only feature names which had "mean()" or "std()" in the name.

5. The subject, feature and activity data were combined into a single data set.
   The subject is the first column, followed by the feature columns, which are followed by the activity column.

6. Descriptive names were given to all of the columns in the data set.  For the feature columns, names were manually created based on names from the original
   dataset's features.txt file.  Original names starting with "t" are Time Domain measurements.  Original names starting with "f" are Fast Fourier Transforms
   of measurements.  The subject column was given the name "Subject".  The activity column was given the name "Activity".

7. Activity values were changed from a code to a descriptive name.  The activity_labels.txt file from the original UCI Har Dataset contains the transformations.

8. Data was summarized by averaging each feature's value for all subject/activity combinations.

9. The final, tidy data set was written to a file "tidy_summary.txt".  This data is tidy because each variable (the average feature value) is in a separate column.
   In addition, this average feature value is observed for a subject/activity pair.  Each subject/activity pair is in a different row.  The Subject and Activity
   columns have this data.
