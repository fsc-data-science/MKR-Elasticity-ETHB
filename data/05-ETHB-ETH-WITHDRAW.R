#' 1,035 ETH B Vaults are identified prior to the block height
#' This query uses Vault numbers from 01-ETHB-Vault-Repair.R
#' It includes a query to match Vault numbers to ETHB ETH Withdrawals


withdraw_input <- fromJSON('[
  "0000000000000000000000000000000000000000000000000000000000003efb",
  "00000000000000000000000025d38c668f01e23fdc5195e08a96afca770428c9",
  "0000000000000000000000000000000000000000000000000494654067e10000"
]
')

as.numeric(paste0("0x", withdraw_input[1]))
