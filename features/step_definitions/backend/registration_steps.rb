# frozen_string_literal: true

Then("I complete a charity registration") do
  @world.backend.dashboard_page.new_registration.click

  @world.current_reg = generate_registration(:charity)

  # Stores the exemption number so the exemption can be edited in later steps
  @world.last_reference = add_submitted_registration(@world.current_reg, false)
end
