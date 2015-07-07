- view: rejects
  sql_table_name: loan_rejects
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
    sql: ${TABLE}."City"

  - dimension: debt_to_income_ratio
    description: "A ratio calculated using the borrower’s total monthly debt payments on the total debt obligations, excluding mortgage and the requested LC loan, divided by the borrower’s self-reported monthly income"
    sql: ${TABLE}."Debt-To-Income Ratio"

  - dimension: employment_length
    description: "Employment length in years. Possible values are between 0 and 10 where 0 means less than one year and 10 means ten or more years"
    sql: ${TABLE}."Employment Length"

  - dimension: loan_title
    sql: ${TABLE}."Loan Title"

  - dimension: policy_code
    type: int
    sql: ${TABLE}."Policy Code"

  - dimension: risk_score
    type: int
    description: "For applications prior to November 5, 2013 the risk score is the borrower's FICO score. For applications after November 5, 2013 the risk score is the borrower's Vantage score"
    sql: ${TABLE}."Risk_Score"

  - dimension: state
    sql: ${TABLE}."State"

  - measure: count
    type: count
    drill_fields: []
    
  - measure: average_amount
    type: average
    sql: ${amount_requested}
    value_format: '$#,##0.00'
  
  
  

