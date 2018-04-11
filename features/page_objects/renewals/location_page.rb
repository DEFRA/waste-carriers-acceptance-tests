class LocationPage < SitePrism::Page

  # Where is your principal place of business?
  elements(:location, "input[name='location_form[location]']", visible: false)
  element(:heading, :xpath, "//h1[contains(text(), 'Where is your principal place of business')]")
  element(:submit_button, "input[type='submit']", visible: false)

  # It's possible to mark an element visible: false for all browsers but Safari
  # So instead of clicking on radio button that has opacity set to zero
  # it looks for clickable text and clicks on that instead

  def submit(args = {})
    wait_for_heading

    find("label", text: (args[:location])).click if args.key?(:location)

    submit_button.click
  end

end
