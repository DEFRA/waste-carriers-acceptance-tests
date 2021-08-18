class StartPage < SitePrism::Page
  set_url((Quke::Quke.config.custom["urls"]["front_office"]).to_s)

  element(:error_summary, ".govuk-error-summary__body")
  element(:heading, ".govuk-fieldset__legend--l")

  element(:new_registration, "[value='new']+ .govuk-radios__label")
  element(:renew_registration, "[value='renew']+ .govuk-radios__label")

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
