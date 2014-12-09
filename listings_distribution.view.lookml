- view: distributions
  derived_table:
    sql: |
      SELECT
        b.uid
        , b.metric
        , sum(b.metric_pct) over (order by b.metric_pct ASC ROWS UNBOUNDED PRECEDING) as accum_metric_pct
      FROM
      (
        SELECT
          a."memberId" AS uid
          , a."annualInc" as metric
          , a."annualInc" / sum(a."annualInc") over () as metric_pct
        FROM 
          listings as a
        WHERE
          {% condition address_state %} a."addrState" {% endcondition %}
          AND
          {% condition is_income_verified %} a."isIncV" {% endcondition %}
          AND
          {% condition date %} a."listD" {% endcondition %}
          AND
          {% condition loan_amount %} a."loanAmount" {% endcondition %}
          AND
          {% condition grade %} a."grade" {% endcondition %}
          AND
          {% condition purpose %} a."purpose" {% endcondition %}
          AND
          {% condition intrest_rate %} a."intRate" {% endcondition %}
          AND
          {% condition annual_income %} a."annualInc" {% endcondition %}
      ) as b
      
  fields:
##  AND
##          {% condition emp_length %} a."empLength" {% endcondition %}
#
#             CASE
#               WHEN a."empLength" < 12 THEN '< 1 year'
#               WHEN a."empLength" = 12 THEN '1 year'
#               WHEN a."empLength" >= 120 THEN '10+ years'
#               ELSE floor(a."empLength" / 12.0) || ' years'
#             END   
  - filter: address_state

  - filter: annual_income
    type: number

  - filter: loan_amount
    type: number
    
  - filter: grade
#     
#   - filter: emp_length
#     type: number
    
  - filter: purpose
    
  - filter: is_income_verified
    
  - filter: intrest_rate
    type: number
    
  - filter: date
    type: datetime
  
  - dimension: uid
    type: number
    hidden: true
    sql: ${TABLE}.uid

  - dimension: income_quartile_bucket
    type: number
    format: "%d%"
    sql: |
      CASE
        WHEN ${TABLE}.accum_metric_pct <= .25
        THEN 25
        WHEN ${TABLE}.accum_metric_pct <= .50
        THEN 50
        WHEN ${TABLE}.accum_metric_pct <= .75
        THEN 75
        ELSE 100
      END

  - dimension: accum_metric_pct
    type: number
    decimals: 3
    sql: ${TABLE}.accum_metric_pct

  - dimension: income_decile_bucket
    label: "APPLICANT Income Percentile"
    type: number
    format: "%d%"
    sql: CEIL(${TABLE}.accum_metric_pct*10)*10
    
  - dimension: my_count
    sql: ${TABLE}.count
