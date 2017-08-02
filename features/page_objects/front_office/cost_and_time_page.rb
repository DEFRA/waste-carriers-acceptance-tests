class CostAndTimePage < SitePrism::Page

  # Cost and time for this permit
  element(:submit_button, "input[type='Submit']")

  def submit(_args = {})
    submit_button.click
  end

end
