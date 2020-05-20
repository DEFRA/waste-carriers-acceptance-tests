When("I cancel the registration") do
  visit_registration_details_page(@reg_number)

  @bo.registration_details_page.cancel_link.click
  @journey.standard_page.submit
end

When("I am about to cancel the registration and change my mind") do
  visit_registration_details_page(@reg_number)

  @bo.registration_details_page.cancel_link.click
  click_link("Keep this registration")
end
