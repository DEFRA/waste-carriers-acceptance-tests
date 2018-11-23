class MailcatcherMainPage < SitePrism::Page

  set_url(Quke::Quke.config.custom["urls"]["mail_client"])

  element(:clear_all_messages, "a[title='Clear all messages']")

  def open_email(email_number)
    visit((Quke::Quke.config.custom["urls"]["mail_client"]) + "/messages/#{email_number}.html")
  end
end
