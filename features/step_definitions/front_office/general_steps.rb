Given(/^I have started a new application$/) do
  @app = FrontOfficeApp.new
  @app.start_or_resume_page.load
  @app.start_or_resume_page.submit
end

Given(/^I have given my email details to save my application$/) do
  @app.save_choice_page.submit(
    email: "tim.stone.ea@gmail.com"
  )
  @app.confirm_email_page.submit
  @app.save_and_return_sent_page.submit
end

When(/^I select an "([^"]*)" standard rules permit "([^"]*)"$/) do |category, permit_no|
  @app.permit_category_page.submit(permit_categories: category)
  @app.select_permit_page.submit(permits: permit_no)
end

# There won't be so many assertions per step in the future
# but they are there to remind me to add them to specific scenarios
# TODO: Move assertions into specific scenarios rather than group
# them here.
When(/^I complete my application$/) do
  @app.task_list_page.cost_and_time.click
  @app.cost_and_time_page.submit

  expect(@app.task_list_page).to have_cost_and_time_completed_status

  @app.task_list_page.read_rules.click
  @app.read_rules_page.submit

  expect(@app.task_list_page).to have_read_rules_completed_status

  # @app.task_list_page.find_out_what_you_need.click
  # @app.find_out_what_need_to_apply_page.submit

  # expect(@app.task_list_page).to have_find_out_what_you_need_completed_status
  @app.task_list_page.pre_app_discussion.click
  @app.pre_app_discussion_page.submit(
    choice: :pre_app_with_ref,
    pre_app_ref: "SRP3423"
  )

  expect(@app.task_list_page).to have_pre_app_discussion_completed_status

  @app.task_list_page.contact_details.click
  @app.contact_details_page.submit(
    contact_name: "Clive",
    contact_tel_number: "12345678",
    contact_email: "clive@example.com"
  )

  expect(@app.task_list_page).to have_contact_details_completed_status

  @app.task_list_page.permit_holder_details.click
  @app.site_operator_details_page.submit(org_type: "Limited company")
  @app.check_operator_page.submit(company_number: "12345678")
  @app.check_company_details_page.submit(choice: :main_address)
  @app.declare_offences_page.submit(choice: :offences)
  @app.offences_check_page.submit(
    offender_name: "Big D",
    offender_position: "Big cheese",
    offence: "Dumper",
    dob_day: "01",
    dob_month: "01",
    dob_year: "1970"
  )
  @app.bankruptcy_check_page.submit(choice: :no)

  expect(@app.task_list_page).to have_permit_holder_details_completed_status

  @app.task_list_page.site_name_and_location.click
  @app.site_name_page.submit(site_name: "Test site")
  @app.grid_reference_page.submit(grid_ref: "ST 58132 72695")
  @app.site_post_code_page.submit(post_code: "BS1 5AH")
  @app.site_address_page.submit(result: "9a, GRANGE ROAD, BRISTOL, BS1 5AH")

  expect(@app.task_list_page).to have_site_name_and_location_completed_status

  @app.task_list_page.site_plan.click
  @app.site_plan_page.submit

  expect(@app.task_list_page).to have_site_plan_completed_status

  @app.task_list_page.qualifications.click
  @app.industry_scheme_page.submit(
    choice: :chartered_institute_of_wastes_management
  )
  @app.industry_scheme_certificate_upload_page.submit
  expect(@app.task_list_page).to have_qualifications_completed_status

  @app.task_list_page.management_system.click
  # TODO: add logic to check each checkbox
  @app.management_system_page.submit

  expect(@app.task_list_page).to have_management_system_completed_status

  @app.task_list_page.confidentiality_needs.click
  @app.claim_confidentiality_page.submit(
    choice: :confidential,
    reason: "Top secret"
  )

  expect(@app.task_list_page).to have_claim_confidentiality_completed_status

  @app.task_list_page.submit
  @app.check_answers_page.submit
  @app.card_payment_page.submit(
    card_number: "12345678910",
    expiry_month: "03",
    expiry_year: "21",
    full_name: "Mr P Holder",
    security_code: "123",
    building_name: "The house",
    building_and_street: "A street",
    town_or_city: "Bristol",
    postcode: "BS1 5AH",
    email: "test@example.com"
  )

  @app.confirm_payment_page.submit
end

Then(/^I will see confirmation my application has been submitted$/) do
  expect(@app.application_sent_page).to have_text("Application sent")
end

# TODO: add logic to look for actual reference number when that is developed
Then(/^I should see my application reference$/) do
  expect(@app.application_sent_page).to have_text("Your reference is:")
end
