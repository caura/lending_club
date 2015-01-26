- dashboard: application_pulse
  title: "Application Pulse - Lending Club"
  layout: tile
  tile_size: 100

  filters:

  - name: date
    title: "Date for New Listings"
    type: date_filter
    default_value: 14 days
    
  - name: address_state
    title: "State"
    type: suggest_filter
    explore: suggest_listings
    dimension: applicant.address_state

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
    explore: listings
    dimension: listings.grade
    
#   - name: emp_length
#     title: "Employment Length"
#     type: number_filter
#     explore: suggest_listings
#     dimension: applicant.emp_length

  - name: purpose
    title: "Loan Purpose"
    type: suggest_filter
    explore: suggest_listings
    dimension: suggest_listings.purpose
    
  - name: is_income_verified
    title: "Inc Verification"
    type: suggest_filter
    explore: listings
    dimension: applicant.is_income_verified
    
  - name: interest_rate
    title: "Interest Rate"
    type: number_filter

  elements:
  
  - name: add_a_unique_name_462
    title: "New Loan Listings"
    type: single_value
    model: lending_club
    explore: listings
    measures: [listings.count]
    sorts: [listings.count desc]
    limit: 500
    listen:
      annual_income: applicant.annual_income
      address_state: applicant.address_state
      emp_length: applicant.emp_length
      is_income_verified: applicant.is_income_verified      
      date: listings.listed_date
      loan_amount: listings.loan_amount
      grade: listings.grade
      purpose: listings.purpose
      interest_rate: listings.interest_rate       
    width: 4
    height: 2
    
  - name: add_a_unique_name_523
    title: "Total Amount Applied for"
    type: single_value
    model: lending_club
    explore: listings
    measures: [listings._total_loan_amount]
    limit: 500
    listen:
      annual_income: applicant.annual_income
      address_state: applicant.address_state
      emp_length: applicant.emp_length
      is_income_verified: applicant.is_income_verified      
      date: listings.listed_date
      loan_amount: listings.loan_amount
      grade: listings.grade
      purpose: listings.purpose
      interest_rate: listings.interest_rate       
    width: 4
    height: 2   
    
  - name: add_a_unique_name_524
    title: "Total Amount Funded"
    type: single_value
    model: lending_club
    explore: listings
    measures: [listings._total_funded_amount]
    limit: 500
    listen:
      annual_income: applicant.annual_income
      address_state: applicant.address_state
      emp_length: applicant.emp_length
      is_income_verified: applicant.is_income_verified      
      date: listings.listed_date
      loan_amount: listings.loan_amount
      grade: listings.grade
      purpose: listings.purpose
      interest_rate: listings.interest_rate       
    width: 4
    height: 2    

  - name: add_a_unique_name_793
    title: "Loan Applications by Accepted Hour (last 3 days)"
    type: looker_column
    model: lending_club
    explore: listings
    dimensions: [listings.listed_date, listings.accepted_hod]
    pivots: [listings.accepted_hod]
    measures: [listings.count]
    listen:
      annual_income: applicant.annual_income
      address_state: applicant.address_state
      loan_amount: listings.loan_amount
      grade: listings.grade
      emp_length: applicant.emp_length
      purpose: listings.purpose
      is_income_verified: applicant.is_income_verified
      interest_rate: listings.interest_rate      
    filters:
      listings.listed_date: 3 days
    sorts: [listings.listed_date asc]
    limit: 500
    show_null_labels: false
    colors: ['#2E6EC2']
    stacking: ''
    x_axis_scale: auto
    
  - name: add_a_unique_name_233
    title: "Loan Applications by State"
    type: looker_geo_choropleth
    model: lending_club
    explore: listings
    dimensions: [applicant.address_state]
    measures: [listings.count]
    sorts: [listings.listed_date desc, listings.count desc]
    limit: 500
    listen:
      annual_income: applicant.annual_income
      address_state: applicant.address_state
      date: listings.listed_date
      loan_amount: listings.loan_amount
      grade: listings.grade
      emp_length: applicant.emp_length
      purpose: listings.purpose
      is_income_verified: applicant.is_income_verified
      interest_rate: listings.interest_rate
    quantize_colors: false
    colors: ["#efefef","#C488DD","#80237D","#651F81"]    
    map: usa
    map_projection: ''
    loading: false
    
  - name: loans_by_amount_type
    title: "Loans by Amount Sum"
    type: looker_area
    base_view: listings
    dimensions: [listings.listed_date,listings.loan_amount_tiers]
    pivots: [listings.loan_amount_tiers]
    measures: [listings.count]
    listen:
      annual_income: applicant.annual_income
      address_state: applicant.address_state
      date: listings.listed_date
      loan_amount: listings.loan_amount
      grade: listings.grade
      emp_length: applicant.emp_length
      purpose: listings.purpose
      is_income_verified: applicant.is_income_verified
      interest_rate: listings.interest_rate
    sorts: [listings.count desc]
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
    
    
  - name: add_a_unique_name_62
    title: "Credit Utilization by Grade Type"
    type: looker_column
    model: lending_club
    explore: listings
    dimensions: [listings.grade, applicant.revol_util_tier]
    pivots: [applicant.revol_util_tier]
    measures: [listings.count]
    sorts: [listings.grade]
    listen:
      annual_income: applicant.annual_income
      address_state: applicant.address_state
      date: listings.listed_date
      loan_amount: listings.loan_amount
      grade: listings.grade
      emp_length: applicant.emp_length
      purpose: listings.purpose
      is_income_verified: applicant.is_income_verified
      interest_rate: listings.interest_rate
    limit: 500
    show_null_labels: false
    stacking: ''
    x_axis_scale: auto

  - name: add_a_unique_name_886
    title: "Income Distribution"
    type: looker_line
    model: lending_club
    explore: listings
    dimensions: [distributions.income_decile_bucket]
    measures: [listings.count, applicant.average_income]
    sorts: [distributions.income_decile_bucket asc]
    limit: 500
    listen:
      annual_income: distributions.annual_income
      address_state: distributions.address_state
      emp_length: distributions.emp_length
      is_income_verified: distributions.is_income_verified      
      date: distributions.date
      loan_amount: distributions.loan_amount
      grade: distributions.grade
      purpose: distributions.purpose
      interest_rate: distributions.interest_rate
    show_null_points: true
    show_null_labels: false
    x_axis_scale: ordinal
    y_axis_orientation: [left, right]
    stacking: ''
    point_style: none
    interpolation: linear
    height: 3
    
  - name: add_a_unique_name_562
    title: "Grade"
    type: table
    model: lending_club
    explore: listings
    dimensions: [listings.grade_linked]
    measures: [listings.average_interest_rate, listings.total_loan_amount, listings.count,
      listings.average_term]
    sorts: [listings.grade_linked]
    limit: 500
    height: 3
    
  - name: add_a_unique_name_949
    title: "Week-over-Week Listings by Grade"
    type: looker_line
    model: lending_club
    explore: listings
    dimensions: [listings.grade, listings.listed_week]
    pivots: [listings.listed_week]
    measures: [listings.count]
    sorts: [listings.listed_week, listings.grade]
    limit: 500
    listen:
      annual_income: applicant.annual_income
      address_state: applicant.address_state
      emp_length: applicant.emp_length
      is_income_verified: applicant.is_income_verified      
      date: listings.listed_date
      loan_amount: listings.loan_amount
      grade: listings.grade
      purpose: listings.purpose
      interest_rate: listings.interest_rate    
    show_null_points: true
    stacking: ''
    show_null_labels: false
    interpolation: step
    x_axis_scale: auto
    point_style: none
    
  - name: add_a_unique_name_780
    title: "Applications by Credit Score and Purpose"
    type: looker_donut_multiples
    model: lending_club
    explore: listings
    dimensions: [listings.purpose, applicant.fico_low_tier]
    pivots: [listings.purpose]
    measures: [listings.count]
    sorts: [listings.purpose, applicant.fico_low_tier desc]
    limit: 24
    listen:
      annual_income: applicant.annual_income
      address_state: applicant.address_state
      emp_length: applicant.emp_length
      is_income_verified: applicant.is_income_verified      
      date: listings.listed_date
      loan_amount: listings.loan_amount
      grade: listings.grade
      purpose: listings.purpose
      interest_rate: listings.interest_rate
    total: false
    show_null_labels: false
    colors: ["#651F81","#EF7F0F","#555E61","#2DA7CE"]
    charts_across: 3
    width: 6
    height: 4
    
      
  


  
