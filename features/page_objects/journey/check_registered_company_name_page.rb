class CheckRegisteredCompanyNamePage < BasePage

  # Is this your registered name and address?

  element(:confirm_company_details, "#check-registered-company-name-form-temp-use-registered-company-details-yes-field+ .govuk-radios__label")
  element(:reject_company_details, "#check-registered-company-name-form-temp-use-registered-company-details-no-field+ .govuk-radios__label")

  def submit(args = {})
    case args[:choice]
    when :reject
      reject_company_details.click
    when :confirm
      confirm_company_details.click
    end
    submit_button.click
  end

end
