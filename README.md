# Hospital_ranking
Functions use data from the Hospital Compare web site runed by the U.S. Department of Health and Human Services. 
The purpose of the web site was to provide data andinformation about the quality of care at over 4,000 
Medicare-certified hospitals in the U.S. This dataset essentially covers all major U.S. hospitals. Functions use

* outcome-of-care-measures.csv: Contains information about 30-day mortality and readmission rates for heart attacks, 
heart failure, and pneumonia for over 4,000 hospitals

Additional file 
* hospital-data.csv: Contains information about each hospital

### best function
Takes two arguments: the 2-character abbreviated name of a state and an
outcome name. The function reads the outcome-of-care-measures.csv file and returns a character vector
with the name of the hospital that has the best (i.e. lowest) 30-day mortality for the specified outcome
in that state. The hospital name is the name provided in the Hospital.Name variable. The outcomes can
be one of “heart attack”, “heart failure”, or “pneumonia”. Hospitals that do not have data on a particular
outcome should be excluded from the set of hospitals when deciding the rankings. The function should check t
he validity of its arguments. If an invalid state value is passed to best, the
function should throw an error via the stop function with the exact message “invalid state”. If an invalid
outcome value is passed to best, the function should throw an error via the stop function with the exact
message “invalid outcome”.
best_examples.R contains some input examples.

### rankhospital function
Takes three arguments: the 2-character abbreviated name of a
state (state), an outcome (outcome), and the ranking of a hospital in that state for that outcome (num).
The function reads the outcome-of-care-measures.csv file and returns a character vector with the name
of the hospital that has the ranking specified by the num argument. 
The num argument can take values “best”, “worst”, or an integer indicating the ranking
(smaller numbers are better). If the number given by num is larger than the number of hospitals in that
state, then the function should return NA. Hospitals that do not have data on a particular outcome should
be excluded from the set of hospitals when deciding the rankings.
The function should check the validity of its arguments. If an invalid state value is passed to rankhospital,
the function should throw an error via the stop function with the exact message “invalid state”. If an invalid
outcome value is passed to rankhospital, the function should throw an error via the stop function with
the exact message “invalid outcome”.
rankhospital_examples.R contains some input examples.

### rankall function
Takes two arguments: an outcome name (outcome) and a hospital ranking (num). 
The function reads the outcome-of-care-measures.csv file and returns a 2-column data frame
containing the hospital in each state that has the ranking specified in num. For example the function call
rankall("heart attack", "best") would return a data frame containing the names of the hospitals that
are the best in their respective states for 30-day heart attack death rates. The function should return a value
for every state (some may be NA). The first column in the data frame is named hospital, which contains
the hospital name, and the second column is named state, which contains the 2-character abbreviation for
the state name. Hospitals that do not have data on a particular outcome should be excluded from the set of
hospitals when deciding the rankings.
The function should check the validity of its arguments. If an invalid outcome value is passed to rankall,
the function should throw an error via the stop function with the exact message “invalid outcome”. The num
variable can take values “best”, “worst”, or an integer indicating the ranking (smaller numbers are better).
If the number given by num is larger than the number of hospitals in that state, then the function should
return NA.
rankall_examples.R contains some input examples.
