class ContactEmailPage < SitePrism::Page

  element(:email, "#registration_contactEmail")
  element(:heading, :xpath, "//h1[contains(text(), 'email address')]")
  element(:submit_button, "input[type='submit']")

  def submit(args = {})
    wait_for_heading
    email.set(args[:email]) if args.key?(:email)

    submit_button.click
  end

end
