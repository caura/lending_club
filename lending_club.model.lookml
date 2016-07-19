- connection: lendingclub

- scoping: true                  # for backward compatibility
- include: "*.view.lookml"       # include all the views
- include: "*.dashboard.lookml"  # include all the dashboards
- template: liquid


- explore: listings
  persist_for: 4 hours
  joins:
    - join: distributions
      sql_on: ${applicant_id} = ${distributions.uid}
      relationship: many_to_one
      
- explore: rejects
  persist_for: 4 hours
  conditionally_filter:
    application_date: after 2014

- explore: loans
  persist_for: 4 hours
  conditionally_filter:
    issue_date: after 2014
    unless: [borrower_id, id, accepted_date, last_payment_date, next_payment_date, last_credit_pull_date, expired_date, listed_date, issue_quarter, fiscal_yyyyq]
      
- explore: borrower
  hidden: true

