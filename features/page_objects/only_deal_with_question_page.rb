class OnlyDealWithQuestionPage < SitePrism::Page

  # Do you only deal with the following waste?
  element(:yes_only, "#registration_onlyAMF_yes", visible: false)
  element(:not_only, "#registration_onlyAMF_no", visible: false)

  element(:submit_button, "input[type='Submit']")

  def submit(args = {})
    case args[:choice]
    when :not_farm_waste
      not_only.click
    when :farm_waste
      yes_only.click
    end
    submit_button.click
  end

end
