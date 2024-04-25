require_relative "sections/govuk_banner"

class DashboardPage < BasePage
  set_url(Quke::Quke.config.custom["urls"]["back_office"])

  section(:govuk_banner, GovukBanner, GovukBanner::SELECTOR)
  element(:sign_out_link, "a[href*='/bo/users/sign_out']")

  element(:search_term, "#term")
  element(:new_reg_link, "a[href*='/ad-privacy-policy']")
  elements(:status, ".govuk-table__cell:nth-child(3)")
  elements(:reg_details_links, "a[href*='/registrations/CBD']")
  elements(:new_reg_details_links, "a[href*='/new-registrations/")
  elements(:transient_reg_details_links, "a[href*='/renewing-registrations/CBD']")
  element(:search_results_summary, ".govuk-table__caption--m")
  element(:registration_search_filter, "#search-reg-identifier-field+ .govuk-checkboxes__label")

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
    registration_search_filter.click
    submit(search_term: args[:search_term])
    i = 0
    while i < 5 && reg_details_links.nil?
      sleep(1)
      i += 1
      puts i
    end
    reg_details_links[0].click
  end

  def view_new_reg_details(args = {})
    submit(search_term: args[:search_term])
    i = 0
    while i < 5 && new_reg_details_links.nil?
      sleep(1)
      i += 1
      puts i
    end
    new_reg_details_links[0].click
  end

  def view_transient_reg_details(args = {})
    submit(search_term: args[:search_term])
    transient_reg_details_links[0].click
  end
end
