class ContactAddressPage < SitePrism::Page

  # whats the address of the person we should contact?

  element(:submit_button, "input[type='Submit']")
  element(:heading, :xpath, "//h1[contains(text(), 'address')]")

  def submit(_args = {})
    wait_for_heading
    submit_button.click
  end

end
