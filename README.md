# Getting-and-Cleaning-Data-Course-Project
## run_analysis.R

The purpose of this script is to read the input files and manipulate the data and create a tidy dataset with the averages of the mean and standard deviations measurements by activity and by subject (individual who participated in the Human activity recognition experiment.

This script was saved in the folder where “UCI HAR Dataset” folder is under. 
The input files came from this link:
	https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip.

The full description of the data can be read here:
	http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

The data came from a series of experiments where 30 individuals (subjects) performed 6 activities (walking, walking upstairs, walking downstairs , sitting, standing and laying wearing a smartphone with a accelerometer and a gyroscope app.

Below are the 4 parts defined in the script. These parts were ordered in the sequence they run.

1. run_analysis - It is the main function where the sub functions are called.
2. read_files - It reads all data file and stores them to a table.
3. build_datasets -This is where column names are assigned and datasets get assembled. Having column names after the tables get created helped in testing and debugging this script.
	- Below is the sequence of building the Test and Train datasets.
		-a. combine the test activities from y_test to its corresponding activity label
		-b. add subject numbers (A subject number represents an individual who did the activity)
		-c. add features measurements (561 measurements per test activity)
		-d. add 128 readings/window for each Inertial signal
			body_acc_x_test
			body_acc_y_test
			body_acc_z_test
			body_gyro_x_test
			body_gyro_y_test
			body_gyro_z_test
			total_acc_x_test
			total_acc_y_test
			total_acc_z_test
		-e. build Training data (from steps a. to d.)
		-f. combine Test and Training data into 1 dataset

4. get average - This is where the mean and standard deviation columns get extracted from the big dataset. Then an average is computed for each of this measurement by Activity and another average is computed by Subject (an individual).

	- Below are the steps done in the function:
		-a. get the column names that contain “mean” and “std” from the list of feature columns
		-b. extract the mean and standard deviation columns along with activity and subject fields from the dataset
		-c. rename measurement names into a generic name. This will be used for the average computation.
		-d. compute average for each measurement (86) by activity
		-e. compute average for each measurement (86) by subject
		-f. combine the averages by activity and subject into one dataset
		-g. rename the measurement columns with “Ave” as a prefix and with its specific feature measurement name
		-h. write the average dataset into a text file
