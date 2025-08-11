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
  # data user
  load_all_apps
  sign_in_to_back_office(user)
  @app = :bo
end

Given("I sign out of back office") do
  sign_out_of_back_office
end

Given("mocking is {string}") do |option|
  case option
  when "enabled"
    pending "It makes no sense to test this feature when mocking is disabled" unless mocking_enabled?
  when "disabled"
    pending "It makes no sense to test this feature when mocking is enabled" if mocking_enabled?
  end
end

Then(/^the registration has a status of "([^"]*)"$/) do |status|
  sign_in_to_back_office("agency-refund-payment-user")

  @bo.dashboard_page.load
  @bo.dashboard_page.submit(search_term: @reg_number)

  expect(@bo.dashboard_page.status.first.text.downcase).to have_text(status.downcase)
end

Then(/^the renewal has a status of "([^"]*)"$/) do |status|
  sign_in_to_back_office("agency-refund-payment-user")

  @bo.dashboard_page.load
  @bo.dashboard_page.submit(search_term: @reg_number)

  expect(@bo.dashboard_page.status.last.text.downcase).to have_text(status.downcase)
end

Then(/^the registration does not have a status of "([^"]*)"$/) do |status|
  sign_in_to_back_office("agency-refund-payment-user")

  @bo.dashboard_page.load
  @bo.dashboard_page.submit(search_term: @reg_number)
  expect(@bo.dashboard_page.status).not_to have_text(status.downcase)
end

Then("I check the registration details are correct on the back office") do
  sign_in_to_back_office("agency-user")
  check_registration_details(@reg_number)
  info_panel = @bo.registration_details_page.info_panel
  page_content = @bo.registration_details_page
  # Upper tier companies now have a registered company name
  if a_company?
    expect(@bo.registration_details_page).to have_text(have_text(@business_name))
  else
    expect(@bo.registration_details_page.business_name).to have_text(@business_name)
  end

  if @tier == :upper
    expect(info_panel).to have_text("Upper tier")
    if @convictions == "no convictions"
      expect(page_content).to have_text("There are no convictions for this registration")
    end
  end

  if @tier == :lower
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
  letter_html_url = "#{@bo.registration_details_page.view_certificate_link[:href]}?show_as_html=true"
  visit(letter_html_url)

  expect(@bo.registration_certificate_page.heading).to have_text("Certificate of Registration")
  page_content = @bo.registration_certificate_page.content
  expect(page_content).to have_text(@business_name) if @business_name
  expect(page_content).to have_text(@reg_number)
  # Increments certificate number when revisiting a certificate after an edit or renewal
  @certificate_number = 0 if @certificate_number.nil?
  @certificate_number += 1
  expect(page_content).to have_text("This is copy number #{@certificate_number} of the certificate.")
  expect(@bo.registration_certificate_page.certificate_dates_are_correct?(@tier, @reg_type)).to be true
  if @tier == :upper
    expect(page_content).to have_text("Your registration will last 3 years")
  else
    expect(page_content).to have_text("Your registration will last indefinitely")
  end
end

Given("I view the registration details") do
  visit_registration_details_page(@reg_number)
end

When("I resend the renewal reminder email") do
  @bo.registration_details_page.resend_renewal_email_link.click
end

When("I resend the confirmation email") do
  @bo.registration_details_page.resend_confirmation_email_link.click
end

Given("I receive a registration confirmation email") do
  send_registration_confirmation_email(@reg_number)
end

When("I refresh the company name from companies house") do
  @bo.registration_details_page.refresh_company_name.click
end

Then("I can see the company name has been updated") do
  @business_name = @bo.registration_details_page.business_name.text.downcase
  if mocking_enabled?
    expect(@business_name).to have_text("acme industries")
  else
    expect(@business_name).to have_text("tesco")
  end
  @bo.registration_details_page.business_name.text
end

Then("I will see the renewal reminder email has been sent") do
  puts "Renewal email sent to #{@contact_email}"
  expect(@bo.registration_details_page.flash_message).to have_text("Renewal email sent to #{@contact_email}")
end

Then("I will see the registration confirmation email has been sent") do
  puts "Confirmation email sent to #{@contact_email}"
  expect(@bo.registration_details_page.flash_message).to have_text("Confirmation email sent to #{@contact_email}")
end

Then("I can see the communication logs on the communication history page") do
  visit_registration_details_page(@reg_number)
  @bo.registration_details_page.communication_history.click
  expect(@bo.communication_history_page.heading).to have_text("Communication history")
  log = @bo.communication_history_page.log_details(@contact_email)
  expect(log.template_name).to have_text("Upper tier renewal reminder")
end

Then("the unsubscription is logged in the communications history") do
  sign_in_to_back_office("agency-refund-payment-user")
  visit_registration_details_page(@reg_number)
  @bo.registration_details_page.communication_history.click
  expect(@bo.communication_history_page.heading).to have_text("Communication history")
  log = @bo.communication_history_page.log_details(@contact_email)
  expect(log.template_name).to have_text("User unsubscribed from email communication")
end
