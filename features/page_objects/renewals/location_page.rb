class LocationPage < SitePrism::Page

  # What type of business or organisation are you?
  elements(:location, "input[name='location_form[location]']", visible: false)

  element(:submit_button, "input[type='submit']", visible: false)

  def submit(args = {})
    location.find { |btn| btn.value == args[:location] }.click if args.key?(:location)
    wait_for_submit_button

    submit_button.click
  end

end
