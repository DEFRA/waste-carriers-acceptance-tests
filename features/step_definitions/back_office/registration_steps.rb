Given(/^NCCC registers an "([^"]*)" tier "([^"]*)" "([^"]*)" with "([^"]*)"$/) do |tier, carrier, business, convictions|

  # Set variables that can be reused across steps
  @tier = tier
  @carrier = carrier
  @business = business
  @convictions = convictions

  # For each function, use "old" or "new" to show which app the journey will be run in
  start_internal_registration("old")
  @business_name = submit_carrier_details("old", "limitedCompany", "upper", "carrier_broker_dealer")
  submit_contact_details("old")
  submit_key_people("old", business)
  submit_convictions("old", convictions)
  check_your_answers("old")
  order_copy_cards("old", 3)
  submit_valid_card_payment
  @reg = complete_internal_registration("old", business, tier, carrier)

  sign_in_to_back_office
  check_registration_details(@reg)

end

Then(/^the back office pages show the correct registration details$/) do
  info_panel = @bo.registration_details_page.info_panel
  page_content = @bo.registration_details_page.content
  expect(@bo.registration_details_page.business_name).to have_text(@business_name)
  expect(@bo.registration_details_page.content).to have_text("Bob Carolgees")

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
