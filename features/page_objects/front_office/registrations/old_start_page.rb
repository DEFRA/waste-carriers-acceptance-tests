class OldStartPage < SitePrism::Page

  set_url(Quke::Quke.config.custom["urls"]["front_office"])

  # Have you already started an application?
  element(:new_registration, "input[value='new']", visible: false)
  element(:renew_registration, "input[value='renew']", visible: false)

  element(:submit_button, "input[type='Submit']")

  def submit(args = {})
    if args[:renewal]
      renew_registration.click
    else
      new_registration.click
    end

    submit_button.click
  end
end
