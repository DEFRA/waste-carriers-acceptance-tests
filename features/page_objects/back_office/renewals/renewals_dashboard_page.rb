class RenewalsDashboardPage < SitePrism::Page

  element(:search_term, "#term")
  element(:submit_button, "input[name='commit']")
  element(:back_office_link, "#proposition-name")
  element(:in_progress_filter, "#in_progress", visible: false)
  element(:pending_payment_filter, "#pending_payment_filter", visible: false)
  element(:conviction_check_filter, "#pending_conviction_check", visible: false)

  sections :results, "table tbody tr" do
    element(:registration_number, "td:nth-child(1)")
    element(:status, "td:nth-child(3)")
    element(:actions, "td:nth-child(5)")
  end

  def search_for_in_progress_renewal(args = {})
    search_term.set(args[:search_term]) if args.key?(:search_term)
    in_progress_filter.click
    submit_button.click
  end

end
