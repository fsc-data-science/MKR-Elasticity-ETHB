# MKR-Elasticity-ETHB

An  Elasticity Analysis of MKR ETH-B "ETH Low Ratio".

For a deeper dive into the context, you can check out the report here on our [research site](https://science.flipsidecrypto.xyz/mkr_ethb_report).

If you aren't interested in code and want the shortest summary of the situation, you can check out the email sized version of this research on our research [beehiiv](https://flipsidecrypto.beehiiv.com) once it is complete. For now, you can subscribe to get (summaries of) the best crypto research direct to your inbox.

The broad goal is to develop a methodology for assessing the Elasticity of on-chain interactions with contracts, using MakerDAO's 
ETH Vault B ("ETH Low Ratio") as the introductory example.

# Research Plan 

To summarize the project plan, we will develop a research piece integrating and testing the following hypotheses:

- The market reacts to changes in ETHB's stability fee. 
  - Participation in ETH B Vaults (Dai minted from new and existing vaults) is reactive to changes in the cost of minting Dai from those vaults (i.e., the stability fee).

- When ETH's USD price is short-term "over-priced" (went up disproportionately quicky fast), ETH B use declines. 
  - People go to the cheaper vaults and/or withdraw or reduce leverage to sell high and rebuy low.
  
Overall, we'd like to adjust for available confounding factors and develop an Elasticity Curve that is useful to the MakerDAO ETH B committee that studies the market to adjust the vault parameters to support MakerDAO's efficiency and revenue growth.

# Outputs

Interactive Report: https://science.flipsidecrypto.xyz/mkr_ethb_report/
Exploratory Visualizations: https://science.flipsidecrypto.xyz/mkr_ethb_viz/
Github w/ Queries & Data: https://github.com/fsc-data-science/MKR-Elasticity-ETHB

# Reproduce Analysis

All analysis is reproducible using the R programming language. The exact queries for the timestamped data pull are available in the `queries` folder as .sql files.
Alternatively, you can use a shroomDK API key to copy our SQL queries and extract data from the [FlipsideCrypto data app](https://next.flipsidecrypto.xyz/); and (2) renv to get the exact package versions we used.

## shroomDK

shroomDK is an R package that accesses the FlipsideCrypto REST API; it is also available for Python. You pass SQL code as a string to our API and get up to 1M rows of data back!

Check out the [documentation](https://docs.flipsidecrypto.com/shroomdk-sdk/get-started) and get your free API Key today.

## renv

renv is a package manager for the R programming language. It ensures analysis is fully reproducible by tracking the exact package versions used in the analysis.

`install.packages('renv')`

## Instructions

To replicate this analysis please do the following:

1.  Clone this repo.
2.  Save your API key into a .txt file as 'api_key.txt' (this exact naming allows the provided .gitignore to ignore your key and keep it off github).
3.  Open the `MKR-Elasticity-ETHB` R Project file in your R IDE (we recommend, RStudio).
4.  Confirm you have renv installed.
5.  Restore the R environment using `renv::restore()` while in the `MKR-Elasticity-ETHB` R Project.
6.  You can now run the `ETHB-Report.Rmd` and `ETHB_Visualizations.Rmd` files. 

If any errors arise, double check you have saved your API key in the expected file name and format.
