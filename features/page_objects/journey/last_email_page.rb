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

  def check_email_for_text(expected_text)
    # Look for an email containing all the strings in the given array
    # and returns the whole text of the page.

    10.times do
      page_text = email_content.text

      # Assume email contains all expected text unless proven otherwise:
      email_contains_all_text = true

      expected_text.each do |element|
        unless page_text.include?(element)
          email_contains_all_text = false
          break
        end
      end

      return "Success" if email_contains_all_text == true

      page.evaluate_script "window.location.reload()"
    end

    puts "Couldn't find email containing string: " + expected_string
    "Email not found"
  end

end
