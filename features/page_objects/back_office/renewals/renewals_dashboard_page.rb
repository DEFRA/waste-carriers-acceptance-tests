require_relative "sections/govuk_banner.rb"

class RenewalsDashboardPage < SitePrism::Page

  section(:govuk_banner, GovukBanner, GovukBanner::SELECTOR)

  element(:search_term, "#term")
  element(:submit_button, ".button")

  # Delete these when tests pass:
  # element(:in_progress_filter, "#in_progress", visible: false)
  # element(:pending_payment_filter, "#pending_payment", visible: false)
  # element(:conviction_check_filter, "#pending_conviction_check", visible: false)

  element(:results_table, "table")

  sections :results, "table tbody tr" do
    element(:registration_number, "td:nth-child(1)")
    element(:status, "td:nth-child(3)")
    element(:actions, "td:nth-child(5)")
  end

  def submit(args = {})
    case args[:choice]
    when :in_progress
      in_progress_filter.click
    when :pending_payment
      pending_payment_filter.click
    when :conviction_check
      conviction_check_filter.click
    end
    search_term.set(args[:search_term]) if args.key?(:search_term)
    submit_button.click
  end

end
