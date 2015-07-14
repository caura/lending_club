#########################
# Description of fields:
# https://www.lendingclub.com/developers/listed-loans.action
#########################
- view: listings
  sql_table_name: listings
  extends: [applicant]
  fields:
###########################################################    
### LISTINGS
###########################################################  


  - measure: expected_weighted_annual_profitability
    type: number
    value_format: '0.0\%' 
    sql: SUM(${expected_profitability} * ${loan_amount}) / ${total_loan_amount}
    drill_fields: [id,interest_rate,listed_date,is_bad,expected_profitability]

  - dimension: expected_profitability
    type: number
    value_format: '0.0\%' 
    sql: 100 * (${interest_rate}/100 - ${is_bad}*(1 - ${is_bad}))

  - dimension: is_bad
    label: 'Prob(Default)'
    type: number
    decimals: 2
    sql: |
      EXP(20.4681692 + -0.0358713*${fico_range_high} + 0.0008713*${fico_range_low} 
      + 0.0187961*${pub_rec_bankruptcies} + -0.0059923*${revolving_utilization} 
      + -0.2145666*${inquiries_last_6mths} + -0.1935067*${is_rent})

#   - dimension: is_rent
#     type: number
#     sql: CASE WHEN (${home_ownership} = 'RENT') THEN 1 ELSE 0 END

  - dimension: applicant_id
    primary_key: true
    type: int
    sql: ${TABLE}."id"

  - dimension_group: accepted
    type: time
    timeframes: [hour_of_day, time, date, week, month, day_of_week]
    sql: ${TABLE}."acceptD"
  
  - dimension:  accepted_hour_of_day_int
    hidden: true
    sql: ${accepted_hour_of_day}::int
    
  - dimension: accepted_hod
    type: int
    sql: ${accepted_hour_of_day}
#     order_by_field: accepted_hour_of_day_int
    

  - dimension_group: as_of
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}."as_of_date"
    
  - measure: count_distinct_uploads
    type: count_distinct
    sql: ${as_of_time}
    
  - dimension_group: expired
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}."expD"
    
  - dimension: funded_amount
    type: number
    sql: ${TABLE}."fundedAmount"

  - dimension: grade
    hidden: true
    suggestions: [A,B,C,D,E,F,G]
    sql: ${TABLE}."grade"
    
  - dimension: grade_linked
    label: "Grade"
    sql: ${grade}
    html: |
      {{ linked_value }}
      <a href="/dashboards/lending_club/historical_perfomance?grade={{ value | encode_uri }}" target="_new">
      <img src="/images/qr-graph-line@2x.png" height=20 width=20></a>
    
  - dimension: description
    sql: ${TABLE}."desc"
    
  - dimension_group: ils_expiration
    description: "wholeloan platform expiration date"
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}."ilsExpD"

  - dimension: initial_list_status
    sql: ${TABLE}."initialListStatus"
    
  - dimension: installment
    type: number
    sql: ${TABLE}."installment"

  - dimension: interest_rate
    type: number
    value_format: '0.00\%'
    sql: ${TABLE}."intRate"
    
#does this field exist?
#   - dimension: number_of_investors
#     type: number
#     sql: ${TABLE}."investorCount"

  - dimension_group: listed
    type: time
    timeframes: [time, date, week, month, hour_of_day, day_of_week, year]
    sql: ${TABLE}."listD"

  - dimension: loan_amount
    type: number
    sql: ${TABLE}."loanAmount"
    
  - dimension: loan_amount_tiers
    type: tier
    tiers: [5000,10000,15000,20000,35000]
    sql: ${loan_amount}   

  - dimension: looker_is_pull_all
    description: "Was this update on the latest listed or a pull of all currently listed"
    type: yesno
    sql: ${TABLE}."looker_is_pull_all"   
    
  - dimension: review_status
    sql: ${TABLE}."reviewStatus"
    

  - dimension_group: review_status
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}."reviewStatusD"

  - dimension: service_fee_rate
    type: number
    sql: ${TABLE}."serviceFeeRate"

  - dimension: sub_grade
    sql: ${TABLE}."subGrade"

  - dimension: term
    type: number
    sql: ${TABLE}."term"
    
###########################################################    
### MEASURES/AGGREGATES
###########################################################
###########################################################    
### LISTINGS
###########################################################  

  - measure: count
    type: count
    drill_fields: default*
    
  - measure: total_funded_amount
    type: sum
    value_format: '$#,##0.00'
    sql: ${funded_amount}
    drill_fields: default*
    
  - measure: total_loan_amount
    type: sum
    value_format: '$#,##0.00'
    sql: ${loan_amount}
    drill_fields: default*
    
#   - measure: _total_funded_amount    
#     hidden: true
#     type: number
#     value_format: '$#,##0.00'
#     sql: ${total_funded_amount}
#     html: |
#       <font size="7">{{ rendered_value }}</font>    
#     
#   - measure: _total_loan_amount    
#     hidden: true
#     type: number
#     value_format: '$#,##0.00'
#     sql: ${total_loan_amount}
#     html: |
#       <font size="7">{{ rendered_value }}</font>     
    
  - measure: average_interest_rate
    type: average
    value_format: '0.00\%'
    sql: ${interest_rate}
    drill_fields: default*
    
  - measure: average_term
    label: "Debt to Income"
    description: "number of months"
    type: average
    decimals: 1
    sql: ${term}/10
    drill_fields: default*

    
    

  # ----- Detail ------
  sets:
    default:
      - id
      - emp_length
      - funded_amount
      - grade
      - term
      - interest_rate
      - purpose