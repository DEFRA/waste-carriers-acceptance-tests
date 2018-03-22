class RenewalStartPage < SitePrism::Page

  # You are about to renew

  element(:submit_button, "input[type='submit']")

  def submit(_args = {})
  	wait_for_submit_button
    submit_button.click
  end

end
