Given(/^I start a new registration$/) do
  @app = FrontOfficeApp.new
  @app.start_page.load
  @app.start_page.submit
end

When(/^I pay for my appliction by maestro ordering (\d+) copy cards$/) do |copy_card_number|
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

Then(/^I will be registered as an upper tier waste carrier$/) do
  expect(@app.registration_confirmed_page.registration_number).to have_text("CBDU")
  expect(@app.registration_confirmed_page).to have_text @email
  # Stores registration number for later use
  @uppertier_registration_number = @app.registration_confirmed_page.registration_number.text
end
