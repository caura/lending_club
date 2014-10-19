- view: loan_rejects
  fields:

  - dimension: amount_requested
    type: number
    sql: ${TABLE}."Amount Requested"

  - dimension_group: application
    type: time
    timeframes: [date, week, month]
    convert_tz: false
    sql: ${TABLE}."Application Date"

  - dimension: city
    sql: ${TABLE}.City

  - dimension: debttoincome_ratio
    sql: ${TABLE}."Debt-To-Income Ratio"

  - dimension: employment_length
    sql: ${TABLE}."Employment Length"

  - dimension: loan_title
    sql: ${TABLE}."Loan Title"

  - dimension: policy_code
    type: int
    sql: ${TABLE}."Policy Code"

  - dimension: risk_score
    type: int
    sql: ${TABLE}.Risk_Score

  - dimension: state
    sql: ${TABLE}.State

  - measure: count
    type: count
    drill_fields: []
    
  - measure: average_amount
    type: average
    sql: ${amount_requested}
    format: "$%0.2f"
  
  
  

