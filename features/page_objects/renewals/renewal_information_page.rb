class RenewalInformationPage < SitePrism::Page

  # Confirmation of your renewal so far

  element(:submit_button, "input[type='submit']")

  def submit(_args = {})
  	wait_for_submit_button
    submit_button.click
  end

end
