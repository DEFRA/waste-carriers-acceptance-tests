# frozen_string_literal: true

require "json"

class LastMessagePage < SitePrism::Page
  # Page which shows last message (email or letter) sent to any address from the environment.
  # As there are two app servers, there is a 50% chance that the latest email
  # will show each time the page is refreshed.
  # The page will be loaded up to 10 times until the email shows
  # (a 1 in 1024 chance of the email not showing).

  element(:message_content, "body")

  def check_message_for_text(expected_text)
    # Look for an email containing all the strings in the given array
    # and returns true if all the expected text is present.

    10.times do
      page_text = message_content.text

      # Assume message contains all expected text unless proven otherwise:
      message_contains_all_text = true

      expected_text.each do |element|
        unless page_text.include?(element)
          message_contains_all_text = false
          break
        end
      end

      return true if message_contains_all_text == true

      page.evaluate_script "window.location.reload()"
    end

    puts "Couldn't find message containing all text: " + expected_text.to_s
    false
  end

end
