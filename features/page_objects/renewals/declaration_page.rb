class DeclarationPage < SitePrism::Page

  element(:declaration, "#registration_declaration")
  element(:heading, :xpath, "//h1[contains(text(), 'Declaration')]")
  element(:submit_button, "input[type='submit']")

  def submit(_args = {})
    wait_for_heading
    submit_button.click
  end

end
