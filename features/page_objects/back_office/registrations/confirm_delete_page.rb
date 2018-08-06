class ConfirmDeletePage < SitePrism::Page

  # Confirm De-Registration

  element(:submit_button, "input[id='delete']")

  def submit(_args = {})
    submit_button.click
  end

end
