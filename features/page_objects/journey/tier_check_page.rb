class TierCheckPage < SitePrism::Page

  # What tier do you need?
  # Applies only to renewals

  element(:error_summary, ".error-summary")
  element(:heading, ".heading-large")

  element(:check_tier, "#tier_check_form_temp_tier_check_yes", visible: false)
  element(:skip_check, "#tier_check_form_temp_tier_check_no", visible: false)
  element(:submit_button, "input[type='submit']")

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
