class CardsConfirmationPage < SitePrism::Page

  # Confirmation of order

  element(:error_summary, ".error-summary")
  element(:heading, ".heading-large")

  element(:confirmation_message, ".flash-success")
  element(:awaiting_payment_message, ".flash-message")
  element(:info_table, "table")

  element(:go_to_search_button, "a.button[href$='/bo']")
  element(:details_for_reg_button, "a.button[href*='/registrations/CBDU']")

end
