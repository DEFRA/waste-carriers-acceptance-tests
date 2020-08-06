require_relative "sections/govuk_banner.rb"

class FinanceChargeAdjustSelectPage < SitePrism::Page

  # Make a charge adjustment for CBDU1

  section(:govuk_banner, GovukBanner, GovukBanner::SELECTOR)

  element(:back_link, ".link-back")
  element(:heading, ".heading-large")
  element(:content, "#content")

  element(:positive_radio, "#charge_adjust_form_charge_type_positive", visible: false)
  element(:negative_radio, "#charge_adjust_form_charge_type_negative", visible: false)

  element(:submit_button, "input[type='submit']")

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
