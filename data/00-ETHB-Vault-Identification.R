library(shroomDK)
api_key <- readLines("api_key.txt")


#' This is not the most efficient way to get ilk identification, 
#' but it successfully identifies 1,035 ETH B vaults; with a few Vault Number 
#' issues that has to be decoded separately.

ethb_vault_query <- {
  "
/*Return: 
TX_HASH, BLOCK_NUMBER, BLOCK_TIMESTAMP, FROM_ADDRESS, SEGMENTED_INPUT, ILK, VAULT_NUMBER

Confirm FROM_ADDRESS and segmented_input[1] are the same;
ilks are ETH-B.
*/

-- Full query: 700s+ 

with base as (
select *,
regexp_substr_all(SUBSTR(input, 11, len(input)), '.{64}') AS segmented_input,
regexp_substr_all(SUBSTR(output, 3, len(output)), '.{64}') AS segmented_output
from ethereum.core.fact_traces
where
-- Maker CDP 
TO_ADDRESS = '0x5ef30b9986345249bc32d8928b7ee64de9435e39'
-- function call is .open() | newCDP
and left(input,10) IN (
'0x6090dec5',
'0xd6be0bc1'
) 
AND TX_STATUS = 'SUCCESS' AND 
BLOCK_NUMBER <= 16540000
),

initial_results AS (
select 
*,
try_hex_decode_string(segmented_input[0]::string) as ilk,
ethereum.public.udf_hex_to_int(segmented_output[0]::string)::integer as vault_number
from base
-- ETH B 
WHERE left(segmented_input[0]::string, 10) = '4554482d42'
order by vault_number asc
)

SELECT TX_HASH, BLOCK_NUMBER, BLOCK_TIMESTAMP, FROM_ADDRESS, SEGMENTED_INPUT, SEGMENTED_OUTPUT, ILK, VAULT_NUMBER
FROM initial_results
WHERE vault_number IS NOT NULL
  "
}


ethb <- auto_paginate_query(ethb_vault_query, api_key)

write.csv(ethb, "ETH_B_History.csv", row.names = FALSE)
