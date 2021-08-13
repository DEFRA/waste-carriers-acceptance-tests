class TierCheckPage < SitePrism::Page

  # What tier do you need?
  # Applies only to renewals

  element(:error_summary, ".govuk-error-summary__body")
  element(:heading, "h1")

  element(:check_tier, "#tier-check-form-temp-tier-check-yes-field", visible: false)
  element(:skip_check, "#tier-check-form-temp-tier-check-no-field", visible: false)
  element(:submit_button, "[type='submit']")

  def submit(args = {})
    case args[:choice]
    when :check_tier
      check_tier.click
    when :skip_check
      skip_check.click
    end
    submit_button.click
  end

end
