Given("I register an upper tier {string} from the back office") do |organisation_type|
  @resource_object = :new_registration
  @tier = "upper"
  @organisation_type = organisation_type

  @bo.dashboard_page.new_reg_link.click
  @bo.ad_privacy_policy_page.submit

  @journey.start_page.submit(choice: @resource_object)
  @journey.location_page.submit(choice: :england)
  @journey.confirm_business_type_page.submit(org_type: @organisation_type)

  # todo continue this once the helper functions are correct
end
