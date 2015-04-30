- view: predict_bad_loans
  derived_table:
    sql: |
      SELECT 
        listings."id" AS listing_id
        , GlmPredict(
            "loans.issue_year","loans.is_rent",
            "borrower.revol_utilization","borrower.fico_range_high",
            "borrower.fico_range_low","borrower.inquiries_last_6mths",
            "borrower.pub_rec_bankruptcies"
      USING PARAMETERS model='dbadmin/glmLoans' ,TYPE='response') AS is_bad_probability
      FROM listings

  fields:
#     Define your dimensions and measures here, like this:
    - dimension: listing_id
      primary_key: true

    - dimension: is_bad_probability
      type: number
      decimals: 2
