When("I choose to view my certificate") do
  @fo.front_office_sign_in_page.load
  @fo.front_office_sign_in_page.submit(
    email: @email_address, password: ENV["WCRS_DEFAULT_PASSWORD"]
  )
  @fo.front_office_dashboard.find_registration(@reg_number)
end

Then("I can view my certificate of registration") do
  # We need to bypass the PDF link by going directly to the HTML version of the certificate.
  visit("#{Quke::Quke.config.custom['urls']['front_office']}/fo/registrations/#{@reg_number}/certificate?show_as_html=true")
  expect(page).to have_text("Certificate of Registration")
  expect(page).to have_text(@reg_number)
  page.evaluate_script("window.history.back()")
end

When("I forget my front office password and reset it") do
  # Submit incorrect password:
  visit(Quke::Quke.config.custom["urls"]["front_office_sign_in"])
  @journey.standard_page.accept_cookies

  @account_email = Quke::Quke.config.custom["accounts"]["waste_carrier2"]["username"]
  @fo.front_office_sign_in_page.submit(
    email: @account_email,
    password: "cheese"
  )
  expect(@fo.front_office_sign_in_page.error_summary).to have_text("Invalid Email or password.")

  # Request a password reset:
  @fo.front_office_sign_in_page.forgotten_link.click
  @fo.front_office_sign_in_page.reset_password_link.click
  @fo.reset_password_page.change_password(email: @account_email)

  # Set the new password
  @password = "B1rthdayP1e"

  # Because the email is stored on one of two servers, there's a possibility that
  # the test picks up an old reset link with the same email address.
  # The following check retries the process if the link is invalid.
  10.times do
    visit(password_reset_link(@account_email))
    @fo.reset_password_page.reset_password(password: @password)
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
  @fo.reset_password_page.change_password(
    current_password: @password,
    password: ENV["WCRS_DEFAULT_PASSWORD"]
  )
  @password = ENV["WCRS_DEFAULT_PASSWORD"]
  expect(@fo.front_office_dashboard.heading).to have_text("Your waste carrier registrations")
end

Then("I can access the footer links") do
  find_link("Privacy").click
  expect(@journey.standard_page.heading).to have_text("Privacy Notice")
  find_link("Cookies").click
  expect(@journey.standard_page.heading).to have_text("Cookies on Register as a waste carrier")
  find_link("Accessibility").click
  expect(@journey.standard_page.heading).to have_text("Accessibility statement")
end

Given("I am based outside England but in the UK") do
  load_all_apps
  @reg_type = :new_registration
  @journey.start_page.load
  @journey.standard_page.accept_cookies

  @journey.start_page.submit(choice: @reg_type)
end

When("I check options for each country") do
  # Select Wales
  @journey.location_page.submit(choice: :wales)
  expect(@journey.standard_page.heading).to have_text("You can register in Wales")
  find_link("Back").click

  # Select Scotland
  @journey.location_page.submit(choice: :scotland)
  expect(@journey.standard_page.heading).to have_text("You can register in Scotland")
  find_link("Back").click

  # Select Northern Ireland
  @journey.location_page.submit(choice: :northern_ireland)
  expect(@journey.standard_page.heading).to have_text("You can register in Northern Ireland")
end

Then("I can still decide to register in England") do
  expect(@journey.standard_page.heading).to have_text("You can register in Northern Ireland")
  @journey.standard_page.submit
  expect(@journey.confirm_business_type_page.heading).to have_text("What type of business or organisation are you?")
end
