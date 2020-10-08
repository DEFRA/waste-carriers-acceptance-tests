When(/^I add a positive charge of £(\d+) to the registration$/) do |charge|
  @old.backend_registrations_page.search(search_input: @reg_number)
  @old.backend_registrations_page.search_results[0].payment_status.click
  @old.payment_status_page.charge_adjustments.click
  @old.charge_adjustments_page.add_charge.click
  @old.new_charge_adjustment_page.submit(
    amount: charge,
    reference: "12345678",
    description: "Positive charge adjustment"
  )
end

When(/^I add a negative charge of £(\d+) to the registration$/) do |charge|
  @old.backend_registrations_page.search(search_input: @reg_number)
  @old.backend_registrations_page.search_results[0].payment_status.click
  @old.payment_status_page.charge_adjustments.click
  @old.charge_adjustments_page.add_negative_charge.click
  @old.new_charge_adjustment_page.submit(
    amount: charge,
    reference: "12345678",
    description: "Positive charge adjustment"
  )
end

Then(/^the outstanding balance will be £(\d+)$/) do |charge|
  expect(@old.payment_status_page.payment_status.text).to eq("Awaiting payment")
  expect(@old.payment_status_page.balance.text).to eq(charge.to_s + ".00")
end

Then(/^the overpaid amount will be £(\d+)$/) do |charge|
  expect(@old.payment_status_page.payment_status.text).to eq("Overpaid by")
  expect(@old.payment_status_page.balance.text).to eq(charge.to_s + ".00")
end
