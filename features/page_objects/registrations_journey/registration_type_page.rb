# frozen_string_literal: true

class RegistrationTypePage < SitePrism::Page

  element(:carrier_dealer, "#registration_registrationType_carrier_dealer")
  element(:broker_dealer, "#registration_registrationType_broker_dealer")
  element(:carrier_broker_dealer, "#registration_registrationType_carrier_broker_dealer")

  element(:submit_button, "#continue")

  def submit(args = {})
    # As long as the arg passed in matches the name of an element we can simply
    # invoke the element using ruby's send() method. In this way we can avoid
    # overly long case/switch statements that check the value of the arg to
    # determine which element to select
    send(args[:choice]).select_option

    submit_button.click
  end

end
