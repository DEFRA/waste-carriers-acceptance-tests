Given(/^I start a new registration$/) do
  @app = FrontOfficeApp.new
  @app.start_page.load
  @app.start_page.submit
end

When(/^I pay for my appliction by maestro ordering (\d+) copy (?:card|cards)$/) do |copy_card_number|
  @app.order_page.submit(
    copy_card_number: copy_card_number,
    choice: :card_payment
  )
  @app.worldpay_card_choice_page.maestro.click

  # finds today's date and adds another year to expiry date
  time = Time.new

  @year = time.year + 1

  @app.worldpay_card_details_page.submit(
    card_number: "6759649826438453",
    security_code: "555",
    cardholder_name: "3d.authorised",
    expiry_month: "12",
    expiry_year: @year
  )
  @app.worldpay_card_details_page.submit_button.click
end

Then(/^I will be asked to confirm my email address$/) do
  expect(@app.confirm_account_page.has_content?("Confirm your email address")).to be(true)
end

Then(/^I will be registered as an upper tier waste carrier$/) do
  expect(@app.registration_confirmed_page.registration_number).to have_text("CBDU")
  expect(@app.registration_confirmed_page).to have_text @email
  # Stores registration number for later use
  @registration_number = @app.registration_confirmed_page.registration_number.text
end

Then(/^I will be registered as a lower tier waste carrier$/) do
  within_window @new_window do
    expect(@app.registration_confirmed_page.registration_number).to have_text("CBDL")
    expect(@app.registration_confirmed_page).to have_text @email
    # Stores registration number for later use
    @registration_number = @app.registration_confirmed_page.registration_number.text
  end
end

When(/^I select that I don't know what business type to enter$/) do
  @app.business_type_page.submit(org_type: "other")
end

Then(/^I will be informed to contact the Environment Agency$/) do
  expect(@app.no_registration_page).to have_text "Contact the Environment Agency"
end

When(/^I choose to pay for my application by bank transfer ordering (\d+) copy (?:card|cards)$/) do |copy_card_number|
  @app.order_page.submit(
    copy_card_number: copy_card_number,
    choice: :bank_transfer_payment
  )
  @app.offline_payment_page.submit
end

Then(/^I will be informed my registration is pending payment$/) do
  expect(@app.registration_confirmed_page).to have_text "Application received"
  expect(@app.registration_confirmed_page).to have_text @email
  # Stores registration number for later use
  @registration_number = @app.registration_confirmed_page.registration_number.text
end

When(/^I confirm my email address$/) do
  @app.mailinator_page.load
  @app.mailinator_page.submit(inbox: @email)
  @app.mailinator_inbox_page.confirmation_email.click
  @app.mailinator_inbox_page.email_details do |frame|
    @new_window = window_opened_by { frame.confirm_email.click }
  end
end
# rubocop:disable Lint/UnusedBlockArgument
Then(/^a registration confirmation email is received$/) do
  # resets session cookies to fix back office authentication issue
  Capybara.reset_session!
  @app.mailinator_page.load
  @app.mailinator_page.submit(inbox: @email)
  @app.mailinator_inbox_page.registration_complete_email.click
  @app.mailinator_inbox_page.email_details do |frame|
    expect(@app.registration_confirmed_page).to have_text @registration_number
  end

end

Then(/^I will receive an application pending payment email$/) do
  @app.mailinator_page.load
  @app.mailinator_page.submit(inbox: @email)
  expect(@app.mailinator_inbox_page).to have_registration_pending_payment_email
end

# rubocop:enable Lint/UnusedBlockArgument

Given(/^I do not confirm my email address$/) do
  # Nothing to do to replicate step
end

Then(/^my registration status will be pending$/) do
  @back_app = BackOfficeApp.new
  @back_app.login_page.load
  @back_app.login_page.submit(
    email: Quke::Quke.config.custom["accounts"]["agency_user"]["username"],
    password: Quke::Quke.config.custom["accounts"]["agency_user"]["password"]
  )
  @back_app.registrations_page.search(search_input: @company_name)
  expect(@back_app.registrations_page.search_results[0].status.text).to eq("Pending")
end
