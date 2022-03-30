class ConfirmBusinessTypePage < BasePage

  # What type of business or organisation are you? - front office

  elements(:org_types, "input[name='business_type_form[business_type]']", visible: false)
  element(:sole_trader, "#business-type-form-business-type-soletrader-field+ .govuk-radios__label")
  element(:submit_button, "[type='submit']", visible: false)

  def submit(args = {})
    if args[:org_type] == "soleTrader" && args[:org_type] != "existing"
      sole_trader.click
    elsif args.key?(:org_type) && args[:org_type] != "existing"
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
