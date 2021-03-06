class TierOtherBusinessesPage < SitePrism::Page

  # Do you ever deal with waste from other businesses or households?
  element(:error_summary, ".error-summary")
  element(:heading, ".heading-large")

  element(:yes_other_businesses, "#other_businesses_form_other_businesses_yes", visible: false)
  element(:no_other_businesses, "#other_businesses_form_other_businesses_no", visible: false)

  element(:submit_button, "input[type='submit']")

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
