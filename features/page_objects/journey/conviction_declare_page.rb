class ConvictionDeclarePage < SitePrism::Page

  # Has anyone in the organisation's management been convicted of an environmental offence in the last 12 months?

  element(:error_summary, ".error-summary")
  element(:heading, ".heading-large")

  element(:convictions, "#declare_convictions_form_declared_convictions_yes", visible: false)
  element(:no_convictions, "#declare_convictions_form_declared_convictions_no", visible: false)
  element(:submit_button, "input[type='submit']")

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
