When("the registration is revoked") do
  @bo.dashboard_page.view_reg_details(search_term: @reg_number)
  @bo.registration_details_page.cease_or_revoke_link.click
  @bo.cease_or_revoke_page.submit(
    choice: :revoke,
    reason: "Did a naughty thing"
  )
  expect(@bo.cease_or_revoke_page.heading).to have_text("Confirm revoke for registration #{@reg_number}")
  @bo.cease_or_revoke_page.submit
  expect(@bo.dashboard_page.flash_message).to have_text("#{@reg_number} has been revoked")
end

When("the registration is ceased") do
  @bo.dashboard_page.view_reg_details(search_term: @reg_number)
  @bo.registration_details_page.cease_or_revoke_link.click
  @bo.cease_or_revoke_page.submit(
    choice: :cease,
    reason: "Carrier has stopped carrying waste"
  )
  expect(@bo.cease_or_revoke_page.heading).to have_text("Confirm cease for registration #{@reg_number}")
  @bo.cease_or_revoke_page.submit
  expect(@bo.dashboard_page.flash_message).to have_text("#{@reg_number} has been ceased")
end

Given("I have a revoked expired registration") do
  load_all_apps
  @tier = :upper
  new_expiry_date = (DateTime.now - 7).to_s

  seed_data = SeedData.new("limitedCompany_revoked_expired_registration.json", "expires_on" => new_expiry_date)
  @reg_number = seed_data.reg_number
  @seeded_data = seed_data.seeded_data
  @email_address = @seeded_data["contactEmail"]

  puts "limitedCompany upper tier revoked expired registration #{@reg_number} seeded"
end

Given("I have a revoked upper tier registration") do
  load_all_apps
  @tier = :upper

  seed_data = SeedData.new("limitedCompany_revoked_registration.json")
  @reg_number = seed_data.reg_number
  @seeded_data = seed_data.seeded_data
  @email_address = @seeded_data["contactEmail"]

  puts "limitedCompany upper tier revoked expired registration #{@reg_number} seeded"
end

Given("I have a ceased lower tier registration") do
  load_all_apps
  @tier = :lower

  seed_data = SeedData.new("lower_tier_ceased_registration.json")
  @reg_number = seed_data.reg_number
  @seeded_data = seed_data.seeded_data
  @email_address = @seeded_data["contactEmail"]

  puts "lower tier ceased registration #{@reg_number} seeded"
end

When("I should not be able to restore the registration") do
  @bo.dashboard_page.view_reg_details(search_term: @reg_number)
  expect(@bo.registration_details_page).to have_no_restore_link
end

When("the registration is restored") do
  @bo.dashboard_page.view_reg_details(search_term: @reg_number)
  @bo.registration_details_page.restore_link.click
  @bo.restore_page.submit(
    reason: "Deregistered in error"
  )
end
