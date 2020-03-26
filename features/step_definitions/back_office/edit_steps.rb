require "pry"

When("I edit the most recent registration") do
  @edited_info = {
    contact_email: generate_email
  }

  @bo.dashboard_page.view_reg_details(search_term: @reg_number)

  registration_details_page = RegistrationDetailsPage.new
  registration_details_page.edit_link.click

  registration_edit_page = RegistrationEditPage.new
  registration_edit_page.change_contact_email.click

  registration_edit_contact_email_page = RegistrationEditContactEmailPage.new
  registration_edit_contact_email_page.contact_email_field.set(@edited_info[:contact_email])
  registration_edit_contact_email_page.confirm_contact_email_field.set(@edited_info[:contact_email])
  registration_edit_contact_email_page.submit_form.click
end

When("I confirm the changes") do
  registration_edit_page = RegistrationEditPage.new
  registration_edit_page.confirm_changes.click

  declaration_page = DeclarationPage.new
  declaration_page.submit
end

Then("I can see the changes on the registration details page") do
  registration_edit_completed_page = RegistrationEditCompletedPage.new
  registration_edit_completed_page.view_registration.click

  @edited_info.each_value do |value|
    expect(page).to have_text(value)
  end
end

When("I edit the most recent registration type to {string}") do |registration_type|
  edited_text = case registration_type
                when "carrier_dealer"
                  "Carrier and dealer"
                when "broker_dealer"
                  "Broker and dealer"
                else
                  "Carrier, broker and dealer"
                end

  @edited_info = {
    registration_type: edited_text
  }

  @bo.dashboard_page.view_reg_details(search_term: @reg_number)

  registration_details_page = RegistrationDetailsPage.new
  registration_details_page.edit_link.click

  registration_edit_page = RegistrationEditPage.new
  registration_edit_page.change_registration_type.click

  registration_edit_type_page = RegistrationEditTypePage.new
  radio_button = "#{registration_type}_radio"
  registration_edit_type_page.public_send(radio_button).click
  registration_edit_type_page.submit_form.click
end

When("I pay by card") do
  registration_edit_payment_summary_page = RegistrationEditPaymentSummaryPage.new
  registration_edit_payment_summary_page.card_payment_method_radio.click
  registration_edit_payment_summary_page.submit_form.click

  submit_valid_card_payment
end

When("I pay by bank transfer") do
  registration_edit_payment_summary_page = RegistrationEditPaymentSummaryPage.new
  registration_edit_payment_summary_page.bank_transfer_payment_method_radio.click
  registration_edit_payment_summary_page.submit_form.click

  registration_edit_pay_by_bank_transfer = RegistrationEditPayByBankTransferPage.new
  registration_edit_pay_by_bank_transfer.submit_form.click
end

When("I cancel the edit") do
  registration_edit_page = RegistrationEditPage.new
  registration_edit_page.cancel_changes.click

  registration_edit_confirm_cancel_page = RegistrationEditConfirmCancelPage.new
  registration_edit_confirm_cancel_page.confirm_cancel.click
end

Then("I cannot see the changes on the registration details page") do
  registration_edit_completed_page = RegistrationEditCompletedPage.new
  registration_edit_completed_page.view_registration.click

  @edited_info.each_value do |value|
    expect(page).to_not have_text(value)
  end
end
