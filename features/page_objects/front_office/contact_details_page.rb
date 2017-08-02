class ContactDetailsPage < SitePrism::Page

  # Who should we contact about this application?
  element(:contact_name, "#contactName")
  element(:agent_or_consultant, "#isContactAnAgent")
  element(:contact_tel_number, "#contactTelephone")
  element(:contact_email, "#contactEmail")

  element(:submit_button, "input[type='Submit']")

  def submit(args = {})
    contact_name.set(args[:contact_name]) if args.key?(:contact_name)

    contact_tel_number.set(args[:contact_tel_number]) if args.key?(:contact_tel_number)
    contact_email.set(args[:contact_email]) if args.key?(:contact_email)
    submit_button.click
  end

end
