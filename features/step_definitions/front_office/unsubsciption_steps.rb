When("I subsubscribe from the renewal reminder emails") do
  visit(Quke::Quke.config.custom["urls"]["last_email_fo"])
  @unsubscription_link = @journey.last_message_page.get_unsubscription_url(@reg_number)
  visit(@unsubscription_link)
end

Then("I will see confirmation that I have unsubscibed") do
  expect(@fo.unsubscription_confirmation_page)
    .to have_text("You have successfully unsubscribed from renewal reminder emails.")
end
