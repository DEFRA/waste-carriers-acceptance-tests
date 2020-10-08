When(/^I write off the small amount owed$/) do
  @old.backend_registrations_page.search(search_input: @reg_number)
  @old.backend_registrations_page.search_results[0].payment_status.click
  @old.payment_status_page.write_off_small.click
  @old.write_offs_page.submit(comment: "small amount written off")
end

When(/^I write off the large amount owed$/) do
  @old.backend_registrations_page.search(search_input: @reg_number)
  @old.backend_registrations_page.search_results[0].payment_status.click
  @old.payment_status_page.write_off_large.click
  @old.write_offs_page.submit(comment: "large amount written off")
end

Then(/^the payment status will be marked as paid$/) do
  expect(@old.payment_status_page.payment_status.text).to eq("Paid in full")
  expect(@old.payment_status_page.balance.text).to eq("0.00")
  @old.payment_status_page.back_link.click
end

When(/^I view the registrations payment summary$/) do
  @old.backend_registrations_page.search(search_input: @reg_number)
  @old.backend_registrations_page.search_results[0].payment_status.click
end

Then(/^I am unable to write off the amount owed$/) do
  # Currently unable to check that button is disabled so clicking on element
  # Then expecting that the page hasn't changed
  @old.payment_status_page.write_off_small.click
  expect(@old.payment_status_page.current_url).to include "/paymentstatus"
end
