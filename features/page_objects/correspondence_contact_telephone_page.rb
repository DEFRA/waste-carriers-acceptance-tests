class CorrespondenceContactTelephonePage < SitePrism::Page

  # What’s the telephone number of the person we should contact?
  element(:contact_telephone, "#correspondence_contact_telephone_telephone_number")

  element(:submit_button, "input[value='Continue']")

  def submit(args = {})
    contact_telephone.set(args[:contact_telephone]) if args.key?(:contact_telephone)

    submit_button.click
  end

end