When(/^I complete my limited company renewal steps declaring a conviction$/) do
  @business_name = "Ltd Company renewal declaring a conviction"
  agree_to_renew_in_england
  @journey.confirm_business_type_page.submit
  @journey.tier_check_page.submit(choice: :check_tier)
  select_random_upper_tier_options("existing")
  @renewals_app.renewal_information_page.submit
  submit_business_details(@business_name)
  submit_company_people
  submit_convictions("convictions")
  @journey.contact_name_page.submit
  @journey.contact_phone_page.submit
  @journey.contact_email_page.submit(
    email: "test@example.com",
    confirm_email: "test@example.com"
  )
  @journey.address_lookup_page.submit_valid_address
  check_your_answers
  @journey.registration_cards_page.submit
  @renewals_app.payment_summary_page.submit(choice: :card_payment)

  submit_valid_card_payment

end

When(/^I complete my limited company renewal steps not declaring a conviction$/) do
  @business_name = "Ltd Company renewal with matching conviction"
  agree_to_renew_in_england
  @journey.confirm_business_type_page.submit
  @journey.tier_check_page.submit(choice: :check_tier)
  select_random_upper_tier_options("existing")
  @renewals_app.renewal_information_page.submit
  submit_business_details(@business_name)
  people = dodgy_people
  @journey.company_people_page.add_main_person(person: people[0])
  @journey.company_people_page.add_main_person(person: people[1])
  @journey.company_people_page.submit_main_person(person: people[2])
  submit_convictions("no convictions")
  @journey.contact_name_page.submit
  @journey.contact_phone_page.submit
  @journey.contact_email_page.submit(
    email: "test@example.com",
    confirm_email: "test@example.com"
  )
  @journey.address_lookup_page.submit_valid_address
  check_your_answers
  @journey.registration_cards_page.submit
  @renewals_app.payment_summary_page.submit(choice: :card_payment)

  submit_valid_card_payment

end

When(/^I complete my limited company renewal steps not declaring a company conviction$/) do
  agree_to_renew_in_england
  @journey.confirm_business_type_page.submit
  @journey.tier_check_page.submit(choice: :check_tier)
  select_random_upper_tier_options("existing")
  @renewals_app.renewal_information_page.submit
  # Submit the existing company name, as it has a conviction against it:
  submit_limited_company_details("existing")
  submit_company_people
  submit_convictions("no convictions")
  @journey.contact_name_page.submit
  @journey.contact_phone_page.submit
  @journey.contact_email_page.submit(
    email: "test@example.com",
    confirm_email: "test@example.com"
  )
  @journey.address_lookup_page.submit_valid_address
  check_your_answers
  @journey.registration_cards_page.submit
  @renewals_app.payment_summary_page.submit(choice: :card_payment)
  submit_valid_card_payment
end
