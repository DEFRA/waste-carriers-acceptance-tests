class ConstructionWastePage < SitePrism::Page

  # Do you ever deal with waste from other businesses or households?
  element(:yes_construction_waste, "#construction_demolition_form_construction_waste_true", visible: false)
  element(:no_construction_waste, "#construction_demolition_form_construction_waste_false", visible: false)
  element(:heading, :xpath, "//h1[contains(text(), 'Do you ever deal with building, construction or demolition waste?')]")
  element(:submit_button, "input[type='submit']")

  def submit(args = {})
    wait_until_heading_visible(5)
    find("label", text: (args[:answer])).click if args.key?(:answer)
    submit_button.click
  end

end
