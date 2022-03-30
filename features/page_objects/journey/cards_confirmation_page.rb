class CardsConfirmationPage < BasePage

  # Confirmation of order

  element(:confirmation_message, ".govuk-notification-banner__heading")
  element(:awaiting_payment_message, ".govuk-notification-banner__heading")
  element(:info_table, "table")

  element(:go_to_search_button, "a[class$='button'][href='/bo']")
  element(:details_for_reg_button, "a[href*='/registrations/CBDU']")

end
