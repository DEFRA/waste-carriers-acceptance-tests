class ConfirmBusinessTypePage < SitePrism::Page

  # What type of business or organisation are you?
  elements(:new_org_types, "input[name='business_type_form[business_type]']", visible: false)

  element(:submit_button, "input[type='submit']", visible: false)

  def submit(args = {})
    find("label", text: (args[:answer])).click if args.key?(:answer)
    wait_for_submit_button

    submit_button.click
  end

end
