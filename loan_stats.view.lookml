- view: loan_stats
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

  - dimension: avg_cur_bal
    sql: ${TABLE}.avg_cur_bal

  - dimension: bc_open_to_buy
    sql: ${TABLE}.bc_open_to_buy

  - dimension: bc_util
    sql: ${TABLE}.bc_util

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
    sql: ${TABLE}.fico_range_high

  - dimension: fico_range_low
    type: int
    sql: ${TABLE}.fico_range_low

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
    sql: ${TABLE}.int_rate

  - dimension: is_inc_v
    sql: ${TABLE}.is_inc_v

  - dimension_group: issue_d
    type: time
    timeframes: [date, week, month]
    convert_tz: false
    sql: ${TABLE}.issue_d

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
    sql: ${TABLE}.revol_util

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

  - dimension: total_bc_limit
    sql: ${TABLE}.total_bc_limit

  - dimension: total_il_high_credit_limit
    sql: ${TABLE}.total_il_high_credit_limit

  - dimension: total_pymnt
    type: number
    sql: ${TABLE}.total_pymnt

  - dimension: total_pymnt_inv
    type: number
    sql: ${TABLE}.total_pymnt_inv

  - dimension: total_rec_int
    type: number
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

  - measure: count
    type: count
    drill_fields: [id]

