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
