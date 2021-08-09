class ConfirmBusinessTypePage < SitePrism::Page

  # What type of business or organisation are you? - front office

  element(:error_summary, ".govuk-error-summary__body")
  element(:heading, ".govuk-fieldset__legend--l")

  elements(:org_types, "input[name='business_type_form[business_type]']", visible: false)
  element(:submit_button, "[type='submit']", visible: false)

  def submit(args = {})
    if args.key?(:org_type) && args[:org_type] != "existing"
      org_types.find { |btn| btn.value == args[:org_type] }.click if args.key?(:org_type)
    end
    submit_button.click
  end

  # Options across front office and frontend are:
  # limitedCompany
  # soleTrader
  # partnership
  # limitedLiabilityPartnership
  # publicBody
  # charity
  # authority
  # other (= I don't know)
end
