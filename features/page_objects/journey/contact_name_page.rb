class ContactNamePage < SitePrism::Page

  # Who should we contact about this registration?

  element(:error_summary, ".error-summary")
  element(:heading, ".heading-large")

  element(:contact_name, "#registration_companyName")
  element(:first_name, "#contact_name_form_first_name")
  element(:last_name, "#contact_name_form_last_name")
  element(:submit_button, ".button")

  def submit(args = {})
    contact_name.set(args[:contact_name]) if args.key?(:contact_name)

    first_name.set(args[:first_name]) if args.key?(:first_name)
    last_name.set(args[:last_name]) if args.key?(:last_name)

    submit_button.click
  end

end
