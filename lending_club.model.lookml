- connection: segah_lending

- scoping: true                  # for backward compatibility
- include: "*.view.lookml"       # include all the views
- include: "*.dashboard.lookml"  # include all the dashboards
- template: liquid


- explore: rejects
  conditionally_filter:
    application_date: after 2014

- explore: loans
  conditionally_filter:
    accepted_date: after 2014
    unless:
    - borrower.id
    - id
    
- explore: listings

