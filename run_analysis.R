# file locations
data_dir = "UCI HAR Dataset"
train_dir = paste(data_dir, "train", sep="/")
test_dir = paste(data_dir, "test", sep="/")
X_train_file = paste(train_dir, "X_train.txt", sep="/")
X_test_file = paste(test_dir, "X_test.txt", sep="/")
y_train_file = paste(train_dir, "y_train.txt", sep="/")
y_test_file = paste(test_dir, "y_test.txt", sep="/")
subject_train_file = paste(train_dir, "subject_train.txt", sep="/")
subject_test_file = paste(test_dir, "subject_test.txt", sep="/")

# load and merge training and testing feature data
# these files have a fixed with format, with 16 characters for each field
X_train = read.fwf(X_train_file, rep(c(16), 561))
X_test = read.fwf(X_test_file, rep(c(16), 561))
X_all = rbind(X_train, X_test)

# load and merge training and testing activity data
y_train = read.csv(y_train_file, header=FALSE)
y_test = read.csv(y_test_file, header=FALSE)
y_all = rbind(y_train, y_test)

# load and merge training and testing subject data
subject_train = read.csv(subject_train_file, header=FALSE)
subject_test = read.csv(subject_test_file, header=FALSE)
subject_all = rbind(subject_train, subject_test)

# extract mean and standard deviation columns
mean_std_cols = c("V1", "V2", "V3", "V4", "V5", "V6", "V41", "V42", "V43", "V44", "V45", "V46",
                  "V81", "V82", "V83", "V84", "V85", "V86", "V121", "V122", "V123", "V124", "V125",
                  "V126", "V161", "V162", "V163", "V164", "V165", "V166", "V201", "V202", "V214",
                  "V215", "V227", "V228", "V240", "V241", "V253", "V254", "V266", "V267", "V268",
                  "V269", "V270", "V271", "V345", "V346", "V347", "V348", "V349", "V350", "V424",
                  "V425", "V426", "V427", "V428", "V429", "V503", "V504", "V516", "V517", "V529",
                  "V530", "V542", "V543")
X_all_mean_std = X_all[, mean_std_cols]

# combine the subject, feature, and activity data into one data frame
# this makes the data easier to work with
all_data = cbind(subject_all, X_all_mean_std, y_all)

# use descriptive column names
col_names = c("Subject", "timeDomainBodyAccelerationMeanX", "timeDomainBodyAccelerationMeanY", "timeDomainBodyAccelerationMeanZ",
              "timeDomainBodyAccelerationStandardDeviationX", "timeDomainBodyAccelerationStandardDeviationY", "timeDomainBodyAccelerationStandardDeviationZ",
              "timeDomainGravityAccelerationMeanX", "timeDomainGravityAccelerationMeanY", "timeDomainGravityAccelerationMeanZ",
              "timeDomainGravityAccelerationStandardDeviationX", "timeDomainGravityAccelerationStandardDeviationY", "timeDomainGravityAccelerationStandardDeviationZ",
              "timeDomainBodyAccelerationJerkMeanX", "timeDomainBodyAccelerationJerkMeanY", "timeDomainBodyAccelerationJerkMeanZ",
              "timeDomainBodyAccelerationJerkStandardDeviationX", "timeDomainBodyAccelerationJerkStandardDeviationY",
              "timeDomainBodyAccelerationJerkStandardDeviationZ", "timeDomainBodyGyroscopeMeanX", "timeDomainBodyGyroscopeMeanY", "timeDomainBodyGyroscopeMeanZ",
              "timeDomainBodyGyroscopeStandardDeviationX", "timeDomainBodyGyroscopeStandardDeviationY", "timeDomainBodyGyroscopeStandardDeviationZ",
              "timeDomainBodyGyroscopeJerkMeanX", "timeDomainBodyGyroscopeJerkMeanY", "timeDomainBodyGyroscopeJerkMeanZ",
              "timeDomainBodyGyroscopeJerkStandardDeviationX", "timeDomainBodyGyroscopeJerkStandardDeviationY", "timeDomainBodyGyroscopeJerkStandardDeviationZ",
              "timeDomainBodyAccelerationMagnitudeMean", "timeDomainBodyAccelerationMagnitudeStandardDeviation", "timeDomainGravityAccelerationMagnitudeMean",
              "timeDomainGravityAccelerationMagnitudeStandardDeviation", "timeDomainBodyAccelerationJerkMagnitudeMean",
              "timeDomainBodyAccelerationJerkMagnitudeStandardDeviation", "timeDomainBodyGyroscopeMagnitudeMean",
              "timeDomainBodyGyroscopeMagnitudeStandardDeviation", "timeDomainBodyGyroscopeJerkMagnitudeMean",
              "timeDomainBodyGyroscopeJerkMagnitudeStandardDeviation", "FFTBodyAccelerationMeanX", "FFTBodyAccelerationMeanY", "FFTBodyAccelerationMeanZ",
              "FFTBodyAccelerationStandardDeviationX", "FFTBodyAccelerationStandardDeviationY", "FFTBodyAccelerationStandardDeviationZ",
              "FFTBodyAccelerationJerkMeanX", "FFTBodyAccelerationJerkMeanY", "FFTBodyAccelerationJerkMeanZ", "FFTBodyAccelerationJerkStandardDeviationX",
              "FFTBodyAccelerationJerkStandardDeviationY", "FFTBodyAccelerationJerkStandardDeviationZ", "FFTBodyGyroscopeMeanX", "FFTBodyGyroscopeMeanY",
              "FFTBodyGyroscopeMeanZ", "FFTBodyGyroscopeStandardDeviationX", "FFTBodyGyroscopeStandardDeviationY", "FFTBodyGyroscopeStandardDeviationZ",
              "FFTBodyAccelerationMagnitudeMean", "FFTBodyAccelerationMagnitudeStandardDeviation", "FFTBodyBodyAccelerationJerkMagnitudeMean",
              "FFTBodyBodyAccelerationJerkMagnitudeStandardDeviation", "FFTBodyBodyGyroscopeMagnitudeMean", "FFTBodyBodyGyroscopeMagnitudeStandardDeviation",
              "FFTBodyBodyGyroscopeJerkMagnitudeMean", "FFTBodyBodyGyroscopeJerkMagnitudeStandardDeviation", "Activity")
colnames(all_data) <- col_names

# replace activities with more descriptive names
all_data[all_data$Activity == 1, "Activity"] = "WALKING"
all_data[all_data$Activity == 2, "Activity"] = "WALKING_UPSTAIRS"
all_data[all_data$Activity == 3, "Activity"] = "WALKING_DOWNSTAIRS"
all_data[all_data$Activity == 4, "Activity"] = "SITTING"
all_data[all_data$Activity == 5, "Activity"] = "STANDING"
all_data[all_data$Activity == 6, "Activity"] = "LAYING"

# summarize by taking the mean of each variables for all Subject/Activity combinations
# there will be one row for each Subject/Activity pair
# the first two columns are the Subject and Activity
# the remaining columns consist of the variable averages
tidy_summary = ddply(all_data, .(Subject, Activity), summarize, timeDomainBodyAccelerationMeanXAvg = mean(timeDomainBodyAccelerationMeanX),
                    timeDomainBodyAccelerationMeanYAvg = mean(timeDomainBodyAccelerationMeanY),
                    timeDomainBodyAccelerationMeanZAvg = mean(timeDomainBodyAccelerationMeanZ),
                    timeDomainBodyAccelerationStandardDeviationXAvg = mean(timeDomainBodyAccelerationStandardDeviationX),
                    timeDomainBodyAccelerationStandardDeviationYAvg = mean(timeDomainBodyAccelerationStandardDeviationY),
                    timeDomainBodyAccelerationStandardDeviationZAvg = mean(timeDomainBodyAccelerationStandardDeviationZ),
                    timeDomainGravityAccelerationMeanXAvg = mean(timeDomainGravityAccelerationMeanX),
                    timeDomainGravityAccelerationMeanYAvg = mean(timeDomainGravityAccelerationMeanY),
                    timeDomainGravityAccelerationMeanZAvg = mean(timeDomainGravityAccelerationMeanZ),
                    timeDomainGravityAccelerationStandardDeviationXAvg = mean(timeDomainGravityAccelerationStandardDeviationX),
                    timeDomainGravityAccelerationStandardDeviationYAvg = mean(timeDomainGravityAccelerationStandardDeviationY),
                    timeDomainGravityAccelerationStandardDeviationZAvg = mean(timeDomainGravityAccelerationStandardDeviationZ),
                    timeDomainBodyAccelerationJerkMeanXAvg = mean(timeDomainBodyAccelerationJerkMeanX),
                    timeDomainBodyAccelerationJerkMeanYAvg = mean(timeDomainBodyAccelerationJerkMeanY),
                    timeDomainBodyAccelerationJerkMeanZAvg = mean(timeDomainBodyAccelerationJerkMeanZ),
                    timeDomainBodyAccelerationJerkStandardDeviationXAvg = mean(timeDomainBodyAccelerationJerkStandardDeviationX),
                    timeDomainBodyAccelerationJerkStandardDeviationYAvg = mean(timeDomainBodyAccelerationJerkStandardDeviationY),
                    timeDomainBodyAccelerationJerkStandardDeviationZAvg = mean(timeDomainBodyAccelerationJerkStandardDeviationZ),
                    timeDomainBodyGyroscopeMeanXAvg = mean(timeDomainBodyGyroscopeMeanX),
                    timeDomainBodyGyroscopeMeanYAvg = mean(timeDomainBodyGyroscopeMeanY),
                    timeDomainBodyGyroscopeMeanZAvg = mean(timeDomainBodyGyroscopeMeanZ),
                    timeDomainBodyGyroscopeStandardDeviationXAvg = mean(timeDomainBodyGyroscopeStandardDeviationX),
                    timeDomainBodyGyroscopeStandardDeviationYAvg = mean(timeDomainBodyGyroscopeStandardDeviationY),
                    timeDomainBodyGyroscopeStandardDeviationZAvg = mean(timeDomainBodyGyroscopeStandardDeviationZ),
                    timeDomainBodyGyroscopeJerkMeanXAvg = mean(timeDomainBodyGyroscopeJerkMeanX),
                    timeDomainBodyGyroscopeJerkMeanYAvg = mean(timeDomainBodyGyroscopeJerkMeanY),
                    timeDomainBodyGyroscopeJerkMeanZAvg = mean(timeDomainBodyGyroscopeJerkMeanZ),
                    timeDomainBodyGyroscopeJerkStandardDeviationXAvg = mean(timeDomainBodyGyroscopeJerkStandardDeviationX),
                    timeDomainBodyGyroscopeJerkStandardDeviationYAvg = mean(timeDomainBodyGyroscopeJerkStandardDeviationY),
                    timeDomainBodyGyroscopeJerkStandardDeviationZAvg = mean(timeDomainBodyGyroscopeJerkStandardDeviationZ),
                    timeDomainBodyAccelerationMagnitudeMeanAvg = mean(timeDomainBodyAccelerationMagnitudeMean),
                    timeDomainBodyAccelerationMagnitudeStandardDeviationAvg = mean(timeDomainBodyAccelerationMagnitudeStandardDeviation),
                    timeDomainGravityAccelerationMagnitudeMeanAvg = mean(timeDomainGravityAccelerationMagnitudeMean),
                    timeDomainGravityAccelerationMagnitudeStandardDeviationAvg = mean(timeDomainGravityAccelerationMagnitudeStandardDeviation),
                    timeDomainBodyAccelerationJerkMagnitudeMeanAvg = mean(timeDomainBodyAccelerationJerkMagnitudeMean),
                    timeDomainBodyAccelerationJerkMagnitudeStandardDeviationAvg = mean(timeDomainBodyAccelerationJerkMagnitudeStandardDeviation),
                    timeDomainBodyGyroscopeMagnitudeMeanAvg = mean(timeDomainBodyGyroscopeMagnitudeMean),
                    timeDomainBodyGyroscopeMagnitudeStandardDeviationAvg = mean(timeDomainBodyGyroscopeMagnitudeStandardDeviation),
                    timeDomainBodyGyroscopeJerkMagnitudeMeanAvg = mean(timeDomainBodyGyroscopeJerkMagnitudeMean),
                    timeDomainBodyGyroscopeJerkMagnitudeStandardDeviationAvg = mean(timeDomainBodyGyroscopeJerkMagnitudeStandardDeviation),
                    FFTBodyAccelerationMeanXAvg = mean(FFTBodyAccelerationMeanX), FFTBodyAccelerationMeanYAvg = mean(FFTBodyAccelerationMeanY),
                    FFTBodyAccelerationMeanZAvg = mean(FFTBodyAccelerationMeanZ),
                    FFTBodyAccelerationStandardDeviationXAvg = mean(FFTBodyAccelerationStandardDeviationX),
                    FFTBodyAccelerationStandardDeviationYAvg = mean(FFTBodyAccelerationStandardDeviationY),
                    FFTBodyAccelerationStandardDeviationZAvg = mean(FFTBodyAccelerationStandardDeviationZ),
                    FFTBodyAccelerationJerkMeanXAvg = mean(FFTBodyAccelerationJerkMeanX),
                    FFTBodyAccelerationJerkMeanYAvg = mean(FFTBodyAccelerationJerkMeanY),
                    FFTBodyAccelerationJerkMeanZAvg = mean(FFTBodyAccelerationJerkMeanZ),
                    FFTBodyAccelerationJerkStandardDeviationXAvg = mean(FFTBodyAccelerationJerkStandardDeviationX),
                    FFTBodyAccelerationJerkStandardDeviationYAvg = mean(FFTBodyAccelerationJerkStandardDeviationY),
                    FFTBodyAccelerationJerkStandardDeviationZAvg = mean(FFTBodyAccelerationJerkStandardDeviationZ),
                    FFTBodyGyroscopeMeanXAvg = mean(FFTBodyGyroscopeMeanX), FFTBodyGyroscopeMeanYAvg = mean(FFTBodyGyroscopeMeanY),
                    FFTBodyGyroscopeMeanZAvg = mean(FFTBodyGyroscopeMeanZ),
                    FFTBodyGyroscopeStandardDeviationXAvg = mean(FFTBodyGyroscopeStandardDeviationX),
                    FFTBodyGyroscopeStandardDeviationYAvg = mean(FFTBodyGyroscopeStandardDeviationY),
                    FFTBodyGyroscopeStandardDeviationZAvg = mean(FFTBodyGyroscopeStandardDeviationZ),
                    FFTBodyAccelerationMagnitudeMeanAvg = mean(FFTBodyAccelerationMagnitudeMean),
                    FFTBodyAccelerationMagnitudeStandardDeviationAvg = mean(FFTBodyAccelerationMagnitudeStandardDeviation),
                    FFTBodyBodyAccelerationJerkMagnitudeMeanAvg = mean(FFTBodyBodyAccelerationJerkMagnitudeMean),
                    FFTBodyBodyAccelerationJerkMagnitudeStandardDeviationAvg = mean(FFTBodyBodyAccelerationJerkMagnitudeStandardDeviation),
                    FFTBodyBodyGyroscopeMagnitudeMeanAvg = mean(FFTBodyBodyGyroscopeMagnitudeMean),
                    FFTBodyBodyGyroscopeMagnitudeStandardDeviationAvg = mean(FFTBodyBodyGyroscopeMagnitudeStandardDeviation),
                    FFTBodyBodyGyroscopeJerkMagnitudeMeanAvg = mean(FFTBodyBodyGyroscopeJerkMagnitudeMean),
                    FFTBodyBodyGyroscopeJerkMagnitudeStandardDeviationAvg = mean(FFTBodyBodyGyroscopeJerkMagnitudeStandardDeviation))

# write the data to a file
write.table(tidy_summary, "tidy_summary.txt", row.name=FALSE)