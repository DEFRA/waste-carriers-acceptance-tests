When("I complete my limited company renewal steps declaring a conviction") do
  @business_name = "Ltd Company renewal declaring a conviction"
  agree_to_renew_in_england
  @journey.confirm_business_type_page.submit
  @journey.carrier_type_page.submit
  @journey.renewal_information_page.submit
  # Submit the existing company name, as it has a conviction against it:
  if @journey.check_registered_company_name_page.heading.has_text? "Is this your registered name and address?"
    # then it's a limited company or LLP:
    expect(@journey.check_registered_company_name_page.companies_house_number).to have_text("Companies House Number - 00445790")
    @journey.check_registered_company_name_page.submit(choice: :confirm)
  end
  submit_company_people
  submit_organisation_details(@business_name)
  submit_convictions("convictions")
  submit_contact_details_for_renewal
  check_your_answers
  order_cards_during_journey(0)
  @journey.payment_summary_page.submit(choice: :card_payment)
  submit_valid_card_payment
end

When("I complete my limited company renewal steps not declaring a personal conviction") do
  @business_name = "Ltd Company renewal with matching conviction"
  agree_to_renew_in_england
  @journey.confirm_business_type_page.submit
  @journey.carrier_type_page.submit
  @journey.renewal_information_page.submit
  people = dodgy_people
  if @journey.check_registered_company_name_page.heading.has_text? "Is this your registered name and address?"
    # then it's a limited company or LLP:
    expect(@journey.check_registered_company_name_page.companies_house_number).to have_text("Companies House Number - 00445790")
    @journey.check_registered_company_name_page.submit(choice: :confirm)
  end

  @journey.company_people_page.add_main_person(person: people[0])
  @journey.company_people_page.add_main_person(person: people[1])
  @journey.company_people_page.submit_main_person(person: people[2])
  submit_organisation_details(@business_name)
  submit_convictions("no convictions")
  submit_contact_details_for_renewal
  check_your_answers
  order_cards_during_journey(5)
  @journey.payment_summary_page.submit(choice: :card_payment)
  submit_valid_card_payment
end

When(/^I complete my limited company renewal steps not declaring a company conviction$/) do
  agree_to_renew_in_england
  @journey.confirm_business_type_page.submit
  @journey.carrier_type_page.submit
  @journey.renewal_information_page.submit
  # Submit the existing company name, as it has a conviction against it:
  if @journey.check_registered_company_name_page.heading.has_text? "Is this your registered name and address?"
    # then it's a limited company or LLP:
    expect(@journey.check_registered_company_name_page.companies_house_number).to have_text("Companies House Number - 00445790")
    @journey.check_registered_company_name_page.submit(choice: :confirm)
  end
  submit_company_people
  submit_organisation_details(@business_name)
  submit_convictions("no convictions")
  submit_contact_details_for_renewal
  check_your_answers
  order_cards_during_journey(3)
  @journey.payment_summary_page.submit(choice: :card_payment)
  submit_valid_card_payment
end
