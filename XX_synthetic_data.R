#' While maker architecture is rebuilt, this synthetic data is used to develop (and test)
#' key functions, visualizations, etc.


set.seed(4)
n = 10000
vaults <- sample(1:500, size = n, replace = TRUE)

ethb <- data.frame(
  vault_number = vaults, 
  block_number = rep(0, n),
  deposits = rep(0, n),
  mints = rep(0, n),
  repay = rep(0, n),
  withdraws = rep(0, n)
)

ethb <- ethb[order(ethb$vault_number), ]
vault_history <- ethb[ethb$vault_number == 1, ]

artificial_history <- function(vault_history, seed = 40){

set.seed(seed)
vault_history$deposits[1] <- sample(c(1:10, 50), size = 1)
rest_of_rows <- 2:nrow(vault_history)
vault_history$deposits[rest_of_rows] <- sample(c(0, 0, 0, 5, 5, 10, 10, 100), 
                                                   size = length(rest_of_rows), 
                                                   replace = TRUE)

# this is chaotic and may withdraw more than ever deposited, will be dropped
vault_history$withdraws[rest_of_rows] <- sample(c(0, 0, 0, 3, 3, 5, 5, 10, 50, 100), 
                                                size = length(rest_of_rows),
                                                replace = TRUE)

# for ease, mints happen during deposits 
vault_history$mints <- sample(c(0,0, 25, 50, 100), size = nrow(vault_history),
                              replace = TRUE) * vault_history$deposits
  
# slightly larger b/c revenue 
vault_history$repay <- sample(c(0,0, 10, 30, 55, 110), size = nrow(vault_history),
                              replace = TRUE) * vault_history$deposits
# never repay in first block
vault_history$repay[1] <- 0

vault_history$block_number = sort(sample(100:1000, size = nrow(vault_history), replace = FALSE), decreasing = FALSE)

# we sampled enough to remove bad rows. 

# remove impossible rows
vault_history$cumulative_deposits <- cumsum(vault_history$deposits)
vault_history <- vault_history[!(vault_history$withdraws >= vault_history$cumulative_deposits), ]

# if it randomly gets empty return NULL
if(nrow(vault_history) == 0){
  return(NULL)
}

# can't repay if never minted 
vault_history$cumulative_mints <- cumsum(vault_history$mints)
vault_history$cumulative_repay <- cumsum(vault_history$repay)

# no >100%+ interest rates lol
vault_history <- vault_history[!(vault_history$cumulative_repay >= 2*vault_history$cumulative_mints), ]

# if it randomly gets empty return NULL
if(nrow(vault_history) == 0){
  return(NULL)
}


# recalculate all 

# never repay or withdraw in first block
vault_history$repay[1] <- 0
vault_history$withdraws[1] <- 0
vault_history$cumulative_deposits <- cumsum(vault_history$deposits)
vault_history$cumulative_withdraws <- cumsum(vault_history$withdraws)
vault_history$cumulative_mints <- cumsum(vault_history$mints)
vault_history$cumulative_repay <- cumsum(vault_history$repay)

# return it 
print(seed)
return(vault_history)
}

vault_list <- split(ethb, f = ethb$vault_number)

vault_list <- lapply(vault_list, function(x){
  artificial_history(x, seed = x$vault_number[1])
})

vault_list <- vault_list[!unlist(lapply(vault_list, is.null))]

ethb_vaults <- do.call(rbind.data.frame, vault_list)

write.csv(ethb_vaults, file = "synthetic_vault_data.csv", row.names = FALSE)
