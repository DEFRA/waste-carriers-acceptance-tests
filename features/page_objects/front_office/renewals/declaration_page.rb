class DeclarationPage < SitePrism::Page

  element(:declaration, "#declaration_form_declaration", visible: false)
  element(:heading, :xpath, "//h1[contains(text(), 'Declaration')]")
  element(:submit_button, "input[type='submit']")

  def submit(args = {})
    wait_for_declaration
    find("label", text: (args[:declaration])).click if args.key?(:declaration)
    submit_button.click
  end

end
