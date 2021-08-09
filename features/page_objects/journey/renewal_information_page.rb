class RenewalInformationPage < SitePrism::Page

  # Confirmation of your renewal so far
  element(:heading, :xpath, "//h1[contains(text(), 'Confirmation of your renewal so far')]")
  element(:submit_button, "[type='submit']")

  def submit(_args = {})
    submit_button.click
  end

end
