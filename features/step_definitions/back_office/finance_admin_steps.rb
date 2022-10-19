Given("an agency-refund-payment-user refunds the card payment") do
  sign_in_to_back_office("agency-refund-payment-user")

  visit_refund_page(@reg_number)
  expect(@bo.finance_refund_select_page.heading).to have_text("Which payment do you want to refund?")

  # Use hidden text to identify correct refund link.
  # This only works if there is only one WorldPay payment that can be refunded on page:
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
  puts "£#{@refund}.00 WorldPay payment refunded"
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

Given("I add a missed Worldpay payment at the payment stage") do
  if @reg_type == :new_registration
    # Search for registration by name as it doesn't have a CBD number yet:
    @bo.dashboard_page.view_new_reg_details(search_term: @business_name)
  else # it's a renewal
    @bo.dashboard_page.view_transient_reg_details(search_term: @reg_number)
  end
  @bo.registration_details_page.add_missed_worldpay_button.click

  # At this point the registration number is generated. Get this and the balance from the screen:
  @reg_number = @bo.finance_payment_input_page.content.text.match(/.*Add a missed WorldPay payment for (.*)\n*/)[1]
  @reg_balance = @bo.finance_payment_input_page.content.text.match(/.*The current balance is £(\d+)*/)[1].to_i
  @bo.finance_payment_input_page.submit(
    amount: @reg_balance.to_s,
    day: "01",
    month: "07",
    year: "2020",
    reference: "0101010",
    comment: "missed worldpay at payment stage"
  )
  expect(@bo.finance_payment_details_page.flash_message).to have_text("#{@reg_balance} payment entered successfully")
  @reg_type = :registration
end
