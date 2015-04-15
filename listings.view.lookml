#########################
# Description of fields:
# https://www.lendingclub.com/developers/listed-loans.action
#########################
- view: listings
  fields:
###########################################################    
### LISTINGS
###########################################################  


  - measure: expected_weighted_annual_profitability
    type: number
    format: "%0.1f%"
    sql: SUM(${expected_profitability} * ${loan_amount}) / ${total_loan_amount}

  - dimension: expected_profitability
    type: number
    format: "%0.1f%"
    sql: 100 * (${interest_rate}/100 - ${is_bad}*(1 - ${is_bad}))

  - dimension: is_bad
    description: 'probability'
    type: number
    decimals: 2
    sql: |
      EXP(20.4681692 + -0.0358713*${applicant.fico_range_high} + 0.0008713*${applicant.fico_range_low} 
      + 0.0187961*${applicant.pub_rec_bankruptcies} + -0.0059923*${applicant.revol_utilization} 
      + -0.2145666*${applicant.inquiries_last_6mths} + -0.1935067*${applicant.is_rent})

  - dimension: applicant.is_rent
    type: yesno
    hidden: true
    sql: CASE WHEN (${applicant.home_ownership} = 'RENT') THEN 1 ELSE 0 END

  - dimension: id
    primary_key: true
    type: int
    sql: ${TABLE}."id"

  - dimension_group: accepted
    type: time
    timeframes: [hour_of_day, time, date, week, month, dow]
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
    format: "%0.2f%"
    sql: ${TABLE}."intRate"
    
#does this field exist?
#   - dimension: number_of_investors
#     type: number
#     sql: ${TABLE}."investorCount"

  - dimension_group: listed
    label: "DATE"
    type: time
    timeframes: [time, date, week, month, hod, dow]
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
    
###########################################################    
### APPLICANT
###########################################################    


  - dimension: applicant.accounts_delinquent
    description: "The number of accounts on which the applicant is now delinquent."
    type: number
    sql: ${TABLE}."accNowDelinq"

  - dimension: applicant.accounts_past_24months
    description: "Number of trades opened in past 24 months."
    type: number
    sql: ${TABLE}."accOpenPast24Mths"

#DEPRECATED
#   - dimension: applicant.address_city
#     sql: ${TABLE}."addrCity"

  - dimension: applicant.address_state
    sql: ${TABLE}."addrState"

  #currently not used (for future campability)
  - dimension: applicant.address_zip
    sql: ${TABLE}."addrZip"

  - dimension: applicant.annual_income_tier
    type: tier
    tiers: [30000,50000,70000,90000,110000]
    sql: ${applicant.annual_income}
    
#   - dimension: decile_income_bucket
#     type: tier
#     tiers: [0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9]
#     sql: ${distributions.income_accum_metric_pct}
#     required_joins: [distributions]

  - dimension: applicant.annual_income
    type: number
    sql: ${TABLE}."annualInc"

  - dimension: applicant.average_current_balance
    type: number
    sql: ${TABLE}."avgCurBal"

  - dimension: applicant.bc_open_to_buy
    type: number
    sql: ${TABLE}."bcOpenToBuy"

  - dimension: applicant.bc_util
    type: number
    sql: ${TABLE}."bcUtil"

  - dimension: applicant.chargeoff_within_12_mths
    type: number
    sql: ${TABLE}."chargeoffWithin12Mths"

  - dimension: applicant.collections_12_mths_ex_med
    type: number
    sql: ${TABLE}."collections12MthsExMed"

  - dimension_group: applicant.credit_pull
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}."creditPullD"

  - dimension: applicant.delinq_2yrs
    type: number
    sql: ${TABLE}."delinq2Yrs"

  - dimension: applicant.delinquent_amount
    type: number
    sql: ${TABLE}."delinqAmnt"

  - dimension: applicant.dti
    type: number
    sql: ${TABLE}."dti"

  - dimension_group: applicant.earliest_cr_line
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}."earliestCrLine"

  - dimension: applicant.emp_length
    sql: |
      CASE
        WHEN ${TABLE}."empLength" < 12 THEN '< 1 year'
        WHEN ${TABLE}."empLength" = 12 THEN '1 year'
        WHEN ${TABLE}."empLength" >= 120 THEN '10+ years'
        ELSE floor(${TABLE}."empLength" / 12.0) || ' years'
      END

  - dimension: applicant.emp_title
    sql: ${TABLE}."empTitle"

  - dimension: applicant.expected_default_rate
    type: number
    format: "%0.2f%"
    sql: ${TABLE}."expDefaultRate"

  - dimension: applicant.fico_range_high
    type: number
    sql: ${TABLE}."ficoRangeHigh"

  - dimension: applicant.fico_range_low
    type: number
    sql: ${TABLE}."ficoRangeLow"
    
  - dimension: applicant.fico_high_tier
    type: tier
    tiers: [650,700,750,800,900]
    sql: ${applicant.fico_range_high}
    
  - dimension: applicant.fico_low_tier
    type: tier
    tiers: [600,750,900]
    sql: ${applicant.fico_range_low}    

  - dimension: applicant.home_ownership
    sql: ${TABLE}."homeOwnership"

  - dimension: applicant.inquiries_last_6mths
    type: number
    sql: ${TABLE}."inqLast6Mths"

  - dimension: applicant.is_income_verified
    suggestions: [NOT_VERIFIED,SOURCE_VERIFIED,VERIFIED]
    sql: ${TABLE}."isIncV"

  - dimension: applicant.id
    type: int
    sql: ${TABLE}."memberId"

  - dimension: applicant.mo_sin_old_il_acct
    type: number
    sql: ${TABLE}."moSinOldIlAcct"

  - dimension: applicant.mo_sin_old_rev_tl_op
    type: number
    sql: ${TABLE}."moSinOldRevTlOp"

  - dimension: applicant.mo_sin_rcnt_rev_tl_op
    type: number
    sql: ${TABLE}."moSinRcntRevTlOp"

  - dimension: applicant.mo_sin_rcnt_tl
    type: number
    sql: ${TABLE}."moSinRcntTl"

  - dimension: applicant.number_mortgage_accounts
    type: number
    sql: ${TABLE}."mortAcc"

  - dimension: applicant.mths_since_last_delinq
    type: number
    sql: ${TABLE}."mthsSinceLastDelinq"

  - dimension: applicant.mths_since_last_major_derog
    type: number
    sql: ${TABLE}."mthsSinceLastMajorDerog"

  - dimension: applicant.mths_since_last_record
    type: number
    sql: ${TABLE}."mthsSinceLastRecord"

  - dimension: applicant.mths_since_recent_bc
    type: number
    sql: ${TABLE}."mthsSinceRecentBc"

  - dimension: applicant.mths_since_recent_bc_dlq
    type: number
    sql: ${TABLE}."mthsSinceRecentBcDlq"

  - dimension: applicant.mths_since_recent_inq
    type: number
    sql: ${TABLE}."mthsSinceRecentInq"

  - dimension: applicant.mths_since_recent_revol_delinq
    type: number
    sql: ${TABLE}."mthsSinceRecentRevolDelinq"

  - dimension: applicant.num_accts_ever_120_pd
    label: "APPLICANT Number of Accounts Past Due 120"
    type: number
    sql: ${TABLE}."numAcctsEver120Ppd"

  - dimension: applicant.num_actv_bc_tl
    type: number
    sql: ${TABLE}."numActvBcTl"

  - dimension: applicant.num_actv_rev_tl
    type: number
    sql: ${TABLE}."numActvRevTl"

  - dimension: applicant.num_bc_sats
    type: number
    sql: ${TABLE}."numBcSats"

  - dimension: applicant.num_bc_tl
    type: number
    sql: ${TABLE}."numBcTl"

  - dimension: applicant.num_il_tl
    type: number
    sql: ${TABLE}."numIlTl"

  - dimension: applicant.num_op_rev_tl
    type: number
    sql: ${TABLE}."numOpRevTl"

  - dimension: applicant.num_rev_accts
    type: number
    sql: ${TABLE}."numRevAccts"

  - dimension: applicant.num_rev_tl_bal_gt_0
    type: number
    sql: ${TABLE}."numRevTlBalGt0"

  - dimension: applicant.num_sats
    type: number
    sql: ${TABLE}."numSats"

  - dimension: applicant.num_tl_120dpd_2m
    type: number
    sql: ${TABLE}."numTl120dpd2m"

  - dimension: applicant.num_tl_30dpd
    type: number
    sql: ${TABLE}."numTl30dpd"

  - dimension: applicant.num_tl_90g_dpd_24m
    type: number
    sql: ${TABLE}."numTl90gDpd24m"

  - dimension: applicant.num_tl_op_past_12m
    type: number
    sql: ${TABLE}."numTlOpPast12m"

  - dimension: applicant.open_acc
    type: number
    sql: ${TABLE}."openAcc"

  - dimension: applicant.pct_tl_nvr_dlq
    type: number
    sql: ${TABLE}."pctTlNvrDlq"

  - dimension: applicant.percent_bc_gt_75
    type: number
    sql: ${TABLE}."percentBcGt75"

  - dimension: applicant.pub_rec
    type: number
    sql: ${TABLE}."pubRec"

  - dimension: applicant.pub_rec_bankruptcies
    type: number
    sql: ${TABLE}."pubRecBankruptcies"

  - dimension: purpose
    sql: ${TABLE}."purpose"

  - dimension: review_status
    sql: ${TABLE}."reviewStatus"

  - dimension_group: review_status
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}."reviewStatusD"

  - dimension: applicant.revol_bal
    type: number
    sql: ${TABLE}."revolBal"

  - dimension: applicant.revol_utilization
    type: number
    sql: ${TABLE}."revolUtil"
    
  - dimension: applicant.revol_util_tier
    type: tier
    tiers: [20,40,60,80]
    sql: ${applicant.revol_utilization}  

  - dimension: service_fee_rate
    type: number
    sql: ${TABLE}."serviceFeeRate"

  - dimension: sub_grade
    sql: ${TABLE}."subGrade"

  - dimension: applicant.tax_liens
    type: number
    sql: ${TABLE}."taxLiens"

  - dimension: term
    type: number
    sql: ${TABLE}."term"

  - dimension: applicant.tot_coll_amt
    type: number
    sql: ${TABLE}."totCollAmt"

  - dimension: applicant.tot_cur_bal
    type: number
    sql: ${TABLE}."totCurBal"

  - dimension: applicant.tot_hi_cred_lim
    type: int
    sql: ${TABLE}."totHiCredLim"

  - dimension: applicant.total_accounts
    type: number
    sql: ${TABLE}."totalAcc"

  - dimension: applicant.total_bal_ex_mort
    type: number
    sql: ${TABLE}."totalBalExMort"

  - dimension: applicant.total_bc_limit
    type: int
    sql: ${TABLE}."totalBcLimit"::int

  - dimension: applicant.installment_high_credit_limit
    type: number
    sql: ${TABLE}."totalIlHighCreditLimit"

  - dimension: applicant.total_rev_hi_lim
    description: "Total revolving high credit/credit limit"
    type: int
    sql: ${TABLE}."totalRevHiLim"

###########################################################    
### MEASURES/AGGREGATES
###########################################################
###########################################################    
### LISTINGS
###########################################################  

  - measure: count
    type: count
    drill_fields: default*
    format: "%d"
    
  - measure: total_funded_amount
    type: sum
    format: "$%d"
    sql: ${funded_amount}
    
  - measure: total_loan_amount
    type: sum
    format: "$%d"
    sql: ${loan_amount}
    
  - measure: _total_funded_amount    
    hidden: true
    type: number
    format: "$%d"
    sql: ${total_funded_amount}
    html: |
      <font size="7">{{ rendered_value }}</font>    
    
  - measure: _total_loan_amount    
    hidden: true
    type: number
    format: "$%d"
    sql: ${total_loan_amount}
    html: |
      <font size="7">{{ rendered_value }}</font>     
    
  - measure: average_interest_rate
    type: average
    format: "%0.2f%"
    sql: ${interest_rate}
    
  - measure: average_term
    label: "DEBT TO INCOME"
    description: "number of months"
    type: average
    format: "%0.1f"
    sql: ${term}/10
    
###########################################################    
### APPLICANT
###########################################################  

  - measure: applicant.average_income
    type: average
    format: "$%d"
    sql: ${applicant.annual_income}
    
  - measure: applicant.average_expected_default_rate
    type: average
    decimals: 2
    format: "%0.1f%"
    sql: ${applicant.expected_default_rate}
    
    

  # ----- Detail ------
  sets:
    default:
      - id
      - applicant.id
      - applicant.emp_length
      - funded_amount
      - grade
      - term
      - interest_rate
      - purpose

