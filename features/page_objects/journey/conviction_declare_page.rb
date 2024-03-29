class ConvictionDeclarePage < BasePage

  # Has anyone in the organisation's management been convicted of an environmental offence in the last 12 months?

  element(:convictions, "[value='yes']+ .govuk-radios__label")
  element(:no_convictions, "[value='no']+ .govuk-radios__label")

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
