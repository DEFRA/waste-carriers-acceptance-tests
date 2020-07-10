class TierServiceProvidedPage < SitePrism::Page

  # Who creates the waste that you deal with?

  element(:error_summary, ".error-summary")
  element(:heading, ".heading-large")

  element(:yes_main_service, "#service_provided_form_is_main_service_yes", visible: false)
  element(:not_main_service, "#service_provided_form_is_main_service_no", visible: false)
  element(:submit_button, ".button")

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
