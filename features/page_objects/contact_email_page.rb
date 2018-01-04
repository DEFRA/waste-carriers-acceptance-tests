class ContactEmailPage < SitePrism::Page

  
  element(:email, "#registration_contactEmail")
  element(:submit_button, "input[type='Submit']")

  def submit(args = {})
    email.set(args[:email]) if args.key?(:email)

    submit_button.click
  end

end
