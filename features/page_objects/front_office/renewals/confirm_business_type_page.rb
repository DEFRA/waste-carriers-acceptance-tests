class ConfirmBusinessTypePage < SitePrism::Page

  # What type of business or organisation are you?
  elements(:org_types, "input[name='business_type_form[business_type]']", visible: false)
  element(:heading, :xpath, "//h1[contains(text(), 'What type of business or organisation are you?')]")
  element(:submit_button, "input[type='submit']", visible: false)

  def submit(args = {})
    org_types.find { |btn| btn.value == args[:org_type] }.click if args.key?(:org_type)
    submit_button.click
  end

end
