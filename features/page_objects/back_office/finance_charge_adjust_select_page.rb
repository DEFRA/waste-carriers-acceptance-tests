require_relative "sections/govuk_banner"

class FinanceChargeAdjustSelectPage < BasePage

  # Make a charge adjustment for CBDU1

  section(:govuk_banner, GovukBanner, GovukBanner::SELECTOR)

  element(:positive_radio, "#charge_adjust_form_charge_type_positive", visible: false)
  element(:negative_radio, "#charge_adjust_form_charge_type_negative", visible: false)

  def submit(args = {})
    case args[:choice]
    when :positive
      positive_radio.click
    when :negative
      negative_radio.click
    end
    submit_button.click
  end

end
