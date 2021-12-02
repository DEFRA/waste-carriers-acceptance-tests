class RenewalStartPage < BasePage

  # You are about to renew
  # That registration has already been renewed

  element(:submit_button, "[type='submit']")
  element(:heading, "h1")
  element(:content, "#main-content")

  def submit(_args = {})
    submit_button.click
  end

end
