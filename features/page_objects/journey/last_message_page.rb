# frozen_string_literal: true

require "json"

class LastMessagePage < BasePage
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

    puts "Couldn't find message containing all text: #{expected_text}"
    false
  end

  def get_renewal_url(reg_number)
    # This email is generated through Notify.
    if check_message_for_text([reg_number, "Renew waste carrier registration"]) == false
      puts("Couldn't find renewal email")
      return "Email not found"
    end

    parsed_data = JSON.parse(message_content.text)
    # Find the string that matches:
    # https://, then any 14-24 characters, then /fo/renew/, then any 24 characters
    parsed_data["last_notify_message"]["body"].match %r/https?:\/\/.{14,39}\/fo\/renew\/.{24}/
  end

  def get_certificate_url(reg_number)
    # This email is generated through Notify.
    if check_message_for_text([reg_number, "Download your certificate at"]) == false
      puts("Couldn't find regisration email")
      return "Email not found"
    end

    parsed_data = JSON.parse(message_content.text)
    # Find the string that matches:
    # https://, then any 14-46 characters, then /certificate?, then any 36 characters
    parsed_data["last_notify_message"]["body"].match %r/https?:\/\/.{14,46}\/certificate\?token=.{36}/
  end

  def get_unsubscription_url(reg_number)
    # This email is generated through Notify.
    if check_message_for_text([reg_number, "unsubscribe"]) == false
      puts("Couldn't find renewal email")
      return "Email not found"
    end

    parsed_data = JSON.parse(message_content.text)
    # Find the string that matches:
    # https://, then any 14-24 characters, then /fo/renew/, then any 24 characters
    parsed_data["last_notify_message"]["body"].match %r/http(s?):\/\/.{14,28}\/fo\/unsubscribe\/.{24}/
  end

end
