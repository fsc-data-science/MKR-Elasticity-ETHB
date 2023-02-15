plot_ly(data = dai_out_fee_price, 
        x = ~price, 
        y = ~implied_revenue, 
        color = ~as.factor(year(day)),
        type = "scatter", 
        mode = "markers") 

ggplotly(
ggplot(data = dai_out_fee_price, 
       aes(x = price, 
       y = implied_revenue, 
       color = as.factor(year(day))
       )) + geom_point() + geom_smooth(se = FALSE) + theme_classic()
) 


m1 = lm(data = dai_out_fee_price, formula = implied_revenue ~ price + RSI)
m2 = lm(data = dai_out_fee_price, formula = implied_revenue ~ price + RSI + day)
# implied revenue = TO_VALUE * dai_outstanding/365 so this is bad practice
m3 = lm(data = dai_out_fee_price, formula = implied_revenue ~ price + RSI + TO_VALUE)
m4 = lm(data = dai_out_fee_price, formula = implied_revenue ~ price + RSI + day + TO_VALUE)


m5 = lm(data = dai_out_fee_price, formula = dai_outstanding ~ price + RSI + day + TO_VALUE)

ggplotly(
  ggplot(data = dai_out_fee_price, 
         aes(x = price, 
             y = dai_outstanding, 
             color = as.factor(TO_VALUE)
         )) + geom_point() + geom_smooth(se = FALSE) + theme_classic()
) 



deps <- ethb_vault_deposits[ , c("BLOCK_NUMBER", "VAULT_NUMBER", "DEPOSIT_AMOUNT_ADJ")]
deps$amount <- as.numeric(deps$DEPOSIT_AMOUNT_ADJ)

deps <- deps[, c("VAULT_NUMBER", "BLOCK_NUMBER","amount")]

withs <- ethb_vault_withdrawals[ , c("BLOCK_NUMBER", "VAULT_NUMBER", "WITHDRAWN_AMOUNT_ADJ")]
withs$amount <- -1*as.numeric(withs$WITHDRAWN_AMOUNT_ADJ)
withs <- withs[, c("VAULT_NUMBER", "BLOCK_NUMBER","amount")]


all <- rbind(deps, withs)

all <- all %>% arrange(VAULT_NUMBER, BLOCK_NUMBER)

vnet <- all %>% group_by(VAULT_NUMBER) %>% 
  summarise(netDep = sum(amount))


