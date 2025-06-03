Given("I register an upper tier {string} from the back office") do |organisation_type|
  @organisation_type = organisation_type.to_sym

  @app = :bo
  @reg_type = :new_registration
  @tier = :upper
  @carrier = :carrier_broker_dealer
  @business_name = "BO upper tier #{organisation_type}"
  @copy_cards = rand(3)

  start_reg_from_back_office
  step("I complete my registration for my business '#{@business_name}'")
end

Given("I register a {string} from the back office with no contact email") do |organisation_type|
  @organisation_type = organisation_type.to_sym
  @app = :bo
  @reg_type = :new_registration
  @tier = :upper
  @carrier = :carrier_broker_dealer
  @business_name = "BO upper tier #{organisation_type}"
  @copy_cards = rand(3)
  @no_contact_email = true
  start_reg_from_back_office
  step("I complete my registration for my business '#{@business_name}'")
end

Given("I register an lower tier {string} from the back office") do |organisation_type|
  @organisation_type = organisation_type.to_sym
  @app = :bo
  @reg_type = :new_registration
  @tier = :lower
  @business_name = "BO lower tier #{organisation_type}"

  start_reg_from_back_office
  step("I complete my registration for my business '#{@business_name}'")

end

Given("I register a lower tier {string} from the back office with no contact email") do |organisation_type|
  @organisation_type = organisation_type.to_sym
  @app = :bo
  @reg_type = :new_registration
  @tier = :lower
  @business_name = "BO lower tier #{organisation_type}"
  @no_contact_email = true

  start_reg_from_back_office
  step("I complete my registration for my business '#{@business_name}'")

end

When("I cancel the registration") do
  visit_registration_details_page(@reg_number)

  @bo.registration_details_page.cancel_link.click
  @journey.standard_page.submit
end
