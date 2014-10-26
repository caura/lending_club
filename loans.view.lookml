- view: loans
  sql_table_name: loan_stats
  fields:

  - dimension: id
    primary_key: true
    type: int
    sql: ${TABLE}.id

  - dimension: acc_now_delinq
    type: int
    sql: ${TABLE}.acc_now_delinq

  - dimension: acc_open_past_24mths
    sql: ${TABLE}.acc_open_past_24mths

  - dimension_group: accept_d
    type: time
    timeframes: [date, week, month]
    convert_tz: false
    sql: ${TABLE}.accept_d

  - dimension: addr_city
    sql: ${TABLE}.addr_city

  - dimension: addr_state
    sql: ${TABLE}.addr_state

  - dimension: annual_inc
    type: number
    sql: ${TABLE}.annual_inc
    
  - dimension: annual_inc_tier
    type: tier
    tiers: [10000,40000,60000,80000]
    sql: ${annual_inc}

  - dimension: avg_cur_bal
    sql: ${TABLE}.avg_cur_bal

  - dimension: bc_open_to_buy
    sql: ${TABLE}.bc_open_to_buy

  - dimension: bc_util
    type: number
    format: "%0.2f%"
    sql: trim(trailing '%' from trim(${TABLE}.bc_util))::float
    
  - dimension: bc_util_tier
    type: tier
    tiers: [20,40,60,80]
    sql: ${bc_util}
    
  - measure: bc_util_average
    type: average
    format: "%0.2f%"
    sql: ${bc_util}

  - dimension: chargeoff_within_12_mths
    type: int
    sql: ${TABLE}.chargeoff_within_12_mths

  - dimension: collection_recovery_fee
    type: number
    sql: ${TABLE}.collection_recovery_fee

  - dimension: collections_12_mths_ex_med
    type: int
    sql: ${TABLE}.collections_12_mths_ex_med

  - dimension: delinq_2yrs
    type: int
    sql: ${TABLE}.delinq_2yrs

  - dimension: delinq_amnt
    type: int
    sql: ${TABLE}.delinq_amnt

  - dimension: desc
    sql: ${TABLE}.desc

  - dimension: dti
    type: number
    sql: ${TABLE}.dti

  - dimension_group: earliest_cr_line
    type: time
    timeframes: [time, date, week, month]
    sql: ${TABLE}.earliest_cr_line

  - dimension: emp_length
    sql: ${TABLE}.emp_length

  - dimension: emp_title
    sql: ${TABLE}.emp_title

  - dimension_group: exp_d
    type: time
    timeframes: [date, week, month]
    convert_tz: false
    sql: ${TABLE}.exp_d

  - dimension: fico_range_high
    type: int
    hidden: true
    sql: ${TABLE}.fico_range_high

  - dimension: fico_range_low
    type: int
    hidden: true
    sql: ${TABLE}.fico_range_low

  - dimension: fico_high_tier
    type: tier
    tiers: [450,550,650,750,850]
    sql: ${fico_range_high}
    
  - dimension: fico_low_tier
    type: tier
    tiers: [450,550,650,750,850]
    sql: ${fico_range_low}

  - dimension: funded_amnt
    type: int
    sql: ${TABLE}.funded_amnt

  - dimension: funded_amnt_inv
    type: number
    sql: ${TABLE}.funded_amnt_inv

  - dimension: grade
    sql: ${TABLE}.grade

  - dimension: home_ownership
    sql: ${TABLE}.home_ownership

  - dimension: initial_list_status
    sql: ${TABLE}.initial_list_status

  - dimension: inq_last_6mths
    type: int
    sql: ${TABLE}.inq_last_6mths

  - dimension: installment
    type: number
    sql: ${TABLE}.installment

  - dimension: int_rate
    type: number
    format: "%0.2f%"
    sql: trim(trailing '%' from trim(${TABLE}.int_rate))::float

  - dimension: is_inc_v
    sql: ${TABLE}.is_inc_v

  - dimension_group: issue
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

  - dimension_group: last_credit_pull_d
    type: time
    timeframes: [date, week, month]
    convert_tz: false
    sql: ${TABLE}.last_credit_pull_d

  - dimension: last_fico_range_high
    type: int
    sql: ${TABLE}.last_fico_range_high

  - dimension: last_fico_range_low
    type: int
    sql: ${TABLE}.last_fico_range_low

  - dimension: last_pymnt_amnt
    type: number
    sql: ${TABLE}.last_pymnt_amnt

  - dimension_group: last_pymnt_d
    type: time
    timeframes: [date, week, month]
    convert_tz: false
    sql: ${TABLE}.last_pymnt_d

  - dimension_group: list_d
    type: time
    timeframes: [date, week, month]
    convert_tz: false
    sql: ${TABLE}.list_d

  - dimension: loan_amnt
    type: int
    sql: ${TABLE}.loan_amnt

  - dimension: loan_status
    sql: ${TABLE}.loan_status

  - dimension: member_id
    type: int
    sql: ${TABLE}.member_id

  - dimension: mo_sin_old_il_acct
    sql: ${TABLE}.mo_sin_old_il_acct

  - dimension: mo_sin_old_rev_tl_op
    sql: ${TABLE}.mo_sin_old_rev_tl_op

  - dimension: mo_sin_rcnt_rev_tl_op
    sql: ${TABLE}.mo_sin_rcnt_rev_tl_op

  - dimension: mo_sin_rcnt_tl
    sql: ${TABLE}.mo_sin_rcnt_tl

  - dimension: mort_acc
    sql: ${TABLE}.mort_acc

  - dimension: mths_since_last_delinq
    sql: ${TABLE}.mths_since_last_delinq

  - dimension: mths_since_last_major_derog
    sql: ${TABLE}.mths_since_last_major_derog

  - dimension: mths_since_last_record
    sql: ${TABLE}.mths_since_last_record

  - dimension: mths_since_recent_bc
    sql: ${TABLE}.mths_since_recent_bc

  - dimension: mths_since_recent_bc_dlq
    sql: ${TABLE}.mths_since_recent_bc_dlq

  - dimension: mths_since_recent_inq
    sql: ${TABLE}.mths_since_recent_inq

  - dimension: mths_since_recent_revol_delinq
    sql: ${TABLE}.mths_since_recent_revol_delinq

  - dimension_group: next_pymnt_d
    type: time
    timeframes: [date, week, month]
    convert_tz: false
    sql: ${TABLE}.next_pymnt_d

  - dimension: num_accts_ever_120_pd
    sql: ${TABLE}.num_accts_ever_120_pd

  - dimension: num_actv_bc_tl
    sql: ${TABLE}.num_actv_bc_tl

  - dimension: num_actv_rev_tl
    sql: ${TABLE}.num_actv_rev_tl

  - dimension: num_bc_sats
    sql: ${TABLE}.num_bc_sats

  - dimension: num_bc_tl
    sql: ${TABLE}.num_bc_tl

  - dimension: num_il_tl
    sql: ${TABLE}.num_il_tl

  - dimension: num_op_rev_tl
    sql: ${TABLE}.num_op_rev_tl

  - dimension: num_rev_accts
    sql: ${TABLE}.num_rev_accts

  - dimension: num_rev_tl_bal_gt_0
    sql: ${TABLE}.num_rev_tl_bal_gt_0

  - dimension: num_sats
    sql: ${TABLE}.num_sats

  - dimension: num_tl_120dpd_2m
    sql: ${TABLE}.num_tl_120dpd_2m

  - dimension: num_tl_30dpd
    sql: ${TABLE}.num_tl_30dpd

  - dimension: num_tl_90g_dpd_24m
    sql: ${TABLE}.num_tl_90g_dpd_24m

  - dimension: num_tl_op_past_12m
    sql: ${TABLE}.num_tl_op_past_12m

  - dimension: open_acc
    type: int
    sql: ${TABLE}.open_acc

  - dimension: out_prncp
    type: number
    sql: ${TABLE}.out_prncp

  - dimension: out_prncp_inv
    type: number
    sql: ${TABLE}.out_prncp_inv

  - dimension: pct_tl_nvr_dlq
    sql: ${TABLE}.pct_tl_nvr_dlq

  - dimension: percent_bc_gt_75
    sql: ${TABLE}.percent_bc_gt_75

  - dimension: policy_code
    type: int
    sql: ${TABLE}.policy_code

  - dimension: pub_rec
    type: int
    sql: ${TABLE}.pub_rec

  - dimension: pub_rec_bankruptcies
    type: int
    sql: ${TABLE}.pub_rec_bankruptcies

  - dimension: purpose
    sql: ${TABLE}.purpose

  - dimension: pymnt_plan
    type: yesno
    sql: ${TABLE}.pymnt_plan

  - dimension: recoveries
    type: number
    sql: ${TABLE}.recoveries

  - dimension: revol_bal
    type: int
    sql: ${TABLE}.revol_bal

  - dimension: revol_util
    type: number
    format: "%0.2f%"
    sql: trim(trailing '%' from trim(${TABLE}.revol_util))::float
    
  - dimension: revol_util_tier
    type: tier
    tiers: [20,40,60,80]
    sql: ${revol_util}
    
  - measure: revol_util_average
    type: sum
    format: "%0.2f%"
    sql: ${revol_util}

  - dimension: sub_grade
    sql: ${TABLE}.sub_grade

  - dimension: tax_liens
    type: int
    sql: ${TABLE}.tax_liens

  - dimension: term
    sql: ${TABLE}.term

  - dimension: title
    sql: ${TABLE}.title

  - dimension: tot_coll_amt
    sql: ${TABLE}.tot_coll_amt

  - dimension: tot_cur_bal
    sql: ${TABLE}.tot_cur_bal

  - dimension: tot_hi_cred_lim
    sql: ${TABLE}.tot_hi_cred_lim

  - dimension: total_acc
    type: int
    sql: ${TABLE}.total_acc

  - dimension: total_bal_ex_mort
    sql: ${TABLE}.total_bal_ex_mort

  - dimension: bc_limit
    type: number
    format: "$%d"
    sql: ${TABLE}.total_bc_limit::int
    
  - measure: average_bc_limit
    type: average
    format: "$%d"
    sql: ${bc_limit}

  - dimension: il_high_credit_limit
    type: number
    format: "$%d"  
    sql: ${TABLE}.total_il_high_credit_limit::int
  
  - measure: average_il_high_credit_limit
    type: average
    format: "$%d"
    sql: ${il_high_credit_limit}

  - dimension: total_pymnt
    type: number
    sql: ${TABLE}.total_pymnt

  - dimension: total_pymnt_inv
    type: number
    sql: ${TABLE}.total_pymnt_inv

  - dimension: total_rec_int
    type: number
    format: "$%d"
    sql: ${TABLE}.total_rec_int

  - dimension: total_rec_late_fee
    type: number
    sql: ${TABLE}.total_rec_late_fee

  - dimension: total_rec_prncp
    type: number
    sql: ${TABLE}.total_rec_prncp

  - dimension: total_rev_hi_lim
    sql: ${TABLE}.total_rev_hi_lim

  - dimension: url
    sql: ${TABLE}.url
    html: |
      <a href="{{ value }}" target="_blank">LendingClub <img src="/images/qr-graph-line@2x.png" height=20 width=20</a>
    
  - dimension: return_num
    type: number
    hidden: true
    sql: 0.99 * (${total_rec_int} + ${total_rec_late_fee}) - ${out_prncp_inv} + (${recoveries} - ${collection_recovery_fee})
  
  - dimension: sum_of_returns
    hidden: true
    type: sum
    sql: ${return_num}
  
  - measure: total_outstanding_principal_inv
    type: sum
    sql: ${out_prncp_inv}
  
  - measure: nar
    type: number
    format: "%0.2f%"
    sql: (POWER(1 + ${sum_of_returns} / NULLIF(${total_outstanding_principal_inv},0),12.0) - 1) * 100.0
    

  - measure: count
    type: count
    drill_fields: [id]
    
  - measure: percent_of_total
    decimals: 2
    type: percent_of_total
    sql: ${count}
    
  - measure: verified_loans
    type: count
    filters:
      is_inc_v: "Verified"
    
  - measure: percent_verified
    type: number
    format: "%0.2f%"
    sql: 100.0 * ${verified_loans} / NULLIF(${count},null)
    
  - measure: total_amount
    type: sum
    sql: ${loan_amnt}
    format: "$%d"
    
  - measure: average_int_rate
    type: average
    format: "%0.2f%"
    sql: ${int_rate}
    
#     
#     "id":111111,
#     "memberId":222222,
#     "loanAmount":1750.0,
#     "fundedAmount":25.0,
#     "term":36,
#     "intRate":10.99,
#     "expDefaultRate":3.5,
#     "serviceFeeRate":0.85,
#     "installment":57.29,
#     "grade":"B",
#     "subGrade":"B3",
#     "empLength":0,
#     "homeOwnership":"OWN",
#     "annualInc":123432.0,
#     "isIncV":"Requested",
#     "acceptD":"2014-08-25T10:56:29.000-07:00",
#     "expD":"2014-09-08T10:57:13.000-07:00",
#     "listD":"2014-08-25T10:50:20.000-07:00",
#     "creditPullD":"2014-08-25T10:56:18.000-07:00",
#     "reviewStatusD":"2014-09-03T14:41:53.957-07:00",
#     "reviewStatus":"NOT_APPROVED",
#     "desc":"Loan description",
#     "purpose":"debt_consolidation",
#     "addrCity":"San Leandro",
#     "addrState":"CA",
#     "investorCount":"",
#     "ilsExpD":"2014-08-25T11:00:00.000-07:00",
#     "initialListStatus":"F",
#     "empTitle":"",
#     "accNowDelinq":"",
#     "accOpenPast24Mths":23,
#     "bcOpenToBuy":30000,
#     "percentBcGt75":23.0,
#     "bcUtil":23.0,
#     "dti":0.0,
#     "delinq2Yrs":1,
#     "delinqAmnt":0.0,
#     "earliestCrLine":"1984-09-15T00:00:00.000-07:00",
#     "ficoRangeLow":750,
#     "ficoRangeHigh":754,
#     "inqLast6Mths":0,
#     "mthsSinceLastDelinq":90,
#     "mthsSinceLastRecord":0,
#     "mthsSinceRecentInq":14,
#     "mthsSinceRecentRevolDelinq":23,
#     "mthsSinceRecentBc":23,
#     "mortAcc":23,
#     "openAcc":3,
#     "pubRec":0,
#     "totalBalExMort":13944,
#     "revolBal":1.0,
#     "revolUtil":0.0,
#     "totalBcLimit":23,
#     "totalAcc":4,
#     "totalIlHighCreditLimit":12,
#     "numRevAccts":28,
#     "mthsSinceRecentBcDlq":52,
#     "pubRecBankruptcies":0,
#     "numAcctsEver120Ppd":12,
#     "chargeoffWithin12Mths":0,
#     "collections12MthsExMed":0,
#     "taxLiens":0,
#     "mthsSinceLastMajorDerog":12,
#     "numSats":8,
#     "numTlOpPast12m":0,
#     "moSinRcntTl":12,
#     "totHiCredLim":12,
#     "totCurBal":12,
#     "avgCurBal":12,
#     "numBcTl":12,
#     "numActvBcTl":12,
#     "numBcSats":7,
#     "pctTlNvrDlq":12,
#     "numTl90gDpd24m":12,
#     "numTl30dpd":12,
#     "numTl120dpd2m":12,
#     "numIlTl":12,
#     "moSinOldIlAcct":12,
#     "numActvRevTl":12,
#     "moSinOldRevTlOp":12,
#     "moSinRcntRevTlOp":11,
#     "totalRevHiLim":12,
#     "numRevTlBalGt0":12,
#     "numOpRevTl":12,
#     "totCollAmt":12    

