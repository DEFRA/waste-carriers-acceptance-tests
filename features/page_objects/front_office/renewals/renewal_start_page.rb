class RenewalStartPage < SitePrism::Page

  # You are about to renew

  element(:submit_button, ".button")
  element(:heading, ".heading-large")

  def submit(_args = {})
    submit_button.click
  end

end
