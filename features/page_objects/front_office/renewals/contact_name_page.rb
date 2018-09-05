class ContactNamePage < SitePrism::Page

  # whats the name of the company?
  element(:contact_name, "#registration_companyName")
  element(:heading, :xpath, "//h1[contains(text(), 'Who should we contact')]")
  element(:submit_button, "input[type='submit']")

  def submit(args = {})
    contact_name.set(args[:contact_name]) if args.key?(:contact_name)

    submit_button.click
  end

end
