


rankhospital <- function(state , outcome, num = "best") {
        library(rlist)
        library(plyr)
        
        states <- NULL
        col_for_analysis <- NULL
        criterion <- as.character(outcome)
        state_name <- as.character (state)
        read_file <- read.csv("outcome-of-care-measures.csv", na.strings = "Not Available")
        states <- as.matrix(summary(read_file$State))
        state_names  <- rownames(states)
        state_check <- state_name %in% state_names 

        ##Check correct state name
        outcome_list <- c('heart attack', 'heart failure', 'pneumonia')
        if( state_check ==  TRUE) {

                ##Check correct outcome
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
                        sorted <- arrange(state_split_df, case, name)

                        ##Adding ranks
                        df_length <-dim(sorted)[1]
                        ranks <- 1:df_length
                        ranks_sorted <- as.matrix(  cbind(sorted, ranks))

                        ##Third argument conditions
                        ##Check if num is char
                        if (class(num) == class("character")){
                                if (num == "worst"){
                                        last_number <- df_length
                                        print( as.character(   ranks_sorted[last_number, 1]))
                                }
                                if (num == "best"){
                                        last_number <- 1
                                        print( as.character(  ranks_sorted[last_number, 1]))
                                } else {
                                        stop(("Invalid spelling. Type best or worst." ))
                                }
                        } 
                        ##Check if num is number
                        if (class(num) == class(9.4)) {   
                                
                                if (num > df_length){
                                        print(NA)
                                }
                                if (num <= df_length){
                                        last_number <- num
                                        print( as.character(  ranks_sorted[last_number, 1]))
                                }
                        }
  
                }else {
                        stop(("invalid outcome"))
                }
        } else {
                stop(("invalid state"))
        }
}
