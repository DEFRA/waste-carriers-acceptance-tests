When(/^I add a positive charge of £(\d+) to the registration$/) do |charge|
  @back_app.registrations_page.search(search_input: @registration_number)
  @back_app.registrations_page.search_results[0].payment_status.click
  @back_app.payment_status_page.charge_adjustments.click
  @back_app.charge_adjustments_page.add_charge.click
  @back_app.new_charge_adjustment_page.submit(
    amount: charge,
    reference: "12345678",
    description: "Positive charge adjustment"
  )
end

When(/^I add a negative charge of £(\d+) to the registration$/) do |charge|
  @back_app.registrations_page.search(search_input: @registration_number)
  @back_app.registrations_page.search_results[0].payment_status.click
  @back_app.payment_status_page.charge_adjustments.click
  @back_app.charge_adjustments_page.add_negative_charge.click
  @back_app.new_charge_adjustment_page.submit(
    amount: charge,
    reference: "12345678",
    description: "Positive charge adjustment"
  )
end

Then(/^the outstanding balance will be £(\d+)$/) do |charge|
  expect(@back_app.payment_status_page.payment_status.text).to eq("Awaiting payment")
  expect(@back_app.payment_status_page.balance.text).to eq(charge + ".00")
end

Then(/^the overpaid amount will be £(\d+)$/) do |charge|
  expect(@back_app.payment_status_page.payment_status.text).to eq("Overpaid by")
  expect(@back_app.payment_status_page.balance.text).to eq(charge + ".00")
end
