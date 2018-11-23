# rubocop:disable Metrics/LineLength
Then(/^I will receive a confirmation email of my renewal$/) do
  if (Quke::Quke.config.custom["urls"]["front_office"]).include? "local"
    @renewals_app.mailcatcher_main_page.open_email(1)
    expect(@renewals_app.mailcatcher_messages_page).to have_text("Your registration as an upper tier waste carrier, broker and dealer has been renewed")
  else
    gmail = Gmail.new(ENV["EMAIL_USERNAME"], ENV["EMAIL_PASSWORD"])
    try(20) { @email = gmail.inbox.emails(:unread, from: "registrations@wastecarriersregistration.service.gov.uk").last }
    message_body = @email.message.body.raw_source
    # Uses nokogiri gem to parse html for link to confirm email
    doc = Nokogiri::HTML(message_body)
    url = doc.at_css("a[id='confirmation_link']").text
    # Cleans up email for later tests
    @email.read!
    @front_app = FrontOfficeApp.new
    visit(url)
  end
end
# rubocop:enable Metrics/LineLength
