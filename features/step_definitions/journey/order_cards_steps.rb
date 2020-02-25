When(/^an agency user orders "([^"]*)" registration (?:card|cards) for "([^"]*)"$/) do |cards, reg|
  @registration_number = reg
  @number_of_cards = cards.to_i

  @bo.dashboard_page.view_reg_details(search_term: reg)
  @bo.registration_details_page.order_cards_link.click
  expect(@journey.cards_order_page.heading).to have_text("Order registration cards for " + reg)

  # Look for the correct contact address for the seeded data:
  expect(@journey.cards_order_page.contact_address).to have_text("Richard Fairclough House")

  # Error validation check:
  @journey.cards_order_page.submit(number_of_cards: "0")
  expect(@journey.cards_order_page.error_summary).to have_text("enter a number between 1 and 999")

  @journey.cards_order_page.submit(number_of_cards: cards)

  if @number_of_cards == 1
    expect(@journey.cards_payment_page.cost_table).to have_text("1 registration card total cost")
  else
    expect(@journey.cards_payment_page.cost_table).to have_text(cards + " registration cards total cost")
  end
  expect(@journey.cards_payment_page.cost_table).to have_text("£" + (@number_of_cards * 5).to_s)
end

When(/^the agency user pays for the (?:card|cards) by bank card$/) do

  # Error validation check:
  @journey.cards_payment_page.submit
  expect(@journey.cards_payment_page.error_summary).to have_text("Select card or alternative payment")

  @journey.cards_payment_page.submit(choice: :bank_card)
  submit_valid_card_payment
end

When(/^the agency user chooses to pay for the (?:card|cards) by bank transfer$/) do
  # This feature will fail if the registration's balance is not 0 at the start of the test.
  # Reset database if needed.
  @journey.cards_payment_page.submit(choice: :alternative_payment)

  expect(@journey.standard_page.heading).to have_text("Details for bank transfer")
  expect(@journey.standard_page.content).to have_text("£" + (@number_of_cards * 5).to_s)
  expect(@journey.standard_page.content).to have_text("Cards will be sent out after the payment has cleared.")
  @journey.standard_page.button.click
end

Then(/^the card order is confirmed with cleared payment$/) do
  expect(@journey.cards_confirmation_page.confirmation_message).to have_text("Order completed.\nPayment has cleared.")
  expect(@journey.cards_confirmation_page.info_table).to have_text("£ " + (@number_of_cards * 5).to_s)
  expect(@journey.cards_confirmation_page.info_table).to have_text(@registration_number)

  @journey.cards_confirmation_page.go_to_search_button.click
  expect(@bo.dashboard_page.heading).to have_text("Waste carriers registrations")
end

Then(/^the card order is confirmed awaiting payment$/) do
  expect(@journey.cards_confirmation_page.awaiting_payment_message).to have_text("Order is awaiting payment.")

  @journey.cards_confirmation_page.details_for_reg_button.click
  expect(@bo.registration_details_page.heading).to have_text("Registration " + @registration_number)
  expect(@bo.registration_details_page.content).to have_text("Payment required")
end

Then(/^the carrier receives an email saying their card order is being printed$/) do
  text_to_check = [
    "We’re printing your waste carriers registration card",
    @registration_number,
    "Order: " + @number_of_cards.to_s + " registration card",
    "Paid: £" + (@number_of_cards.to_i * 5).to_s + " by debit or credit card"
  ]

  # Check there is an email containing all strings in text_to_check:
  visit(Quke::Quke.config.custom["urls"]["last_email_bo"])
  expect(@journey.last_email_page.check_email_for_text(text_to_check)).to be true
end

Then(/^the carrier receives an email saying they need to pay for their card order$/) do
  text_to_check = [
    "You need to pay for your waste carriers registration card",
    @registration_number,
    "We cannot print the cards until we receive confirmation that you have paid",
    "You ordered " + @number_of_cards.to_s + " registration card"
  ]

  # Check there is an email containing all strings in text_to_check:
  visit(Quke::Quke.config.custom["urls"]["last_email_bo"])
  expect(@journey.last_email_page.check_email_for_text(text_to_check)).to be true
end
