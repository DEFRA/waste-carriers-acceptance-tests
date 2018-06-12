class WorldpayCardChoicePage < SitePrism::Page

  # Secure Payment Page
  element(:mastercard, "input[alt='Mastercard']")
  element(:visa, "input[alt='Visa']")
  element(:maestro, "input[alt='Maestro']")

  element(:cancel, :xpath, "//b[contains(.,'Cancel')]")

  element(:submit_button, "input[type='submit']")

  def submit(_args = {})
    maestro.click
    submit_button.click
  end

end
