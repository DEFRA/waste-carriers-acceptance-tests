class BankTransferPage < SitePrism::Page

  # Pay by bank transfer

  element(:submit_button, "input[type='submit']")

  def submit(_args = {})
    submit_button.click
  end

end
