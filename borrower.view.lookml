- view: borrower
  sql_table_name: loan_stats
###########################################################    
### BORROWER
###########################################################     

  fields:
  - dimension: borrower_id
    type: int
    sql: ${TABLE}.member_id
    view_label: Borrower
        
  - dimension: debt_to_income
    description: |
      A ratio calculated using the borrower’s total monthly debt payments on the total debt obligations, 
      excluding mortgage and the requested LC loan, divided by the borrower’s self-reported monthly income
    type: number
    sql: ${TABLE}.dti
    view_label: Borrower

  - dimension_group: earliest_credit_line
    description: "The date the borrower's earliest reported credit line was opened"
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.earliest_cr_line
    view_label: Borrower

  - dimension: employment_length
    description: "Employment length in years. Possible values are between 0 and 10 where 0 means less than one year and 10 means ten or more years"
    sql: ${TABLE}.emp_length
    view_label: Borrower

  - dimension: employment_title
    sql: ${TABLE}.emp_title    
    view_label: Borrower

  - dimension: fico_high_tier
    type: tier
    tiers: [450,550,650,750,850]
    sql: ${fico_range_high}
    view_label: Borrower
    
  - dimension: fico_range_high
    hidden: true
    sql: ${TABLE}.fico_range_high
    view_label: Borrower
    
  - dimension: fico_low_tier
    hidden: true
    type: tier
    tiers: [450,550,650,750,850]
    sql: ${fico_range_low}
    view_label: Borrower
    
  - dimension: fico_range_low
    hidden: true
    sql: ${TABLE}.fico_range_low
    view_label: Borrower
    
  - dimension: accounts_delinquent
    description: "The number of accounts on which the borrower is now delinquent"
    type: int
    sql: ${TABLE}.acc_now_delinq
    view_label: Borrower

  - dimension: accounts_past_24months
    hidden: true
    description: "Number of trades opened in past 24 months"
    sql: ${TABLE}.acc_open_past_24mths
    view_label: Borrower

  - dimension_group: accepted
    type: time
    timeframes: [date, week, month, year]
    convert_tz: false
    sql: ${TABLE}.accept_d
    view_label: Borrower

  - dimension: address_city
    sql: ${TABLE}.addr_city
    view_label: Borrower

  - dimension: address_state
    sql: ${TABLE}.addr_state
    view_label: Borrower

  - dimension: annual_income
    hidden: true
    type: number
    sql: ${TABLE}.annual_inc
    view_label: Borrower
    
  - dimension: annual_income_tier
    type: tier
    tiers: [30000,50000,70000,90000,110000]
    sql: ${annual_income}
    view_label: Borrower

  - dimension: avg_cur_bal
    hidden: true
    type: number
    sql: ${TABLE}.avg_cur_bal
    view_label: Borrower

  - dimension: bankcard_open_to_buy
    hidden: true
    description: "Total open to buy on revolving bankcards"
    sql: ${TABLE}.bc_open_to_buy
    view_label: Borrower

  - dimension: bankcard_utilization
    hidden: true
    description: "Ratio of total current balance to high credit/credit limit for all bankcard accounts"
    type: number
    value_format: '0.00\%'
    sql: trim(trailing '%' from trim(${TABLE}.bc_util))::float
    view_label: Borrower
    
  - dimension: bankcard_utilization_tier
    type: tier
    description: "Ratio of total current balance to high credit/credit limit for all bankcard accounts"
    tiers: [20,40,60,80]
    sql: ${bankcard_utilization}
    view_label: Borrower

  - dimension: chargeoff_within_12_mths
    hidden: true
    description: "Number of charge-offs within 12 months"
    type: int
    sql: ${TABLE}.chargeoff_within_12_mths
    view_label: Borrower

  - dimension: collection_recovery_fee
    description: "Post charge off collection fee"
    type: number
    sql: ${TABLE}.collection_recovery_fee
    view_label: Borrower

  - dimension: collections_12_months_excluding_medical
    hidden: true
    description: "Number of collections in 12 months excluding medical collections"
    type: int
    sql: ${TABLE}.collections_12_mths_ex_med
    view_label: Borrower

  - dimension: delinquennt_2yrs
    hidden: true
    description: "The number of 30+ days past-due incidences of delinquency in the borrower's credit file for the past 2 years"
    type: int
    sql: ${TABLE}.delinq_2yrs
    view_label: Borrower

  - dimension: delinquent_amount
    description: "The past-due amount owed for the accounts on which the borrower is now delinquent"
    type: int
    sql: ${TABLE}.delinq_amnt
    view_label: Borrower

  - dimension: revolving_balance
    description: "Total credit revolving balance"
    type: int
    sql: ${TABLE}.revol_bal
    view_label: Borrower
    
  - dimension: revolving_utilization_tier
    type: tier
    tiers: [20,40,60,80]
    sql: ${revolving_utilization}
    view_label: Borrower
    
  - dimension: revolving_utilization
    hidden: true
    type: number
    sql: trim(trailing '%' from trim(${TABLE}.revol_util))::float  
    view_label: Borrower
    
  - dimension_group: last_credit_pull
    type: time
    timeframes: [date, week, month]
    convert_tz: false
    sql: ${TABLE}.last_credit_pull_d
    view_label: Borrower
    
  - dimension: inquiries_last_6mths
    hidden: true
    type: int
    description: "The number of inquiries by creditors during the past 6 months"
    sql: ${TABLE}.inq_last_6mths
    view_label: Borrower

  - dimension: is_income_verified
    sql: ${TABLE}.is_inc_v    
    view_label: Borrower

  - dimension: last_fico_range_high_tier
    hidden: true
    type: tier
    tiers: [450,550,650,750,850]
    sql: ${TABLE}.last_fico_range_high
    view_label: Borrower

  - dimension: last_fico_range_low_tier
    hidden: true
    type: tier
    tiers: [450,550,650,750,850]
    sql: ${TABLE}.last_fico_range_low    
    view_label: Borrower

  - dimension: mo_sin_old_il_acct
    hidden: true
    description: "Months since oldest installment account opened"
    sql: ${TABLE}.mo_sin_old_il_acct
    view_label: Borrower

  - dimension: mo_sin_old_rev_tl_op
    hidden: true
    description: "Months since oldest revolving account opened"
    sql: ${TABLE}.mo_sin_old_rev_tl_op
    view_label: Borrower

  - dimension: mo_sin_rcnt_rev_tl_op
    hidden: true
    description: "Months since most recent revolving account opened"
    sql: ${TABLE}.mo_sin_rcnt_rev_tl_op
    view_label: Borrower

  - dimension: mo_sin_rcnt_tl
    hidden: true
    description: "Months since most recent account opened"
    sql: ${TABLE}.mo_sin_rcnt_tl
    view_label: Borrower

  - dimension: number_mortgage_accounts
    sql: ${TABLE}.mort_acc
    view_label: Borrower

  - dimension: mths_since_last_delinq
    hidden: true
    description: "The number of months since the borrower's last delinquency"
    sql: ${TABLE}.mths_since_last_delinq
    view_label: Borrower

  - dimension: mths_since_last_major_derog
    hidden: true
    description: "Months since most recent 90-day or worse rating"
    sql: ${TABLE}.mths_since_last_major_derog
    view_label: Borrower

  - dimension: mths_since_last_record
    hidden: true
    description: "The number of months since the last public record"
    sql: ${TABLE}.mths_since_last_record
    view_label: Borrower

  - dimension: mths_since_recent_bc
    hidden: true
    description: "Months since most recent bankcard account opened"
    sql: ${TABLE}.mths_since_recent_bc
    view_label: Borrower

  - dimension: mths_since_recent_bc_dlq
    hidden: true
    description: "Months since most recent bankcard delinquency"
    sql: ${TABLE}.mths_since_recent_bc_dlq
    view_label: Borrower

  - dimension: mths_since_recent_inq
    hidden: true
    description: "Months since most recent inquiry"
    sql: ${TABLE}.mths_since_recent_inq
    view_label: Borrower

  - dimension: mths_since_recent_revol_delinq
    hidden: true
    description: "Months since most recent revolving delinquency"
    sql: ${TABLE}.mths_since_recent_revol_delinq    
    view_label: Borrower
    
  - dimension: collection_amounts
    hidden: true
    description: "Total collection amounts ever owed"
    type: int
    sql: ${TABLE}.tot_coll_amt
    view_label: Borrower

  - dimension: current_balance
    hidden: true
    type: int
    description: "Total current balance of all accounts"
    sql: ${TABLE}.tot_cur_bal
    view_label: Borrower

  - dimension: total_high_creded_limit
    description: "Total high credit/credit limit"
    sql: ${TABLE}.tot_hi_cred_lim
    view_label: Borrower

  - dimension: accounts
    description: "The total number of credit lines currently in the borrower's credit file"
    type: int
    sql: ${TABLE}.total_acc
    view_label: Borrower

  - dimension: balance_excluding_mortgage
    description: "Total credit balance excluding mortgage"
    sql: ${TABLE}.total_bal_ex_mort
    view_label: Borrower

  - dimension: bankcard_limit
    description: "Total bankcard high credit/credit limit"
    type: number
    value_format: '$#,##0.00'
    sql: ${TABLE}.total_bc_limit::int
    view_label: Borrower

  - dimension: installment_high_credit_limit
    description: "Total installment high credit/credit limit"
    type: number
    value_format: '$#,##0.00'  
    sql: ${TABLE}.total_il_high_credit_limit::int
    view_label: Borrower

  - dimension: home_ownership
    sql: ${TABLE}.home_ownership   
    view_label: Borrower

  - dimension: number_accounts_ever_120_past_due
    hidden: true
    label: "Number of Accounts Past Due 120"
    description: "Number of accounts ever 120 or more days past due"
    sql: ${TABLE}.num_accts_ever_120_pd
    view_label: Borrower

  - dimension: num_actv_bc_tl
    hidden: true
    description: "Number of currently active bankcard accounts"
    sql: ${TABLE}.num_actv_bc_tl
    view_label: Borrower

  - dimension: num_actv_rev_tl
    hidden: true
    description: "Number of currently active revolving trades"
    sql: ${TABLE}.num_actv_rev_tl
    view_label: Borrower

  - dimension: num_bc_sats
    hidden: true
    description: "Number of satisfactory bankcard accounts"
    sql: ${TABLE}.num_bc_sats
    view_label: Borrower

  - dimension: num_bc_tl
    hidden: true
    description: "Number of bankcard accounts"
    sql: ${TABLE}.num_bc_tl
    view_label: Borrower

  - dimension: num_il_tl
    hidden: true
    description: "Number of installment accounts"
    sql: ${TABLE}.num_il_tl
    view_label: Borrower

  - dimension: num_op_rev_tl
    hidden: true
    description: "Number of open revolving accounts"
    sql: ${TABLE}.num_op_rev_tl
    view_label: Borrower

  - dimension: number_revolving_accounts
    description: "Number of revolving accounts"
    sql: ${TABLE}.num_rev_accts
    view_label: Borrower

  - dimension: num_rev_tl_bal_gt_0
    hidden: true
    description: "Number of revolving trades with balance >0"
    sql: ${TABLE}.num_rev_tl_bal_gt_0
    view_label: Borrower

  - dimension: num_sats
    hidden: true
    description: "Number of satisfactory accounts"
    sql: ${TABLE}.num_sats
    view_label: Borrower

  - dimension: num_tl_120dpd_2m
    hidden: true
    description: "Number of accounts currently 120 days past due (updated in past 2 months)"
    sql: ${TABLE}.num_tl_120dpd_2m
    view_label: Borrower

  - dimension: num_tl_30dpd
    hidden: true
    description: "Number of accounts currently 30 days past due (updated in past 2 months)"
    sql: ${TABLE}.num_tl_30dpd
    view_label: Borrower

  - dimension: num_tl_90g_dpd_24m
    hidden: true
    description: "Number of accounts 90 or more days past due in last 24 months"
    sql: ${TABLE}.num_tl_90g_dpd_24m
    view_label: Borrower

  - dimension: num_tl_op_past_12m
    hidden: true
    description: "Number of accounts opened in past 12 months"
    sql: ${TABLE}.num_tl_op_past_12m
    view_label: Borrower

  - dimension: open_accounts
    description: "The number of open credit lines in the borrower's credit file"
    type: int
    sql: ${TABLE}.open_acc    
    view_label: Borrower

  - dimension: percent_bc_gt_75
    hidden: true
    description: "Percentage of all bankcard accounts > 75% of limit"
    sql: ${TABLE}.percent_bc_gt_75    
    view_label: Borrower

  - dimension: pub_rec
    hidden: true
    description: "Number of derogatory public records"
    type: int
    sql: ${TABLE}.pub_rec
    view_label: Borrower

  - dimension: public_record_bankruptcies
    hidden: true
    description: "Number of public record bankruptcies"
    type: int
    sql: ${TABLE}.pub_rec_bankruptcies    
    view_label: Borrower

#   - dimension: tax_liens
#     description: "Number of tax liens"
#     type: int
#     sql: ${TABLE}.tax_liens
#     view_label: Loans
    
###########################################################    
### MEASURES/AGGREGATES
###########################################################

  - measure: average_bankcard_utilization
    type: average
    value_format: '0.00\%'
    sql: ${bankcard_utilization}
    view_label: Borrower
    
  - measure: average_bankcard_limit
    type: average
    value_format: '$#,##0.00'
    sql: ${bankcard_limit}
    view_label: Borrower
  
  - measure: average_installment_high_credit_limit
    type: average
    value_format: '$#,##0.00'
    sql: ${installment_high_credit_limit}
    view_label: Borrower
    
  - measure: average_revolving_utilization
    type: average
    description: "Revolving line utilization rate, or the amount of credit the borrower is using relative to all available revolving credit"
    value_format: '0.00\%'
    sql:  ${revolving_utilization}
    view_label: Borrower
    
  - measure: total_public_record_bankruptcies
    description: "Number of public record bankruptcies"
    type: sum
    sql: ${public_record_bankruptcies}
    view_label: Borrower
  
  - measure: total_collection_amounts
    description: "Total collection amounts ever owed"
    type: sum
    sql: ${collection_amounts}
    value_format: '$#,##0.00'
    view_label: Borrower
    
  - measure: total_current_balance
    description: "Total current balance of all accounts"
    type: sum
    sql: ${current_balance}
    value_format: '$#,##0.00'
    view_label: Borrower
    
  - measure: total_accounts_delinquent
    description: "The number of accounts on which the borrowers are now delinquent"
    type: sum
    sql: ${accounts_delinquent}
    view_label: Borrower
    
  - measure: average_current_balance
    type: average
    sql: ${avg_cur_bal}
    value_format: '$#,##0.00'
    view_label: Borrower
    
  - measure: total_annual_income
    type: sum
    sql: ${annual_income}
    value_format: '$#,##0.00'
    view_label: Borrower  
    
    
    
    