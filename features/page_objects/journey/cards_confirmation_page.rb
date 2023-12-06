class CardsConfirmationPage < BasePage

  # Confirmation of order

  element(:go_to_search_button, "a[class$='button'][href='/bo']")
  element(:details_for_reg_button, "a[href*='/registrations/CBDU']")

end
