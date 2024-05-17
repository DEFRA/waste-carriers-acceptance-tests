class LocationPage < BasePage

  # This page object is currently shared between old and new apps, as the elements are similar.
  # Update once the old registration journey is no longer live.

  # Where is your principal place of business?

  element(:heading, "h1")
  element(:england, "[value='england']+ .govuk-radios__label")
  element(:wales, "[value='wales']+ .govuk-radios__label")
  element(:scotland, "[value='scotland']+ .govuk-radios__label")
  element(:northern_ireland, "[value='northern_ireland']+ .govuk-radios__label")
  element(:overseas, "[value='overseas']+ .govuk-radios__label")
  element(:submit_button, "[type='submit']")

  def submit(args = {})
    case args[:choice].to_s
    when "England"
      england.click
    when "Wales"
      wales.click
    when "Scotland"
      scotland.click
    when "Northern Ireland"
      northern_ireland.click
    when "overseas"
      overseas.click
    end

    submit_button.click
  end
end
