require_relative "sections/govuk_banner"

class FinanceChargeAdjustSelectPage < SitePrism::Page

  # Make a charge adjustment for CBDU1

  section(:govuk_banner, GovukBanner, GovukBanner::SELECTOR)

  element(:back_link, ".govuk-back-link")
  element(:heading, "h1")
  element(:content, "#main-content")

  element(:positive_radio, "#charge_adjust_form_charge_type_positive", visible: false)
  element(:negative_radio, "#charge_adjust_form_charge_type_negative", visible: false)

  element(:submit_button, "[type='submit']")

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
