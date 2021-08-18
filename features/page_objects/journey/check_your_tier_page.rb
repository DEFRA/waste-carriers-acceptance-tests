class CheckYourTierPage < SitePrism::Page

  # What type of tier are you?
  # Applies only to registrations

  element(:error_summary, ".govuk-error-summary__body")
  elements(:check_your_tier_options, "input[type='radio']", visible: false)
  element(:not_sure, "[value='unknown']+ .govuk-radios__label")
  element(:upper_tier, "[value='upper']+ .govuk-radios__label")
  element(:lower_tier, "[value='lower']+ .govuk-radios__label")
  element(:submit_button, "[type='submit']")

  def submit(args = {})
    case args[:option]
    when :lower
      lower_tier.click
    when :upper
      upper_tier.click
    when :unknown
      not_sure.click
    end
    submit_button.click
  end
end
