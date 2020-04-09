# Group pieces together when they are always consecutive (renewal - new lower tier - new upper tier)
# Helpers vs Step to group things together - Choose helpers, avoid steps.
# Helpers vs Step - repeat helpers, not steps.
# Use `Given` to set up instance variables for the rest of the journey decisions

Given("I want to register as a lower tier carrier") do
  load_all_apps

  @resource_object = :new_registration
  @tier = "lower"
end

Given("I want to register as an upper tier carrier") do
  load_all_apps

  @resource_object = :new_registration
  @tier = "upper"
end

When("I start a new registration journey in {string} as a {string}") do |location, organisation_type|
  @organisation_type = organisation_type

  @journey.start_page.load
  @journey.start_page.submit

  @journey.location_page.submit(choice: location)

  @journey.business_type_page.submit(org_type: organisation_type)
end

When("I complete my registration") do
  if @organisation_type == "charity"
    # then all tier routing questions are skipped and user is told "you need to register as a lower tier waste carrier"
    @journey.standard_page.submit
  elsif @tier == "lower"
    select_random_lower_tier_options
  else
    select_random_upper_tier_options("existing")
  end

  @journey.carrier_type_page.submit(choice: :carrier_broker_dealer) if @tier == "upper"

  @business_name = "#{@tier} tier #{@organisation_type} new registration"
  @journey.company_name_page.submit(company_name: @business_name)

  @journey.address_lookup_page.submit_valid_address

  if @tier == "upper"
    people = @journey.company_people_page.main_people
    @journey.company_people_page.submit_main_person(person: people[0])

    @journey.conviction_declare_page.submit(choice: :no)
  end

  names = {
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name
  }
  @journey.contact_name_page.submit(names)

  @journey.contact_phone_page.submit(phone_number: "0117 4960000")

  @email_address = generate_email
  @journey.contact_email_page.submit(email: @email_address, confirm_email: @email_address)

  @journey.address_lookup_page.submit_valid_address

  expect(page).to have_content("Check your answers")
  @journey.standard_page.submit

  @journey.declaration_page.submit

  # Copy cards - Just submit, order no copy cards
  @journey.standard_page.submit if @tier == "upper"
end

Then("I am notified that my registration has been successful") do
  expect(page).to have_content("Registration complete")

  # TODO: Check email received
end
