class RegistrationTypePage < SitePrism::Page

  # Do you carry the waste yourselves, or arrange for others to do it?
  element(:carrier_dealer, "input[value='carrier_dealer']", visible: false)
  element(:broker_dealer, "input[value='broker_dealer']", visible: false)
  element(:carrier_broker_dealer, "input[value='carrier_broker_dealer']", visible: false)

  element(:submit_button, "input[type='submit']")

  def submit(args = {})
    case args[:choice]
    when :carrier_dealer
      carrier_dealer.click
    when :broker_dealer
      broker_dealer.click
    when :carrier_broker_dealer
      carrier_broker_dealer.click
    end

    submit_button.click
  end

end
