Given(/^I sign into the back office as "([^"]*)"$/) do |user|
  # Use this step to sign in to the back office as any of the following users:
  # agency-user
  # agency-refund-payment-user
  # agency-super
  # finance-user
  # finance-admin-user
  # finance-super
  # waste_carrier
  # waste_carrier2
  load_all_apps
  sign_in_to_back_office(user)
end

Given("I sign out of back office") do
  sign_out_of_back_office
end

Given("mocking is disabled") do
  # Some tests rely on being able to perform actions on the Worldpay payment screen.
  # This step skips those tests when mocking is disabled.
  pending "It makes no sense to test this feature when mocking is enabled" if mocking_enabled?
end

Given("mocking is enabled") do
  # Tests which simulate a "pending WorldPay" status can only be run in automated tests if mocking is enabled.
  # See RUBY-1013 for details on how to test this manually.
  pending "It makes no sense to test this feature when mocking is disabled" unless mocking_enabled?
end

Then(/^the registration has a status of "([^"]*)"$/) do |status|
  sign_in_to_back_office("agency-refund-payment-user", false)

  @bo.dashboard_page.load
  @bo.dashboard_page.submit(search_term: @reg_number)

  expect(@bo.dashboard_page.results_table).to have_text(status)
end

Then(/^the registration does not have a status of "([^"]*)"$/) do |status|
  sign_in_to_back_office("agency-refund-payment-user", false)

  @bo.dashboard_page.load
  @bo.dashboard_page.submit(search_term: @reg_number)
  expect(@bo.dashboard_page.results_table).to have_no_text(status)
end

Then("I check the registration details are correct on the back office") do
  sign_in_to_back_office("agency-user")
  check_registration_details(@reg_number)
  info_panel = @bo.registration_details_page.info_panel
  page_content = @bo.registration_details_page.content
  expect(@bo.registration_details_page.business_name).to have_text(@business_name)

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

  @carrier = @seeded_data["registrationType"] if @carrier.blank? && @seeded_data.present?

  case @carrier
  when "carrier_broker_dealer"
    expect(info_panel).to have_text("Carrier, broker and dealer")
  when "broker_dealer"
    expect(info_panel).to have_text("Broker and dealer")
  when "carrier_dealer"
    expect(info_panel).to have_text("Carrier and dealer")
  end
end

Then("the certificate shows the correct details") do
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
  expect(@bo.registration_certificate_page.certificate_dates_are_correct(@tier, @reg_type)).to be true
  if @tier == "upper"
    expect(page_content).to have_text("Your registration will last 3 years")
  else
    expect(page_content).to have_text("Your registration will last indefinitely")
  end
end

Given("I view the registration details") do
  visit_registration_details_page(@reg_number)
end

When("I resend the confirmation email") do
  @bo.registration_details_page.resend_renewal_email_link.click
end

Then("I will see the renewal reminder email has been sent") do
  puts "Renewal email sent to #{@contact_email}"
  expect(@bo.registration_details_page.flash_message).to have_text("Renewal email sent to #{@contact_email}")
end
