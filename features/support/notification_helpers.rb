# frozen_string_literal: true

def message_exists?(expected_text)
  # registration is the full hash containing all registration details
  # expected_text is an array containing all the text you want to search for

  visit(Quke::Quke.config.custom["urls"]["notify_link"])

  return true if @journey.last_message_page.check_message_for_text(expected_text)

  puts "Message not found"
  false
end
