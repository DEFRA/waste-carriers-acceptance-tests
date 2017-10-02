class ConstructionWasteQuestionPage < SitePrism::Page

  # Do you ever deal with waste from other businesses or households?
  element(:yes_construction_waste, "#registration_constructionWaste_yes", visible: false)
  element(:no_construction_waste, "#registration_constructionWaste_no", visible: false)

  element(:submit_button, "input[type='Submit']")

  def submit(args = {})
    case args[:choice]
    when :no
      no_construction_waste.select_option
    when :yes
      yes_construction_waste.select_option
    end
    submit_button.click
  end

end
