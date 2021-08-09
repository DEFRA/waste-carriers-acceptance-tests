class ConvictionDeclarePage < SitePrism::Page

  # Has anyone in the organisation's management been convicted of an environmental offence in the last 12 months?

  element(:error_summary, ".govuk-error-summary__body")
  element(:heading, "h1")

  element(:convictions, "input[value='yes']", visible: false)
  element(:no_convictions, "input[value='no']", visible: false)
  element(:submit_button, "[type='submit']")

  def submit(args = {})
    case args[:choice]
    when :no
      no_convictions.click
    when :yes
      convictions.click
    end
    submit_button.click
  end

end
