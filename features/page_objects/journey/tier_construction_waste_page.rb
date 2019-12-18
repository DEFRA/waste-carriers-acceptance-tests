class TierConstructionWastePage < SitePrism::Page

  # Do you ever deal with waste from other businesses or households?
  element(:heading, ".heading-large")
  element(:yes_construction_waste, "#construction_demolition_form_construction_waste_yes", visible: false)
  element(:no_construction_waste, "#construction_demolition_form_construction_waste_no", visible: false)
  element(:submit_button, ".button")

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
