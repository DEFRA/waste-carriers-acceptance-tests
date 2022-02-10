require_relative "base_page"

class AdPrivacyPolicyPage < BasePage

  element(:submit_button, "a[class='govuk-button']")

  def submit(_args = {})
    submit_button.click
  end

end
