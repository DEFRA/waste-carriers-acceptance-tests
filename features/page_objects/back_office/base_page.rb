# frozen_string_literal: true

class BasePage < SitePrism::Page

  element(:back_link, ".govuk-back-link")
  element(:heading, "h1")
  element(:content, "#main-content")
  element(:submit_button, "[type='submit']")
  element(:flash_message, ".govuk-notification-banner__heading")
  element(:error_summary, ".govuk-error-summary__body")

  def submit(_args = {})
    submit_button.click
  end

  def accept_cookies
    return unless has_accept_analytics_cookies?

    accept_analytics_cookies.click
    hide_cookie_banner.click
  end

end
