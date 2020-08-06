class ConfirmBusinessTypePage < SitePrism::Page

  # What type of business or organisation are you? - front office
  # TODO This page is mixed up with business_type_page. Sometimes the new app calls the old page.

  element(:error_summary, ".error-summary")

  elements(:org_types, "input[name='business_type_form[business_type]']", visible: false)
  element(:submit_button, "input[type='submit']", visible: false)

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
