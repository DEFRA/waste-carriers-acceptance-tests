class CarrierTypePage < SitePrism::Page

  # Do you carry the waste yourselves, or arrange for others to do it?

  element(:error_summary, ".govuk-error-summary__body")
  element(:carrier_dealer, "input[value='carrier_dealer']", visible: false)
  element(:broker_dealer, "input[value='broker_dealer']", visible: false)
  element(:carrier_broker_dealer, "input[value='carrier_broker_dealer']", visible: false)

  element(:submit_button, "[type='submit']")

  def submit(args = {})
    case args[:choice]&.to_sym
    when :carrier_dealer
      carrier_dealer.click
    when :broker_dealer
      broker_dealer.click
    when :carrier_broker_dealer
      carrier_broker_dealer.click
    end
    # If the carrier type is "existing" then skip these and just click submit:
    submit_button.click
  end

end
