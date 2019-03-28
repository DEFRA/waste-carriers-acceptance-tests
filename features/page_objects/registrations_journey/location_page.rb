# frozen_string_literal: true

class LocationPage < SitePrism::Page

  element(:england, "#registration_location_england")
  element(:wales, "#registration_location_wales")
  element(:scotland, "#registration_location_scotland")
  element(:northern_ireland, "#registration_location_northern_ireland")

  element(:submit_button, "#continue")

  def submit(args = {})
    # As long as the arg passed in matches the name of an element we can simply
    # invoke the element using ruby's send() method. In this way we can avoid
    # overly long case/switch statements that check the value of the arg to
    # determine which element to select
    send(args[:location]).select_option

    submit_button.click
  end

end
