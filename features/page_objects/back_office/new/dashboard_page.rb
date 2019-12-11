require_relative "sections/govuk_banner.rb"

class RenewalsDashboardPage < SitePrism::Page

  section(:govuk_banner, GovukBanner, GovukBanner::SELECTOR)
  element(:heading, ".heading-large")

  element(:search_term, "#term")
  element(:submit_button, ".button")

  element(:results_table, "table")
  elements(:reg_details_links, "a[href*='/registrations/CBD']")
  elements(:transient_reg_details_links, "a[href*='/renewing-registrations/CBD']")

  sections :results, "table tbody tr" do
    element(:registration_number, "td:nth-child(1)")
    element(:status, "td:nth-child(3)")
    element(:actions, "td:nth-child(5)")
  end

  def submit(args = {})
    search_term.set(args[:search_term]) if args.key?(:search_term)
    submit_button.click
  end

  def view_reg_details(args = {})
    submit(search_term: args[:search_term])
    reg_details_links[0].click
  end

  def view_transient_reg_details(args = {})
    submit(search_term: args[:search_term])
    transient_reg_details_links[0].click
  end

end
