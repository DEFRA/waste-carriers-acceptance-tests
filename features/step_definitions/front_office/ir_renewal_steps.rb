Given(/^I renew my registration using my previous registration number "([^"]*)"$/) do |reg|
  @front_app = FrontOfficeApp.new
  @front_app.start_page.load
  @front_app.start_page.submit(renewal: true)
  @front_app.existing_registration_page.submit(reg_no: reg)
end

Given(/^I choose to renew my registration using my previous registration number$/) do
  Capybara.reset_session!
  @front_app = FrontOfficeApp.new
  @front_app.start_page.load
  @front_app.start_page.submit(renewal: true)
  @front_app.existing_registration_page.submit(reg_no: @registration_number)
end

Given(/^the registration is expired$/) do
  # Scenario reads better with this step
end

When(/^I complete the public body registration renewal$/) do
  @front_app.business_type_page.submit
  @front_app.other_businesses_question_page.submit(choice: :no)
  @front_app.construction_waste_question_page.submit(choice: :yes)
  @front_app.registration_type_page.submit
  @front_app.business_details_page.submit(
    postcode: "S60 1BY",
    result: "ENVIRONMENT AGENCY, BOW BRIDGE CLOSE, ROTHERHAM, S60 1BY"
  )
  @email = @front_app.generate_email
  @front_app.contact_details_page.submit(
    first_name: "Bob",
    last_name: "Carolgees",
    phone_number: "012345678",
    email: @email
  )
  @front_app.postal_address_page.submit

  people = @front_app.key_people_page.key_people

  @front_app.key_people_page.submit_key_person(person: people[0])
  @front_app.relevant_convictions_page.submit(choice: :no)
  @front_app.check_details_page.submit
  @front_app.sign_up_page.submit(
    registration_password: "Secret123",
    confirm_password: "Secret123",
    confirm_email: @email
  )
  @front_app.order_page.submit(
    copy_card_number: "2",
    choice: :card_payment
  )
  click(@front_app.worldpay_card_choice_page.maestro)

  # finds today's date and adds another year to expiry date
  time = Time.new

  @year = time.year + 1

  @front_app.worldpay_card_details_page.submit(
    card_number: "6759649826438453",
    security_code: "555",
    cardholder_name: "3d.authorised",
    expiry_month: "12",
    expiry_year: @year
  )
  @front_app.worldpay_card_details_page.submit_button.click
  # Stores registration number for later use
  @registration_number = @front_app.confirmation_page.registration_number.text
  @front_app.mailinator_page.load
  @front_app.mailinator_page.submit(inbox: @email)
  @front_app.mailinator_inbox_page.confirmation_email.click
  @front_app.mailinator_inbox_page.email_details do |frame|
    @new_window = window_opened_by { frame.confirm_email.click }
  end
end

Then(/^I will be told "([^"]*)"$/) do |message|
  expect(@front_app.existing_registration_page).to have_text(message)
end
