class TierOtherBusinessesPage < SitePrism::Page

  # Do you ever deal with waste from other businesses or households?
  element(:error_summary, ".govuk-error-summary__body")
  element(:heading, ".govuk-fieldset__legend--l")

  element(:yes_other_businesses, "[value='yes']+ .govuk-radios__label")
  element(:no_other_businesses, "[value='no']+ .govuk-radios__label")

  element(:submit_button, "[type='submit']")

  def submit(args = {})
    case args[:choice]
    when :no
      no_other_businesses.click
    when :yes
      yes_other_businesses.click
    end
    submit_button.click
  end

end
