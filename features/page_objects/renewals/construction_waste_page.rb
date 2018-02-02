class ConstructionWastePage < SitePrism::Page

  # Do you ever deal with waste from other businesses or households?
  element(:yes_construction_waste, "#construction_demolition_form_construction_waste_true", visible: false)
  element(:no_construction_waste, "#construction_demolition_form_construction_waste_false", visible: false)

  element(:submit_button, "input[type='Submit']")

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
