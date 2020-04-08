Given(/^NCCC partially registers an upper tier "([^"]*)" "([^"]*)" with "([^"]*)"$/) do |carrier, business, convictions|

  # Set variables that can be reused across steps
  @app = "old"
  @tier = "upper"
  @carrier = carrier
  @business = business
  # Generate the business name, stripping out any illegal characters such as _.
  # As gsub amends the original value of carrier, plus any references to it, work from a clone instead:
  carrier_without_underscore = carrier.clone.gsub!(/[^0-9A-Za-z]/, "")
  @business_name = "Registered " + carrier_without_underscore + " " + business + " with " + convictions
  @convictions = convictions
  @resource_object = :registration

  old_start_internal_registration
  old_submit_carrier_details(business, "upper", @carrier)
  old_submit_business_details(@business_name, @tier)
  old_submit_contact_details_from_bo
  old_submit_company_people(business)
  old_submit_convictions(convictions)
  old_check_your_answers

end

And(/^NCCC finishes the registration$/) do
  @reg_number = old_complete_registration_from_bo(@business, @tier, @carrier)
end

Given(/^NCCC registers a lower tier "([^"]*)"$/) do |business|
  @app = "old"
  @tier = "lower"
  @carrier = "-"
  @business = business
  @business_name = "Registered lower tier " + business
  @resource_object = :registration

  old_start_internal_registration
  old_submit_carrier_details(@business, @tier, @carrier)
  old_submit_business_details(@business_name, @tier)
  old_submit_contact_details_from_bo
  old_check_your_answers
  @reg_number = old_complete_registration_from_bo(@business, @tier, @carrier)
end

Then(/^the back office pages show the correct registration details$/) do
  sign_in_to_back_office("agency-user")
  check_registration_details(@reg_number)
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

  if @carrier == "carrier_broker_dealer"
    expect(info_panel).to have_text("Carrier, broker and dealer")
  elsif @carrier == "broker_dealer"
    expect(info_panel).to have_text("Broker and dealer")
  else
    expect(info_panel).to have_text("Carrier and dealer")
  end

end

Then(/^the certificate shows the correct details$/) do
  # Assume user is already at the "registration details" page here.
  # As we cannot directly read PDFs through web test automation, use a dedicated URL to view the content as HTML.
  # Also, when testing headlessly, the direct link to the certificate PDF doesn't work.
  # So we need to bypass the PDF link by going directly to the HTML version of the link.
  # Get target URL from certificate link:
  letter_html_url = @bo.registration_details_page.view_certificate_link[:href].to_s + "?show_as_html=true"
  visit(letter_html_url)

  expect(@bo.registration_certificate_page.heading).to have_text("Certificate of Registration")
  page_content = @bo.registration_certificate_page.content
  expect(page_content).to have_text(@business_name)
  expect(page_content).to have_text(@reg_number)
  expect(@bo.registration_certificate_page.certificate_dates_are_correct(@tier, @is_renewal)).to be true
  if @tier == "upper"
    expect(page_content).to have_text("Your registration will last 3 years")
  else
    expect(page_content).to have_text("Your registration will last indefinitely")
  end
end
