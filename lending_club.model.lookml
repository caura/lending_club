- connection: segah_lending

- scoping: true                  # for backward compatibility
- include: "*.view.lookml"       # include all the views
- include: "*.dashboard.lookml"  # include all the dashboards
- template: liquid


- explore: loan_rejects
  conditionally_filter:
    application_date: after 2014

- explore: loans
  conditionally_filter:
    accept_d_date: after 2014
    unless:
    - member_id
    - id
    
- explore: listings

