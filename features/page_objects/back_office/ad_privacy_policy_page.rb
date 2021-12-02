require_relative "base_page"

class AdPrivacyPolicyPage < BasePage

  element(:heading, "h1")
  element(:content, ".column-two-thirds")

  element(:policy_text_link, "span", text: "Waste carriers, brokers and dealers privacy policy text")
  element(:dpo_details_link, "span", text: "Contact details for the Data Protection Officer")
  element(:ico_details_link, "span", text: "Contact details for the Information Commissioner's Office")

  element(:submit_button, "a[class='govuk-button']")

  def submit(_args = {})
    policy_text_link.click
    dpo_details_link.click
    ico_details_link.click
    submit_button.click
  end

end
