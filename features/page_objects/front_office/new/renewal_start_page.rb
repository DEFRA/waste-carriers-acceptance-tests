class RenewalStartPage < SitePrism::Page

  # You are about to renew
  # That registration has already been renewed

  element(:submit_button, ".button")
  element(:heading, ".heading-large")
  element(:content, "#content")

  def submit(_args = {})
    submit_button.click
  end

end
