class DeclareOffencesPage < SitePrism::Page

  # Does anyone connected with your business have a conviction for a relevant offence?
  element(:yes_offences, "#yesOffences", visible: false)
  element(:no_offences, "#noOffences", visible: false)

  element(:submit_button, "input[type='Submit']")

  def submit(args = {})
    case args[:choice]
    when :none
      no_offences.select_option
    when :offences
      yes_offences.select_option
    end
    submit_button.click
  end

end
