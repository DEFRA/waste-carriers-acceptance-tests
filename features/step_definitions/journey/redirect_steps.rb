Given("the old apps are no longer available") do
  # quick check that the old apps aren't available
  load_all_apps
  visit(Quke::Quke.config.custom["urls"]["front_end"])
  expect(page).to have_text("Page not found")
end

When("an Environment Agency user tries to access the previous URLs") do
  # Assume user is signed out and check root URL takes user to new app sign in page
  visit(Quke::Quke.config.custom["urls"]["back_end_root"])
  expect(on_bo_sign_in_page?)

  # Check old agency sign in page redirects to new
  visit(Quke::Quke.config.custom["urls"]["back_end"])
  expect(on_bo_sign_in_page?)

  # Check old admin sign in page redirects to new
  visit(Quke::Quke.config.custom["urls"]["back_end_admin"])
  expect(on_bo_sign_in_page?)
end

Then("the Environment Agency user cannot access the old URLs") do
  visit(Quke::Quke.config.custom["urls"]["back_end_dashboard"])
  expect(page).to have_text("Page not found")

  visit(Quke::Quke.config.custom["urls"]["back_end_registrations"])
  expect(page).to have_text("Page not found")
end

Given("an external user tries to access the old app") do
  # Check old sign in URL
  visit(Quke::Quke.config.custom["urls"]["front_end_sign_in"])
  expect(page).to have_text("Sign in")
  url = URI.parse(current_url).to_s
  expect(url).to include("/fo/users/sign_in")

  visit("/") # this is the frontend root
  expect(on_fo_start_page?)
end

Then("the external user is redirected to the new app") do
  @journey.start_page.submit(choice: :new_registration)
  expect(@journey.location_page.heading).to have_text("Where is your principal place of business?")
  url = URI.parse(current_url).to_s
  expect(url).to include("/fo/")
end
