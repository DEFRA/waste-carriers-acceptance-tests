# frozen_string_literal: true

class WorldpayCardChoicePage < SitePrism::Page

  # Secure Payment Page
  element(:mastercard, "input[alt='Mastercard']")
  element(:visa, "input[alt='Visa']")
  element(:maestro, "input[alt='Maestro']")

  element(:cancel, :xpath, "//b[contains(.,'Cancel')]")

  def submit(args = {})
    # As long as the arg passed in matches the name of an element we can simply
    # invoke the element using ruby's send() method. In this way we can avoid
    # overly long case/switch statements that check the value of the arg to
    # determine which element to select
    send(args[:choice]).select_option
  end

end
