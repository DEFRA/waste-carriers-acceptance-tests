class OtherBusinessesQuestionPage < SitePrism::Page

  # Do you ever deal with waste from other businesses or households?
  element(:yes_other_businesses, "#registration_otherBusinesses_yes", visible: false)
  element(:no_other_businesses, "#registration_otherBusinesses_no", visible: true)

  element(:submit_button, "input[type='Submit']")

  def submit(args = {})
    case args[:choice]
    when :no
      no_other_businesses.click
    when :yes
      yes_other_businesses.click
    end
    submit_button.click
  end

end
