# Getting-and-Cleaning-Data-Prog-Course-3


This script depends on the reshape2 library. Please make sure to install this library before using.


1) Download R script

2) Set working directory to the UCI HAR Dataset directory

3) Run script

4) Tidy dataset is in the home directory of the UCI HAR Dataset directory


This script works first by merging the training and the testing datasets.
Next, the activity labels are binded as a column to the merged dataset.
The variables of the dataset are then named.
After naming the variables, measurements only for mean and std are extracted.
Lastly, reshape2 helps in tidying the dataset, which gives us the average of each variable for each activity and each subject.
