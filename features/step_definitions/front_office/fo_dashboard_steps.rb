When(/^I choose to view my certificate$/) do
  Capybara.reset_session!
  @front_app = FrontOfficeApp.new
  @journey = JourneyApp.new
  @fo.waste_carrier_sign_in_page.load
  @fo.waste_carrier_sign_in_page.submit(
    email: Quke::Quke.config.custom["accounts"]["waste_carrier2"]["username"],
    password: ENV["WCRS_DEFAULT_PASSWORD"]
  )
  @fo.waste_carrier_registrations_page.find_registration(@reg_number)
end

Then(/^I can view my certificate of registration$/) do
  # We need to bypass the PDF link by going directly to the HTML version of the certificate.
  visit("#{Quke::Quke.config.custom['urls']['front_office']}/registrations/#{@reg_number}/certificate?show_as_html=true")
  expect(page).to have_text("Certificate of Registration")
  expect(page).to have_text(@reg_number)
  page.evaluate_script("window.history.back()")
end

When("I forget my front office password and reset it") do
  visit(Quke::Quke.config.custom["urls"]["front_office_sign_in"])
  @account_email = Quke::Quke.config.custom["accounts"]["waste_carrier2"]["username"]
  @fo.front_office_sign_in_page.submit(
    email: @account_email,
    password: "cheese"
  )
  expect(@fo.front_office_sign_in_page.error_summary).to have_text("Invalid Email or password.")

  reset_fo_password(@account_email, "Ch33s3m0nger")
end

Then("I can log in with the new password") do
  expect(@fo.waste_carrier_registrations_page.heading).to have_text("Your waste carrier registrations")
  expect(@fo.waste_carrier_registrations_page.content).to have_text(@account_email)
  @fo.waste_carrier_registrations_page.sign_out.click
end

Then("I can reset it to its original value") do
  visit(Quke::Quke.config.custom["urls"]["front_office_sign_in"])
  reset_fo_password(@account_email, ENV["WCRS_DEFAULT_PASSWORD"])
end
