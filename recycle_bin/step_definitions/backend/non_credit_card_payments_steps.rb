When(/^I enter a cash payment for the full amount owed$/) do
  @old.backend_registrations_page.search(search_input: @reg_number)
  @old.backend_registrations_page.search_results[0].payment_status.click
  @old.payment_status_page.enter_payment.click
  # Finds the amount needed to be paid and strips off the pound sign
  @amount_due = @old.payments_page.amount_due.text[1..-1]
  @old.payments_page.submit(
    payment_amount: @amount_due,
    payment_day: "1",
    payment_month: "1",
    payment_year: "2017",
    payment_ref: "Test",
    payment_type: "Cash",
    payment_comment: "exact cash payment"
  )
  expect(@old.payment_status_page.payment_status.text).to eq("Paid in full")
  expect(@old.payment_status_page.balance.text).to eq("0.00")
  @old.payment_status_page.back_link.click
end

When(/^I enter a cheque payment overpaying for the amount owed$/) do
  @old.backend_registrations_page.search(search_input: @reg_number)
  @old.backend_registrations_page.search_results[0].payment_status.click
  @old.payment_status_page.enter_payment.click
  # Finds the amount needed to be paid and strips off the pound sign
  @amount_due = @old.payments_page.amount_due.text[1..-1]
  @small_overpayment = @amount_due.to_i + 1
  @old.payments_page.submit(
    payment_amount: @small_overpayment,
    payment_day: "1",
    payment_month: "1",
    payment_year: "2017",
    payment_ref: "Test",
    payment_type: "Cheque",
    payment_comment: "cheque overpayment payment"
  )
  @old.payment_status_page.back_link.click
end

When(/^I enter a postal order payment underpaying for the amount owed$/) do
  @old.backend_registrations_page.search(search_input: @reg_number)
  @old.backend_registrations_page.search_results[0].payment_status.click
  @old.payment_status_page.enter_payment.click
  # Finds the amount needed to be paid and strips off the pound sign
  @amount_due = @old.payments_page.amount_due.text[1..-1]
  @small_underpayment = @amount_due.to_i - 1
  @old.payments_page.submit(
    payment_amount: @small_underpayment,
    payment_day: "1",
    payment_month: "1",
    payment_year: "2017",
    payment_ref: "Test",
    payment_type: "Postal order",
    payment_comment: "postal order underpayment payment"
  )
  @old.payment_status_page.back_link.click
end

When(/^I enter a bank transfer payment for the full amount owed$/) do
  @old.backend_registrations_page.search(search_input: @reg_number)
  @old.backend_registrations_page.search_results[0].payment_status.click
  @old.payment_status_page.enter_payment.click
  # Finds the amount needed to be paid and strips off the pound sign
  @amount_due = @old.payments_page.amount_due.text[1..-1]
  @old.payments_page.submit(
    payment_amount: @amount_due,
    payment_day: "1",
    payment_month: "1",
    payment_year: "2017",
    payment_ref: "Test",
    payment_type: "Bank transfer payment",
    payment_comment: "exact bank transfer payment"
  )
  @old.payment_status_page.back_link.click
end

Then(/^the payment status will be marked as overpaid$/) do
  @old.backend_registrations_page.search(search_input: @reg_number)
  @old.backend_registrations_page.search_results[0].payment_status.click
  expect(@old.payment_status_page.payment_status.text).to eq("Overpaid by")
  expect(@old.payment_status_page.balance.text).to eq("1.00")
end

Then(/^the payment status will be marked as underpaid$/) do
  @old.backend_registrations_page.search(search_input: @reg_number)
  @old.backend_registrations_page.search_results[0].payment_status.click
  expect(@old.payment_status_page.payment_status.text).to eq("Awaiting payment")
  expect(@old.payment_status_page.balance.text).to eq("1.00")
end

Then(/^the registration will be marked as "([^"]*)"$/) do |status|
  @old.backend_registrations_page.search(search_input: @reg_number)
  expect(@old.backend_registrations_page.search_results[0].status.text).to eq(status)

end
