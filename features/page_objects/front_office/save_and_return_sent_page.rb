class SaveAndReturnSentPage < SitePrism::Page

  # We sent you a return link
  element(:submit_button, "input[type='Submit']")

  def submit(_args = {})
    submit_button.click
  end

end
