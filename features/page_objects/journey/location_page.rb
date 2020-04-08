class LocationPage < SitePrism::Page

  # Where is your principal place of business?
  element(:heading, "#groupLabel")
  elements(:location, "input[name='location_form[location]']", visible: false)
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
