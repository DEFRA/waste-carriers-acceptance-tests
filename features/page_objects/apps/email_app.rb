# frozen_string_literal: true

# https://github.com/natritmeyer/site_prism#epilogue
class EmailApp
  # Using an attr_reader automatically gives us a my_app.last_page method
  attr_reader :last_page

  def mailcatcher_main_page
    @last_page = MailcatcherMainPage.new
  end

  def mailcatcher_messages_page
    @last_page = MailcatcherMessagesPage.new
  end

  def mailinator_inbox_page
    @last_page = MailinatorInboxPage.new
  end

  def mailinator_page
    @last_page = MailinatorPage.new
  end

  def mailinator_email_details_page
    @last_page = MailinatorEmailDetailsPage.new
  end

  def local?
    (Quke::Quke.config.custom["urls"]["mail_client"]).include? "local"
  end

end
