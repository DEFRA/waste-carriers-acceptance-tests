When(/^an agency user orders "([^"]*)" registration (?:card|cards)$/) do |cards|
  @number_of_cards = cards.to_i

  @bo.dashboard_page.view_reg_details(search_term: @reg_number)
  @bo.registration_details_page.order_cards_link.click
  expect(@journey.cards_order_page.heading).to have_text("Order registration cards for #{@reg_number}")

  @journey.cards_order_page.submit(number_of_cards: cards)

  if @number_of_cards == 1
    expect(@journey.cards_payment_page.cost_table).to have_text("1 registration card total cost")
  else
    expect(@journey.cards_payment_page.cost_table).to have_text("#{cards} registration cards total cost")
  end
  expect(@journey.cards_payment_page.cost_table).to have_text("£#{@number_of_cards * 5}")
end

When(/^the agency user pays for the (?:card|cards) by bank card$/) do

  # Error validation check:
  @journey.cards_payment_page.submit
  expect(@journey.cards_payment_page).to have_text("Payment summary")

  @journey.cards_payment_page.submit(choice: :bank_card)
  submit_card_payment
end

Then(/^the card order is confirmed with cleared payment$/) do
  expect(@journey.cards_confirmation_page.confirmation_message).to have_text("Order completed.\nPayment has cleared.")
  expect(@journey.cards_confirmation_page).to have_text("£ #{@number_of_cards * 5}")
  expect(@journey.cards_confirmation_page).to have_text(@reg_number)

  @journey.cards_confirmation_page.go_to_search_button.click
  expect(@bo.dashboard_page.heading).to have_text("Waste carriers registrations")
end

Then(/^the card order is confirmed awaiting payment$/) do
  expect(@journey.cards_confirmation_page.awaiting_payment_message).to have_text("Order is awaiting payment.")

  @journey.cards_confirmation_page.details_for_reg_button.click
  expect(@bo.registration_details_page.heading).to have_text("Registration #{@reg_number}")
  expect(@bo.registration_details_page).to have_text("Payment required")
end

Then("the carrier receives an email saying their card order is being printed") do
  expected_text = [
    "We’re printing your waste carriers registration card",
    @reg_number,
    "Order: #{@number_of_cards}  registration card",
    "Paid: £#{@number_of_cards.to_i * 5} by debit or credit card"
  ]

  expect(message_exists?(expected_text)).to be true
end

Then("the carrier receives an email saying they need to pay for their card order") do
  expected_text = [
    "You need to pay for your waste carriers registration card",
    @reg_number,
    "We cannot print the cards until we receive confirmation that you have paid",
    "You ordered #{@number_of_cards} registration card"
  ]

  expect(message_exists?(expected_text)).to be true
end
