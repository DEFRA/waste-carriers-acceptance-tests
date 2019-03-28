# frozen_string_literal: true

Then("I am a charity") do
  @world.current_reg = generate_registration(:charity)
end

Then("I register") do
  @world.last_reference = add_submitted_registration(@world.current_reg)
  @world.last_email = @world.current_reg[:contact][:email]
  expect(page).to have_content(@world.last_email) if @world.current_reg[:business_type] == :charity
end

Then("I will be informed the registration is complete") do
  expect(page).to have_content("Registration complete")
  expect(page).to have_content(@world.last_reference)
end
