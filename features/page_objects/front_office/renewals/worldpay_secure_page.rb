class WorldpaySecurePage < SitePrism::Page

  # 3D Secure Simulator
  element(:submit_button, "input[value='Submit']")
  element(:heading, :xpath, "//h1[contains(text(), '3D Secure Simulator')]")

  def submit(_args = {})
    submit_button.click
  end

end
