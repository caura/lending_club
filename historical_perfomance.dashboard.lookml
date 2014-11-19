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
    type: suggest_filter
    explore: loans
    dimension: borrower.address_state

  - name: annual_income
    title: "Income"
    type: number_filter
    default_value: '>10000'

  - name: loan_amount
    title: "Loan Amount"
    type: number_filter
    
  - name: grade
    title: "Grade"
    type: suggest_filter
    explore: loans
    dimension: loans.grade
    
  - name: emp_length
    title: "Employment Length"
    type: suggest_filter
    explore: loans
    dimension: borrower.emp_length

  - name: purpose
    title: "Loan Purpose"
    type: suggest_filter
    explore: loans
    dimension: loans.purpose
    
  - name: is_income_verified
    title: "Inc Verification"
    type: suggest_filter
    explore: loans
    dimension: borrower.is_income_verified
    
  - name: interest_rate
    title: "Interest Rate"
    type: number_filter

  elements:
  
  - name: add_a_unique_name_462
    title: "Issed Loans"
    type: single_value
    model: lending_club
    explore: loans
    measures: [loans.count]
    sorts: [loans.count desc]
    limit: 500
    listen:
      annual_income: borrower.annual_income
      address_state: borrower.address_state
      emp_length: borrower.emp_length
      is_income_verified: borrower.is_income_verified      
      date: loans.issue_date
      loan_amount: loans.loan_amount
      grade: loans.grade
      purpose: loans.purpose
      interest_rate: loans.interest_rate       
    width: 4
    height: 3
    
  - name: add_a_unique_name_523
    title: "Total Principal"
    type: single_value
    model: lending_club
    explore: loans
    measures: [loans._total_loan_amount]
    limit: 500
    listen:
      annual_income: borrower.annual_income
      address_state: borrower.address_state
      emp_length: borrower.emp_length
      is_income_verified: borrower.is_income_verified      
      date: loans.issue_date
      loan_amount: loans.loan_amount
      grade: loans.grade
      purpose: loans.purpose
      interest_rate: loans.interest_rate       
    width: 4
    height: 3
    
  - name: add_a_unique_name_25
    title: "Total Recoveries"
    type: single_value
    model: lending_club
    explore: loans
    measures: [loans._sum_recoveries]
    listen:
      annual_income: borrower.annual_income
      address_state: borrower.address_state
      emp_length: borrower.emp_length
      is_income_verified: borrower.is_income_verified      
      date: loans.issue_date
      loan_amount: loans.loan_amount
      grade: loans.grade
      purpose: loans.purpose
      interest_rate: loans.interest_rate
    sorts: [loans.issue_date, loans.sum_recoveries desc]
    limit: 500
    show_null_labels: false
    width: 4
    height: 3
    
  - name: add_a_unique_name_350
    title: "Total Loans and Lent Amount by Loan Status"
    type: table
    model: lending_club
    explore: loans
    dimensions: [loans.loan_status]
    measures: [loans.count, loans.total_loan_amount]
    listen:
      annual_income: borrower.annual_income
      address_state: borrower.address_state
      emp_length: borrower.emp_length
      is_income_verified: borrower.is_income_verified      
      date: loans.issue_date
      loan_amount: loans.loan_amount
      grade: loans.grade
      purpose: loans.purpose
      interest_rate: loans.interest_rate
    limit: 500
      
    
  - name: loans_by_amount_type
    title: "Loans by Amount Sum"
    type: looker_area
    base_view: loans
    dimensions: [loans.issue_week,loans.loan_amount_tiers]
    pivots: [loans.loan_amount_tiers]
    measures: [loans.count]
    listen:
      annual_income: borrower.annual_income
      address_state: borrower.address_state
      date: loans.issue_date
      loan_amount: loans.loan_amount
      grade: loans.grade
      emp_length: borrower.emp_length
      purpose: loans.purpose
      is_income_verified: borrower.is_income_verified
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