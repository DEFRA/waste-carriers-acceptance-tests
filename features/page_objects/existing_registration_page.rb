class ExistingRegistrationPage < SitePrism::Page

  # What is your waste carrier registration number?
  element(:reg_no, "#registration_originalRegistrationNumber")

  element(:submit_button, "input[type='submit']")
  element(:error_message, "a[class='error-text']")

  def submit(args = {})
    reg_no.set(args[:reg_no]) if args.key?(:reg_no)
    submit_button.click
  end

end
