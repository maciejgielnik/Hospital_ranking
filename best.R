


best <- function(state , outcome) {
  library(rlist)
  library(plyr)
  
## initial parameters      
  states <- NULL
  col_for_analysis <- NULL
  criterion <- as.character(outcome)
  state_name <- as.character(state)
  
  read_file <- read.csv("outcome-of-care-measures.csv", na.strings = "Not Available")
  states <- as.matrix(summary(read_file$State))
  state_names <- rownames(states)
  state_name_check <- state_name %in% state_names
  outcome_list <- c('heart attack', 'heart failure', 'pneumonia')
 
  ##Check correct state name
  if( state_name_check ==  TRUE) {
    
    ##Check correct outcome name
    if ((criterion %in% outcome_list) == TRUE){

      ## Select column for analysis  
      if (criterion == 'heart attack') {
        col_for_analysis <- 11
      }
      if (criterion == 'heart failure') { 
        col_for_analysis <- 17
      }
      if (criterion == 'pneumonia') {   
        col_for_analysis <- 23
      }
            
      ##Selecting columns and reducing data frame
      col1 <-  data.frame("name"  = read_file[, 2])
      col2 <-  data.frame("state_name"  = read_file[, 7])
      col3 <-  data.frame("case"  = read_file[, col_for_analysis])
      reduced_df <- cbind(col1, col2, col3)
      complete_df <- reduced_df[complete.cases(reduced_df),]

      split_df <- split(complete_df, complete_df$state_name)
      state_split <- list.match(split_df, state_name)
      state_split_df <- as.data.frame( state_split, col.names = "")
      sorted <- arrange(state_split_df, case)


      minimum <- sorted[1, 3]
      final <- NULL
      final <- as.data.frame(  subset(sorted, sorted$case == minimum ))
      final2 <- arrange(final, name)
      final3 <- as.matrix(final2)
      print(as.character( final3[1,1]))
        }else {
         stop(("invalid outcome"))
        }
    
  } else {
    stop(("invalid state"))
  }
}
