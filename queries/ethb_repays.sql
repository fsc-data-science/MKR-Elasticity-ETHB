-- This query aligns to Maker ETHB Elasticity Report 
-- https://science.flipsidecrypto.xyz/mkr_ethb_viz
-- https://flipsidecrypto.xyz/edit/queries/f9f297bc-8222-46fa-bdce-a5becaaa5c87

with vault_urn AS (
SELECT VAULT_NUMBER,  URN_ADDRESS 
  FROM ETHEREUM.MAKER.EZ_VAULT_CREATION
  WHERE startswith(COLLATERAL_TYPE, 'ETH-B') 
    AND BLOCK_NUMBER <= 16400000
),

-- can't get ilk from mints/repays directly
deposit_based_ilk AS (
SELECT DISTINCT  ILK, U_ADDRESS as urn_address, VAULT_NUMBER
 FROM ETHEREUM.MAKER.FACT_VAT_FROB 
INNER JOIN vault_urn ON ETHEREUM.MAKER.FACT_VAT_FROB.U_ADDRESS = vault_urn.URN_ADDRESS
WHERE DINK > 0 AND
startswith(ilk, 'ETH-B') AND BLOCK_NUMBER <= 16400000
),

-- urn : vault_number : ilk 
-- filter by correct ilk using dst_address = urn_address
--  if(urn=dst) repay; else if (urn = src) mint
repays AS (
SELECT TX_HASH, BLOCK_NUMBER, BLOCK_TIMESTAMP, 
 DST_ADDRESS as urn_address, VAULT_NUMBER,
 rad as amount_repaid
 FROM ethereum.maker.fact_vat_move INNER JOIN vault_urn 
 ON ethereum.maker.fact_vat_move.DST_ADDRESS = vault_urn.URN_ADDRESS
WHERE rad > 0 
 AND VAULT_NUMBER IN (SELECT VAULT_NUMBER FROM deposit_based_ilk) 
 AND BLOCK_NUMBER <= 16400000
)
    
-- DAI repayed is both debt change + paid fees
-- https://tracker-vaults.makerdao.network/vault/VAULT_NUMBER 
-- to double check a value.
SELECT BLOCK_NUMBER, BLOCK_TIMESTAMP,
 VAULT_NUMBER,
 amount_repaid as DAI_REPAYED
FROM repays  

