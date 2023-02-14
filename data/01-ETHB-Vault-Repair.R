#' 1,035 ETH B Vaults are identified prior to the block height
#' This query reads from 00-ETHB-Vault-Identification.R
#' and repairs a few known hexcode issues 


ethb <- read.csv("ETH_B_History.csv", colClasses = 'character', row.names = NULL)

# Fill in missing Vault Numbers ----
ethb[ethb$VAULT_NUMBER == "", "VAULT_NUMBER"] <- {
  
  strtoi(
    paste0("0x", 
           gsub("\\[\n  \"|\\\"\\\n\\]", "", ethb[ethb$VAULT_NUMBER == "", "SEGMENTED_OUTPUT"]))
  )
  
}

# Confirm FROM_ADDRESS = Output address ----

ethb$from_ouput <- {
  gsub("000000000000000000000000", "0x",
       x =  gsub(
         pattern = "\\[\n  \"4554482d42000000000000000000000000000000000000000000000000000000\",\n  \\\"|\\\"\\\n\\]",
         replacement = "", 
         x = ethb$SEGMENTED_INPUT)
  )
}

# All 1,035 FROM address match inputs ---- 
table(
ethb$FROM_ADDRESS == ethb$from_ouput
)

# Write local select columns 
write.csv(ethb[, c("TX_HASH","BLOCK_NUMBER","BLOCK_TIMESTAMP","FROM_ADDRESS","ILK","VAULT_NUMBER")],
          "ETH_B_History_Repaired.csv", row.names = FALSE)
