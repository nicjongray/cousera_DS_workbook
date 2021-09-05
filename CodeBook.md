# Code Book for run_analysis.R:
#### The following description outlines the steps involved with the code in the file "run_analysis.R". Each step has a coressponding step in the R script.

### Download all Data
- **Test Set**: This data is contained in the folder "UCI HAR Dataset/test/" and includes a results (X_test.txt) and the corresponding activity (y_test.txt) and subject (subject_test.txt) labels.

- **Train Set**: This data is contained in the folder "UCI HAR Dataset/train/" and includes a results (X_train.txt) and the corresponding activity (y_train.txt) and subject (subject_train.txt) labels.

- **Column Lables**: Additionally, download the dictionary of human readable names for the result data (*features.txt* )and activity labels (*activity_labels.txt*).

Rename column labels with feature dictionary, update the column names of the result (X set) data.


### 1. Merge train and test sets together: 
Combined the train and test data (keeping results and labels separate for now) using the row binding function which will preserve the order of the columns in each set - held in **DT_X/DT_y/DT_subject**. And remove the test and training data sets to free memory (optional).


### 2. Extract only required fields:
Extract the only labels of the columns with "mean" and "std", given in **mean_and_std**. Usin this, filter the **DT_X** dataset down to only the extracted columns.


### 3. Manipulate the column names into tidydata form: 
- make lower case
- change prefix (t and f) to clearer names (time and FFT)
- remove symbols
- add label for for subject set


### 4. Label activty id with name from data dictionary
Using the activity data dictionary extracted from *activity_labels.txt*, rename all the results columns with the corresponding human readable name.


Merge the results (X set) with the corresponding activity labels (y sets) and subject labels (subject set) to create **DT** which is used for the next step.


### 5. Average values for each activity and each subject
For second dataset, **DT_ave**, Group by the two identifier columns, then take the average of the numerical non-identifier columns.


### Write each data set to text file
- *Assignment_dataset.txt*: tidy dataset with aggregated values across all numerical columns grouped by each subject and each activity.




