# Getting-and-Cleaning-Data-Project-1
## Script Description
1) Lines 15-17 download the file, and unzip it
2) Lines 19-29 read all tables of the data set given by Samsung
3) Lines 42-44 merge train and test datasets with their other related subdatasets and then mergest both full datasets
4) Lines 47-52 subset the specifc MEAN and STD columns requested by the tidy set
4) Lines 54-60 make those variable names tidy-complaint (cleaning symbols such as -, (),and ","
5) Lines 63-68 subsets the columns of interest and change the names to the tidy compliant names
6) Line 71 merges with activity labels so as to add the WALKING, etc easy-to-read column
7) Line 77- 80 remove the actividyid column and rearranges columns to let the activity label at the beginning of the table
8) Line 84-90 generate the summary as requested and writes the table into a TEXT file

##Code Book:
The dataset includes the following files:

- 'README.md'

- 'avgtidy.txt': Shows information about the variables used on the feature vector.

For each record it is provided:
- Average and Standard Deviation of Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Average and Standard Deviation of Triaxial Angular velocity from the gyroscope. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.


Notes: 

- Features are normalized and bounded within [-1,1].
