require_relative "sections/govuk_banner.rb"

class FinanceWriteoffPage < SitePrism::Page

  section(:govuk_banner, GovukBanner, GovukBanner::SELECTOR)
  element(:heading, ".heading-large")

  element(:reason_form, "#write_off_form_comment")
  element(:submit_button, ".button")

  def submit(args = {})
    reason_form.set(args[:reason]) if args.key?(:reason)
    submit_button.click
  end

end
