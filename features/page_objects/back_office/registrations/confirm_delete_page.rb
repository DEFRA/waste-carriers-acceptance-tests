class ConfirmDeletePage < SitePrism::Page

  # Confirm De-Registration

  element(:submit_button, "#delete")

  def submit(_args = {})
    submit_button.click
  end

end
