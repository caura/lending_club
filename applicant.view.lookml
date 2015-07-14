- view: applicant

  fields:
  
  - dimension: is_rent
    type: number
    sql: CASE WHEN (${home_ownership} = 'RENT') THEN 1 ELSE 0 END
    view_label: Applicant
    
  - dimension: accounts_delinquent
    description: "The number of accounts on which the applicant is now delinquent."
    type: number
    sql: ${TABLE}."accNowDelinq"
    view_label: Applicant

  - dimension: accounts_past_24months
    description: "Number of trades opened in past 24 months."
    type: number
    sql: ${TABLE}."accOpenPast24Mths"
    view_label: Applicant

#DEPRECATED
#   - dimension: address_city
#     sql: ${TABLE}."addrCity"

  - dimension: address_state
    sql: ${TABLE}."addrState"
    view_label: Applicant

  #currently not used (for future campability)
  - dimension: address_zip
    sql: ${TABLE}."addrZip"
    view_label: Applicant

  - dimension: annual_income_tier
    type: tier
    tiers: [30000,50000,70000,90000,110000]
    sql: ${annual_income}
    view_label: Applicant
    
#   - dimension: decile_income_bucket
#     type: tier
#     tiers: [0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9]
#     sql: ${distributions.income_accum_metric_pct}
#     required_joins: [distributions]

  - dimension: annual_income
    type: number
    sql: ${TABLE}."annualInc"
    view_label: Applicant

  - dimension: average_current_balance
    type: number
    sql: ${TABLE}."avgCurBal"
    view_label: Applicant

  - dimension: bc_open_to_buy
    type: number
    sql: ${TABLE}."bcOpenToBuy"
    view_label: Applicant
    
  - dimension: bc_util
    type: number
    sql: ${TABLE}."bcUtil"
    view_label: Applicant

  - dimension: chargeoff_within_12_mths
    type: number
    sql: ${TABLE}."chargeoffWithin12Mths"
    view_label: Applicant

  - dimension: collections_12_mths_ex_med
    type: number
    sql: ${TABLE}."collections12MthsExMed"
    view_label: Applicant

  - dimension_group: credit_pull
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}."creditPullD"
    view_label: Applicant
    
  - dimension: delinq_2yrs
    type: number
    sql: ${TABLE}."delinq2Yrs"
    view_label: Applicant
    
  - dimension: delinquent_amount
    type: number
    sql: ${TABLE}."delinqAmnt"
    view_label: Applicant

  - dimension: dti
    type: number
    sql: ${TABLE}."dti"
    view_label: Applicant

  - dimension_group: earliest_cr_line
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}."earliestCrLine"
    view_label: Applicant

  - dimension: emp_length
    sql: |
      CASE
        WHEN ${TABLE}."empLength" < 12 THEN '< 1 year'
        WHEN ${TABLE}."empLength" = 12 THEN '1 year'
        WHEN ${TABLE}."empLength" >= 120 THEN '10+ years'
        ELSE floor(${TABLE}."empLength" / 12.0) || ' years'
      END
    view_label: Applicant

  - dimension: emp_title
    sql: ${TABLE}."empTitle"
    view_label: Applicant

  - dimension: expected_default_rate
    type: number
    value_format: '0.00\%'
    sql: ${TABLE}."expDefaultRate"
    view_label: Applicant

  - dimension: fico_range_high
    type: number
    sql: ${TABLE}."ficoRangeHigh"
    view_label: Applicant

  - dimension: fico_range_low
    type: number
    sql: ${TABLE}."ficoRangeLow"
    view_label: Applicant
    
  - dimension: fico_high_tier
    type: tier
    tiers: [650,700,750,800,900]
    sql: ${fico_range_high}
    view_label: Applicant
    
  - dimension: fico_low_tier
    type: tier
    tiers: [600,750,900]
    sql: ${fico_range_low}
    view_label: Applicant

  - dimension: home_ownership
    sql: ${TABLE}."homeOwnership"
    view_label: Applicant

  - dimension: inquiries_last_6mths
    type: number
    sql: ${TABLE}."inqLast6Mths"
    view_label: Applicant

  - dimension: is_income_verified
    suggestions: [NOT_VERIFIED,SOURCE_VERIFIED,VERIFIED]
    sql: ${TABLE}."isIncV"
    view_label: Applicant

  - dimension: id
    type: int
    sql: ${TABLE}."memberId"
    view_label: Applicant

  - dimension: mo_sin_old_il_acct
    type: number
    sql: ${TABLE}."moSinOldIlAcct"
    view_label: Applicant
    
  - dimension: mo_sin_old_rev_tl_op
    type: number
    sql: ${TABLE}."moSinOldRevTlOp"
    view_label: Applicant

  - dimension: mo_sin_rcnt_rev_tl_op
    type: number
    sql: ${TABLE}."moSinRcntRevTlOp"
    view_label: Applicant

  - dimension: mo_sin_rcnt_tl
    type: number
    sql: ${TABLE}."moSinRcntTl"
    view_label: Applicant

  - dimension: number_mortgage_accounts
    type: number
    sql: ${TABLE}."mortAcc"
    view_label: Applicant

  - dimension: mths_since_last_delinq
    type: number
    sql: ${TABLE}."mthsSinceLastDelinq"
    view_label: Applicant

  - dimension: mths_since_last_major_derog
    type: number
    sql: ${TABLE}."mthsSinceLastMajorDerog"
    view_label: Applicant

  - dimension: mths_since_last_record
    type: number
    sql: ${TABLE}."mthsSinceLastRecord"
    view_label: Applicant
    
  - dimension: mths_since_recent_bc
    type: number
    sql: ${TABLE}."mthsSinceRecentBc"

  - dimension: mths_since_recent_bc_dlq
    type: number
    sql: ${TABLE}."mthsSinceRecentBcDlq"
    view_label: Applicant

  - dimension: mths_since_recent_inq
    type: number
    sql: ${TABLE}."mthsSinceRecentInq"
    view_label: Applicant
    
  - dimension: mths_since_recent_revol_delinq
    type: number
    sql: ${TABLE}."mthsSinceRecentRevolDelinq"
    view_label: Applicant

  - dimension: num_accts_ever_120_pd
    label: "Number of Accounts Past Due 120"
    type: number
    sql: ${TABLE}."numAcctsEver120Ppd"
    view_label: Applicant

  - dimension: num_actv_bc_tl
    type: number
    sql: ${TABLE}."numActvBcTl"
    view_label: Applicant

  - dimension: num_actv_rev_tl
    type: number
    sql: ${TABLE}."numActvRevTl"
    view_label: Applicant
    
  - dimension: num_bc_sats
    type: number
    sql: ${TABLE}."numBcSats"
    view_label: Applicant
    
  - dimension: num_bc_tl
    type: number
    sql: ${TABLE}."numBcTl"
    view_label: Applicant

  - dimension: num_il_tl
    type: number
    sql: ${TABLE}."numIlTl"
    view_label: Applicant

  - dimension: num_op_rev_tl
    type: number
    sql: ${TABLE}."numOpRevTl"
    view_label: Applicant

  - dimension: num_rev_accts
    type: number
    sql: ${TABLE}."numRevAccts"
    view_label: Applicant

  - dimension: num_rev_tl_bal_gt_0
    type: number
    sql: ${TABLE}."numRevTlBalGt0"
    view_label: Applicant

  - dimension: num_sats
    type: number
    sql: ${TABLE}."numSats"
    view_label: Applicant

  - dimension: num_tl_120dpd_2m
    type: number
    sql: ${TABLE}."numTl120dpd2m"
    view_label: Applicant
    
  - dimension: num_tl_30dpd
    type: number
    sql: ${TABLE}."numTl30dpd"
    view_label: Applicant

  - dimension: num_tl_90g_dpd_24m
    type: number
    sql: ${TABLE}."numTl90gDpd24m"
    view_label: Applicant

  - dimension: num_tl_op_past_12m
    type: number
    sql: ${TABLE}."numTlOpPast12m"
    view_label: Applicant

  - dimension: open_acc
    type: number
    sql: ${TABLE}."openAcc"
    view_label: Applicant
    
  - dimension: pct_tl_nvr_dlq
    type: number
    sql: ${TABLE}."pctTlNvrDlq"
    view_label: Applicant

  - dimension: percent_bc_gt_75
    type: number
    sql: ${TABLE}."percentBcGt75"
    view_label: Applicant

  - dimension: pub_rec
    type: number
    sql: ${TABLE}."pubRec"
    view_label: Applicant

  - dimension: pub_rec_bankruptcies
    type: number
    sql: ${TABLE}."pubRecBankruptcies"
    view_label: Applicant
    
  - dimension: purpose_raw
    sql: ${TABLE}."purpose"
    view_label: Applicant
    
  - dimension: purpose
    sql:
      CASE
      WHEN ${purpose_raw} IN (
          'debt_consolidation'
          , 'home_improvement'
          , 'credit_card'
          , 'small_business'
          , 'major_purchase'
          )
      THEN ${purpose_raw}
      ELSE 'other'
      END
    view_label: Applicant
    

  - dimension: revol_bal
    type: number
    sql: ${TABLE}."revolBal"
    view_label: Applicant

  - dimension: revol_utilization
    type: number
    sql: ${TABLE}."revolUtil"
    view_label: Applicant
    
  - dimension: revol_util_tier
    type: tier
    tiers: [20,40,60,80]
    sql: ${revol_utilization}  
    view_label: Applicant

  - dimension: tax_liens
    type: number
    sql: ${TABLE}."taxLiens"
    view_label: Applicant


  - dimension: tot_coll_amt
    type: number
    sql: ${TABLE}."totCollAmt"
    view_label: Applicant

  - dimension: tot_cur_bal
    type: number
    sql: ${TABLE}."totCurBal"
    view_label: Applicant

  - dimension: tot_hi_cred_lim
    type: int
    sql: ${TABLE}."totHiCredLim"
    view_label: Applicant

  - dimension: total_accounts
    type: number
    sql: ${TABLE}."totalAcc"
    view_label: Applicant

  - dimension: total_bal_ex_mort
    type: number
    sql: ${TABLE}."totalBalExMort"
    view_label: Applicant

  - dimension: total_bc_limit
    type: int
    sql: ${TABLE}."totalBcLimit"::int
    view_label: Applicant

  - dimension: installment_high_credit_limit
    type: number
    sql: ${TABLE}."totalIlHighCreditLimit"
    view_label: Applicant

  - dimension: total_rev_hi_lim
    description: "Total revolving high credit/credit limit"
    type: int
    sql: ${TABLE}."totalRevHiLim"
    view_label: Applicant
    
    
    
  - measure: average_income
    type: average
    value_format: '$#,##0.00'
    sql: ${annual_income}
    view_label: Applicant
    
  - measure: average_expected_default_rate
    type: average
    decimals: 2
    value_format: '0.0\%' 
    sql: ${expected_default_rate}
    view_label: Applicant