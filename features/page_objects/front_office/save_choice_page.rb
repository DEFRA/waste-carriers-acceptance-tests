class SaveChoicePage < SitePrism::Page

  # Get a link to save your application
  element(:email, "#user_email")
  element(:no_email, ".summary")
  element(:mobile_number, "#user_phone")

  element(:submit_button, "input[type='Submit']")

  def submit(args = {})
    email.set(args[:email]) if args.key?(:email)

    submit_button.click
  end

end
