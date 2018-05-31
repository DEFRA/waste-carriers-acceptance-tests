When(/^I write off the small amount owed$/) do
  @back_app.registrations_page.search(search_input: @registration_number)
  @back_app.registrations_page.search_results[0].payment_status.click
  @back_app.payment_status_page.write_off_small.click
  @back_app.write_offs_page.submit(comment: "small amount written off")
end

Then(/^the payment status will be marked as paid$/) do
  expect(@back_app.payment_status_page.payment_status.text).to eq("Paid in full")
  expect(@back_app.payment_status_page.balance.text).to eq("0.00")
  @back_app.payment_status_page.back_link.click
end

When(/^I view the registrations payment summary$/) do
  @back_app.registrations_page.search(search_input: @registration_number)
  @back_app.registrations_page.search_results[0].payment_status.click
end

Then(/^I am unable to write off the amount owed$/) do
  # Currently unable to check that button is disabled so clicking on element
  # Then expecting that the page hasn't changed
  @back_app.payment_status_page.write_off_small.click
  expect(@back_app.payment_status_page.current_url).to include "/paymentstatus"
end
