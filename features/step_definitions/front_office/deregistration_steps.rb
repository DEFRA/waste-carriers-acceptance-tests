When("I select the link to deregister my registration") do
  if @deregister_from_email_link.nil?
    visit "#{Quke::Quke.config.custom['urls']['front_office']}/fo/deregister/#{@deregistration_token}"
  else
    visit(@deregister_from_email_link)
  end
end

When("I confirm I want to cancel my registration") do
  @fo.deregistration_confirmation_page.accept_cookies
  @fo.deregistration_confirmation_page.submit(choice: :confirm)
end

Then("I will be informed my registration is deregistered") do
  expect(@fo.deregistration_complete_page.heading).to have_text("Deregistration complete")
end

Given("I am sent an new deregisration invite email") do
  visit(Quke::Quke.config.custom["urls"]["notify_link"])
  @deregister_from_email_link = @journey.last_message_page.get_deregister_url(@reg_number)
  puts "Deregister link for #{@reg_number} is #{@deregister_from_email_link}"
end
