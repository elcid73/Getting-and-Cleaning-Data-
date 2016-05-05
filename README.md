# Getting-and-Cleaning-Data-

The script reads in training and testing data files (ytrain, xtrain, features, subject_train, ytest, xtest, subject_test) , adds appropriate column names to the files stripts all columns from traing and testing data sets that don't contain mean or std values and combines the data in "trainingDataCombined" and "testingDataCombined" that include the results and subject and and activityId information.  

Then, "trainingDataCombined" and "testingDataCombined" are combined into "AllDataCombined" that includes both testing and traing data.

Script then reads in ActyvityType file, and merges its contents with the "AllDataCombined" on activityID field.

Finally, the scripts creates a copy of AllDataCombined" -. AllDataCombined1", where activity type is removed, aggregates all the values in AllDataCombined1" that are not subjectid or activityid, and puts the results into TidyData file.  Then, activity type is added to the TidyData file, and it is exported to the external location.
