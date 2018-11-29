class MailcatcherMessagesPage < SitePrism::Page

  element(:confirmation_link, "#confirmation_link")
  element(:trash, "button[title='Delete Emails']")
end
