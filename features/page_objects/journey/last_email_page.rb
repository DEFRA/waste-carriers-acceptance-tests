# frozen_string_literal: true

require "json"

class LastEmailPage < SitePrism::Page
  # Page which shows last email sent to any address from the environment.
  # As there are two app servers, there is a 50% chance that the latest email
  # will show each time the page is refreshed.
  # The page will be loaded up to 10 times until the email shows
  # (a 1 in 1024 chance of the email not showing).

  element(:email_content, "pre")

  # Copy additional functions from WEX tests as needed:
  # https://github.com/DEFRA/waste-exemptions-acceptance-tests/blob/master/features/page_objects/email/last_email_api_page.rb

  def get_page_text(expected_string)
    # Checks that the page contains a string unique to what's expected
    # and returns the whole text of the page.

    10.times do
      page.evaluate_script "window.location.reload()"
      page_text = email_content.text
      next unless page_text.include?(expected_string)

      return page_text
    end
    puts "Couldn't find email containing string: " + expected_string
    "Email not found"
  end

end
