When("I select the link to deregister my registration") do
  visit "#{Quke::Quke.config.custom['urls']['front_office']}/fo/deregister/#{@deregistration_token}"
end

When("I confirm I want to cancel my registration") do
  @fo.deregistration_confirmation_page.accept_cookies
  @fo.deregistration_confirmation_page.submit(choice: :confirm)
end

Then("I will be informed my registration is deregistered") do
  expect(@fo.deregistration_complete_page.heading).to have_text("Deregistration complete")
end
