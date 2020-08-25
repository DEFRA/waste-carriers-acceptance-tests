Given("I register an upper tier {string} from the back office") do |organisation_type|
  @organisation_type = organisation_type
  @app = "bo"
  @resource_object = :new_registration
  @tier = "upper"
  @carrier = "carrier_broker_dealer"
  @business_name = "BO upper tier " + organisation_type.to_s
  @copy_cards = rand(3)

  start_reg_from_back_office
  step("I complete my registration for my business '#{@business_name}'")

end
