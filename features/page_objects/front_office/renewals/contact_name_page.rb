class ContactNamePage < SitePrism::Page

  # whats the name of the company?
  element(:contact_name, "#registration_companyName")

  # The next two page objects are only relevant if the contact is a named person.
  # These objects not yet called, but should be included in future tests.
  element(:first_name, "#contact_name_form_first_name")
  element(:last_name, "#contact_name_form_last_name")

  element(:heading, :xpath, "//h1[contains(text(), 'Who should we contact')]")
  element(:submit_button, ".button")

  def submit(args = {})
    contact_name.set(args[:contact_name]) if args.key?(:contact_name)

    submit_button.click
  end

end
