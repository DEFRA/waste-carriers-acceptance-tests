class RenewalStartPage < SitePrism::Page

  # You are about to renew

  element(:submit_button, "input[type='submit']")
  element(:heading, :xpath, "//h1[contains(text(), 'You are about to renew')]")

  def submit(_args = {})
    submit_button.click
  end

end
