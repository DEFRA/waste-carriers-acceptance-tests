When(/^I complete my registration of my limited company as a upper tier waste carrier$/) do
  @app.business_type_page.submit(org_type: "limitedCompany")
  @app.other_businesses_question_page.submit(choice: :no)
  @app.construction_waste_question_page.submit(choice: :yes)
  @app.registration_type_page.submit(choice: :carrier_broker_dealer)
end

Then(/^I will be registered as an upper tier waste carrier$/) do
  pending # Write code here that turns the phrase above into concrete actions
end