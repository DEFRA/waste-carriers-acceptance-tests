class RegistrationCardsPage < SitePrism::Page

  # Certificate and registration cards

  element(:error_summary, ".error-summary")

  element(:cards, "#cards_form_temp_cards", visible: false)
  element(:submit_button, "input[type='submit']")

  def submit(args = {})
    cards.set(args[:cards]) if args.key?(:cards)
    submit_button.click
  end

end
