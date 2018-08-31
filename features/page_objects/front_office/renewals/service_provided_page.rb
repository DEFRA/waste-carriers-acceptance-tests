class ServiceProvidedPage < SitePrism::Page

  # Who produces the waste that you deal with?
  element(:yes_main_service, "#service_provided_form_is_main_service_yes", visible: false)
  element(:not_main_service, "#service_provided_form_is_main_service_no", visible: false)
  element(:heading, :xpath, "//h1[contains(text(), 'Who produces the waste that you deal with')]")
  element(:submit_button, "input[type='submit']")

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
