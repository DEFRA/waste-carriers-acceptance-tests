class TierConstructionWastePage < BasePage

  # Do you ever deal with building, construction or demolition waste?

  element(:back_link, ".govuk-back-link")

  element(:heading, "h1")

  element(:yes_construction_waste, "#construction-demolition-form-construction-waste-yes-field+ .govuk-radios__label")
  element(:no_construction_waste, "#construction-demolition-form-construction-waste-no-field+ .govuk-radios__label")
  element(:submit_button, "[type='submit']")

  def submit(args = {})
    case args[:choice]
    when :no
      no_construction_waste.click
    when :yes
      yes_construction_waste.click
    end
    submit_button.click
  end

end
