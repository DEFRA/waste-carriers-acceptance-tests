class AddressReusePage < BasePage

  # Do you want to use this address as a contact address?

  element(:reuse, "[value='yes']+ .govuk-radios__label")
  element(:decline_reuse, "[value='no']+ .govuk-radios__label")
  element(:submit_button, "[type='submit']")

  def submit(args = {})
    case args[:choice]

    when :no
      decline_reuse.click
    when :yes
      reuse.click
    end
    submit_button.click
  end

end
