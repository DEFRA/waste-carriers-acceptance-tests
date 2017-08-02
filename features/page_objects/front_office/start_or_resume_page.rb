class StartOrResumePage < SitePrism::Page

  set_url(Quke::Quke.config.custom["urls"]["front_office"])

  # Have you already started an application?
  element(:started_app, "#open-application", visible: false)
  element(:not_started_app, "#start-application", visible: false)

  element(:submit_button, "input[type='Submit']")

  def submit(args = {})
    if args[:started]
      started_app.click
    else
      not_started_app.click
    end

    submit_button.click
  end

end
