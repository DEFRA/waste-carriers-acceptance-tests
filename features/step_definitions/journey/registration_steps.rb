# Group pieces together when they are always consecutive (renewal - new lower tier - new upper tier)
# Helpers vs Step to group things together - Choose helpers, avoid steps.
# Helpers vs Step - repeat helpers, not steps.
# Use `Given` to set up instance variables for the rest of the journey decisions

Given("I want to register as a lower tier carrier") do
  load_all_apps

  @tier = :lower
end

When("I start a new registration journey in {string} as a {string}") do |location, organisation_type|
  @organisation_type = organisation_type

  @journey.start_page.load
  @journey.start_page.submit

  @journey.location_page.submit(choice: location)

  @journey.business_type_page.submit(org_type: organisation_type)
end

When("I complete my registration") do
  if @organisation_type != "charity"
    @journey.check_your_tier_page.submit(option: :unknown)

    if @tier == :lower
      select_random_lower_tier_options
    else
      select_random_upper_tier_options("existing")
    end
  end

  if @organisation_type == "charity" || @tier == :lower
    expect(page).to have_content("You need to register as a lower tier waste carrier")
  else
    expect(page).to have_content("You need to register as an upper tier waste carrier")
  end

  @journey.standard_page.submit

  business_name = "Lower Tier #{@organisation_type} business new registration"
  @journey.company_name_page.submit(company_name: business_name)

  @journey.address_lookup_page.submit_valid_address

  names = {
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name
  }
  @journey.contact_name_page.submit(names)

  @journey.contact_phone_page.submit(phone_number: "01234567890")

  email = generate_email
  @journey.contact_email_page.submit(email: email, confirm_email: email)

  @journey.address_lookup_page.submit_valid_address

  expect(page).to have_content("Check your answers")
  @journey.standard_page.submit

  @journey.declaration_page.submit
end

Then("I am notified that my registration has been successful") do
  expect(page).to have_content("Registration complete")

  # TODO: Check email received
end
