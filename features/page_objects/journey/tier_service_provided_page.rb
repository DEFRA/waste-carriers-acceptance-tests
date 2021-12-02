class TierServiceProvidedPage < BasePage

  # Who creates the waste that you deal with?

  element(:error_summary, ".govuk-error-summary__body")
  element(:heading, "h1")

  element(:yes_main_service, "[value='yes']+ .govuk-radios__label")
  element(:not_main_service, "[value='no']+ .govuk-radios__label")
  element(:submit_button, "[type='submit']")

  def submit(args = {})
    case args[:choice]
    when :not_main_service
      not_main_service.click
    when :main_service
      yes_main_service.click
    end
    submit_button.click
  end

end
