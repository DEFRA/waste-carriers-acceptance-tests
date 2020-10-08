Given("an Agency super user has signed in to the admin area") do
  @old = OldApp.new
  @bo = BackOfficeApp.new
  @journey = JourneyApp.new
  @old.admin_sign_in_page.load
  @old.admin_sign_in_page.submit(
    email: Quke::Quke.config.custom["accounts"]["agency-super"]["username"],
    password: ENV["WCRS_DEFAULT_PASSWORD"]
  )
end

Given("has created an agency user") do
  @user = generate_email
  @old.agency_users_page.add_user.click
  @old.agency_users_page.submit(
    email: @user,
    password: ENV["WCRS_DEFAULT_PASSWORD"]
  )
  expect(@old.agency_users_page).to have_text("Agency user was successfully created.")
  @old.agency_users_page.sign_out.click
end

When("I migrate the backend users to the back office") do
  @bo.dashboard_page.govuk_banner.manage_users_link.click
  expect(@bo.users_page).to_not have_text(@user)
  @bo.users_page.migrate_users.click
  @bo.user_migrate_page.migrate_users.click
  expect(@bo.user_migrate_page).to have_text(@user)
end

Then("the user has been added to the back office") do
  expect(@bo.user_migrate_page).to have_text(@user)
end
