class CheckRegisteredCompanyNamePage < BasePage

  # Is this your registered name and address?

  def submit(_args = {})
    submit_button.click
  end

end
