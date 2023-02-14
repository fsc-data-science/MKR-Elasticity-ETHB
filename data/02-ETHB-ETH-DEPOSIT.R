#' 1,035 ETH B Vaults are identified prior to the block height
#' This query uses Vault numbers from 01-ETHB-Vault-Repair.R
#' It includes a query to match Vault numbers to ETH Deposit Histories

library(jsonlite)

ethb <- read.csv("ETH_B_History_Repaired.csv",
                 colClasses = "character", row.names = NULL)

deposit_input <- fromJSON('["0000000000000000000000000000000000000000000000000000000000003efb",
                          "000000000000000000000000000000000000000000000000058d15e176280000",
                          "00000000000000000000000000000000000000000000000680135ff579a1ede8"]')

# Vault 16123 
as.numeric(paste0("0x", deposit_input))
