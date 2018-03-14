class LocationPage < SitePrism::Page

  # What type of business or organisation are you?
  elements(:location, "input[name='location_form[location]']", visible: false)

  element(:submit_button, "input[type='submit']", visible: false)

  def submit(args = {})
    wait_for_location
    location.find { |btn| btn.value == args[:location] }.click if args.key?(:location)

    submit_button.click
  end

end
