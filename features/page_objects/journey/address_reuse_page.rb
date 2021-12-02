class AddressReusePage < BasePage

  # Do you want to use this address as a contact address?

  element(:error_summary, ".govuk-error-summary__body")
  element(:heading, "h1")

  element(:reuse, "[value='yes']+ .govuk-radios__label")
  element(:no_reuse, "[value='no']+ .govuk-radios__label")
  element(:submit_button, "[type='submit']")

  def submit(args = {})
    case args[:choice]

    when :no
      no_reuse.click
    when :yes
      reuse.click
    end
    submit_button.click
  end

end
