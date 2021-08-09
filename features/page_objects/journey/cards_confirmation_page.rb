class CardsConfirmationPage < SitePrism::Page

  # Confirmation of order

  element(:error_summary, ".govuk-error-summary__body")
  element(:heading, "h1")

  element(:confirmation_message, ".flash-success")
  element(:awaiting_payment_message, ".flash-message")
  element(:info_table, "table")

  element(:go_to_search_button, "a[type='submit'][href$='/bo']")
  element(:details_for_reg_button, "a[type='submit'][href*='/registrations/CBDU']")

end
