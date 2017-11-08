When(/^I change my registration type to "([^"]*)"$/) do |registration_type|
  @front_app.mailinator_page.load
  @front_app.mailinator_page.submit(inbox: @email)
  @front_app.mailinator_inbox_page.confirmation_email.click
  @front_app.mailinator_inbox_page.email_details do |frame|
    @new_window = window_opened_by { frame.confirm_email.click }
  end
  @front_app.waste_carrier_sign_in_page.load
  @front_app.waste_carrier_sign_in_page.submit(
    email: @email,
    password: "Secret123"
  )
  @front_app.waste_carrier_registrations_page.user_registrations[0].edit_registration.click
  @front_app.declaration_page.edit_registration_type.click
  @front_app.registration_type_page.submit(choice: registration_type.to_sym)
  @front_app.declaration_page.submit
end

Then(/^I will be charged "([^"]*)" for the change$/) do |charge|
  @actual_charge = "£" + @front_app.order_page.charge.value
  expect(@actual_charge).to eq(charge)
end
