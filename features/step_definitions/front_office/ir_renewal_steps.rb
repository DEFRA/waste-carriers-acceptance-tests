Given(/^I renew my registration using my previous registration number "([^"]*)"$/) do |reg|
  @renewals_app = RenewalsApp.new
  @renewals_app.start_page.load
  @renewals_app.start_page.submit(renewal: true)
  @renewals_app.existing_registration_page.submit(reg_no: reg)
end

Given(/^I choose to renew my registration using my previous registration number$/) do
  Capybara.reset_session!
  @renewals_app = RenewalsApp.new
  @renewals_app.start_page.load
  @renewals_app.start_page.submit(renewal: true)
  @renewals_app.existing_registration_page.submit(reg_no: @registration_number)
end

When(/^I complete the public body registration renewal$/) do
  @renewals_app.confirm_business_type_page.submit
  @renewals_app.other_businesses_page.submit(choice: :no)
  @renewals_app.construction_waste_page.submit(choice: :yes)
  @renewals_app.registration_type_page.submit
  @renewals_app.business_details_page.submit(
    postcode: "S60 1BY",
    result: "ENVIRONMENT AGENCY, BOW BRIDGE CLOSE, ROTHERHAM, S60 1BY"
  )
  @email = @renewals_app.generate_email
  @renewals_app.contact_details_page.submit(
    first_name: "Bob",
    last_name: "Carolgees",
    phone_number: "012345678",
    email: @email
  )
  @renewals_app.postal_address_page.submit

  people = @renewals_app.renew_key_people_page.key_people

  @renewals_app.renew_key_people_page.submit_key_person(person: people[0])
  @renewals_app.relevant_convictions_page.submit(choice: :no)
  @renewals_app.declaration_page.submit
  @renewals_app.sign_up_page.submit(
    registration_password: "Secret123",
    confirm_password: "Secret123",
    confirm_email: @email
  )
  @renewals_app.order_page.submit(
    copy_card_number: "2",
    choice: :card_payment
  )
  click(@renewals_app.worldpay_card_choice_page.maestro)

  # finds today's date and adds another year to expiry date
  time = Time.new

  @year = time.year + 1

  @renewals_app.worldpay_card_details_page.submit_button.click(
    card_number: "6759649826438453",
    security_code: "555",
    cardholder_name: "3d.authorised",
    expiry_month: "12",
    expiry_year: @year
  )
  @renewals_app.worldpay_card_details_page.submit_button.click_button.click
  # Stores registration number for later use
  @registration_number = @renewals_app.confirmation_page.registration_number.text
  @renewals_app.mailinator_page.load
  @renewals_app.mailinator_page.submit(inbox: @email)
  @renewals_app.mailinator_inbox_page.confirmation_email.click
  @renewals_app.mailinator_inbox_page.email_details do |frame|
    @new_window = window_opened_by { frame.confirm_email.click }
  end
end
