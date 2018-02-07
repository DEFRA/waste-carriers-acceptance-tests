class ConfirmBusinessTypePage < SitePrism::Page

  # What type of business or organisation are you?
  elements(:new_org_types, "input[name='business_type_form[business_type]']", visible: false)

  element(:submit_button, "input[type='submit']", visible: false)

  def submit(args = {})
    new_org_types.find { |btn| btn.value == args[:new_org_type] }.click if args.key?(:new_org_type)
    wait_for_submit_button
    submit_button.click
  end

end
