# frozen_string_literal: true

class ConstructionWastePage < SitePrism::Page

  # Do you ever deal with waste from other businesses or households?
  element(:yes_option, "#registration_constructionWaste_yes", visible: false)
  element(:no_option, "#registration_constructionWaste_no", visible: false)

  element(:submit_button, "#continue")

  def submit(args = {})
    case args[:choice]
    when :no
      no_option.click
    when :yes
      yes_option.click
    end
    submit_button.click
  end

end
