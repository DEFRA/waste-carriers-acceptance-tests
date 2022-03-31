When("I edit the most recent registration") do
  @edited_info = {
    contact_email: generate_email
  }

  @bo.dashboard_page.view_reg_details(search_term: @reg_number)
  @bo.registration_details_page.edit_link.click
  @bo.edit_page.change_contact_email.click

  @journey.contact_email_page.submit(email: @edited_info[:contact_email], confirm_email: @edited_info[:contact_email])
end

When("I confirm the changes") do
  @bo.edit_page.confirm_changes.click
  @journey.declaration_page.submit
end

Then("I can see the changes on the registration details page") do
  find_link("View registration").click

  @edited_info.each_value do |value|
    expect(page).to have_text(value)
  end
end

When("I edit the most recent registration type to {string}") do |carrier_type|
  edited_text = case carrier_type
                when "carrier_dealer"
                  "Carrier and dealer"
                when "broker_dealer"
                  "Broker and dealer"
                else
                  "Carrier, broker and dealer"
                end

  @edited_info = {
    carrier_type: edited_text
  }

  @bo.dashboard_page.view_reg_details(search_term: @reg_number)
  @bo.registration_details_page.edit_link.click
  @bo.edit_page.change_registration_type.click

  @journey.carrier_type_page.submit(choice: carrier_type)
end
