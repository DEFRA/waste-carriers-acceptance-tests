When(/^I complete my limited company renewal steps declaring a conviction$/) do
  @business_name = "Ltd Company renewal declaring a conviction"
  agree_to_renew_in_england
  @journey.confirm_business_type_page.submit
  select_tier_for_renewal("existing")
  @journey.renewal_information_page.submit
  submit_business_details(@business_name, @tier)
  submit_company_people
  submit_convictions("convictions")
  submit_contact_details_for_renewal
  check_your_answers
  order_cards_during_journey(0)
  @journey.payment_summary_page.submit(choice: :card_payment)

  submit_valid_card_payment

end

When(/^I complete my limited company renewal steps not declaring a conviction$/) do
  @business_name = "Ltd Company renewal with matching conviction"
  agree_to_renew_in_england
  @journey.confirm_business_type_page.submit
  select_tier_for_renewal("existing")
  @journey.renewal_information_page.submit
  submit_business_details(@business_name, @tier)
  people = dodgy_people
  @journey.company_people_page.add_main_person(person: people[0])
  @journey.company_people_page.add_main_person(person: people[1])
  @journey.company_people_page.submit_main_person(person: people[2])
  submit_convictions("no convictions")
  submit_contact_details_for_renewal
  check_your_answers
  order_cards_during_journey(0)
  @journey.payment_summary_page.submit(choice: :card_payment)

  submit_valid_card_payment

end

When(/^I complete my limited company renewal steps not declaring a company conviction$/) do
  agree_to_renew_in_england
  @journey.confirm_business_type_page.submit
  select_tier_for_renewal("existing")
  @journey.renewal_information_page.submit
  # Submit the existing company name, as it has a conviction against it:
  submit_limited_company_details("existing", @tier)
  submit_company_people
  submit_convictions("no convictions")
  submit_contact_details_for_renewal
  check_your_answers
  order_cards_during_journey(0)
  @journey.payment_summary_page.submit(choice: :card_payment)
  submit_valid_card_payment
end
