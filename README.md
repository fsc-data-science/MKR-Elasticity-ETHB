# MKR-Elasticity-ETHB

 An Elasticity Analysis of MKR ETH-B "ETH Low Ratio"

# Template 
For any reproducible analysis using this template please follow the provided format.

1.  2-3 sentence summary of the analysis.
2.  Link to both the general research site & specific report on that research site. A markdown example is provided to show how to link using `[]()` syntax. Details on how to update the research site are available [at its repo](https://github.com/FlipsideCrypto/research).

`For a deeper dive into the context, you can check out the report on our [research site](https://science.flipsidecrypto.xyz/research/) at [bonk-post-mortem](https://science.flipsidecrypto.xyz/bonk-post-mortem/).`

3.  Link to the email sized version of the analysis on the flipside beehiiv. A markdown example is provided showing how to use the `[]()` syntax and identify the beehiiv site. To add content to the beehiiv site, please contact the beehiiv admin to get added as an org member.

`If you aren't interested in code and want the shortest summary of the situation, you can check out the email sized [bonk-post-mortem](https://flipsidecrypto.beehiiv.com/p/bonk-post-mortem) on our research beehiiv and subscribe to get (summaries of) the best crypto research direct to your inbox.`

4.  Keep the Reproduce Analysis section (confirm links work) with the shroomDK and renv subheaders. Confirm your analysis is reproducible by using renv and that any SQL code you used to pull data is provided and accessible via shroomDK. For Python analysis use `pyenv` and `pip install shroomdk` and swap out any R details for Python ones.

5.  Update the instructions section.

-   To keep code bases uniform, please use `readLines('api_key.txt')` to access your api key within code and ensure gitignore files are consistently able to keep API Keys off github.

-   Use R Projects & renv to ensure portability across directories and operating systems.

-   For analysis across multiple files; either provide a single .Rmd file that accesses those files in order or explicitly detail what order .R files should be run in.

# Reproduce Analysis

All analysis is reproducible using the R programming language. You'll need (1) an shroomDK API key to copy our SQL queries and extract data from the [FlipsideCrypto data app](https://next.flipsidecrypto.xyz/); and (2) renv to get the exact package versions we used.

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
3.  Open the `R PROJECT NAME HERE` R Project file in your R IDE (we recommend, RStudio).
4.  Confirm you have renv installed.
5.  Restore the R environment using `renv::restore()` while in the `R PROJECT NAME HERE` R Project.
6.  You can now run `SPECIFY .R FILE(s) and/or .Rmd FILE(s) HERE`

If any errors arise, double check you have saved your API key in the expected file name and format.
