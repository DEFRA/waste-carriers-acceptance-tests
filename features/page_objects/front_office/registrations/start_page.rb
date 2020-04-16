class StartPage < SitePrism::Page
  set_url("#{Quke::Quke.config.custom['urls']['front_office']}/start")

  element(:new_registration, "input[value='new']", visible: false)
  element(:renew_registration, "input[value='renew']", visible: false)

  element(:submit_button, "input[type='submit']")

  def submit(args = {})
    if args[:renewal]
      renew_registration.click
    else
      new_registration.click
    end

    submit_button.click
  end
end
