When("I search for {string}") do |search_term|
  @bo.dashboard_page.submit(search_term: search_term)
end

When("I search for the name {string}") do |search_term|
  @bo.dashboard_page.search_full_name.click
  @bo.dashboard_page.submit(search_term: search_term)
end

When("I search for email {string}") do |search_term|
  @bo.dashboard_page.search_email.click
  @bo.dashboard_page.submit(search_term: search_term)
end

When("I search using the registration number") do
  @bo.dashboard_page.search_reg_number.click
  @bo.dashboard_page.submit(search_term: @reg_number)
end

Then("I can see the search results have been found") do
  expect(@bo.dashboard_page.search_results_summary).to have_text(/Found \d+ registrations?/)
end
