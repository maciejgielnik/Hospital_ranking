


rankall <- function(outcome, num = "best") {
        library(rlist)
        library(plyr)
        
        read_file <- read.csv("outcome-of-care-measures.csv", na.strings = "Not Available")
        criterion <- as.character(outcome)
        outcome_list <- c('heart attack', 'heart failure', 'pneumonia')
        
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
                
                ##List for loop
                states <- as.matrix(summary(read_file$State))
                state_names <- rownames(states)
                loop_list <- data.frame(1:54, state_names)
                i <- 1
                output1 <- NULL
                
                ##State iteration
                while (i < 55) {
                        state_iteration <- as.character( loop_list[[i, 2]])
                        state_expr <- NULL
                        
                        state_expr <- list.match(split_df, state_iteration)
                        state_df <- as.data.frame( state_expr, col.names = "")
                        sorted <- arrange(state_df, case, name)
                        length <-dim(sorted)[1]
                        one_to_length <- 1:length
                        sorted_ranks <- as.data.frame(  cbind(sorted, one_to_length))
                        
                        ##num argument is char
                        if (class(num) == class("character")){
                                
                                if (num == "best"){
                                        some_number <- 1
                                        output2 <- sorted_ranks[1, 1:2]
                                }
                                if (num == "worst"){
                                        some_number <- length
                                        output2 <- sorted_ranks[some_number, 1:2]
                                }
                        } 
                        
                        ##num argument is numeric 
                        if (class(num) == class(9.4)) {   
                                
                                if (num > length){
                                        name <- NA
                                        state_name <- as.character(sorted_ranks[1,2])
                                        output2 <- cbind(name, state_name)
                                }
                                if (num <= length){
                                        some_number <- num
                                        output2 <- sorted_ranks[some_number, 1:2]
                                }
                        }

                        output1 <- rbind(output1, output2)
                        i <- i+1
                }
                output1

        }else {
                stop(("invalid outcome"))
        }
}
