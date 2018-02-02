class ServiceProvidedPage < SitePrism::Page

  # Who produces the waste that you deal with?
  element(:yes_main_service, "#service_provided_form_is_main_service_true", visible: false)
  element(:not_main_service, "#service_provided_form_is_main_service_false", visible: false)

  element(:submit_button, "input[type='Submit']")

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
