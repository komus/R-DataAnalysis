library(tidyverse)
library(scales)
library(ggrepel)
library(ggthemes)

library(dplyr)



'Select few - columns'
new_data <- select(hmda_lar, loan_amount_000s, hud_median_family_income, applicant_income_000s,  action_taken_name, loan_purpose_name, denial_reason_name_1)

'add new columns'
new_data <- mutate(new_data, family_rate = hud_median_family_income/(loan_amount_000s * 1000), loan_rate = applicant_income_000s/loan_amount_000s)


'remove NA values'
no_na <- filter(new_data, !is.na(loan_rate))

### get a sample size of the population
reduced_val <- no_na[1:1000000,]

### define the slope of the line with intercept 0
r <- reduced_val %>% summarise(rate = sum(applicant_income_000s) / sum (loan_amount_000s)  ) %>% .$rate

### defining the plot




