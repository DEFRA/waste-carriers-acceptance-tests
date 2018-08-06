class CarrierTypePage < SitePrism::Page

  # Do you carry the waste yourselves, or arrange for others to do it?
  element(:carrier_dealer, "#cards_form_temp_cards", visible: false)
  element(:submit_button, "input[type='submit']")

  def submit(args = {})
    wait_for_carrier_dealer
    find("label", text: (args[:answer])).click if args.key?(:answer)
    submit_button.click
  end

end
