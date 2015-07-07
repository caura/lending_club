# field descriptions:
# https://docs.google.com/a/looker.com/spreadsheets/d/1QfoI8zjZSlh7A735zz6dxiQ7Gu4E5SuY1i6K66vDwXI/edit?usp=sharing

- view: loans
  sql_table_name: loan_stats
  fields:

###########################################################    
### DIMENSIONS/FIELDS
###########################################################
###########################################################    
### LOAN
###########################################################  

  - dimension: id
    primary_key: true
    type: int
    sql: ${TABLE}.id

  - dimension: description
    sql: ${TABLE}.desc

  - dimension_group: expired
    type: time
    timeframes: [date, week, month]
    convert_tz: false
    sql: ${TABLE}.exp_d

  - dimension: funded_amount
    description: "The total amount committed to that loan at that point in time"
    type: int
    sql: ${TABLE}.funded_amnt

#How is this different from funded_amount?
  - dimension: funded_amount_investors
    description: "The total amount committed by investors for that loan at that point in time"
    type: number
    sql: ${TABLE}.funded_amnt_inv

  - dimension: grade
    sql: ${TABLE}.grade

  - dimension: initial_list_status
    sql: ${TABLE}.initial_list_status

  - dimension: installment
    description: "The monthly payment owed by the borrower if the loan originates"
    type: number
    sql: ${TABLE}.installment

  - dimension: interest_rate
    description: "Interest Rate on the loan"
    type: number
    format: "%0.2f%"
    sql: trim(trailing '%' from trim(${TABLE}.int_rate))::float

  - dimension_group: issue
    description: "The date which the loan was funded"
    type: time
    timeframes: [date, week, month,month_num, year]
    convert_tz: false
    sql: ${TABLE}.issue_d
    
  - dimension: issue_quarter
    type: int
    sql: CEIL(${issue_month_num} / 3.0)

  - dimension: fiscal_yyyyq
    sql: |
      ${issue_year} ||  '-Q' || ${issue_quarter}    

  - dimension: last_payment_amount
    description: "Last total payment amount received"
    type: number
    sql: ${TABLE}.last_pymnt_amnt

  - dimension_group: last_payment
    type: time
    timeframes: [date, week, month]
    convert_tz: false
    sql: ${TABLE}.last_pymnt_d

  - dimension_group: listed
    type: time
    timeframes: [date, week, month]
    convert_tz: false
    sql: ${TABLE}.list_d

  - dimension: loan_amount
    description: "The listed amount of the loan applied for by the borrower. If at some point in time, the credit department reduces the loan amount, then it will be reflected in this value"
    type: int
    sql: ${TABLE}.loan_amnt

  - dimension: loan_amount_tiers
    type: tier
    tiers: [5000,10000,15000,20000,35000]
    sql: ${loan_amount}

  - dimension: loan_status
    sql: ${TABLE}.loan_status
    
  - dimension: is_bad
    sql: |
      CASE 
      WHEN ${loan_status} IN ('Late (16-30 days)', 'Late (31-120 days)', 'Default', 'Charged Off')
        THEN 1
      WHEN ${loan_status} = ''
        THEN NULL
      ELSE 0
      END
      
  - dimension: is_rent
    sql: |
      CASE 
      WHEN ${borrower.home_ownership} = 'RENT' THEN 1
      ELSE 0
      END
      
  - dimension: borrower.revol_utilization
    type: number
    sql: trim(trailing '%' from trim(${TABLE}.revol_util))::float      

  - dimension_group: next_payment
    description: "Next scheduled payment date"
    type: time
    timeframes: [date, week, month]
    convert_tz: false
    sql: ${TABLE}.next_pymnt_d

  - dimension: out_prncp
    label: "Outstanding Principle"
    description: "Remaining outstanding principal for total amount funded"
    type: number
    sql: ${TABLE}.out_prncp

  - dimension: out_prncp_inv
    label: "Outstanding Principle (Inv)"
    description: "Remaining outstanding principal for portion of total amount funded by investors"
    type: number
    sql: ${TABLE}.out_prncp_inv
    
  - dimension: principle_delta
    description: "LC-funded Principle?"
    type: number
    sql: ${out_prncp} - ${out_prncp_inv}

  - dimension: pct_tl_nvr_dlq
    label: "Percent Never Delinquent"
    description: "Percent of trades never delinquent"
    type: number
    format: "%0.2f%"
    sql: ${TABLE}.pct_tl_nvr_dlq

  - dimension: policy_code
    type: int
    sql: ${TABLE}.policy_code

  - dimension: purpose
    description: "A category provided by the borrower for the loan request"
    sql: ${TABLE}.purpose

  - dimension: payment_plan
    type: yesno
    sql: ${TABLE}.pymnt_plan

  - dimension: recoveries
    description: "Post charge off gross recovery"
    type: number
    sql: ${TABLE}.recoveries
    
  - dimension: sub_grade
    sql: ${TABLE}.sub_grade

  - dimension: borrower.tax_liens
    description: "Number of tax liens"
    type: int
    sql: ${TABLE}.tax_liens

  - dimension: term
    description: "The number of payments on the loan. Values are in months and can be either 36 or 60"
    sql: ${TABLE}.term

  - dimension: title
    sql: ${TABLE}.title

  - dimension: total_pymnt
    description: "Payments received to date for total amount funded"
    type: number
    sql: ${TABLE}.total_pymnt

  - dimension: total_payment_inv
    description: "Payments received to date for portion of total amount funded by investors"
    type: number
    sql: ${TABLE}.total_pymnt_inv

  - dimension: total_rec_int
    label: "Total Received Interest"
    type: number
    format: "$%d"
    sql: ${TABLE}.total_rec_int

  - dimension: total_rec_late_fee
    label: "Total Received Late fees"
    type: number
    sql: ${TABLE}.total_rec_late_fee

  - dimension: total_rec_prncp
    label: "Total Received Principle"
    type: number
    sql: ${TABLE}.total_rec_prncp

  - dimension: total_rev_hi_lim
    description: "Total revolving high credit/credit limit"
    sql: ${TABLE}.total_rev_hi_lim

  - dimension: url
    sql: ${TABLE}.url
    html: |
      <a href="{{ value }}" target="_blank">LendingClub <img src="/images/qr-graph-line@2x.png" height=20 width=20</a>
    
#   - dimension: return_num
#     type: number
#     hidden: true
#     sql: 0.99 * (${total_rec_int} + ${total_rec_late_fee}) - ${out_prncp_inv} + (${recoveries} - ${collection_recovery_fee})
#   
#   - dimension: sum_of_returns
#     hidden: true
#     type: sum
#     sql: ${return_num}
    
###########################################################    
### BORROWER
###########################################################      
  - dimension: borrower.id
    type: int
    sql: ${TABLE}.member_id
        
  - dimension: borrower.dti
    description: |
      A ratio calculated using the borrower’s total monthly debt payments on the total debt obligations, 
      excluding mortgage and the requested LC loan, divided by the borrower’s self-reported monthly income
    type: number
    sql: ${TABLE}.dti

  - dimension_group: borrower.earliest_cr_line
    description: "The date the borrower's earliest reported credit line was opened"
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.earliest_cr_line

  - dimension: borrower.emp_length
    description: "Employment length in years. Possible values are between 0 and 10 where 0 means less than one year and 10 means ten or more years"
    sql: ${TABLE}.emp_length

  - dimension: borrower.emp_title
    sql: ${TABLE}.emp_title    

  - dimension: borrower.fico_high_tier
    type: tier
    tiers: [450,550,650,750,850]
    sql: ${borrower.fico_range_high}
    
  - dimension: borrower.fico_range_high
    sql: ${TABLE}.fico_range_high
    
  - dimension: borrower.fico_low_tier
    type: tier
    tiers: [450,550,650,750,850]
    sql: ${borrower.fico_range_low}
    
  - dimension: borrower.fico_range_low
    sql: ${TABLE}.fico_range_low
    
  - dimension: borrower.accounts_delinquent
    description: "The number of accounts on which the borrower is now delinquent"
    type: int
    sql: ${TABLE}.acc_now_delinq

  - dimension: borrower.accounts_past_24months
    description: "Number of trades opened in past 24 months"
    sql: ${TABLE}.acc_open_past_24mths

  - dimension_group: accepted
    type: time
    timeframes: [date, week, month, year]
    convert_tz: false
    sql: ${TABLE}.accept_d

  - dimension: borrower.address_city
    sql: ${TABLE}.addr_city

  - dimension: borrower.address_state
    sql: ${TABLE}.addr_state

  - dimension: borrower.annual_income
    type: number
    sql: ${TABLE}.annual_inc
    
  - dimension: borrower.annual_income_tier
    type: tier
    tiers: [30000,50000,70000,90000,110000]
    sql: ${borrower.annual_income}

  - dimension: borrower.average_current_balance
    sql: ${TABLE}.avg_cur_bal

  - dimension: borrower.bc_open_to_buy
    description: "Total open to buy on revolving bankcards"
    sql: ${TABLE}.bc_open_to_buy

  - dimension: borrower.bc_util
    description: "Ratio of total current balance to high credit/credit limit for all bankcard accounts"
    type: number
    format: "%0.2f%"
    sql: trim(trailing '%' from trim(${TABLE}.bc_util))::float
    
  - dimension: borrower.bc_util_tier
    type: tier
    tiers: [20,40,60,80]
    sql: ${borrower.bc_util}

  - dimension: borrower.chargeoff_within_12_mths
    description: "Number of charge-offs within 12 months"
    type: int
    sql: ${TABLE}.chargeoff_within_12_mths

  - dimension: collection_recovery_fee
    description: "Post charge off collection fee"
    type: number
    sql: ${TABLE}.collection_recovery_fee

  - dimension: borrower.collections_12_mths_ex_med
    description: "Number of collections in 12 months excluding medical collections"
    type: int
    sql: ${TABLE}.collections_12_mths_ex_med

  - dimension: borrower.delinq_2yrs
    description: "The number of 30+ days past-due incidences of delinquency in the borrower's credit file for the past 2 years"
    type: int
    sql: ${TABLE}.delinq_2yrs

  - dimension: borrower.delinquent_amount
    description: "The past-due amount owed for the accounts on which the borrower is now delinquent"
    type: int
    sql: ${TABLE}.delinq_amnt

  - dimension: borrower.revol_bal
    description: "Total credit revolving balance"
    type: int
    sql: ${TABLE}.revol_bal
    
  - dimension: borrower.revol_util_tier
    type: tier
    tiers: [20,40,60,80]
    sql: ${borrower.revol_utilization}
    
  - dimension_group: borrower.last_credit_pull
    type: time
    timeframes: [date, week, month]
    convert_tz: false
    sql: ${TABLE}.last_credit_pull_d
    

  - dimension: borrower.inquiries_last_6mths
    type: int
    description: "The number of inquiries by creditors during the past 6 months"
    sql: ${TABLE}.inq_last_6mths

  - dimension: borrower.is_income_verified
    sql: ${TABLE}.is_inc_v    

  - dimension: borrower.last_fico_range_high_tier
    type: tier
    tiers: [450,550,650,750,850]
    sql: ${TABLE}.last_fico_range_high

  - dimension: borrower.last_fico_range_low_tier
    type: tier
    tiers: [450,550,650,750,850]
    sql: ${TABLE}.last_fico_range_low    

  - dimension: borrower.mo_sin_old_il_acct
    description: "Months since oldest installment account opened"
    sql: ${TABLE}.mo_sin_old_il_acct

  - dimension: borrower.mo_sin_old_rev_tl_op
    description: "Months since oldest revolving account opened"
    sql: ${TABLE}.mo_sin_old_rev_tl_op

  - dimension: borrower.mo_sin_rcnt_rev_tl_op
    description: "Months since most recent revolving account opened"
    sql: ${TABLE}.mo_sin_rcnt_rev_tl_op

  - dimension: borrower.mo_sin_rcnt_tl
    description: "Months since most recent account opened"
    sql: ${TABLE}.mo_sin_rcnt_tl

  - dimension: borrower.number_mortgage_accounts
    sql: ${TABLE}.mort_acc

  - dimension: borrower.mths_since_last_delinq
    description: "The number of months since the borrower's last delinquency"
    sql: ${TABLE}.mths_since_last_delinq

  - dimension: borrower.mths_since_last_major_derog
    description: "Months since most recent 90-day or worse rating"
    sql: ${TABLE}.mths_since_last_major_derog

  - dimension: borrower.mths_since_last_record
    description: "The number of months since the last public record"
    sql: ${TABLE}.mths_since_last_record

  - dimension: borrower.mths_since_recent_bc
    description: "Months since most recent bankcard account opened"
    sql: ${TABLE}.mths_since_recent_bc

  - dimension: borrower.mths_since_recent_bc_dlq
    description: "Months since most recent bankcard delinquency"
    sql: ${TABLE}.mths_since_recent_bc_dlq

  - dimension: borrower.mths_since_recent_inq
    description: "Months since most recent inquiry"
    sql: ${TABLE}.mths_since_recent_inq

  - dimension: borrower.mths_since_recent_revol_delinq
    description: "Months since most recent revolving delinquency"
    sql: ${TABLE}.mths_since_recent_revol_delinq    
    
  - dimension: borrower.tot_coll_amt
    description: "Total collection amounts ever owed"
    sql: ${TABLE}.tot_coll_amt

  - dimension: borrower.tot_cur_bal
    description: "Total current balance of all accounts"
    sql: ${TABLE}.tot_cur_bal

  - dimension: borrower.tot_hi_cred_lim
    description: "Total high credit/credit limit"
    sql: ${TABLE}.tot_hi_cred_lim

  - dimension: borrower.total_accounts
    description: "The total number of credit lines currently in the borrower's credit file"
    type: int
    sql: ${TABLE}.total_acc

  - dimension: borrower.total_bal_ex_mort
    description: "Total credit balance excluding mortgage"
    sql: ${TABLE}.total_bal_ex_mort

  - dimension: borrower.bc_limit
    description: "Total bankcard high credit/credit limit"
    type: number
    format: "$%d"
    sql: ${TABLE}.total_bc_limit::int

  - dimension: borrower.installment_high_credit_limit
    description: "Total installment high credit/credit limit"
    type: number
    format: "$%d"  
    sql: ${TABLE}.total_il_high_credit_limit::int

  - dimension: borrower.home_ownership
    sql: ${TABLE}.home_ownership   

  - dimension: borrower.num_accts_ever_120_pd
    label: "Number of Accounts Past Due 120"
    description: "Number of accounts ever 120 or more days past due"
    sql: ${TABLE}.num_accts_ever_120_pd

  - dimension: borrower.num_actv_bc_tl
    description: "Number of currently active bankcard accounts"
    sql: ${TABLE}.num_actv_bc_tl

  - dimension: borrower.num_actv_rev_tl
    description: "Number of currently active revolving trades"
    sql: ${TABLE}.num_actv_rev_tl

  - dimension: borrower.num_bc_sats
    description: "Number of satisfactory bankcard accounts"
    sql: ${TABLE}.num_bc_sats

  - dimension: borrower.num_bc_tl
    description: "Number of bankcard accounts"
    sql: ${TABLE}.num_bc_tl

  - dimension: borrower.num_il_tl
    description: "Number of installment accounts"
    sql: ${TABLE}.num_il_tl

  - dimension: borrower.num_op_rev_tl
    description: "Number of open revolving accounts"
    sql: ${TABLE}.num_op_rev_tl

  - dimension: borrower.num_rev_accts
    description: "Number of revolving accounts"
    sql: ${TABLE}.num_rev_accts

  - dimension: borrower.num_rev_tl_bal_gt_0
    description: "Number of revolving trades with balance >0"
    sql: ${TABLE}.num_rev_tl_bal_gt_0

  - dimension: borrower.num_sats
    description: "Number of satisfactory accounts"
    sql: ${TABLE}.num_sats

  - dimension: borrower.num_tl_120dpd_2m
    description: "Number of accounts currently 120 days past due (updated in past 2 months)"
    sql: ${TABLE}.num_tl_120dpd_2m

  - dimension: borrower.num_tl_30dpd
    description: "Number of accounts currently 30 days past due (updated in past 2 months)"
    sql: ${TABLE}.num_tl_30dpd

  - dimension: borrower.num_tl_90g_dpd_24m
    description: "Number of accounts 90 or more days past due in last 24 months"
    sql: ${TABLE}.num_tl_90g_dpd_24m

  - dimension: borrower.num_tl_op_past_12m
    description: "Number of accounts opened in past 12 months"
    sql: ${TABLE}.num_tl_op_past_12m

  - dimension: borrower.open_acc
    description: "The number of open credit lines in the borrower's credit file"
    type: int
    sql: ${TABLE}.open_acc    

  - dimension: borrower.percent_bc_gt_75
    description: "Percentage of all bankcard accounts > 75% of limit"
    sql: ${TABLE}.percent_bc_gt_75    

  - dimension: borrower.pub_rec
    description: "Number of derogatory public records"
    type: int
    sql: ${TABLE}.pub_rec

  - dimension: borrower.pub_rec_bankruptcies
    description: "Number of public record bankruptcies"
    type: int
    sql: ${TABLE}.pub_rec_bankruptcies    
    
###########################################################    
### MEASURES/AGGREGATES
###########################################################
###########################################################    
### LOAN
###########################################################  
  
  - measure: total_outstanding_principal_inv
    type: sum
    sql: ${out_prncp_inv}
  
#   - measure: nar
#     type: number
#     format: "%0.2f%"
#     sql: (POWER(1 + ${sum_of_returns} / NULLIF(${total_outstanding_principal_inv},0),12.0) - 1) * 100.0
    
  - measure: count
    type: count
    drill_fields: default*
    
  - measure: percent_of_total
    decimals: 2
    type: percent_of_total
    sql: ${count}
    
  - measure: verified_loans
    type: count
    filters:
      borrower.is_income_verified: "Verified"
    
  - measure: percent_verified
    type: number
    format: "%0.2f%"
    sql: 100.0 * ${verified_loans} / NULLIF(${count},null)
    
  - measure: total_loan_amount
    type: sum
    format: "$%d"
    sql: ${loan_amount}
    
  - measure: total_funded_amount
    type: sum
    format: "$%d"
    sql: ${funded_amount}
      
  - measure: _total_loan_amount      
    hidden: true
    type: number
    format: "$%d"
    sql: ${total_loan_amount}
    html: |
      <font size="7">{{ rendered_value }}</font>      
    
  - measure: average_int_rate
    type: average
    format: "%0.2f%"
    sql: ${interest_rate}
    

  - measure: sum_recoveries
    type: sum
    format: "$%d"
    sql: (${total_rec_int} + ${total_rec_late_fee}) + (${recoveries} - ${collection_recovery_fee})
    
  - measure: _sum_recoveries
    hidden: true
    type: number
    format: "$%d"
    sql: ${sum_recoveries}
    html: |
      <font size="7">{{ rendered_value }}</font>     
    
###########################################################    
### BORROWER
###########################################################  

  - measure: borrower.bc_util_average
    type: average
    format: "%0.2f%"
    sql: ${borrower.bc_util}
    
  - measure: borrower.revol_util_average
    type: sum
    format: "%0.2f%"
    sql: ${borrower.revol_utilization}
    
  - measure: borrower.average_bc_limit
    type: average
    format: "$%d"
    sql: ${borrower.bc_limit}
  
  - measure: borrower.average_il_high_credit_limit
    type: average
    format: "$%d"
    sql: ${borrower.installment_high_credit_limit}
    
  - measure: borrower.average_revol_utilization
    type: average
    description: "Revolving line utilization rate, or the amount of credit the borrower is using relative to all available revolving credit"
    format: "%0.2f%"
    sql:  ${borrower.revol_utilization}
    
    
  # ----- Detail ------
  sets:
    default:
      - id
      - borrower.id
      - borrower.emp_length
      - funded_amount
      - grade
      - term
      - interest_rate
      - purpose
