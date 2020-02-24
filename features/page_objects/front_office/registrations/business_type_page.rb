class BusinessTypePage < SitePrism::Page

  # What type of business or organisation are you?
  elements(:org_types, "input[name='registration[businessType]']", visible: false)

  element(:submit_button, "input[type='Submit']", visible: false)

  def submit(args = {})
    org_types.find { |btn| btn.value == args[:org_type] }.click if args.key?(:org_type)
    # Options on backend are:
    # limitedCompany
    # soleTrader
    # partnership
    # publicBody
    # charity
    # authority
    # other (= I don't know)

    submit_button.click
  end

end
