- dashboard: historical_perfomance
  title: "Historical Perfomance - Lending Club"
  layout: tile
  tile_size: 100

  filters:

  - name: date
    title: "Date for New loans"
    type: date_filter
    default_value: last year
    
  - name: address_state
    title: "State"
    type: field_filter
    explore: borrower
    field: borrower.address_state

  - name: annual_income
    title: "Income"
    type: number_filter
    default_value: '>10000'

  - name: loan_amount
    title: "Loan Amount"
    type: number_filter
    
  - name: grade
    title: "Grade"
    type: field_filter
    explore: loans
    field: loans.grade
    
  - name: employment_length
    title: "Employment Length"
    type: field_filter
    explore: borrower
    field: borrower.employment_length

  - name: purpose
    title: "Loan Purpose"
    type: field_filter
    explore: loans
    field: loans.purpose
    
  - name: is_income_verified
    title: "Income Verification"
    type: field_filter
    explore: borrower
    field: borrower.is_income_verified
    
  - name: interest_rate
    title: "Interest Rate"
    type: number_filter

  elements:
  
  - name: add_a_unique_name_462
    title: "Issued Loans"
    type: single_value
    font_size: medium
    model: lending_club
    explore: loans
    measures: [loans.count]
    sorts: [loans.count desc]
    limit: 500
    listen:
      annual_income: loans.annual_income
      address_state: loans.address_state
      employment_length: loans.employment_length
      is_income_verified: loans.is_income_verified      
      date: loans.issue_date
      loan_amount: loans.loan_amount
      grade: loans.grade
      purpose: loans.purpose
      interest_rate: loans.interest_rate       
    width: 4
    height: 2
    font_size: small
    
  - name: add_a_unique_name_523
    title: "Total Principal"
    font_size: medium
    type: single_value
    model: lending_club
    explore: loans
    measures: [loans.total_loan_amount]
    limit: 500
    listen:
      annual_income: loans.annual_income
      address_state: loans.address_state
      employment_length: loans.employment_length
      is_income_verified: loans.is_income_verified      
      date: loans.issue_date
      loan_amount: loans.loan_amount
      grade: loans.grade
      purpose: loans.purpose
      interest_rate: loans.interest_rate       
    width: 4
    height: 2
    font_size: small
    
  - name: add_a_unique_name_25
    title: "Total Recoveries"
    font_size: medium
    type: single_value
    model: lending_club
    explore: loans
    measures: [loans.sum_recoveries]
    listen:
      annual_income: loans.annual_income
      address_state: loans.address_state
      employment_length: loans.employment_length
      is_income_verified: loans.is_income_verified      
      date: loans.issue_date
      loan_amount: loans.loan_amount
      grade: loans.grade
      purpose: loans.purpose
      interest_rate: loans.interest_rate
    sorts: [loans.issue_date, loans.sum_recoveries desc]
    limit: 500
    show_null_labels: false
    width: 4
    height: 2
    font_size: small
    
  - name: add_a_unique_name_350
    title: "Total Loans and Lent Amount by Loan Status"
    type: table
    model: lending_club
    explore: loans
    dimensions: [loans.loan_status]
    measures: [loans.count, loans.total_loan_amount]
    listen:
      annual_income: loans.annual_income
      address_state: loans.address_state
      employment_length: loans.employment_length
      is_income_verified: loans.is_income_verified      
      date: loans.issue_date
      loan_amount: loans.loan_amount
      grade: loans.grade
      purpose: loans.purpose
      interest_rate: loans.interest_rate
    limit: 500
      
    
  - name: loans_by_amount_type
    title: "Loans by Amount Sum"
    type: looker_area
    explore: loans
    dimensions: [loans.issue_week,loans.loan_amount_tiers]
    pivots: [loans.loan_amount_tiers]
    measures: [loans.count]
    listen:
      annual_income: loans.annual_income
      address_state: loans.address_state
      date: loans.issue_date
      loan_amount: loans.loan_amount
      grade: loans.grade
      employment_length: loans.employment_length
      purpose: loans.purpose
      is_income_verified: loans.is_income_verified
      interest_rate: loans.interest_rate
    sorts: [loans.count desc]
    limit: 500
    width:
    height:
    legend_align:
    hide_legend:
    stacking: normal
    x_axis_label:
    x_axis_datetime_label:
    x_axis_label_rotation:
    y_axis_orientation:
    x_axis_datetime_tick_count: '5'
    y_axis_combined:
    y_axis_labels:
    y_axis_min:
    y_axis_max:
    colors: ["#651F81", "#80237D", "#C488DD", "#Ef7F0F", "#FEAC47", "#8ED1ED"]
    x_axis_datetime: yes
    hide_points: yes
    hide_legend: yes