-- This query aligns to Maker ETHB Elasticity Report 
-- https://science.flipsidecrypto.xyz/mkr_ethb_viz
-- https://flipsidecrypto.xyz/edit/queries/7a354f90-3947-4d42-9da5-57fb77bef274

SELECT BLOCK_NUMBER, BLOCK_TIMESTAMP, 
    VAULT_NUMBER, COLLATERAL_TYPE as ILK, URN_ADDRESS 
  FROM ETHEREUM.MAKER.EZ_VAULT_CREATION
  WHERE startswith(ILK, 'ETH-B') AND BLOCK_NUMBER <= 16400000


