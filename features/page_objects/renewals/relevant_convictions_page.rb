class RelevantConvictionsPage < SitePrism::Page

  # Has anyone involved in managing your organisation been convicted
  # of an environmental offence in the last 12 months?
  element(:yes, "input[value='yes']", visible: false)
  element(:no, "input[value='no']", visible: false)

  element(:submit_button, "input[type='submit']")

  def submit(args = {})
    case args[:choice]
    when :no
      no.click
    when :yes
      yes.click
    end
    submit_button.click
  end

end
