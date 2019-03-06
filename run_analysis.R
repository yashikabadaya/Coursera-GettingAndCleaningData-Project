#Reading training tables
xtrain = read.table(file.path(pathdata, "train", "X_train.txt"), header = FALSE)
ytrain = read.table(file.path(pathdata, "train", "y_train.txt"), header = FALSE)
subject_train = read.table(file.path(pathdata, "train", "subject_train.txt"), header = FALSE)

#Reading testing tables
xtest = read.table(file.path(pathdata, "test", "x_test.txt"), header = FALSE)
ytest = read.table(file.path(pathdata, "test", "y_test.txt"), header = FALSE)
subject_test = read.table(file.path(pathdata, "test", "subject_test.txt"), header = FALSE)

#Read features data
features = read.table(file.path(pathdata, "features.txt"), header = FALSE)

#Read activity labels data
activityLabels = read.table(file.path(pathdata, "activity_labels.txt"), header = FALSE)

colnames(xtrain) = features[,2]
colnames(ytrain) = "activityId"
colnames(subject_train) = "subjectId"

colnames(xtest) = features[,2]
colnames(ytest) = "activityId"
colnames(subject_test) = "subjectId"

colnames(activityLabels) <- c('activityId', 'activityType')

#Part 1 of project
#Merging test and train data
final_training_set = cbind(subject_train, xtrain, ytrain)
final_test_set = cbind(subject_test, xtest, ytest)

#joining dataframes vertically using rbind
merged_set = rbind(final_training_set, final_test_set)

#Part 2 of project
allColNames = colnames(merged_set)

#grpl  which returns TRUE when a pattern
#is found in the corresponding character string.
#grabbing all the columns in merged_set which is activityId, subjectId and all columns related to mean and std
mean_and_std = (grepl("activityId", allColNames)| grepl("subjectId", allColNames)| grepl("mean..", allColNames)| grepl("std..", allColNames))

MeanandStdColsOnly <- merged_set[, mean_and_std == TRUE]

#Part 3 of Project
setWithActivityNames = merge(MeanandStdColsOnly, activityLabels, by='activityId', all.x=TRUE)

#Part 4 of Project
#Variable Names already given

#Part 5 of Project
#Aggregate Splits the data into subsets, computes summary statistics for each, and returns the result
#in a convenient form.
#Creates a tidy dataset that consists of the average (mean) value of each variable for each 
#subject and activity pair.
TidySet1 <- aggregate(. ~subjectId + activityId, setWithActivityNames, mean)
TidySet <- TidySet1[order(secTidySet$subjectId, secTidySet$activityId),]
write.table(TidySet, "TidySet.txt", row.name=FALSE)



 