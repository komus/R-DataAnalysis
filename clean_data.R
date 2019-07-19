'KNN'

load("~/RecommenderSys/RecommenderSys.Rproj.RData")
library(tidyverse)
new_data <- select(hmda_lar, loan_amount_000s, hud_median_family_income, applicant_income_000s,  action_taken_name, loan_purpose_name, denial_reason_name_1)

'add new columns'
new_data <- mutate(new_data, family_rate = hud_median_family_income/(loan_amount_000s * 1000), loan_rate = applicant_income_000s/loan_amount_000s)


'remove NA values'
no_na <- filter(new_data, !is.na(loan_rate))
'convert to factor'
clean_data <- no_na %>% mutate_if(is.character,as.factor)
'percentage of loans'
round(prop.table(table(clean_data$action_taken_name)) * 100, digits = 1)

'get only loan_originated'
loan_data <- clean_data %>% filter(action_taken_name == "Loan originated")
loan_data <- loan_data %>% filter(!is.na(loan_amount_000s))
loan_data <- loan_data %>%
  mutate(hud_median_family_income = if_else(is.na(hud_median_family_income), 0, hud_median_family_income))

#find the mean of the data
mean_loan <- mean(loan_data$loan_amount_000s)
mean_income <- mean(loan_data$applicant_income_000s)
mean_family <- mean(!is.na(loan_data$hud_median_family_income))

sampledata <-  loan_data[1:100000,]
sampledata %>% ggplot() + geom_point(aes(x= loan_amount_000s, y = applicant_income_000s+hud_median_family_income ))
sampledata %>% ggplot() + geom_point(aes(x= loan_amount_000s, y = applicant_income_000s))