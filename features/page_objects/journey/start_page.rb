class StartPage < SitePrism::Page
  set_url("#{Quke::Quke.config.custom['urls']['front_office']}/start")

  element(:error_summary, ".govuk-error-summary__body")
  element(:heading, ".govuk-fieldset__legend--l")

  element(:new_registration, "input[value='new']", visible: false)
  element(:renew_registration, "input[value='renew']", visible: false)

  element(:submit_button, "[type='submit']")

  def submit(args = {})
    case args[:choice]
    when :renewal
      renew_registration.click
    when :new_registration
      new_registration.click
    end

    submit_button.click
  end
end
