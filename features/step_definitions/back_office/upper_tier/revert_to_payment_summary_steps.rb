require "pry"

When(/^I renew my last registration"$/) do |reg|
  @renewals_app = RenewalsApp.new
  @journey = JourneyApp.new
  @renewals_app.start_page.load
  @renewals_app.start_page.submit(renewal: true)
  @renewals_app.existing_registration_page.submit(reg_no: reg)
  # save registration number for checks later on
  @reg_number = reg
end

When("I revert the last renewal to payment summary") do
  visit_renewal_details_page(@reg_number)

  @bo.registration_details_page.revert_to_payment_summary_link.click
end

Then("the user is able to complete their renewal") do
  sign_in_to_front_end_if_necessary(@email_address)

  @renewals_app.start_page.load
  @renewals_app.start_page.submit(renewal: true)
  @renewals_app.existing_registration_page.submit(reg_no: @reg_number)
  @renewals_app.payment_summary_page.submit(choice: :card_payment)
  submit_valid_card_payment

  expect(page).to have_content("Renewal complete")
end
