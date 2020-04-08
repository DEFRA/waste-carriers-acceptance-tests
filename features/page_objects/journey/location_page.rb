class LocationPage < SitePrism::Page

  # This page object is currently shared between old and new apps, as the elements are similar.
  # Update once the old registration journey is no longer live.

  # Where is your principal place of business?
  elements(:location, "input[name='location_form[location]']", visible: false)
  # The following applies to old (grey background) radio buttons. Delete when we remove old app:
  element(:england_old, "#registration_location_england", visible: false)
  # New app elements:
  element(:england, "input[value='england']", visible: false)
  element(:wales, "input[value='wales']", visible: false)
  element(:scotland, "input[value='scotland']", visible: false)
  element(:northern_ireland, "input[value='northern_ireland']", visible: false)
  element(:overseas, "input[value='overseas']", visible: false)
  element(:heading, :xpath, "//h1[contains(text(), 'Where is your principal place of business')]")
  element(:submit_button, "input[type='submit']")

  def submit(args = {})
    case args[:choice].to_s.snakecase
    when "england"
      england.click
    when "wales"
      wales.click
    when "scotland"
      scotland.click
    when "northern_ireland"
      northern_ireland.click
    when "overseas"
      overseas.click
    end

    submit_button.click
  end
end
