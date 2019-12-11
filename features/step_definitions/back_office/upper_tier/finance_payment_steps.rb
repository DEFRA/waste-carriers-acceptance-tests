Given(/^registration "([^"]*)" has a renewal paid by bank transfer$/) do |reg|
  @bo.registrations_page.search(search_input: reg.to_sym)
  @registration_number = reg

  @expiry_date = @bo.registrations_page.search_results[0].expiry_date.text
  # Turns the text expiry date into a date
  @expiry_date_year_first = Date.parse(@expiry_date)
  @bo.registrations_page.search_results[0].renew.click
  @bo.sign_in_page.submit(
    email: Quke::Quke.config.custom["accounts"]["agency_user_with_payment_refund"]["username"],
    password: ENV["WCRS_DEFAULT_PASSWORD"]
  )
  start_internal_renewal
  @journey.confirm_business_type_page.submit
  @journey.tier_check_page.submit(choice: :skip_check)
  @journey.carrier_type_page.submit
  @bo.renewal_information_page.submit
  @journey.company_number_page.submit
  @journey.company_name_page.submit
  @journey.address_lookup_page.choose_manual_address
  @journey.address_manual_page.submit(
    house_number: "1",
    address_line_one: "Test lane",
    address_line_two: "Testville",
    city: "Teston"
  )
  submit_company_people
  submit_convictions("no convictions")
  @journey.contact_name_page.submit
  @journey.contact_phone_page.submit
  @journey.contact_email_page.submit(
    email: "bo-user@example.com",
    confirm_email: "bo-user@example.com"
  )
  @journey.address_lookup_page.submit_invalid_address
  @journey.address_manual_page.submit(
    house_number: "1",
    address_line_one: "Test lane",
    address_line_two: "Testville",
    city: "Teston"
  )
  check_your_answers
  @bo.registration_cards_page.submit
  @bo.payment_summary_page.submit(choice: :bank_transfer_payment)
  @bo.bank_transfer_page.submit
end
