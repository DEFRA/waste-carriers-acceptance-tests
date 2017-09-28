class BusinessTypePage < SitePrism::Page

  # What type of business or organisation are you?
  element(:org_types, "input[name='registration[businessType]']", visible: false)

  element(:submit_button, "input[type='Submit']")

  def submit(args = {})
    if args.key?(:org_type)
      org_types.find { |btn| btn.value == args[:org_type] }.click
    end

    submit_button.click
  end

end
