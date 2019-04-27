Then("I create a new backend user") do
  @world.last_email = generate_example_email(nil, nil)
  create_backend_user(@world.last_email, false)

  expect(@world.backend.users_page).to have_text("Agency user was successfully created.")

  @world.backend.users_page.sign_out.click
end

Then("the new backend user can sign in") do
  login_backend_user(@world.last_email)

  expect(@world.backend.dashboard_page).to have_text("Signed in successfully.")
end
