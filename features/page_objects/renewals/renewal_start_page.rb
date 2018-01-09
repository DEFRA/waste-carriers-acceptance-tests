class RenewalStartPage < SitePrism::Page

  # You are about to renew

  element(:submit_button, "input[type='submit']")

  def submit(_args = {})
    submit_button.click
  end

end
