# field descriptions:
# https://docs.google.com/a/looker.com/spreadsheets/d/1QfoI8zjZSlh7A735zz6dxiQ7Gu4E5SuY1i6K66vDwXI/edit?usp=sharing

- view: loans
  sql_table_name: loan_stats
  extends: [borrower]
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
    hidden: true
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
    value_format: '$#,##0.00'

#How is this different from funded_amount?
  - dimension: funded_amount_investors
    hidden: true
    description: "The total amount committed by investors for that loan at that point in time"
    type: number
    sql: ${TABLE}.funded_amnt_inv
    value_format: '$#,##0.00'

  - dimension: grade
    sql: ${TABLE}.grade

  - dimension: initial_list_status
    hidden: true
    sql: ${TABLE}.initial_list_status

  - dimension: installment
    description: "The monthly payment owed by the borrower if the loan originates"
    type: number
    sql: ${TABLE}.installment

  - dimension: interest_rate
    description: "Interest Rate on the loan"
    type: number
    value_format: '0.00\%'
    sql: trim(trailing '%' from trim(${TABLE}.int_rate))::float

  - dimension_group: issue
    description: "The date which the loan was funded"
    type: time
    timeframes: [date, week, month,month_num, year]
    convert_tz: false
    sql: ${TABLE}.issue_d

  - dimension: issue_quarter
    hidden: true
    type: int
    sql: CEIL(${issue_month_num} / 3.0)

  - dimension: fiscal_yyyyq
    sql: |
      ${issue_year} ||  '-Q' || ${issue_quarter}    

  - dimension: last_payment_amount
    description: "Last total payment amount received"
    type: number
    sql: ${TABLE}.last_pymnt_amnt
    value_format: '$#,##0.00'

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
    hidden: true
    description: "The listed amount of the loan applied for by the borrower. If at some point in time, the credit department reduces the loan amount, then it will be reflected in this value"
    type: int
    sql: ${TABLE}.loan_amnt
    value_format: '$#,##0.00'

  - dimension: loan_amount_tiers
    type: tier
    tiers: [5000,10000,15000,20000,35000]
    sql: ${loan_amount}

  - dimension: loan_status
    sql: ${TABLE}.loan_status
    
  - dimension: is_bad
    type: yesno
    sql: ${loan_status} IN ('Late (16-30 days)', 'Late (31-120 days)', 'Default', 'Charged Off')

  - dimension: is_rent
    type: yesno
    sql: ${home_ownership} = 'RENT'

  - dimension_group: next_payment
    description: "Next scheduled payment date"
    type: time
    timeframes: [date, week, month]
    convert_tz: false
    sql: ${TABLE}.next_pymnt_d

  - dimension: out_prncp
    hidden: true
    label: "Outstanding Principle"
    description: "Remaining outstanding principal for total amount funded"
    type: number
    sql: ${TABLE}.out_prncp
    value_format: '$#,##0.00'

  - dimension: out_prncp_inv
    hidden: true
    label: "Outstanding Principle (Inv)"
    description: "Remaining outstanding principal for portion of total amount funded by investors"
    type: number
    sql: ${TABLE}.out_prncp_inv
    value_format: '$#,##0.00'
    
  - dimension: principle_delta
    hidden: true
    description: "LC-funded Principle?"
    type: number
    sql: ${out_prncp} - ${out_prncp_inv}
    value_format: '$#,##0.00'

  - dimension: pct_tl_nvr_dlq
    hidden: true
    label: "Percent Never Delinquent"
    description: "Percent of trades never delinquent"
    type: number
    value_format: '0.00\%'
    sql: ${TABLE}.pct_tl_nvr_dlq

  - dimension: policy_code
    hidden: true
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
    value_format: '$#,##0.00'
    
  - dimension: sub_grade
    sql: ${TABLE}.sub_grade

  - dimension: term
    description: "The number of payments on the loan. Values are in months and can be either 36 or 60"
    sql: ${TABLE}.term

  - dimension: title
    hidden: true
    sql: ${TABLE}.title

  - dimension: total_pymnt
    hidden: true
    description: "Payments received to date for total amount funded"
    type: number
    sql: ${TABLE}.total_pymnt
    value_format: '$#,##0.00'

  - dimension: total_payment_inv
    hidden: true
    description: "Payments received to date for portion of total amount funded by investors"
    type: number
    sql: ${TABLE}.total_pymnt_inv
    value_format: '$#,##0.00'

  - dimension: total_rec_int
    hidden: true
    label: "Total Received Interest"
    type: number
    value_format: '$#,##0.00'
    sql: ${TABLE}.total_rec_int

  - dimension: total_rec_late_fee
    hidden: true
    label: "Total Received Late fees"
    type: number
    sql: ${TABLE}.total_rec_late_fee

  - dimension: total_rec_prncp
    hidden: true
    label: "Total Received Principle"
    type: number
    sql: ${TABLE}.total_rec_prncp
    value_format: '$#,##0.00'

  - dimension: total_rev_hi_lim
    hidden: true
    description: "Total revolving high credit/credit limit"
    sql: ${TABLE}.total_rev_hi_lim
    value_format: '$#,##0.00'

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
# 

###########################################################    
### MEASURES/AGGREGATES
###########################################################  
  
  - measure: total_outstanding_principal_inv
    type: sum
    sql: ${out_prncp_inv}
  
#   - measure: nar
#     type: number
#     value_format: '0.00\%'
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
      is_income_verified: "Verified"
    
  - measure: percent_verified
    type: number
    value_format: '0.00\%'
    sql: 100.0 * ${verified_loans} / NULLIF(${count},null)
    
  - measure: total_loan_amount
    type: sum
    value_format: '$#,##0.00'
    sql: ${loan_amount}
    
  - measure: total_funded_amount
    type: sum
    value_format: '$#,##0.00'
    sql: ${funded_amount}
      
  - measure: _total_loan_amount      
    hidden: true
    type: number
    value_format: '$#,##0.00'
    sql: ${total_loan_amount}
    html: |
      <font size="7">{{ rendered_value }}</font>      
    
  - measure: average_int_rate
    type: average
    value_format: '0.00\%'
    sql: ${interest_rate}

  - measure: sum_recoveries
    type: sum
    value_format: '$#,##0.00'
    sql: (${total_rec_int} + ${total_rec_late_fee}) + (${recoveries} - ${collection_recovery_fee})
 
  - measure: total_payment
    description: "Payments received to date for total amount funded"
    type: sum
    sql: ${total_pymnt}
    value_format: '$#,##0.00'    
    
#   - measure: _sum_recoveries
#     hidden: true
#     type: number
#     value_format: '$#,##0.00'
#     sql: ${sum_recoveries}
#     html: |
#       <font size="7">{{ rendered_value }}</font>     
    
    
  # ----- Detail ------
  sets:
    default:
      - id
      - funded_amount
      - grade
      - term
      - interest_rate
      - purpose