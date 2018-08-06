class WorldpayCardChoicePage < SitePrism::Page

  # Secure Payment Page
  element(:mastercard, "input[alt='Mastercard']")
  element(:visa, "input[alt='Visa']")
  element(:maestro, "input[alt='Maestro']")

  element(:cancel, :xpath, "//b[contains(.,'Cancel')]")

  def submit(_args = {})
    maestro.click
  end

end
