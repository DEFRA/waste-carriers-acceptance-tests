class TradingNameQuestionPage < BasePage

  element(:trading_name, "[value='yes']+ .govuk-radios__label")
  element(:decline_trading_name, "[value='no']+ .govuk-radios__label")

  def submit(args = {})
    case args[:option]
    when :yes
      trading_name.click
    when :no
      decline_trading_name.click
    end
    submit_button.click
  end
end
