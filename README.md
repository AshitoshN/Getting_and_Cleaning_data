# Getting_and_Cleaning_data

##Read test datasets

	The test variables are readed and stored in dataframes like - x_test, y_test, subject_test 


##Read train Datasets

	The train variables are readed and stored in dataframes like - x_train, y_train, subject_train 


## Read the Feature data

	features data set readed and stored in feature data frame
 

##Read Activity lable

Activity lable is readed and stored in activity_lable data frame


##Set the coloumn names to all data sets 
 
coloumn names for test and train data frames are assigned from feature & activity data frame

##merge all train & test data

	merged the test data in data_test data frame

	merged the train data in data_train data frame

	binding the data by row in data frame 

##Get character vector of all the coloumn names of data file

	column <- colnames(data)

##take all the  needed colnames

	req_col <- (grepl("ActivityId" , column) | grepl("SubjectId" , column) | grepl("mean.." , column) | grepl("std.." , column))

##set the column details to reqiured data 

	req_data <- data[,req_col == TRUE]

##merge data set by activityId

	merged_data <- merge(req_data, activity_lable, by ='ActivityId', all.x = TRUE)

##removing Non Numeric Data Columns such as Activity Name
	
	merged_data <- merged_data[,1:81]

##agrregate data 
	aggregate_data <- aggregate(.~ SubjectId + ActivityId , data = merged_data, mean)

##Sort by ascending order of SubjectId & ActivityId
	aggregate_data <- aggregate_data[order(aggregate_data$SubjectId, aggregate_data$ActivityId),]

##Export .txt file as output
	output <- write.table(aggregate_data, "output.txt", row.name=FALSE)