#Read test datasets
x_test <- read.table("C:/Users/LENOVO/Desktop/Data_Science/UCIHARDataset/test/X_test.txt",header = FALSE)
y_test <- read.table("C:/Users/LENOVO/Desktop/Data_Science/UCIHARDataset/test/y_test.txt",header = FALSE)
subject_test <- read.table("C:/Users/LENOVO/Desktop/Data_Science/UCIHARDataset/test/subject_test.txt", header = FALSE)

#Read train Datasets
x_train <- read.table("C:/Users/LENOVO/Desktop/Data_Science/UCIHARDataset/train/X_train.txt",header = FALSE)
y_train <- read.table("C:/Users/LENOVO/Desktop/Data_Science/UCIHARDataset/train/y_train.txt",header = FALSE)
subject_train <- read.table("C:/Users/LENOVO/Desktop/Data_Science/UCIHARDataset/train/subject_train.txt", header = FALSE)

# Read the Feature data
feature <- read.table("C:/Users/LENOVO/Desktop/Data_Science/UCIHARDataset/features.txt",header = FALSE)

#Read Activity lable
activity_lable <- read.table("C:/Users/LENOVO/Desktop/Data_Science/UCIHARDataset/activity_labels.txt",header = FALSE)



#Set the coloumn names to all data sets 
colnames(x_test) <- feature[,2]
colnames(y_test) <- "ActivityId"
colnames(subject_test) <- "SubjectId"

colnames(x_train) <- feature[,2]
colnames(y_train) <- "ActivityId"
colnames(subject_train) <- "SubjectId"

colnames(activity_lable) <- c("ActivityId","Activity_type")

#merge all train & test data
data_test <- cbind(y_test,subject_test,x_test)

data_train <- cbind(y_train,subject_train,x_train)

data <- rbind(data_train,data_test)

# Get character vector of all the coloumn names of data file

column <- colnames(data)

#take all the  needed colnames

req_col <- (grepl("ActivityId" , column) | grepl("SubjectId" , column) | grepl("mean.." , column) | grepl("std.." , column))

#set the column details to reqiured data 

req_data <- data[,req_col == TRUE]

# merge data set by activityId

merged_data <- merge(req_data, activity_lable, by ='ActivityId', all.x = TRUE)

# removing Non Numeric Data Columns such as Activity_ID , Activity Name
merged_data <- merged_data[,1:81]

# agrregate data 
aggregate_data <- aggregate(.~ SubjectId + ActivityId , data = merged_data, mean)

#Sort by ascending order of SubjectId & ActivityId
aggregate_data <- aggregate_data[order(aggregate_data$SubjectId, aggregate_data$ActivityId),]

#Export .txt file as output
output <- write.table(aggregate_data, "output.txt", row.name=FALSE)