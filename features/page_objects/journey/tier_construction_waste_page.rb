class TierConstructionWastePage < SitePrism::Page

  # Do you ever deal with building, construction or demolition waste?

  element(:back_link, ".govuk-back-link")
  element(:error_summary, ".govuk-error-summary__body")
  element(:heading, "h1")

  element(:yes_construction_waste, "#construction-demolition-form-construction-waste-yes-field", visible: false)
  element(:no_construction_waste, "#construction-demolition-form-construction-waste-no-field", visible: false)
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
