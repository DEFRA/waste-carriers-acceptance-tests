class DeclarationsPage < SitePrism::Page

  # Check your details before registering
  element(:declaration, "#registration_declaration")

  element(:submit_button, "input[type='Submit']")

  def submit(_args = {})
    submit_button.click
  end

end
