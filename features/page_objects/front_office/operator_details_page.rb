class SiteOperatorDetailsPage < SitePrism::Page

  elements(:org_types, "input[name='operatorType']", visible: false)

  element(:submit_button, "input[type='Submit']")

  def submit(args = {})
    if args.key?(:org_type)
      org_types.find { |btn| btn.value == args[:org_type] }.click
    end

    submit_button.click
  end

end
