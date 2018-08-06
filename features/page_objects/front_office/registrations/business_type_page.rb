class BusinessTypePage < SitePrism::Page

  # What type of business or organisation are you?
  elements(:org_types, "input[name='registration[businessType]']", visible: false)
  elements(:new_org_types, "input[name='business_type_form[business_type]']", visible: false)

  element(:submit_button, "input[type='Submit']", visible: false)

  def submit(args = {})
    org_types.find { |btn| btn.value == args[:org_type] }.click if args.key?(:org_type)
    new_org_types.find { |btn| btn.value == args[:new_org_type] }.click if args.key?(:new_org_type)

    submit_button.click
  end

end
