Given("an agency-refund-payment-user refunds the card payment") do
  sign_in_to_back_office("agency-refund-payment-user")

  visit_refund_page(@reg_number)
  expect(@bo.finance_refund_select_page.heading).to have_text("Which payment do you want to refund?")

  # Use hidden text to identify correct refund link.
  # This only works if there is only one card payment that can be refunded on page:
  find_link("by Card").click

  # The refund itself is a simple page which does not need its own page object:
  expect(@journey.standard_page.heading).to have_text("Confirm the payment refund")

  # Store amount to be refunded as text, for later steps:
  @refund = (-@reg_balance).to_s

  expect(@journey.standard_page.content).to have_text("Balance that will be refunded £#{@refund}.00")
  @journey.standard_page.submit_button.click
  # Takes user back to payment details page with flash message.
end

Then("the card payment is shown as refunded") do
  expect(@bo.finance_payment_details_page.flash_message).to have_text("£#{@refund}.00 refunded successfully")
  expect(@bo.finance_payment_details_page).to have_text("A refund has been requested for this Govpay payment -#{@refund}.00")
  puts "£#{@refund}.00 card payment refunded"
end

Given(/^a finance admin user adjusts the charge by (-?\d+)$/) do |amount|
  # input is a positive or negative integer amount
  sign_in_to_back_office("finance-admin-user")
  random_number = rand(0..999_999) # to help identify transaction later
  amount = amount.to_i
  adjust_charge(amount, random_number)

  expect(@bo.finance_payment_details_page.flash_message).to have_text("£#{amount}.00 charge adjust completed successfully")
  expect(@bo.finance_payment_details_page).to have_text("charge adjustment #{random_number}")

  @reg_balance += amount
end

Given(/^(?:a|an) "([^"]*)" reverses the previous payment$/) do |user|
  sign_in_to_back_office(user)
  reverse_last_transaction

  expect(@bo.finance_payment_details_page.flash_message).to have_text("reversed successfully")
  expect(@bo.finance_payment_details_page).to have_text("ti esrever")
end

Given(/^(?:a|an) "([^"]*)" writes off the outstanding balance$/) do |user|
  # An agency-refund-payment-user is able to write off up to +/- 5 pounds.
  # A finance-admin-user can write off any amount.
  sign_in_to_back_office(user)
  go_to_payments_page(@reg_number)

  write_off_outstanding_balance

  expect(@bo.finance_payment_details_page.flash_message).to have_text("write off completed successfully")
  expect(@bo.finance_payment_details_page).to have_text("this is a writeoff")
end
