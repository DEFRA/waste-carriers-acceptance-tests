class CorrespondenceContactNamePage < SitePrism::Page

  # Who should we contact about this activity?
  element(:contact_name, "#registration_companyName")

  element(:submit_button, "input[value='Continue']")

  def submit(args = {})
    contact_name.set(args[:contact_name]) if args.key?(:contact_name)

    submit_button.click
  end

end