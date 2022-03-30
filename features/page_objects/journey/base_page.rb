# frozen_string_literal: true

class BasePage < SitePrism::Page

  element(:back_link, ".govuk-back-link")
  element(:heading, "h1")
  element(:content, "#main-content")
  element(:error, ".govuk-error-summary")
  element(:error_summary, ".govuk-error-summary__body")
  element(:submit_button, "[type='submit']")
  element(:accept_analytics_cookies, "input[value='Accept analytics cookies']")
  element(:reject_analytics_cookies, "input[value='Reject analytics cookies']")
  element(:hide_cookie_banner, "input[value='Hide this message']")
  element(:button, ".govuk-button")

  def submit(_args = {})
    submit_button.click
  end

  def accept_cookies
    return unless has_accept_analytics_cookies?

    accept_analytics_cookies.click
    hide_cookie_banner.click
  end

end
