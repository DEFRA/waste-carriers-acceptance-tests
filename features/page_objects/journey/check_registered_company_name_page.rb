class CheckRegisteredCompanyNamePage < BasePage

  # Is this your registered name and address?
  element(:confirm_company_details, "input[value='yes']+ .govuk-radios__label")
  element(:reject_company_details, "input[value='no']+ .govuk-radios__label")
  element(:companies_house_number, ".govuk-heading-m:nth-child(1)")

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
