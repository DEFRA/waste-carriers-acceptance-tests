# frozen_string_literal: true

def message_exists?(expected_text)
  # registration is the full hash containing all registration details
  # expected_text is an array containing all the text you want to search for

  visit(Quke::Quke.config.custom["urls"]["last_email_fo"])

  5.times do
    return true if @journey.last_message_page.check_message_for_text(expected_text)

    puts "Message not found"
    sleep(1)
    false
  end
end

def send_registration_confirmation_email(reg_identifier)
  sign_in_to_back_office("agency-user")
  visit_registration_details_page(reg_identifier)
  @bo.registration_details_page.resend_confirmation_email_link.click
end
