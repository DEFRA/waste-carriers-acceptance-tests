When("I choose to view my certificate") do
  @fo.front_office_sign_in_page.load
  @fo.front_office_sign_in_page.submit(
    email: Quke::Quke.config.custom["accounts"]["waste_carrier2"]["username"],
    password: ENV["WCRS_DEFAULT_PASSWORD"]
  )
  @fo.front_office_dashboard.find_registration(@reg_number)
end

Then("I can view my certificate of registration") do
  # We need to bypass the PDF link by going directly to the HTML version of the certificate.
  visit("#{Quke::Quke.config.custom['urls']['front_office']}/registrations/#{@reg_number}/certificate?show_as_html=true")
  expect(page).to have_text("Certificate of Registration")
  expect(page).to have_text(@reg_number)
  page.evaluate_script("window.history.back()")
end

When("I forget my front office password and reset it") do
  # Submit incorrect password:
  visit(Quke::Quke.config.custom["urls"]["front_office_sign_in"])
  @account_email = Quke::Quke.config.custom["accounts"]["waste_carrier2"]["username"]
  @fo.front_office_sign_in_page.submit(
    email: @account_email,
    password: "cheese"
  )
  expect(@fo.front_office_sign_in_page.error_summary).to have_text("Invalid Email or password.")

  # Request a password reset:
  @fo.front_office_sign_in_page.forgotten_link.click
  @fo.front_office_sign_in_page.reset_password_link.click
  @fo.reset_password_page.submit(email: @account_email)

  # Set the new password
  @password = "B1rthdayP1e"

  # Because the email is stored on one of two servers, there's a possibility that
  # the test picks up an old reset link with the same email address.
  # The following check retries the process if the link is invalid.
  10.times do
    visit(password_reset_link(@account_email))
    @fo.reset_password_page.submit(password: @password)
    break if page.text.not.include? "is invalid"
  end
end

Then("I can log in with the updated password") do
  @fo.front_office_dashboard.sign_out.click
  @fo.front_office_sign_in_page.submit(
    email: @account_email,
    password: @password
  )
  expect(@fo.front_office_dashboard.heading).to have_text("Your waste carrier registrations")
  expect(@fo.front_office_dashboard.content).to have_text(@account_email)
end

Then("I change the password back to its original value") do
  @fo.front_office_dashboard.change_password_link.click
  @fo.reset_password_page.submit(
    current_password: @password,
    password: ENV["WCRS_DEFAULT_PASSWORD"]
  )
  @password = ENV["WCRS_DEFAULT_PASSWORD"]
  expect(@fo.front_office_dashboard.heading).to have_text("Your waste carrier registrations")
end

Given("I have reached the GOV.UK start page") do
  @journey = JourneyApp.new
  visit("https://www.gov.uk/waste-carrier-or-broker-registration")
  expect(@journey.govuk_start_page.heading).to have_text("Register or renew as a waste carrier, broker or dealer")
end

When("I access the links on the page") do
  # Select Wales
  find_link("Wales").click
  expect(page).to have_text("Register or renew as a waste carrier, broker or dealer")
  expect(page).to have_text("If your business is based in Wales, you must register with us")
  page.evaluate_script("window.history.back()")

  # Select Scotland
  find_link("Scotland").click
  expect(page).to have_text("Waste carriers and brokers")
  expect(page).to have_text("Waste Management Licensing (Scotland) Regulations 2011")
  page.evaluate_script("window.history.back()")

  # Select Northern Ireland
  find_link("Northern Ireland").click
  expect(page).to have_text("Registration of carriers and brokers")
  expect(page).to have_text("Information on how to register as a carrier or broker of waste with the Northern Ireland Environment Agency")
  page.evaluate_script("window.history.back()")

  # Select public register
  find_link("public register of waste carriers, brokers and dealers").click
  expect(page).to have_text("Choose a register to search")
  page.evaluate_script("window.history.back()")

  # Select "renew your registration"
  find_link("renew your registration").click
  expect(page).to have_text("Is this a new registration?")
  page.evaluate_script("window.history.back()")

  # Select "Start now"
  @journey.govuk_start_page.start_now_button.click
end

Then("I can start my registration") do
  expect(on_fo_start_page?)
end

Then("I can access the footer links") do
  new_window = window_opened_by { find_link("Privacy").click }
  within_window new_window do
    expect(@journey.standard_page.heading).to have_text("Waste carriers, brokers and dealers privacy policy")
    expect(@journey.standard_page.content).to have_text("Lower-tier registrations are non-expiring")
    new_window = window_opened_by { find_link("Cookies").click }
    within_window new_window do
      expect(@journey.standard_page.heading).to have_text("Cookies")
      expect(@journey.standard_page.content).to have_text("After 20 minutes of inactivity")
      new_window = window_opened_by { find_link("Accessibility").click }
      within_window new_window do
        expect(@journey.standard_page.heading).to have_text("Accessibility statement")
        expect(@journey.standard_page.content).to have_text("beta banner has insufficient contrast")
      end
    end
  end
end
