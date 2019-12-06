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
  @bo.ad_privacy_policy_page.submit
  @bo.renewal_start_page.submit
  @bo.location_page.submit(choice: :england_new)
  @bo.confirm_business_type_page.submit
  @bo.tier_check_page.submit(choice: :skip_check)
  @bo.carrier_type_page.submit
  @bo.renewal_information_page.submit
  @bo.registration_number_page.submit
  @bo.company_name_page.submit
  @journey_app.address_lookup_page.choose_manual_address
  @journey_app.address_manual_page.submit(
    house_number: "1",
    address_line_one: "Test lane",
    address_line_two: "Testville",
    city: "Teston"
  )
  people = @bo.main_people_page.main_people
  @bo.main_people_page.add_main_person(person: people[0])
  @bo.main_people_page.add_main_person(person: people[1])
  @bo.main_people_page.submit_main_person(person: people[2])
  @bo.declare_convictions_page.submit(choice: :no)
  @bo.contact_name_page.submit
  @bo.contact_telephone_number_page.submit
  @bo.contact_email_page.submit(
    email: "bo-user@example.com",
    confirm_email: "bo-user@example.com"
  )
  @journey_app.address_lookup_page.submit_invalid_address
  @journey_app.address_manual_page.submit(
    house_number: "1",
    address_line_one: "Test lane",
    address_line_two: "Testville",
    city: "Teston"
  )
  @bo.check_your_answers_page.submit
  @bo.declaration_page.submit
  @bo.registration_cards_page.submit
  @bo.payment_summary_page.submit(choice: :bank_transfer_payment)
  @bo.bank_transfer_page.submit
end
