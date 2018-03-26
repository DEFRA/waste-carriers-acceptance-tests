class ServiceProvidedPage < SitePrism::Page

  # Who produces the waste that you deal with?
  element(:yes_main_service, "#service_provided_form_is_main_service_true", visible: false)
  element(:not_main_service, "#service_provided_form_is_main_service_false", visible: false)
  element(:heading, :xpath, "//h1[contains(text(), 'Who produces the waste that you deal with')]")
  element(:submit_button, "input[type='submit']")

  def submit(args = {})
    wait_for_yes_main_service
    find("label", text: (args[:answer])).click if args.key?(:answer)
    submit_button.click
  end

end
