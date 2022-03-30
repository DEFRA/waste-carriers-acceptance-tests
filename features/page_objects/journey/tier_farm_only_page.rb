class TierFarmOnlyPage < BasePage

  # Do you only deal with: Farm or agricultural waste ...?

  element(:heading, "h1")

  element(:only_these_types, "#waste-types-form-only-amf-yes-field+ .govuk-radios__label")
  element(:other_types, "#waste-types-form-only-amf-no-field+ .govuk-radios__label")
  element(:submit_button, "[type='submit']")

  def submit(args = {})
    case args[:choice]
    when :yes
      only_these_types.click
    when :no
      other_types.click
    end
    submit_button.click
  end

end
