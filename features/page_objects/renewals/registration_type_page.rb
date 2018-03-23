class RegistrationTypePage < SitePrism::Page

  # Do you carry the waste yourselves, or arrange for others to do it?
  element(:carrier_dealer, "input[value='carrier_dealer']", visible: false)
  element(:broker_dealer, "input[value='broker_dealer']", visible: false)
  element(:carrier_broker_dealer, "input[value='carrier_broker_dealer']", visible: false)
  element(:heading, :xpath, "//h1[contains(text(), 'Do you carry the waste yourselves, or arrange for others to do it?')]")
  element(:submit_button, "input[type='submit']")

  def submit(args = {})
    wait_until_heading_visible(5)
    find("label", text: (args[:answer])).click if args.key?(:answer)
    submit_button.click
  end

end
