class RenewalsDashboardPage < SitePrism::Page

  element(:search_term, "#term")
  element(:submit_button, "input[name='commit']")
  element(:back_office_link, "#proposition-name")

  sections :results, "table tbody tr" do
    element(:registration_number, "td:nth-child(1)")
    element(:status, "td:nth-child(3)")
    element(:actions, "td:nth-child(5)")
  end

  def submit(args = {})
    search_term.set(args[:search_term]) if args.key?(:search_term)
    submit_button.click
  end

end
