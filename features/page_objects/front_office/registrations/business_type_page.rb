class BusinessTypePage < SitePrism::Page

  # What type of business or organisation are you?
  element(:error_summary, ".error-summary")
  elements(:org_types, "input[type='radio']", visible: false)

  element(:submit_button, "input[type='Submit']", visible: false)

  def submit(args = {})
    org_types.find { |btn| btn.value == args[:org_type] }.click if args.key?(:org_type)
    # Options on backend are:
    # limitedCompany
    # soleTrader
    # partnership
    # limitedLiabilityPartnership
    # publicBody
    # charity
    # authority
    # other (= I don't know)

    submit_button.click
  end

end
