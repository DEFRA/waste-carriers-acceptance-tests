class OfflinePaymentPage < SitePrism::Page

  # Payment by bank transfer

  element(:submit_button, "input[type='Submit']", visible: false)

  def submit(_args = {})
    submit_button.click
  end

end
