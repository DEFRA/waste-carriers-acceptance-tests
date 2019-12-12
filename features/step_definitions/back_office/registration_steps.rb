# rubocop:disable Metrics/LineLength
Given(/^NCCC partially registers an "([^"]*)" tier "([^"]*)" "([^"]*)" with "([^"]*)"$/) do |tier, carrier, business, convictions|
  # rubocop:enable Metrics/LineLength

  # Set variables that can be reused across steps
  @app = "old"
  @tier = tier
  @carrier = carrier
  @business = business
  @convictions = convictions

  old_start_internal_registration
  old_submit_carrier_details("limitedCompany", "upper", "carrier_broker_dealer")
  @business_name = old_submit_business_details
  old_submit_contact_details_from_bo
  old_submit_company_people
  old_submit_convictions(convictions)
  old_check_your_answers

end

And(/^NCCC finishes the registration$/) do
  @registration_number = old_complete_registration_from_bo(@business, @tier, @carrier)
end

Then(/^the back office pages show the correct registration details$/) do
  sign_in_to_back_office
  check_registration_details(@registration_number)
  info_panel = @bo.view_details_page.info_panel
  page_content = @bo.view_details_page.content
  expect(@bo.view_details_page.business_name).to have_text(@business_name)
  expect(@bo.view_details_page.content).to have_text("Bob Carolgees")

  if @tier == "upper"
    expect(info_panel).to have_text("Upper tier")
    if @convictions == "no convictions"
      expect(page_content).to have_text("There are no convictions for this registration")
    end
  end

  if @tier == "lower"
    expect(info_panel).to have_text("Lower tier")
    expect(page_content).to have_text("Lower tier registration - convictions are not applicable")
  end

  if @tier == "carrier_broker_dealer"
    expect(info_panel).to have_text("Carrier, broker and dealer")
  elsif @tier == "broker_dealer"
    expect(info_panel).to have_text("Broker and dealer")
  end

end

# Add the following functions:
#   check_conviction_details
#   check_payment_details
