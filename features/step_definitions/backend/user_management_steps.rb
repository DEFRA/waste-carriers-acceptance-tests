# frozen_string_literal: true

Then("I create a new backend user") do
  @world.last_email = generate_example_email(nil, nil)
  create_backend_user(@world.last_email, nil, false)

  expect(@world.backend.users_page).to have_text("Agency user was successfully created.")

  @world.backend.users_page.sign_out.click
end

Then("I create a new finance backend user") do
  @world.last_email = generate_example_email(nil, nil)
  create_backend_user(@world.last_email, :finance_basic, :false)

  expect(@world.backend.users_page).to have_text("Agency user was successfully created.")

  @world.backend.users_page.sign_out.click
end

Then("the new/edited backend user can sign in") do
  login_backend_user(@world.last_email)

  expect(@world.backend.dashboard_page).to have_text("Signed in successfully.")
end

Then("I edit a backend user") do
  edit_backend_user(nil, false)

  expect(@world.backend.users_page).to have_text("Agency user was successfully updated.")

  @world.backend.users_page.sign_out.click
end

Then("I delete a backend user") do
  delete_backend_user(nil, false)

  expect(@world.backend.users_page).to have_text("Agency user was successfully deleted.")

  @world.backend.users_page.sign_out.click
end

Then("the backend user cannot sign in") do
  login_backend_user(@world.last_email)

  expect(page).to have_text("Invalid email or password.")
end
