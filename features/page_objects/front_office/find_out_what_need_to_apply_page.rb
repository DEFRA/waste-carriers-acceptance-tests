class FindOutWhatNeedToApplyPage < SitePrism::Page

  element(:submit_button, "input[type='Submit']")

  def submit(_args = {})
    submit_button.click
  end

end
