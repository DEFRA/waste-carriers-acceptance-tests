class RegistrationCardsPage < BasePage

  # Certificate and registration cards

  element(:error_summary, ".govuk-error-summary__body")

  element(:cards, "input[id^='cards-form-temp-cards-field']", visible: false)
  element(:submit_button, "[type='submit']")

  def submit(args = {})
    cards.set(args[:cards]) if args.key?(:cards)
    submit_button.click
  end

end
