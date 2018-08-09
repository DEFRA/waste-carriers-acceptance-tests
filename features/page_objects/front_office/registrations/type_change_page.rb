class TypeChangePage < SitePrism::Page

  # You cannot renew

  element(:submit_button, "input[type='Submit']")

  def submit(_args = {})
    submit_button.click
  end

end
