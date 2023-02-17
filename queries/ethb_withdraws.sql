-- This query aligns to Maker ETHB Elasticity Report 
-- https://science.flipsidecrypto.xyz/mkr_ethb_viz
-- https://flipsidecrypto.xyz/edit/queries/d838e2b1-4163-40a3-9c54-fe064f3b1351

with vault_urn AS (
SELECT VAULT_NUMBER,  URN_ADDRESS 
  FROM ETHEREUM.MAKER.EZ_VAULT_CREATION
  WHERE startswith(COLLATERAL_TYPE, 'ETH-B') 
AND BLOCK_NUMBER <= 16400000
),

withdraws AS (
SELECT BLOCK_NUMBER, BLOCK_TIMESTAMP, 
      ILK, U_ADDRESS as urn_address, VAULT_NUMBER,
      dink as amount
   FROM ETHEREUM.MAKER.FACT_VAT_FROB INNER JOIN vault_urn 
    ON ETHEREUM.MAKER.FACT_VAT_FROB.U_ADDRESS = vault_urn.URN_ADDRESS
WHERE DINK < 0 AND BLOCK_NUMBER <= 16400000
)

SELECT BLOCK_NUMBER, BLOCK_TIMESTAMP, 
  URN_ADDRESS, ILK, VAULT_NUMBER,
  amount as WITHDRAWN_AMOUNT_ADJ 
FROM withdraws