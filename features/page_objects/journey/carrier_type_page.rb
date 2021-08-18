class CarrierTypePage < SitePrism::Page

  # Do you carry the waste yourselves, or arrange for others to do it?

  element(:error_summary, ".govuk-error-summary__body")
  element(:carrier_dealer, "#cbd-type-form-registration-type-carrier-dealer-field+ .govuk-radios__label")
  element(:broker_dealer, "#cbd-type-form-registration-type-broker-dealer-field+ .govuk-radios__label")
  element(:carrier_broker_dealer, "#cbd-type-form-registration-type-carrier-broker-dealer-field+ .govuk-radios__label")

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
