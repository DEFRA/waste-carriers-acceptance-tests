class ConfirmBusinessTypePage < SitePrism::Page

  # What type of business or organisation are you?
  elements(:new_org_types, "input[name='business_type_form[business_type]']", visible: false)
  element(:heading, :xpath, "//h1[contains(text(), 'What type of business or organisation are you?')]")
  element(:submit_button, "input[type='submit']", visible: false)

  def submit(args = {})
    wait_for_new_org_types
    find("label", text: (args[:answer])).click if args.key?(:answer)
    submit_button.click
  end

end
