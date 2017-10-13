class ServiceProvidedQuestionPage < SitePrism::Page

  # Who produces the waste that you deal with?
  element(:yes_main_service, "#registration_isMainService_yes", visible: false)
  element(:not_main_service, "#registration_isMainService__no", visible: false)

  element(:submit_button, "input[type='Submit']")

  def submit(args = {})
    case args[:choice]
    when :no
      not_main_service.select_option
    when :yes
      yes_main_service.select_option
    end
    submit_button.click
  end

end
