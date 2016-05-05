
##########################################################################################
rm(list=ls())

# Import the train data from files

xTrain       = read.table('x_train.txt',header=FALSE); 
yTrain       = read.table('y_train.txt',header=FALSE); 

features     = read.table('features.txt',header=FALSE); 
subjectTrain = read.table('subject_train.txt',header=FALSE); 


# Add column names to the train data from above

colnames(xTrain)        = features[,2]; 
colnames(yTrain)        = "activityId";
colnames(subjectTrain)  = "subjectId";

# select columns with mean() or std() in train data
Mean_Std_Only <- grep("-(mean|std)\\(\\)", features[, 2])

# subset the columns from above in train data
xTrain <- xTrain[, Mean_Std_Only]

# Combine train data
trainingDataCombined = cbind(yTrain,subjectTrain,xTrain);

# inport  the test data
xTest       = read.table('x_test.txt',header=FALSE); 
yTest       = read.table('y_test.txt',header=FALSE); 

subjectTest = read.table('subject_test.txt',header=FALSE); 

#add column names to the test data imported above
colnames(xTest)       = features[,2]; 
colnames(yTest)       = "activityId";

colnames(subjectTest) = "subjectId";


# subset the columns with std/mean only in test data
xTest <- xTest[, Mean_Std_Only]


# Combine testing data
testingDataCombined = cbind(yTest,subjectTest,xTest);


# Combine training and test data into combined file
AllDataConmined = rbind(trainingDataCombined,testingDataCombined);

#Import Activity type file
ActivityType = read.table('activity_labels.txt',header=FALSE); 

#Add columns to activity type file
colnames(ActivityType)  = c('activityId','activityType');

#Combine the combined file with the acitivity type file to add activity names
AllDataConmined = merge(AllDataConmined,ActivityType,by='activityId',all.x=TRUE);

#Create new data without the activity Type
AllDataConmined1  = AllDataConmined[,names(AllDataConmined) != 'activityType'];



#Create data with the mean of each variable for each activity and each subject
TidyData    = aggregate(AllDataConmined1[,names(AllDataConmined1) != c('activityId','subjectId')],by=list(activityId=AllDataConmined1$activityId,subjectId = AllDataConmined1$subjectId),mean);



#Add back the activity names to the tidy data
TidyData    = merge(TidyData,ActivityType,by='activityId',all.x=TRUE);

#Export the tidyData file
write.table(TidyData, "TidyData.txt",row.names=TRUE,sep='\t')



