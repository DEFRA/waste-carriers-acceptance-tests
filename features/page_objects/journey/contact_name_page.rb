class ContactNamePage < BasePage

  # Who should we contact about this registration?

  element(:contact_name, "#registration_companyName")
  element(:first_name, "input[id^='contact-name-form-first-name-field']")
  element(:last_name, "input[id^='contact-name-form-last-name-field']")

  def submit(args = {})
    contact_name.set(args[:contact_name]) if args.key?(:contact_name)

    first_name.set(args[:first_name]) if args.key?(:first_name)
    last_name.set(args[:last_name]) if args.key?(:last_name)

    submit_button.click
  end

end
