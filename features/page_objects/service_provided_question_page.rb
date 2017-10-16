class ServiceProvidedQuestionPage < SitePrism::Page

  # Who produces the waste that you deal with?
  element(:yes_main_service, "#registration_isMainService_yes", visible: false)
  element(:not_main_service, "#registration_isMainService_no", visible: false)

  element(:submit_button, "input[type='Submit']")

  def submit(args = {})
    case args[:choice]
    when :not_main_service
      not_main_service.select_option
    when :main_service
      yes_main_service.select_option
    end
    submit_button.click
  end

end
