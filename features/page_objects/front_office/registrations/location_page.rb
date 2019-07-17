class LocationPage < SitePrism::Page

  # Where is your principal place of business?
  element(:heading, "#groupLabel")
  elements(:location, "input[name='location_form[location]']", visible: false)
  element(:england, "#location_form_location_england", visible: false)
  element(:wales, "#location_form_location_wales", visible: false)
  element(:scotland, "#location_form_location_scotland", visible: false)
  element(:northern_ireland, "#location_form_location_northern_ireland", visible: false)
  element(:overseas, "#location_form_location_overseas", visible: false)
  element(:heading, :xpath, "//h1[contains(text(), 'Where is your principal place of business')]")
  element(:submit_button, "input[type='submit']")

  def submit(args = {})
    case args[:choice]
    when :england
      england.click
    when :wales
      wales.click
    when :scotland
      scotland.click
    when :northern_ireland
      northern_ireland.click
    when :overseas
      overseas.click
    end
    submit_button.click
  end

end
