### Program: run_analysis.R
### Date Written: 25 January 2015
### Author: Jdata Scientist

run_analysis <- function() {
	
	### This is the main function
	library(dplyr)
	library(data.table)
	options(warn=-1)
	
	read_files()
	build_datasets ()		
	get_average()
}

read_files <- function(){
	
	### Read files into tables
	
	activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")

	features <- read.table("./UCI HAR Dataset/features.txt")
	
	subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")

	X_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
	
	y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
	
	body_acc_x_test <- read.table("./UCI HAR Dataset/test/Inertial Signals/body_acc_x_test.txt")

	body_acc_y_test <- read.table("./UCI HAR Dataset/test/Inertial Signals/body_acc_y_test.txt")
	
	body_acc_z_test <- read.table("./UCI HAR Dataset/test/Inertial Signals/body_acc_z_test.txt")
	
	body_gyro_x_test <- read.table("./UCI HAR Dataset/test/Inertial Signals/body_gyro_x_test.txt")
	
	body_gyro_y_test <- read.table("./UCI HAR Dataset/test/Inertial Signals/body_gyro_y_test.txt")
	
	body_gyro_z_test <- read.table("./UCI HAR Dataset/test/Inertial Signals/body_gyro_z_test.txt")

	total_acc_x_test <- read.table("./UCI HAR Dataset/test/Inertial Signals/total_acc_x_test.txt")
	
	total_acc_y_test <- read.table("./UCI HAR Dataset/test/Inertial Signals/total_acc_y_test.txt")
	
	total_acc_z_test <- read.table("./UCI HAR Dataset/test/Inertial Signals/total_acc_z_test.txt")
	
	subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
	colnames(subject_train) <- c("Subject_Nmbr")
	
	X_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
	colnames(X_train) <- features$Feature

	y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
	colnames(y_train) <- c("Activity_Nmbr")
	
	body_acc_x_train <- read.table("./UCI HAR Dataset/train/Inertial Signals/body_acc_x_train.txt")
	
	body_acc_y_train <- read.table("./UCI HAR Dataset/train/Inertial Signals/body_acc_y_train.txt")

	body_acc_z_train <- read.table("./UCI HAR Dataset/train/Inertial Signals/body_acc_z_train.txt")
	
	body_gyro_x_train <- read.table("./UCI HAR Dataset/train/Inertial Signals/body_gyro_x_train.txt")
	
	body_gyro_y_train <- read.table("./UCI HAR Dataset/train/Inertial Signals/body_gyro_y_train.txt")
	
	body_gyro_z_train <- read.table("./UCI HAR Dataset/train/Inertial Signals/body_gyro_z_train.txt")

	total_acc_x_train <- read.table("./UCI HAR Dataset/train/Inertial Signals/total_acc_x_train.txt")
	
	total_acc_y_train <- read.table("./UCI HAR Dataset/train/Inertial Signals/total_acc_y_train.txt")
	
	total_acc_z_train <- read.table("./UCI HAR Dataset/train/Inertial Signals/total_acc_z_train.txt")

}

build_datasets <- function(){
	### Build Datasets
	
	### Build Column names
	colnames(activity_labels) <- c("Activity_Nmbr", "Activity")
	colnames(features) <-c("Feature_Nmbr", "Feature")
	colnames(subject_test) <- c("Subject_Nmbr")
	colnames(X_test) <- features$Feature
	colnames(y_test) <- c("Activity_Nmbr")
	
	reading_vector <- replicate(128, "Reading_")
	nmbr_vector <- c(1:128)
	reading_columns <- paste(reading_vector, nmbr_vector, sep = "")

	body_acc_x_cols <- paste(replicate(128, "Body_Acc_X_"), reading_columns, sep = "")
	
	body_acc_y_cols <- paste(replicate(128, "Body_Acc_Y_"), reading_columns, sep = "")
	
	body_acc_z_cols <- paste(replicate(128, "Body_Acc_Z_"), reading_columns, sep = "")
	
	body_gyro_x_cols <- paste(replicate(128, "Body_Gyro_X_"), reading_columns, sep = "")
	
	body_gyro_y_cols <- paste(replicate(128, "Body_Gyro_Y_"), reading_columns, sep = "")

	body_gyro_z_cols <- paste(replicate(128, "Body_Gyro_Z_"), reading_columns, sep = "")
	
	total_acc_x_cols <- paste(replicate(128, "Total_Acc_X_"), reading_columns, sep = "")
	
	total_acc_y_cols <- paste(replicate(128, "Total_Acc_Y_"), reading_columns, sep = "")

	total_acc_z_cols <- paste(replicate(128, "Total_Acc_Z_"), reading_columns, sep = "")
	
	### Assign Column names to Appropriate Test tables
	
	colnames(body_acc_x_test) <- body_acc_x_cols

	colnames(body_acc_y_test) <- body_acc_y_cols
 	 
	colnames(body_acc_z_test)  <- body_acc_z_cols
 	
 	colnames(body_gyro_x_test) <- body_gyro_x_cols

	colnames(body_gyro_y_test) <- body_gyro_y_cols

	colnames(body_gyro_z_test) <- body_gyro_z_cols

	colnames(total_acc_x_test) <- total_acc_x_cols

	colnames(total_acc_y_test) <- total_acc_y_cols
	
	colnames(total_acc_z_test) <- total_acc_z_cols

	
	### Assign Column names to Appropriate Train tables

	colnames(body_acc_x_train) <- body_acc_x_cols

	colnames(body_acc_y_train) <- body_acc_y_cols
 	 
	colnames(body_acc_z_train)  <- body_acc_z_cols
 	
 	colnames(body_gyro_x_train) <- body_gyro_x_cols

	colnames(body_gyro_y_train) <- body_gyro_y_cols

	colnames(body_gyro_z_train) <- body_gyro_z_cols

	colnames(total_acc_x_train) <- total_acc_x_cols

	colnames(total_acc_y_train) <- total_acc_y_cols
	
	colnames(total_acc_z_train) <- total_acc_z_cols
	
	### Build Test data	
	activity_desc_test <- merge(y_test, activity_labels, by = "Activity_Nmbr", all.x = TRUE, sort = FALSE)
	
	activity_test <- cbind(activity_desc_test, replicate(nrow(y_test), "TEST"))
	colnames(activity_test)[3] <- "Type"
	
	activity_test2 <- cbind(activity_test, subject_test)

	### Combine Features Measurements with the rest
	activity_test3 <- cbind(activity_test2, X_test)

	### Combine 128 Readings from Inertial signals with the rest 
	activity_test4 <- cbind(activity_test3, body_acc_x_test, body_acc_y_test, body_acc_z_test, body_gyro_x_test, body_gyro_y_test, body_gyro_z_test, total_acc_x_test, 
		total_acc_y_test, total_acc_z_test)
	## [1] 2947 1717
	
	
	### Build Train data
	
	activity_desc_train <- merge(y_train, activity_labels, by = "Activity_Nmbr", all.x = TRUE, sort = FALSE)
	
	activity_train <- cbind(activity_desc_train, replicate(nrow(y_train), "TRAINING"))
	colnames(activity_train)[3] <- "Type"
	## 7352    3
	
	activity_train2 <- cbind(activity_train, subject_train)
	## [1] 7352    4

	### Combine Features Measurements with the rest
	activity_train3 <- cbind(activity_train2, X_train)


	### Combine 128 Readings from Inertial signals with the rest 
	activity_train4 <- cbind(activity_train3, body_acc_x_train, body_acc_y_train, body_acc_z_train, body_gyro_x_train, body_gyro_y_train, body_gyro_z_train, total_acc_x_train, 
		total_acc_y_train, total_acc_z_train)
	## [1] 7352 1717
	
	
	### Combine Test and Training Data

	activity_all <- rbind(activity_test4, activity_train4)
	## [1] 10299  1717
}

get_average <- function(){
	### Manipulate Data
	
	### Look for mean and standard deviation columns from features
	extract_cols <- as.vector(features[grepl("mean", features$Feature, ignore.case = TRUE) | grepl("std", features$Feature, ignore.case = TRUE), 2])

	### Get the mean and standard deviation columns from the data set along with activity and subject columns	
	extract_mean_std <- cbind(activity_all[, 1:4], subset(activity_all, select = extract_cols))
	## [1] 10299    90

	### Get Average by Activity
	
	ems <- extract_mean_std
	
	### Rename column names in such a way it would work with the mean function
	
	measure_pre <- replicate(86, "Measure_")
	nmbr_to86 <- c(1:86)
	measure_col <- paste(measure_pre, nmbr_to86, sep = "")
	colnames(ems)[5:90] <- measure_col
	
	ems_a <- cbind(ems[, 2], ems[, 5:90])
	colnames(ems_a)[1] <- c("Activity")
	
	### Compute Average by Activity
	
	ems_a_dt <- as.data.table(ems_a)
	ave_by_activity <- ems_a_dt [, lapply(.SD, mean), by=list(Activity)]
	colnames(ave_by_activity)[2:87] <- extract_cols
	colnames(ave_by_activity)[1] <- c("Activity/Subject")
	
	### Get Average by Subject
	
	ems_s <- cbind(ems[, 4], ems[, 5:90])
	colnames(ems_s)[1] <- c("Subject")	
	
	### Compute Average by Subject
	ems_s_dt <- as.data.table(ems_s)
	ave_by_subject <- ems_s_dt [, lapply(.SD, mean), by=list(Subject)]
	
	colnames(ave_by_subject)[2:87] <- extract_cols
	colnames(ave_by_subject)[1] <- c("Activity/Subject")
	
	### Combine Average by Activity and Average by Subject into 1 dataset
	
	ave_by_act_sub <- rbind(ave_by_activity, ave_by_subject)
	
	ave_pre <- replicate(86, "Ave_")
	ave_col <- paste(ave_pre, extract_cols, sep = "")
	colnames(ave_by_act_sub)[2:87] <- ave_col
	
	### Write Aeverage by Activity and Subject dataset into a text file
	
	write.table(ave_by_act_sub, file = "./Human_Activity_Data.txt", row.names = FALSE)
}

