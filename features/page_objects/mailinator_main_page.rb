class MailinatorPage < SitePrism::Page

  # Mailinator email checker main page
  set_url(Quke::Quke.config.custom["urls"]["mail_checker"])

  iframe :email_details, MailinatorEmailDetailsPage, "#msg_body"

  element(:inbox, "#inboxfield")
  element(:search, "button[type='button']")

  element(:email, :xpath, "//div[contains(@class,'all_message-min_text all_message-min_text-3 firepath-matching-node')]")


 
  def submit(args = {})
    inbox.set(args[:inbox]) if args.key?(:inbox)
    search.click
  end



end
