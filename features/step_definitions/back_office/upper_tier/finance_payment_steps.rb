Given(/^registration "([^"]*)" has a renewal paid by bank transfer$/) do |reg|
  @back_renewals_app.registrations_page.search(search_input: reg.to_sym)
  @registration_number = reg
  @back_renewals_app.registrations_page.search_results[0].renew.click
  @back_renewals_app.admin_sign_in_page.submit(
    email: Quke::Quke.config.custom["accounts"]["agency_user_with_payment_refund"]["username"],
    password: ENV["WCRS_DEFAULT_PASSWORD"]
  )
  @back_renewals_app.renewal_start_page.submit
  @back_renewals_app.location_page.submit(choice: :england)
  @back_renewals_app.confirm_business_type_page.submit
  @back_renewals_app.tier_check_page.submit(choice: :skip_check)
  @back_renewals_app.carrier_type_page.submit
  @back_renewals_app.renewal_information_page.submit
  @back_renewals_app.registration_number_page.submit
  @back_renewals_app.company_name_page.submit
  @back_renewals_app.post_code_page.submit(postcode: "BS1 5AH")
  @back_renewals_app.business_address_page.manual_address_submit
  @back_renewals_app.manual_address_page.submit(
    house_number: "1",
    address_line_one: "Test lane",
    address_line_two: "Testville",
    city: "Teston"
  )
  people = @back_renewals_app.main_people_page.main_people
  @back_renewals_app.main_people_page.add_main_person(person: people[0])
  @back_renewals_app.main_people_page.add_main_person(person: people[1])
  @back_renewals_app.main_people_page.submit_main_person(person: people[2])
  @back_renewals_app.declare_convictions_page.submit(choice: :no)
  @back_renewals_app.contact_name_page.submit
  @back_renewals_app.contact_telephone_number_page.submit
  @back_renewals_app.contact_email_page.submit(
    email: "bo-user@example.com",
    confirm_email: "bo-user@example.com"
  )
  @back_renewals_app.contact_postcode_page.submit(postcode: "BS1 9XX")
  @back_renewals_app.contact_postcode_page.manual_address.click
  @back_renewals_app.contact_manual_address_page.submit(
    house_number: "1",
    address_line_one: "Test lane",
    address_line_two: "Testville",
    city: "Teston"
  )
  @back_renewals_app.check_your_answers_page.submit
  @back_renewals_app.declaration_page.submit
  @back_renewals_app.registration_cards_page.submit
  @back_renewals_app.payment_summary_page.submit(choice: :bank_transfer_payment)
  @back_renewals_app.bank_transfer_page.submit
end
