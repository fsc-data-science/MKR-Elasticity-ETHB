-- This query aligns to Maker ETHB Elasticity Report 
-- https://science.flipsidecrypto.xyz/mkr_ethb_viz
-- If you're looking at this code for a different vault
-- double check INK::number decimal makes sense for that specific Ilk!
-- https://flipsidecrypto.xyz/edit/queries/76b0e308-3e34-440b-81d7-0e4882396ef7

with vault_urn AS (
SELECT VAULT_NUMBER,  URN_ADDRESS 
  FROM ETHEREUM.MAKER.EZ_VAULT_CREATION
  WHERE startswith(COLLATERAL_TYPE, 'ETH-B') 
    AND BLOCK_NUMBER <= 16400000
),

cat_liqs AS (
SELECT BLOCK_NUMBER, BLOCK_TIMESTAMP, TX_HASH, 
  ETHEREUM.MAKER.FACT_CAT_BITE.URN_ADDRESS, 
  ILK, VAULT_NUMBER, INK::number as amount_liq,
  tab as dai_debt 
FROM ETHEREUM.MAKER.FACT_CAT_BITE INNER JOIN vault_urn 
  ON ETHEREUM.MAKER.FACT_CAT_BITE.URN_ADDRESS = vault_urn.URN_ADDRESS
WHERE startswith(ILK, 'ETH-B') AND BLOCK_NUMBER <= 16400000
),

dog_liqs AS (
SELECT BLOCK_NUMBER, BLOCK_TIMESTAMP, TX_HASH, 
  ETHEREUM.MAKER.FACT_DOG_BARK.URN_ADDRESS, 
  ILK, VAULT_NUMBER, 
  INK::number as amount_liq,
  due as dai_debt 
FROM ETHEREUM.MAKER.FACT_DOG_BARK INNER JOIN vault_urn 
  ON ETHEREUM.MAKER.FACT_DOG_BARK.URN_ADDRESS = vault_urn.URN_ADDRESS
WHERE startswith(ILK, 'ETH-B') AND BLOCK_NUMBER <= 16400000
)

SELECT BLOCK_NUMBER, BLOCK_TIMESTAMP, VAULT_NUMBER, 
AMOUNT_LIQ as COLLATERAL_LIQUIDATED_AMOUNT, 
DAI_DEBT as DAI_REPAYED_AMOUNT
FROM (SELECT * FROM dog_liqs UNION ALL (SELECT * FROM cat_liqs))


