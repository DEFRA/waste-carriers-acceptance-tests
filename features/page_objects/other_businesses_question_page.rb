class OtherBusinessesQuestionPage < SitePrism::Page

  # Do you ever deal with waste from other businesses or households?
  element(:yes_other_businesses, "#registration_otherBusinesses_yes", visible: false)
  element(:no_other_businesses, "#registration_otherBusinesses_no", visible: false)

  element(:submit_button, "input[type='Submit']")

  def submit(args = {})
    case args[:choice]
    when :no
      no_other_businesses.select_option
    when :yes
      yes_other_businesses.select_option
    end
    submit_button.click
  end

end
