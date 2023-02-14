#' 1,035 ETH B Vaults are identified prior to the block height
#' This query uses Vault numbers from 01-ETHB-Vault-Repair.R
#' It includes a query to match Vault numbers to ETHB Dai Repayments

library(jsonlite)

repay_input <- fromJSON(
  '[
  "0000000000000000000000005ef30b9986345249bc32d8928b7ee64de9435e39",
  "0000000000000000000000009759a6ac90977b93b58547b4a71c78317f391a28",
  "0000000000000000000000000000000000000000000000000000000000003efb",
  "000000000000000000000000000000000000000000000006c6b935b8bbd40000",
  "00000000000000000000000025d38c668f01e23fdc5195e08a96afca770428c9"
]'
)

vault <- as.numeric(paste0("0x", repay_input[3]))
repay_amount_dai <- as.numeric(paste0("0x", repay_input[4]))/1e18
