'load("~/RecommenderSys/RecommenderSys.Rproj.RData")'
library(dplyr)



'Select few - columns'
new_data <- select(hmda_lar, loan_amount_000s, hud_median_family_income, applicant_income_000s,  action_taken_name, loan_purpose_name, denial_reason_name_1)

'add new columns'
new_data <- mutate(new_data, family_rate = hud_median_family_income/(loan_amount_000s * 1000), loan_rate = applicant_income_000s/loan_amount_000s)


'remove NA values'
no_na <- filter(new_data, !is.na(loan_rate))

'altman plot of applicants income and loan amount'
x <- no_na$applicant_income_000s + no_na$loan_amount_000s
y <- no_na$loan_amount_000s - no_na$applicant_income_000s
plot(x,y)

'find the mean of loan amount'
mean_loan <- mean(no_na$loan_amount_000s)

'mean applicant income'
income_mean <- mean(no_na$applicant_income_000s)

'mean loan_rate'
mean_rate <- mean(no_na$loan_rate)

percentile <- c(0.1, 0.25, 0.5, 0.75, 0.95)

'get the '
observed_loan <- quantile()
 