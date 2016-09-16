- dashboard: application_pulse
  title: "Application Pulse - Lending Club"
  layout: tile
  tile_size: 100

  filters:

  - name: date
    title: "Date for New Listings"
    type: date_filter
    default_value: before 2016/01/01
    
  - name: address_state
    title: "State"
    type: field_filter
    explore: listings
    field: listings.address_state

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
    explore: listings
    field: listings.grade
    
#   - name: emp_length
#     title: "Employment Length"
#     type: number_filter
#     explore: suggest_listings
#     dimension: applicant.emp_length

  - name: purpose
    title: "Loan Purpose"
    type: field_filter
    explore: listings
    field: listings.purpose
    
  - name: is_income_verified
    title: "Inc Verification"
    type: field_filter
    explore: listings
    field: listings.is_income_verified
    
  - name: interest_rate
    title: "Interest Rate"
    type: number_filter

  elements:
  
#   - name: add_a_unique_name_510
#     title: "Expected Profitability"
#     type: single_value
#     model: lending_club
#     explore: listings
#     listen:
#       annual_income: listings.annual_income
#       address_state: listings.address_state
# #       emp_length: applicant.emp_length
#       is_income_verified: listings.is_income_verified      
#       date: listings.listed_date
#       loan_amount: listings.loan_amount
#       grade: listings.grade
#       purpose: listings.purpose
#       interest_rate: listings.interest_rate 
#     measures: [listings.expected_weighted_annual_profitability]
#     sorts: [listings.expected_weighted_annual_profitability desc]
#     limit: 500
#     total: false
#     width: 2
#     height: 2
#     font_size: small
  
  - name: add_a_unique_name_462
    title: "New Loan Listings"
    type: single_value
    model: lending_club
    explore: listings
    measures: [listings.count]
    sorts: [listings.count desc]
    limit: 500
    listen:
      annual_income: listings.annual_income
      address_state: listings.address_state
#       emp_length: applicant.emp_length
      is_income_verified: listings.is_income_verified      
      date: listings.listed_date
      loan_amount: listings.loan_amount
      grade: listings.grade
      purpose: listings.purpose
      interest_rate: listings.interest_rate       
    width: 4
    height: 2
    font_size: small
    
  - name: add_a_unique_name_523
    title: "Total Amount Applied for"
    type: single_value
    model: lending_club
    explore: listings
    measures: [listings.total_loan_amount]
    limit: 500
    listen:
      annual_income: listings.annual_income
      address_state: listings.address_state
#       emp_length: applicant.emp_length
      is_income_verified: listings.is_income_verified      
      date: listings.listed_date
      loan_amount: listings.loan_amount
      grade: listings.grade
      purpose: listings.purpose
      interest_rate: listings.interest_rate       
    width: 4
    height: 2  
    font_size: small
    
  - name: add_a_unique_name_524
    title: "Total Amount Funded"
    type: single_value
    model: lending_club
    explore: listings
    measures: [listings.total_funded_amount]
    limit: 500
    listen:
      annual_income: listings.annual_income
      address_state: listings.address_state
#       emp_length: applicant.emp_length
      is_income_verified: listings.is_income_verified      
      date: listings.listed_date
      loan_amount: listings.loan_amount
      grade: listings.grade
      purpose: listings.purpose
      interest_rate: listings.interest_rate       
    width: 4
    height: 2 
    font_size: small

  - name: add_a_unique_name_793
    title: "Loan Applications by Accepted Hour (last 12 months)"
    type: looker_column
    model: lending_club
    explore: listings
    dimensions: [listings.listed_date, listings.accepted_hod]
    pivots: [listings.accepted_hod]
    measures: [listings.count]
    listen:
      annual_income: listings.annual_income
      address_state: listings.address_state
      loan_amount: listings.loan_amount
      grade: listings.grade
#       emp_length: applicant.emp_length
      purpose: listings.purpose
      is_income_verified: listings.is_income_verified
      interest_rate: listings.interest_rate      
    filters:
      listings.listed_date: 12 months
    sorts: [listings.listed_date asc]
    limit: 500
    show_null_labels: false
    colors: ['#2E6EC2']
    stacking: ''
    x_axis_scale: auto
    hide_legend: yes
    
  - name: add_a_unique_name_233
    title: "Loan Applications by State"
    type: looker_geo_choropleth
    model: lending_club
    explore: listings
    dimensions: [listings.address_state]
    measures: [listings.count]
    sorts: [listings.listed_date desc, listings.count desc]
    limit: 500
    listen:
      annual_income: listings.annual_income
      address_state: listings.address_state
      date: listings.listed_date
      loan_amount: listings.loan_amount
      grade: listings.grade
#       emp_length: applicant.emp_length
      purpose: listings.purpose
      is_income_verified: listings.is_income_verified
      interest_rate: listings.interest_rate
    quantize_colors: false
    colors: ["#efefef","#C488DD","#80237D","#651F81"]    
    map: usa
    map_projection: ''
    loading: false
    
  - name: loans_by_amount_type
    title: "Loans by Amount Sum"
    type: looker_area
    explore: listings
    dimensions: [listings.listed_date,listings.loan_amount_tiers]
    pivots: [listings.loan_amount_tiers]
    measures: [listings.count]
    listen:
      annual_income: listings.annual_income
      address_state: listings.address_state
      date: listings.listed_date
      loan_amount: listings.loan_amount
      grade: listings.grade
#       emp_length: applicant.emp_length
      purpose: listings.purpose
      is_income_verified: listings.is_income_verified
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
#     hide_legend: yes
    
    
  - name: add_a_unique_name_62
    title: "Credit Utilization by Grade Type"
    type: looker_column
    model: lending_club
    explore: listings
    dimensions: [listings.grade, listings.revol_util_tier]
    pivots: [listings.revol_util_tier]
    measures: [listings.count]
    sorts: [listings.grade]
    listen:
      annual_income: listings.annual_income
      address_state: listings.address_state
      date: listings.listed_date
      loan_amount: listings.loan_amount
      grade: listings.grade
#       emp_length: applicant.emp_length
      purpose: listings.purpose
      is_income_verified: listings.is_income_verified
      interest_rate: listings.interest_rate
    limit: 500
    show_null_labels: false
    colors: ["#651F81", "#80237D", "#C488DD", "#Ef7F0F", "#FEAC47", "#8ED1ED"]
    stacking: ''
    x_axis_scale: auto

  - name: add_a_unique_name_886
    title: "Home Ownership"
    type: looker_column
    model: lending_club
    explore: listings
    dimensions: [listings.home_ownership]
    measures: [listings.average_annual_income, listings.count]
    filters:
      distributions.annual_income: '>10000'
      distributions.date: 5 months
    sorts: [distributions.income_decile_bucket, listings.count desc]
    limit: 500
    column_limit: ''
    show_null_points: true
    show_null_labels: false
    x_axis_scale: ordinal
    y_axis_orientation: [left, right]
    stacking: ''
    point_style: none
    interpolation: linear
    colors: ['#651F81', '#Ef7F0F', '#FEAC47', '#8ED1ED']
    show_value_labels: false
    label_density: 25
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    series_types:
      listings.count: column
      listings.average_annual_income: line
    show_dropoff: false
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
      annual_income: listings.annual_income
      address_state: listings.address_state
#       emp_length: applicant.emp_length
      is_income_verified: listings.is_income_verified      
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
    colors: ["#651F81", "#80237D", "#C488DD", "#Ef7F0F", "#FEAC47", "#8ED1ED"]
    
  - name: add_a_unique_name_780
    title: "Applications by Credit Score and Purpose"
    type: looker_donut_multiples
    model: lending_club
    explore: listings
    dimensions: [listings.purpose, listings.fico_low_tier]
    pivots: [listings.purpose]
    measures: [listings.count]
    sorts: [listings.purpose, listings.fico_low_tier desc]
    limit: 24
    listen:
      annual_income: listings.annual_income
      address_state: listings.address_state
#       emp_length: applicant.emp_length
      is_income_verified: listings.is_income_verified      
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
    
      
  


  
