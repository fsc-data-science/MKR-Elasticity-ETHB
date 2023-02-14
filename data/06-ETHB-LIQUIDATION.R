#' 1,035 ETH B Vaults are identified prior to the block height
#' This query uses Vault numbers from 01-ETHB-Vault-Repair.R
#' It includes a query to match Vault numbers to ETHB Liquidations


library(wkb)
hex_to_string <- function(hex){
  
  hex_raw <- wkb::hex2raw(hex)
  text <- rawToChar(as.raw(strtoi(hex_raw, 16L)))
  return(text)
}

liquidation_input <- fromJSON('
                              [
  "0000000000000000000000000000000000000000000000000000000000001185",
  "00000000000000000000000000000000000000000000000000000000036e2625",
  "0000000000000000000000000000000000000000000000000000000000001ca9",
  "0000000000000000000000004bb75f6b2325d393518a452f0102dd7b6c135429",
  "0000000000000000000000002c9b95cba69195a480db776d782d233ed4010033"
]
                              ')

for(i in liquidation_input){
  print(i)
  print(tryCatch(as.numeric(paste0("0x", i)), error = function(e){"not a number"}))
  print(tryCatch(hex_to_string(i), error = function(e){"not a string"}))
}


