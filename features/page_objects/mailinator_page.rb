class MailinatorPage < SitePrism::Page

  # Mailinator email checker main page
  set_url(Quke::Quke.config.custom["urls"]["mail_checker"])

  element(:inbox, "#inboxfield")
  element(:search, "button[type='button']")

  def submit(args = {})
    inbox.set(args[:inbox]) if args.key?(:inbox)
    search.click
  end

end
