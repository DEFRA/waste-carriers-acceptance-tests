# frozen_string_literal: true

class LastEmailPage < SitePrism::Page

  element(:email_content, "pre")

  def confirmation_url(email)
    return unless email_cached?(email) # return nil if email not cached

    # Find the text in the JSON between the following two strings:
    # confirmation_token=
    # \">
    # See https://stackoverflow.com/a/4219038
    token = email_content.text[/confirmation_token=(.*?)\\">/, 1]
    query_string = "/users/confirmation?confirmation_token=#{token}"

    File.join(Quke::Quke.config.custom["urls"]["frontend"], query_string)
  end

  private

  # Page which shows last email sent to any address from the environment.
  # As there are two app servers, there is a 50% chance that the latest email
  # will show each time the page is refreshed.
  # The page will be loaded up to 10 times until the email shows
  # (a 1 in 1024 chance of the email not showing).
  def email_cached?(email)
    counter = 0
    loop do
      break if email_content.text.include?(email) || counter > 9

      page.evaluate_script "window.location.reload()"
      sleep(1)
      counter += 1
    end
    return true if counter < 10

    false
  end

end
